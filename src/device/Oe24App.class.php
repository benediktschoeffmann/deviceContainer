<?
/**
 * Oe24App Class.
 *
 * This class handles all operations related to the Oe24App.
 * Additional files are page/oe24app/*.page and tpl/device/oe24app/*
 *
 */
class Oe24App {

    /**
     * Singleton Instance
     */
    static private $instance;

    private $config        = array();
    private $categories    = array();
    private $tplAnnotation = '';
    private $jsonArray     = array();
    private $errors        = array();
    // private $ads           = array();

    private $portal;
    private $oewaTagCache  = array();

    private $videoAdCache  = array();
    private $categories2Colors = array();

    /**
     * Mapping of BoxTypes to Default Templates
     * @var array
     */
    private $defaultTemplates = array(
        'oe24.core.TabbedBox'   => true,
        'oe24.core.ContentBox'  => 'oe24.oe24.device.oe24app.tpl.contentBox.contentBox',
        'oe24.core.ConsoleBox'  => 'oe24.oe24.device.oe24app.tpl.consoleBox.consoleBox',
        'oe24.core.TemplateBox' => false,
        'oe24.core.FreeHtmlBox' => true,
        'oe24.core.XmlBox'      => false,
    );
    /**
     * Private Constructor
     */
    private function __construct() {
        // Oe24Benchmarker::getInstance()->setBenchmark('constructor');
    }

    /**
     * Singleton getter
     * @return instance Oe24App
     */
    public static function getInstance() {
        if (null === self::$instance) {
            self::$instance = new Oe24App();
        }
        return self::$instance;
    }

    /**
     * Initializes the Device and sets the config.
     * @param  array  $config the Configuraion Array from categories.conf
     * @return void
     */
    public function init($config = array()) {
        $this->config        = $config;
        $this->tplAnnotation = $this->getConfig('deviceType').'Tpl';
        $this->portal        = Portal::getPortalByName('oe24', false);
        $this->prepareAds();
    }

    /**
     * Gets the Boxes of a Channel(column) and filters them via filterBoxes()
     * @param  oe24.core.Channel $channel
     * @return array<oe24.core.FrontendBox> the filtered Boxes
     */
    private function getBoxes($channel, $isFrontpage = false) {
        $columnName = $this->getConfig('validColumn');
        $column = $channel->getColumnByName($columnName);
        if (!$column) {
            throw new Oe24AppException(
                "Column $columnName in Channel ".$channel->getName()." wurde nicht gefunden. Config : " .$this->getConfig()
                );
        }

        $boxes = $column->getBoxes();
        $maxBoxes = ($isFrontpage) ? $this->getConfig('maxBoxesFrontpage') : $this->getConfig('maxBoxes');

        $boxes = $this->filterBoxes($boxes, $maxBoxes);

        // this is done inside filterBoxes
        // $boxes = array_slice($boxes, 0, (int) $maxBoxes);
        return $boxes;
    }

    /**
    *   Filters the Boxes of a Channel so that only valid representations are used.
    *   @param $boxes   oe24.core.FrontendBox
    *   @return array<oe24.core.FrontendBox>
    */
    private function filterBoxes($boxes = array(), $maxBoxes = 10) {
        $validBoxes = array();
        $validBoxesElems = 0;

        foreach ($boxes as $key => $box) {
            $boxTemplateString = $box->getTemplate();
            $boxTemplate = spunQ_Template::get($boxTemplateString);

            // get the @oe24AppTpl annotation
            $annotations = $boxTemplate->getAnnotations();
            $annotationsTpl = $annotations->get($this->tplAnnotation);
            $templateString = (isset($annotationsTpl[0])) ? $annotationsTpl[0] : null;

            // no annotation found, use standard types
            if (!$templateString) {

                $boxType = $box->_getType()->getName();
                if (false == $this->defaultTemplates[$boxType]) {
                    continue;
                }

                if (  !(isset($this->defaultTemplates[$boxType])) ||
                    false === $this->defaultTemplates[$boxType]) {
                    $this->errors[] = "BoxType $boxType is not defined in `defaultTemplates` ";
                    continue;
                }

                // resolve tabbed boxes
                if ($box instanceof TabbedBox) {
                    $tabboxBoxes = self::getBoxesOfTabbedBox($box);
                    $tabboxFilteredBoxes = $this->filterBoxes($tabboxBoxes);

                    if (!empty($tabboxFilteredBoxes)) {

                        array_unshift($tabboxFilteredBoxes, array(
                                'box' => $box,
                                'template' => 'oe24.oe24.device.oe24app.tpl.tabbedBoxHeadline.tabbedBoxHeadline'
                            ));

                    }

                    foreach ($tabboxFilteredBoxes as $entry) {
                        $validBoxes[$validBoxesElems++] = $entry;
                    }

                    if ($validBoxesElems >= $maxBoxes) {
                        break;
                    }
                    continue;
                }
                $templateString = $this->defaultTemplates[$boxType];
            }

            $validBoxes[$validBoxesElems++] = array(
                'box'      => $box,
                'template' => $templateString
            );

            if ($validBoxesElems >= $maxBoxes) {
                break;
            }
        }

        return $validBoxes;
    }

    /**
     * Convenience method to get contents of TabbedBoxes.
     * Ignore TabbedBoxes in other TabbedBoxes.
     * @param  oe24.core.TabbedBox $tabbedBox
     * @return array<oe24.core.FrontendBox>
     */
    public static function getBoxesOfTabbedBox($tabbedBox, $getAllTabs = true, $useTemplateOptions = false ) {

        $validBoxes = array();



        if (!($tabbedBox instanceof TabbedBox)) {
            return array();
        }
        $tabItems = $tabbedBox->getTabbedBoxItems();
        if (!$tabItems) {
            return array();
        }
        foreach ($tabItems as $tabKey => $tabItem) {
            if ($tabKey > 0 && !$getAllTabs) {
                break;
            }
            $tabItemBoxes = $tabItem->getBoxes();
            if (!$tabItemBoxes) {
                continue;
            }
            foreach ($tabItemBoxes as $itemKey => $box) {
                if ($box instanceof TabbedBox) {
                    continue;
                }

                // Right-side Boxes should be aware of templateOptions
                if ($tabKey > 1 && $useTemplateOptions) {
                    $o = $box->getTemplateOptions();
                    if ($o->get('Hide-Mobile-Box') ||
                        $o->get('Mobil-Kein-Slider') ||
                        !$o->get('showMobile') ||
                        !$o->get('Show-Mobile-Box')) {
                        continue;
                    }
                }

                $validBoxes[] = $box;
            }
        }
        return $validBoxes;
    }


    /**
     * Here processing starts - the operation type is determined.
     * See inner comments for more information.
     * Will handle the rest of the program flow.
     * @return  void
     */
    public function processDevice() {
        $this->setConfig('status', 'processing');

        // there are 3 cases :
        // single number 1   : process categories and collections from conf.
        // multiple numbers  : assume these are article ids and process only those.
        // single number > 1 : either a Channel or a ContentCollection or a Article

        $ids              = $this->getConfig('ids');
        $onlyArticles     = (   $ids != NULL
                             && is_array($ids)
                             && isset($ids[0])
                            );

        // this check is needed because it is not possible for AAA to use features as they were intended to be used.
        if ($onlyArticles) {
            $object = db()->getById($ids[0], 'spunQ.db.StorableObject', false);
            if (!($object instanceof TextualContent)) {
                $onlyArticles = false;
            }
        }

        if ($onlyArticles) {
            $this->setConfig('onDemandObject', 'article');
            $tmp = $this->getArticleDataByIds($ids);
            $articleArray = reset($tmp);

            $this->jsonArray = $articleArray;

        } else {
            $object = null;
            $objectType = null;

            if ($ids[0] !== 1) {
                $object = db()->getById($ids[0], 'spunQ.db.StorableObject', false);

                if ($object) {
                    switch (true) {
                        case ($object instanceof Channel) :
                                $this->setConfig('onDemandObject', 'channel');
                                $objectType = 'channel';
                            break;
                        case ($object instanceof ContentCollection) :
                                $this->setConfig('onDemandObject', 'collection');
                                $objectType = 'collection';

                            break;
                        default:

                    }
                } else {
                    $this->errors[] = 'processDevice: incoming id was not a valid object. id: ' . $ids[0] ;
                    return;
                }
            }

            // handle boxes and categories
            $categories     = $this->getConfig('categories');
            $defaultOewaPath = $this->getConfig('defaultOewaTag');


            // accept only channels/collections that are also in the config to prevent DDOS attacks.
            if ($objectType == 'channel') {
                $channelIds = array($ids[0]);
                $categories = array_filter($categories, function ($entry) use ($ids) {
                    return $entry['id'] == $ids[0];
                });
            } else if ($objectType == 'collection') {
                $channelIds = array();
                $categories = array();
            } else {
                $channelIds = array_map(function ($entry) {
                    return $entry['id'];
                }, $categories);
            }

            // accept only channels/collections that are also in the config to prevent DDOS attacks.
            $channels = db()->getByIds($channelIds, 'oe24.core.Channel', false);
            if (count($channels) != count($categories)) {
                $this->errors[] = 'processDevice: one or more Channels could not be found, ids are: ' . implode($channelIds, ', ');
                    return;
            }

            $categoryArray = array();
            foreach ($categories as $key => $category) {

                $oewaPath       = $category['oewa'];
                $useMoreBoxes   = in_array($category['name'], $this->getConfig('maxBoxesSpecial'));

                $channelOptions = $channels[$category['id']]->getOptions(true, true);
                $layoutOverride = $channelOptions->get('layoutOverride');
                $channelColor   = $this->getColorFromLayoutIdentifier($layoutOverride);

                $categories2Colors[$category['name']] = (($channelColor) ? $channelColor : '
                #d0113a');

                array_push($categoryArray,
                    array(
                        'name'         => $category['name'],
                        'id'           => $category['id'],
                        'boxes'        => $this->getBoxes($channels[$category['id']], $useMoreBoxes),
                        'oewa'         => $oewaPath,
                    )
                );
            }

            $this->processBoxes($categoryArray);

            // it is more logical if this check is here than in processCollections()
            if ($objectType !== 'channel') {
                $collectionId = ($objectType === 'collection') ? $ids[0] : null;
                $this->processCollections($collectionId);
            }

        }

        // here all 3 paths meet
        $this->setConfig('status', 'finalizing');
        $this->finalize();
        $this->setConfig('status', 'encoding');
        $this->encode();
        $this->setConfig('status', 'done');
    }


    /**
     * Process Collections
     * @param  $collectionId one id if it is an onDemand call, null otherwise.
     * @return array with collection Information
     */
    private function processCollections($collectionId = null) {

        // this gets now checked in processDevice()
        // skip if it was a channel call.
        // if ($this->getConfig('onDemandObject') == 'channel') {
        //     return;
        // }

        // accept only channels/collections that are also in the config to prevent DDOS attacks.
        $collectionArray = $this->getConfig('collections');
        if ($collectionId) {
            $collectionArray = array_filter($collectionArray, function ($entry) use ($collectionId) {
                return $entry['id'] == $collectionId;
            });
        }
        if (!$collectionArray) {
            return;
        }

        $maxArticles = $this->getConfig('maxCollectionArticles');
        foreach ($collectionArray as $collection) {

            // get article ids of Collection
            $itemQuery = new spunQ_SelectQuery();
            $itemQuery->setProperties(array(
                'items._value.id',
                ));

            $itemQuery->setType('oe24.core.ContentCollection');
            $itemQuery->setConditions(array(
                'id = {collectionId}'
            ));

            $itemQuery->setReturnType(spunQ_SelectQuery::RETURN_ARRAY);
            $itemQuery->setLimit($maxArticles);
            $data = $itemQuery->execute(
                array(
                    'collectionId' => $collection['id'],
                    )
                );

            // remap ids
            $articleIds = array();
            $articleIds = array_map(function($entry) {
                return $entry['items._value.id'];
            }, $data);


            // add livestream if its the video-collection
            if ($collection['name'] == 'video') {
                $livestreamId = (int) $this->getConfig('livestreamId');
                $articleIds = array_merge(
                    array($livestreamId), $articleIds);
            }

            $tmp = $this->getArticleDataByIds($articleIds);
            $articleArray = reset($tmp);

            // put the elements in the order where they came in.
            $sorted = array_flip($articleIds);
            array_walk($articleArray, function ($entry) use (&$sorted) {
                $sorted[$entry['article']['id']] = $entry;
            });

            // filter out invalid ids
            $sorted = array_filter($sorted, function ($entry) {
                return is_array($entry);
            });

            // reindex array starting at zero
            $sorted = array_values($sorted);
            $this->jsonArray[$collection['name']]['articles'] = $sorted;
        }
    }

    /**
     * Prepare category array and handle boxes.
     * The boxes call their template and add it to the Json
     * @param  array  $categoryArray
     * @return void
     */
    private function processBoxes($categoryArray = array()) {

        foreach ($categoryArray as $key => $category) {
            $categoryName = $category['name'];

            $this->jsonArray['categories'][$categoryName]['id']   = (string) $category['id'];
            $this->jsonArray['categories'][$categoryName]['name'] = $categoryName;
            $this->jsonArray['categories'][$categoryName]['oewaPath'] = $category['oewa'];

            // (bs) es war angedacht, dass nur in der ersten Kategorie xlBoxen etc ausgespielt
            // werden. da das jetzt auch in den anderen passiert, brauchen wir diese zeile nicht mehr
            // $this->setConfig('firstCategory', ($key === 0));

            $this->setConfig('articlesPerCategory', 0);
            $boxesOfCategory = $category['boxes'];

            foreach ($boxesOfCategory as $key => $boxEntry) {

                // (bs) 2017-11-24 Niki will, dass in allen Kategorien ausser Frontpage max. 19
                // Artikel ausgespielt werden.
                if ($categoryName != 'frontpage' && $this->getConfig('articlesPerCategory') >= 19) {
                    break;
                }

                // (bs) 2017-06-08 this line is "wrong".
                // causes the filtering only to happen inside a box.
                // since requirements change so often, leave it here, if you want filtering to happen categorywise, put it before the loop.
                $categoryIdArray = array();

                $this->getBoxRepresentationAsArray(
                    $boxEntry['template'],
                    array(
                        'box'           => $boxEntry['box'],
                        'category'      => $categoryName,
                        'boxCount'      => $key,
                        'oewaPath'      => $category['oewa'],
                         ),
                    $categoryIdArray);
            }

        } // end of foreach Category
    }

    private function getBoxRepresentationAsArray($templateString, $params, &$categoryIdArray = array()) {

        $box = $params['box'];
        switch (true) {
            case $box instanceof ConsoleBox :
                $articles = $box->getContents();
                break;
            case $box instanceof ContentBox :
                $articles = $box->getContentOfAllDropAreas(true);
                $templateOptions = $box->getTemplateOptions();
                if ($templateOptions->get('With-Top-Stories')) {
                    $boxHomeChannel = $box->getHomeChannel();
                    $homeChannelTopStories = (NULL === $boxHomeChannel) ? array() : $boxHomeChannel->getTopContents(true, true);
                    $articles = array_merge($homeChannelTopStories, $articles);
                }
                break;
            // case $box instanceof TabbedBox :
            //     $articles = array();
            //     break;
            default:
                // for TabbedBox and FreeHtmlBox
                $articles = array();
                break;
        }

        $articlesFiltered = array();
        if (!empty($articles)) {
            $articlesFiltered = array_filter($articles, function($entry) {
                // return ($entry instanceof Text);
                return (($entry instanceof Text) || ($entry instanceof Video));
                //
            });
        }

        if (($box instanceof ConsoleBox || $box instanceof ContentBox) && empty($articlesFiltered)) {
            return;
        }

        // $articlesFiltered = array();
        // foreach ($articles as $key => $article) {
        //     // $articleId = $article->getId();
        //     // if (!in_array($articleId, $categoryIdArray) && ($article instanceof Text)) {
        //     //     $categoryIdArray[] = $articleId;
        //     //     $articlesFiltered[] = $article;
        //     // }

        //     // $articleId = $article->getId();
        //     if ($article instanceof Text) {
        //         $articlesFiltered[] = $article;
        //     }
        // }


        // calls the template code.
        // the template uses $device->addData to return data.
        tpl($templateString, array(
            'box'           =>  $box,
            'articles'      =>  $articlesFiltered,
            'category'      =>  $params['category'],
            'device'        =>  $this,
            'oewaPath'      =>  $params['oewaPath'],
            'portal'        =>  $this->portal,
        ));
    }

    /**
     * Function to return data from the Article Templates
     * @param string $category
     * @param array<oe24.core.Text>  $articleArray
     * @param string $key
     */
    public function addData($category, $articleArray = array(), $key = 'articles', $inCategory = false) {
        if ($inCategory) {
            $this->jsonArray['categories'][$category][$key][] = $articleArray;
        } else {
            $this->jsonArray[$category][$key][] = $articleArray;
        }
    }

    /**
     * If all went ok, use this method to encode the data array.
     * @return void
     */
    private function encode() {
        if ($this->getConfig('status') !== 'encoding') {
            $this->errors[] = 'Error, process device first! ';
            return json_encode($this->errors);
        }

        $this->json = json_encode($this->jsonArray);
        $this->setConfig('status', 'done');
    }

    /**
     * Get the JSON String
     * @return string json
     */
    public function getJson() {
        if ($this->getConfig('status') !== 'done') {
            $this->errors[] = 'Error, proccessing is not done yet. ';
            return json_encode($this->errors);
        }
        return $this->json;
    }

    /**
     * convenience method to encode the bodyText
     * @param  string $html the processed body text
     * @return the encoded bodyText
     */
    public function encodeBodyText($bodyText) {
        return base64_encode($bodyText);
    }

    /**
     * Add final data like ads etc.
     * @return void
     */
    private function finalize() {
        if (!empty($this->errors)) {
            $this->jsonArray = $this->errors;
            return;
        }

        $onDemandObject = $this->getConfig('onDemandObject');
        if ('channel' === $onDemandObject) {

            // put frontpage at the start and rename it.
            if (isset($this->jsonArray['categories']['frontpage'])) {
                $this->jsonArray['categories']['frontpage']['name'] = 'Top Stories';
            }
            $returnValue = reset($this->jsonArray['categories']);
            $returnValue['name'] = ucfirst($returnValue['name']);
            if ($returnValue['name'] === 'österreich') {
                $returnValue['name'] = 'Österreich';
            }

            $this->jsonArray = $returnValue;
        }

        if (null === $onDemandObject) {
            // put frontpage at the start and rename it.
            $categories = $this->jsonArray['categories'];
            $categories['frontpage']['name'] = 'Top Stories';
            $newCategories = array();
            $newCategories[] = $categories['frontpage'];
            foreach ($categories as $key => $category) {

                if ($category['name'] === 'Top Stories') {
                    continue;
                }
                $tmp = $category;
                $tmp['name'] = ucfirst($category['name']);
                $newCategories[] = $tmp;
            }

            $this->jsonArray['home']['categories'] = $newCategories;
            unset($this->jsonArray['categories']);

            // fill in additional information
            $this->jsonArray['home']['interstitial'] = array(
                'interval'  => 5,
                'url'       => $this->getAdUrl('', '', true),
                );

            $this->jsonArray['home']['impressum'] = $this->getConfig('impressum');
            $this->jsonArray['home']['ePaperUrl'] = $this->getConfig('ePaperUrl');
        }

        if ('collection' == $onDemandObject) {
            // nothing to do !
        }
    }

    /**
     * Prepares relevant Ads
     * Maps Ad-Ids to categories.
     * @return void
     */
    private function prepareAds() {
        $categories = $this->getConfig('categories');
        $adStrings = $this->getConfig('adStrings');

        $adKeys = array_keys($adStrings);

        $channelIds = array_map(function ($entry) {
            return $entry['id'];
        }, $categories);

        $channels = db()->getByIds($channelIds, 'oe24.core.Channel', false);
        if (count($channels) != count($categories)) {
            $this->errors[] = 'prepareAds: one or more Channels could not be found.' ;
                return;
        }

        foreach ($categories as $key => $category) {

            $adSlots = json_decode($channels[$category['id']]->getOptions(true, true)->get('AditionAdSlots'), true);

            if (!$adSlots) {
                continue;
            }

            $this->ads[$category['name']] = array();
            foreach ($adSlots as $adSlot) {
                $bannerName = (str_replace(array(')', '(', ' '), '', $adSlot['banner']));

                if (in_array($bannerName, $adKeys)) {
                    $this->ads[$category['name']][$adStrings[$bannerName]] = $adSlot['id'];
                }
            }
        }
    }

    /**
     * Retrieves Ad Urls
     * Points to http://www.oe24.at/_oe24app/api/ADID/getAds
     *
     * Is public so templates can use it.
     *
     * @param  string  $category
     * @param  string  $position
     * @param  boolean $interstitial [description]
     * @return string adUrl
     */
    public function getAdUrl($category, $position, $interstitial = false) {
        if ($interstitial) {
            $id = $this->getConfig('interstitial');
        } else if (isset($this->ads[$category][$position])) {
            $id = $this->ads[$category][$position];
        } else {
            return false;
                // 'http://www.oe24.at/_oe24app/api/2941124/getAds';
        }

        $link = 'http://www.oe24.at' . l('oe24.oe24.oe24app.getAds', array('adId' => $id));
        return $link;
    }


    /**
     * Function to get the Url for a Preroll of a Video.
     * This is different from normal channel Ads hence it gets its own function.
     *
     * Caches AdPositions in $videoAdCache
     * @param  $video oe24.core.Video
     * @return an Url or false.
     */
    private function getVideoPreRollUrl($video) {
        $homeChannel = $video->getHomeChannel();
        $channelId   = $homeChannel->getId();

        if ( isset($videoAdCache[$channelId])) {
            return $videoAdCache[$channelId];
        }

        $options = $homeChannel->getOptions(true, true);

        $urlPrefix  = 'http://ad1.adfarm1.adition.com/banner?sid=';
        $urlPostfix = '&wpt=X';
        $adSlots    = json_decode($options->get('AditionAdSlots'), true);
        $adSlot     = array_filter($adSlots, function ($entry) {
            return (isset($entry['banner']) && $entry['banner'] === 'Video Preroll (1)');
        });

        $adSlot = array_shift($adSlot);
        $url = '';
        if ($adSlot && isset($adSlot['id'])) {
            $url = $urlPrefix . $adSlot['id']. $urlPostfix;
            $videoAdCache[$channelId] = $url;
            return $url;
        }
        return false;
    }

    /**
     * Process articles
     *
     * Deprecated, use getArticleDataByIds
     *
     * @param  array  $ids article Ids
     * @return
     */
    private function processArticles($ids = array(), $entry = NULL) {
        // $articles = array();
        // $articles = $this->getArticleDataByIds($ids);

        // return $articles;

        // if ($this->getConfig('onDemand') === 'collection') {
        //     $ids = array_map(function($entry) {
        //         return $entry['id'];
        //     }, $articles);
        // }

        // if ($entry) {
        //     $this->jsonArray[$entry] = $articles;
        // } else {
        //     $this->jsonArray = $articles;
        // }
    }

    /**
     * Get data of article by id
     * deprecated, use getArticleDataByIds(array $ids)
     *
     * @param  int $id [description]
     * @return [type]     [description]
     */
    private function getArticleDataById($id) {
        /*
        if (!$id) {
            return array();
        }
        $article = db()->getById($id, 'oe24.core.TextualContent', false);
        if (!$article) {
            return array();
        }
        if ($article instanceof Video) {
            return $this->getVideoDataAsArticle($article);
        }
        return $this->getArticleData($article);
        */
    }

    /**
     * Get data of Articles by an array of ids
     * @param  int $id
     * @return array
     */
    private function getArticleDataByIds($ids = array()) {
        $articles = db()->getByIds($ids, 'oe24.core.TextualContent', false);
        $articleArray = array();
        foreach ($articles as $key => $article) {

            if (!$article) {
                $elem = array();
            } else {
                $elem = ($article instanceof Video) ?
                    $this->getVideoDataAsArticle($article) :
                    $this->getArticleData($article);
            }

            if (!empty($elem)) {
                $articleArray['articles'][] = $elem;
            }
        }
        return $articleArray;
    }

    /**
     * returns video data
     * @param  oe24.core.Video $video
     * @return array
     */
    private function getVideoDataAsArticle($video) {
        $image = $video->getFirstRelatedImage();
        if (NULL === $image) {
            return NULL;
        }

        // $imgSrc = $image->getFileUrl('bigStory');
        $imgSrc = $image->getFileUrl('Oe24AppBigStory');
        $oewaTag = $this->getConfig('defaultOewaTag');

        $articleId = (int) $video->getId();

        $preTitle = $this->sanitize($video->getPreTitle(true));
        $title = $this->sanitize($video->getTitle(true));
        $leadText = $this->sanitize($video->getLeadText(true, true));
        $contentUrl = $video->getUrl(true);

        $arr = array(
            'id'           => (string) $articleId,
            'oewaPath'     => $oewaTag,
            'headline'     => $title,
            'sub_headline' => $preTitle,
            'abstract'     => $leadText ? strip_tags($leadText) : '',
            'image_url'    => trim($imgSrc),
            'url'          => trim($contentUrl),
            'publishDate'  => trim($video->getPublishDate()->__toString()),
        );

        $mp4ID = $video->getVideoId();
        if (strpos($mp4ID, '://') > 0) {
            $videoUrl = $mp4ID;
        } else {
            $videoUrl = 'http://vs-pd10.sf.apa.at/vs_oe24/' . $mp4ID . '.mp4'; // APA MP4
        }
        $arr['videoUrl']     = $videoUrl;
        $credit              = $video->getFrontendSource()->getName();
        $arr['credit']       = $this->sanitize($credit);
        $arr['duration']     = ($video->getVideoLength()) ? $video->getVideoLength() : '00:00';
        $arr['canonicalUrl'] = $video->getUrl();

        try {
            $isLivestream = $video->getIsLivestream();
        } catch (Exception $e) {
            $isLivestream = NULL;
        }
        $isLivestream = (!$isLivestream) ? false : $isLivestream;
        $arr['live'] = $isLivestream;

        $preRollUrl = $this->getVideoPreRollUrl($video);
        if (false !== $preRollUrl) {
            $arr['ads'] = true;
            $arr['preroll'] = $preRollUrl;
            $arr['autostart'] = true;
        } else {
            $arr['ads'] = false;
        }

        $image             = $video->getFirstRelatedImage();
        // $imageUrl          = ($image) ? $image->getFileUrl('bigStoryCrop') : lp('image', 'empty.gif');
        $imageUrl          = ($image) ? $image->getFileUrl('Oe24AppBigStoryCrop') : lp('image', 'empty.gif');
        $arr['previewUrl'] = $imageUrl;

        $returnValue = array();
        $returnValue = array(
                'typ'       => 'video',
                'article'   => $arr,
        );

        return $returnValue;
    }

    /**
     * Get Data of Article
     * @param  oe24.core.Text  $article
     * @return array
     */
    private function getArticleData($article, $oewaTag = null, $imageFormat = null) {
        if (!$article) {
            return array();
        }

        $oewaPath = ($oewaTag) ? $oewaTag : $this->getConfig('defaultOewaTag');

        $returnValue    = array();
        $id             = $article->getId();
        $preTitle       = $this->sanitize($article->getPretitle());
        $title          = $this->sanitize($article->getTitle());
        $postTitle      = $this->sanitize($article->getPostTitle());
        $leadText       = $this->sanitize($article->getLeadText());
        $articleUrl     = $article->getUrl();
        $publishDate    = $article->getFrontendDate();

        $image          = $article->getFirstRelatedImage();
        $imageUrl       = ($image) ? $image->getFileUrl() : lp('image', 'empty.gif');

        $oe24Portal     = $this->portal;

        $bodyText   = templateAsString(
            'oe24.oe24.device.oe24app.tpl.article.article',
            array('device' => $this,
                  'article'=> $article,
                  'portal' => $oe24Portal,
                  'layout' => 'smartphone')
            );

        // remove html comment tags
        $bodyText = preg_replace('/<!--(.*)-->/Uis', '', $bodyText);

        // and encode it
        $bodyText = $this->encodeBodyText($bodyText);

        // entgeltlicher Content
        $advertorial = ($article->getOptions(true, true)->get('EntgeltlicherContent')) ? true : false;

        $returnValue = array(
            'typ'              => 'article',
            'article'          => array(
                'id'               => (string) $id,
                'pre_headline'     => $preTitle,
                'article_headline' => $title,
                'sub_headline'     => $postTitle,
                'abstract'         => $leadText ? strip_tags($leadText) : '',
                'articleUrl'       => $articleUrl,
                'publishDate'      => $publishDate->__toString(),
                'oewaPath'         => $oewaPath,
                'image'            => $imageUrl,
                'advertorial'      => $advertorial,
                'bodyText'         => $bodyText,
            ),
        );

        $pre_ad = $this->getAdUrl('frontpage', 'artikel_top');
        $post_ad = $this->getAdUrl('frontpage', 'artikel_bottom');

        if ($pre_ad !== false) {
            $returnValue['article']['pre_ad'] = $pre_ad;
        }

        if ($post_ad !== false) {
            $returnValue['article']['post_ad'] = $post_ad;
        }

        $media = $this->getMediaData($article);
        if (!empty($media)) {
            $returnValue['article']['media'] = $media;
        }

        return $returnValue;
    }


    /**
     * Get Article Data via Database
     * This is needed because the speed of SpunQ-Calls is not up to scratch.
     *
     * not used atm.
     * @param  [type] $ids [description]
     * @return [type]      [description]
     */
    private function getArticleDataViaDatabase($ids) {
        $query = new spunQ_SelectQuery();
        $query->setProperties(array(
            'preTitle',
            'postTitle',
            'title',
            'leadText',
            'bodyText'
            ));
        $query->setType('oe24.core.TextualContent');
        $query->setConditions(
            array(
                'id IN {ids}'
            )
        );

        $query->setReturnType(spunQ_SelectQuery::RETURN_ARRAY);
        $data = $query->execute(array(
            'ids' => $ids,
        ));
    }

    /**
     * Returns MediaData (i.e. Images and Videos)
     * @param  [type] $article [description]
     * @return
     */
    public function getMediaData($article, $imageFormat = null) {

        $videoCount = 0;

        $relatedData = array();
        $articleId = $article->getId();
        $query = new spunQ_SelectQuery();
        $query->setProperties(array(
            'relatedContent._value.id'
            ));

        $query->setType('oe24.core.Content');
        $query->setConditions(array(
            'id = {contentId}'
            ));
        $query->setReturnType(spunQ_SelectQuery::RETURN_ARRAY);

        $relatedIds = $query->execute(array(
            'contentId' => $articleId,
            ));

        // add own information to related articles if it is a video
        // else the video won't be shown.
        if ($article instanceof Video) {
            array_push($relatedIds,
                array(
                    'relatedContent._value.id' => $article->getId()
                )
            );
        }

        $objects = array();
        foreach ($relatedIds as $key => $relatedId) {
            $r_id = $relatedId['relatedContent._value.id'];
            if (!$r_id) {
                continue;
            }
            $object = db()->getById($r_id, 'oe24.core.Content', false);

            if ($object) {
                $data = array();
                $addData = false;

                $type = '';
                switch (true) {
                    case $object instanceof Image:
                        $imageId = (string) $object->getId();
                        $imageUrl = ($imageFormat) ? $object->getFileUrl($imageFormat) : $object->getFileUrl();
                        $copyright = $object->getCopyright();

                        $data['typ'] = 'image';
                        $data['image'] = array(
                            'id' => $imageId,
                            'url' => $imageUrl,
                            'copyright' => (null != $copyright && '' != $copyright) ? '© '.$copyright : '',
                        );

                        $type = 'image';
                        $addData = true;
                        break;
                    case $object instanceof Video:
                        $videoId = (string) $object->getId();

                        $mp4ID = $object->getVideoId();
                        if (strpos($mp4ID, '://') > 0) {
                            $videoUrl = $mp4ID;
                        } else {
                            $videoUrl = 'http://vs-pd10.sf.apa.at/vs_oe24/' . $mp4ID . '.mp4';
                        }

                        $image    = $article->getFirstRelatedImage();
                        $imageUrl = ($image) ? $image->getFileUrl() : lp('image', 'empty.gif');

                        $data['typ'] = 'video';
                        $data['video'] = array(
                            'id' => $videoId,
                            'url' => $videoUrl,
                            'previewUrl' => $imageUrl,
                        );

                        $preRollUrl = $this->getVideoPreRollUrl($object);
                        if (false !== $preRollUrl) {
                            $data['video']['ads'] = true;
                            $data['video']['preroll'] = $preRollUrl;
                            $data['video']['autostart'] = true;
                        } else {
                            $data['video']['ads'] = false;
                        }

                        $type = 'video';
                        $addData = true;

                        break;
                    default:
                        continue;
                }

                if ($addData) {
                    // add Images at the End
                    if ($type === 'image') {
                        array_push($relatedData, $data);
                    } else {
                    // and Videos at the Start
                        $videoCount++;
                        array_unshift($relatedData, $data);
                    }
                }
            }
        }

        // if there is a video, return only the video.
        if ($videoCount > 0) {
            $relatedData = array_slice($relatedData, 0, $videoCount);
        }


        return $relatedData;
    }

    /**
     * Translates LayoutIdentifiers from TabbedBoxes to a color.
     * @param  string $layoutIdentifier
     * @return string a rgb hex color or the standard red.
     */
    public function getColorFromLayoutIdentifier($layoutIdentifier, $isBusiness = false) {
        return ($isBusiness) ? getBusinessChannelColor($layoutIdentifier) : getChannelColor($layoutIdentifier);
    }

    /**
     * Translates categories and the layout Identifiers thereof to a color.
     * @param  string $category
     * @return string a rgb hex color or the standard red.
     */
    public function getColorFromCategory($category) {
        return (isset($categories2Colors[$category]) ? $categories2Colors[$category] : '#d0113a');
    }

    /**
     * Set a config value
     * @param string  $key
     * @param any     $value
     * @param boolean $override
     */
    public function setConfig($key, $value, $override = true) {

        if ($override) {
            $this->config[$key] = $value;
            return true;
        } elseif (!isset($this->config[$key])) {
            $this->config[$key] = $value;
            return true;
        } else {
            return false;
        }
    }

    /**
     * This method strips all new Lines in the Headlines
     * @param  $text string
     * @return sanitized string
     */
    public function sanitize($text) {
        $tmp = str_replace(array("\r","\n","\t"), '', $text);
        return html_entity_decode($tmp);
    }

    /**
     * Retrieves a Config Value
     * @param  [type] $key [description]
     * @return the value or null
     */
    public function getConfig($key = null) {
        if (isset($this->config[$key])) {
            return $this->config[$key];
        } else {
            return null;
        }
    }

}
