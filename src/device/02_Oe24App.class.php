<?
/**
 * Oe24App Class.
 *
 * This class handles all operations related to the Oe24App.
 * Additional files are page/oe24app/getArticle.page and tpl/device/oe24app/*
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
    private $ads           = array();

    private $handler;

    /**
     * Mapping of BoxTypes to Default Templates
     * @var array
     */
    private $defaultTemplates = array(
        'oe24.core.TabbedBox'   => true,
        'oe24.core.ContentBox'  => 'oe24.oe24.device.oe24app.tpl.contentBox.contentBox',
        'oe24.core.ConsoleBox'  => 'oe24.oe24.device.oe24app.tpl.consoleBox.consoleBox',
        'oe24.core.TemplateBox' => false,
        'oe24.core.FreeHtmlBox' => false,
        'oe24.core.XmlBox'      => false,
    );
    /**
     * Private Constructor
     */
    private function __construct() {}

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

        $this->handler       = new Oe24AppArticleHandler($this);

        $this->tplAnnotation = $this->getConfig('deviceType').'Tpl';
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
        $boxes = $this->filterBoxes($boxes);
        $maxBoxes = ($isFrontpage) ? $this->getConfig('maxBoxesFrontpage') : $this->getConfig('maxBoxes');
        $boxes = array_slice($boxes, 0, (int) $maxBoxes);
        return $boxes;
    }

    /**
    *   Filters the Boxes of a Channel so that only valid representations are used.
    *   @param $boxes   oe24.core.FrontendBox
    *   @return array<oe24.core.FrontendBox>
    */
    private function filterBoxes($boxes = array()) {
        $validBoxes = array();
        foreach ($boxes as $key => $box) {
            $boxTemplateString = $box->getTemplate();
            $boxTemplate = spunQ_Template::get($boxTemplateString);

            $annotations = $boxTemplate->getAnnotations();

            $annotationsTpl = $annotations->get($this->tplAnnotation);
            $templateString = (isset($annotationsTpl[0])) ? $annotationsTpl[0] : null;
            if (!$templateString) {

                $boxType = $box->_getType()->getName();
                if (false == $this->defaultTemplates[$boxType]) {
                    continue;
                }
                if (    !(isset($this->defaultTemplates[$boxType]))
                     && !($box instanceof TabbedBox)
                   ) {
                    $this->errors[] = "Der BoxType $boxType ist nicht in den `defaultTemplates` definiert')";
                    continue;
                }

                if ($box instanceof TabbedBox) {
                    $tabboxBoxes = self::getBoxesOfTabbedBox($box);
                    $add = $this->filterBoxes($tabboxBoxes);
                    $validBoxes[] = array_shift($add);

                    continue;
                }
                $templateString = $this->defaultTemplates[$boxType];
            }

            $validBoxes[] = array(
                'box'      => $box,
                'template' => $templateString
            );
        }

        return $validBoxes;
    }

    /**
     * Convenience method to get contents of TabbedBoxes.
     * If a TabbedBox is in another TabbedBox, it gets continued.
     * @param  oe24.core.TabbedBox $tabbedBox
     * @return array<oe24.core.FrontendBox>
     */
    public static function getBoxesOfTabbedBox($tabbedBox) {
        $validBoxes = array();
        if (!($tabbedBox instanceof TabbedBox)) {
            return null;
        }
        $tabItems = $tabbedBox->getTabbedBoxItems();
        if (!$tabItems) {
            return null;
        }
        foreach ($tabItems as $key => $tabItem) {
            $tabItemBoxes = $tabItem->getBoxes();
            if (!$tabItemBoxes) {
                continue;
            }
            foreach ($tabItemBoxes as $key => $box) {
                if ($box instanceof TabbedBox) {
                    continue;
                }

                $validBoxes[] = $box;
            }
        }
        return $validBoxes;
    }

    public function processDevice() {
        $this->setConfig('status', 'processing');

        $ids            = $this->getConfig('ids');
        $onlyArticles = (   $ids != NULL
                         && is_array($ids)
                         && isset($ids[0])
                         && (count($ids) > 1 || $ids[0] !== 1)
                        );

        if ($onlyArticles) {
            $this->setConfig('onlyArticles', true);
            $this->processArticles($ids);
        } else {
            $this->setConfig('onlyArticles', false);

            // handle boxes and categories
            $categories     = $this->getConfig('categories');
            $categoryArray  = array();

            $defaultOewaPath = $this->getConfig('defaultOewaTag');
            foreach ($categories as $key => $category) {

                $channel = db()->getById($category['id'], 'oe24.core.Channel', false);

                if (!$channel) {
                    $this->errors[] = 'Konnte Kategorie '.$category['name'].' mit Channel-id '.$category['id'].' nicht finden.';
                    continue;
                }

                $oewaTag = $channel->getOewaTag();

                $oewaPath = $oewaTag ? $oewaTag->getUrlSchemaName() . '/oe24.at/moewa' : $defaultOewaPath;

                $isFrontpage = ($category['name'] === 'frontpage') ? true : false;

                array_push($categoryArray,
                    array(
                        'name'  => $category['name'],
                        'id'    => $category['id'],
                        'boxes' => $this->getBoxes($channel, $isFrontpage),
                        'oewa'  => $oewaPath,
                ));
            }

            $this->processBoxes($categoryArray);

            $this->processCollections();
        }

        // here both paths meet
        $this->setConfig('status', 'finalizing');
        $this->finalize();
        $this->setConfig('status', 'encoding');
        $this->encode();
        $this->setConfig('status', 'done');
    }

    public function processCollections() {
        $collectionArray = $this->getConfig('collections');

        if (!$collectionArray) {
            return;
        }
        foreach ($collectionArray as $collection) {

            $itemQuery = new spunQ_SelectQuery();
            $itemQuery->setProperties(array(
                'items._value.id'
                ));

            $itemQuery->setType('oe24.core.ContentCollection');
            $itemQuery->setConditions(array(
                'id = {collectionId}'
            ));

            $itemQuery->setReturnType(spunQ_SelectQuery::RETURN_ARRAY);

            $data = $itemQuery->execute(array(
                'collectionId' => $collection['id'],
            ));

            $articleIds = array();
            $articleIds = array_map(function($entry) {
                return $entry['items._value.id'];
            }, $data);

            if ($collection['name'] == 'video') {
                $articleIds = array_merge(array((int) $this->getConfig('livestreamId')), $articleIds);
            }

            $maxArticles = $this->getConfig('maxCollectionArticles');
            $articleIds = array_slice($articleIds, 0, $maxArticles);

            $this->processArticles($articleIds, $collection['name']);
        }
    }

    public function processBoxes($categoryArray = array()) {
        foreach ($categoryArray as $key => $category) {
            $categoryName = $category['name'];

            $this->jsonArray['categories'][$categoryName]['id']   = (string) $category['id'];
            $this->jsonArray['categories'][$categoryName]['name'] = $categoryName;
            $this->jsonArray['categories'][$categoryName]['oewaPath'] = $category['oewa'];

            // (bs) es war angedacht, dass nur in der ersten Kategorie xlBoxen etc ausgespielt
            // werden. da das jetzt auch in den anderen passiert, brauchen wir diese zeile nicht mehr
            // $this->setConfig('firstCategory', ($key === 0));

            $boxesOfCategory = $category['boxes'];
            if (!empty($boxesOfCategory)) {
                tpl('oe24.oe24.device.oe24app.tpl.categoryHeadline.categoryHeadline', array(
                    'device'        => $this,
                    'categoryName'  => $categoryName,
                    'channelId'     => $category['id'],
                    ));
            }

            foreach ($boxesOfCategory as $key => $boxEntry) {

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
                         ),
                    $categoryIdArray);
            }
        } // end of foreach Category
    }

    private function getBoxRepresentationAsArray($templateString, $params, &$categoryIdArray = array()) {
        $box = $params['box'];

        tpl('oe24.oe24.device.oe24app.tpl.boxHeadline.boxHeadline', array(
            'device'       => $this,
            'box'          => $box,
            'categoryName' => $params['category'],
        ));

        $articles = ($box instanceof ConsoleBox) ? $box->getContents() : $box->getContentOfAllDropAreas(true);

        // $articles = array_filter($articles, function($entry) {
        //     return ($entry instanceof Text);
        // });

        $articlesFiltered = array();
        foreach ($articles as $key => $article) {
            $articleId = $article->getId();
            if (!in_array($articleId, $categoryIdArray) && ($article instanceof Text)) {
                $categoryIdArray[] = $articleId;
                $articlesFiltered[] = $article;
            }
        }

        tpl($templateString, array(
            'box'           =>  $box,
            'articles'      =>  $articlesFiltered,
            'category'      =>  $params['category'],
            'device'        =>  $this,
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
     * If all went ok, use this method to encode the Data Array.
     * @return void
     */
    private function encode() {
        if ($this->getConfig('status') !== 'encoding') {
            return json_encode('Error, process device first! ');
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
            return json_encode('Error, proccessing is not done yet. ');
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
        }

        if (!$this->getConfig('onlyArticles')) {
            $categories = $this->jsonArray['categories'];
            $categories['frontpage']['name'] = 'Startseite';
            $newCategories = array();
            $newCategories[] = $categories['frontpage'];
            // error(var_dump($categories));
            foreach ($categories as $key => $category) {
                // if ($category['name'] === 'frontpage') {
                // if (!isset($category['name'])) {
                //     var_dump($category);
                //     continue;
                // }
                if ($category['name'] === 'Startseite') {
                    continue;
                }
                $tmp = $category;
                $tmp['name'] = ucfirst($category['name']);
                $newCategories[] = $tmp;
            }

            $this->jsonArray['home']['categories'] = $newCategories;
            unset($this->jsonArray['categories']);

            $this->jsonArray['home']['interstitial'] = array(
                'interval'  => 10,
                'url'       => $this->getAdUrl('', '', true),
                );

            $this->jsonArray['home']['impressum'] = $this->getConfig('impressum');
            $this->jsonArray['home']['ePaperUrl'] = $this->getConfig('ePaperUrl');
        }
    }

    private function prepareAds() {
        $categories = $this->getConfig('categories');
        $adStrings = $this->getConfig('adStrings');

        $adKeys = array_keys($adStrings);
        foreach ($categories as $key => $category) {
            $channel = db()->getById($category['id'], 'oe24.core.Channel', false);
            if (!$channel) {
                $this->errors[] = 'prepareAds: could not find Channel with id: ' . $category['id'];
                return;
            }
            $adSlots = json_decode($channel->getOptions()->get('AditionAdSlots'), true);
            $this->ads[$category['name']] = array();
            if (!$adSlots) {
                continue;
            }
            foreach ($adSlots as $adSlot) {
                $bannerName = $adSlot['banner'];
                $bannerName = (str_replace(array(')', '(', ' '), '', $bannerName));

                if (in_array($bannerName, $adKeys)) {
                    $this->ads[$category['name']][$adStrings[$bannerName]] = $adSlot['id'];
                }
            }
        }
    }

    public function getAdUrl($category, $position, $interstitial = false) {

        if ($interstitial) {
            $id = $this->getConfig('interstitial');
        } else if (isset($this->ads[$category][$position])) {
            $id = $this->ads[$category][$position];
        } else {
            $id = 0;
        }

        $link = 'http://www.oe24.at' . l('oe24.oe24.oe24app.getAds', array('adId' => $id));
        return $link;
    }


    /**
     * Function to get the Url for a Preroll of a Video.
     * This is different from normal channel Ads hence it gets its own function.
     * @param  [type] $video [description]
     * @return [type]        [description]
     */
    public function getVideoPreRollUrl($video) {
        $urlPrefix  = 'http://ad1.adfarm1.adition.com/banner?sid=';
        $urlPostfix = '&wpt=X';
        $adSlots = json_decode($video->getOptions(true, true)->get('AditionAdSlots'), true);
        $adSlot = array_filter($adSlots, function ($entry) {
            return (isset($entry['banner']) && $entry['banner'] === 'Video Preroll (1)');
        });

        $adSlot = array_shift($adSlot);
        if ($adSlot && isset($adSlot['id'])) {
            return $urlPrefix . $adSlot['id']. $urlPostfix;
        }
        return false;
    }

    /**
     * Process articles
     * @param  array  $ids article Ids
     * @return
     */
    private function processArticles($ids = array(), $entry = NULL) {
        $articles = array();
        $articleArray = array();
        foreach ($ids as $key => $id) {
            $articleData = $this->getArticleDataById($id);

            if (empty($articleData)) {
                continue;
            }

            if ($articleData) {
                $articles['articles'][] = $articleData;
            }
        }
        if ($entry) {
            $this->jsonArray[$entry] = $articles;
        } else {
            $this->jsonArray = $articles;
        }
    }

    /**
     * Get Data of Article by Id
     * @param  int $id [description]
     * @return [type]     [description]
     */
    private function getArticleDataById($id) {
        if (!$id) {
            return array();
        }
        $article = db()->getById($id, 'oe24.core.TextualContent', false);
        if (!$article) {
            return array();
        }
        if ($article instanceof Video) {
            return $this->handler->getVideoDataAsArticle($article);
        }
        return $this->getArticleData($article);
    }

    /*
    private function getVideoDataAsArticle($video) {
        $image = $video->getFirstRelatedImage();
        if (NULL === $image) {
            return NULL;
        }

        $imgSrc = $image->getFileUrl('bigStory');
        $leadText = trim($video->getLeadText(true, true));
        $pattern = '/(<br\ ?\/?>)+/iusU';
        $leadText = preg_replace($pattern, '', $leadText);
        $pattern = '/<h[1-6].*?>(.*?)<\/h[1-6]>/isu';
        $leadText = preg_replace($pattern, '${1}', $leadText);
        $pattern = '/<p.*?>(.*?)<\/p>/isu';
        $leadText = preg_replace($pattern, '${1}', $leadText);
        $leadText = preg_replace('/\s*$/iusU','',$leadText);
        $leadText = trim(str_replace(array("\n\r","\n","\r"), ' ', $leadText));

        $oewaTag = '';
        $options = $video->getOptions(true, true);
        $contentHomeChannel = $video->getHomeChannel();
        if (true === $options->get('OewaTracking') && $contentHomeChannel->getOewaTag(true)) {
            $oewaTag = $contentHomeChannel->getOewaTag(true)->getUrlSchemaName();
        }
        if (!$oewaTag) {
            $oewaTag = $this->getConfig('defaultOewaTag');
        }

        $articleId = (int) $video->getId();

        $title = $video->getTitle(true);
        $preTitle = $video->getPreTitle(true);
        $contentUrl = $video->getUrl(true);

        $arr = array(
            'id' => $articleId,
            'oewaPath' => trim($oewaTag),
            'headline' => trim($title),
            'sub_headline' => trim($preTitle),
            'abstract' => $leadText ? strip_tags($leadText) : '',
            'image_url' => trim($imgSrc),
            'url' => trim($contentUrl),
            'publishDate' => trim($video->getPublishDate()->__toString()),
        );

        $mp4ID = $video->getVideoId();
        if (strpos($mp4ID, '://') > 0) {
            $videoUrl = $mp4ID;
        } else {
            $videoUrl = 'http://vs-pd10.sf.apa.at/vs_oe24/' . $mp4ID . '.mp4'; // APA MP4
        }
        $arr['videoUrl'] = $videoUrl;

        $credit = trim($video->getFrontendSource()->getName());
        $credit = trim($credit, '.');
        $arr['credit'] = $credit;
        $arr['duration'] = ($video->getVideoLength()) ? $video->getVideoLength() : '00:00';
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

        $image    = $video->getFirstRelatedImage();
        $imageUrl = ($image) ? $image->getFileUrl() : lp('image', 'empty.gif');
        $arr['previewUrl'] = $imageUrl;

        $returnValue = array();
        $returnValue = array(
                'typ'       => 'video',
                'article'   => $arr,
        );

        return $returnValue;
    }
    */

    /**
     * Get Data of Article
     * @param  oe24.core.Text  $article
     * @return array
     */
    private function getArticleData($article) {
        if (!$article) {
            return array();
        }
        $defaultOewaPath = $this->getConfig('defaultOewaTag');
        $homeChannel = $article->getHomeChannel();
        if ($homeChannel && $article->getHomeChannel()->getOewaTag(true)) {
            $oewaPath = $article->getHomeChannel()->getOewaTag(true)->getUrlSchemaName();
        } else {
            $oewaPath = $defaultOewaPath;
        }

        $returnValue    = array();
        $id             = $article->getId();
        $preTitle       = $article->getPretitle();
        $title          = $article->getTitle();
        $postTitle      = $article->getPostTitle();
        $leadText       = $article->getLeadText();
        $articleUrl     = $article->getUrl();
        $publishDate    = $article->getFrontendDate();

        $image          = $article->getFirstRelatedImage();
        $imageUrl       = ($image) ? $image->getFileUrl() : lp('image', 'empty.gif');

        $oe24Portal     = Portal::getPortalByName('oe24', false);

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
                'pre_ad'           => $this->getAdUrl('frontpage', 'artikel_top'),
                'post_ad'          => $this->getAdUrl('frontpage', 'artikel_bottom'),
            ),
        );

        // $media = $this->getMediaData($article);

        $media = $this->handler->getMediaData($article);
        if (!empty($media)) {
            $returnValue['article']['media'] = $media;
        }

        return $returnValue;
    }


    /**
     * Get Article Data via Database
     * This is needed because the speed of SpunQ-Calls is not up to scratch.
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
        $query->setConditions(array(
            'id IN {ids}'
        ));

        $query->setReturnType(spunQ_SelectQuery::RETURN_ARRAY);

        $data = $query->execute(array(
            'ids' => $ids,
        ));
    }

    /**
     * Injects MediaData
     * @param  [type] $article [description]
     * @return
     */
    public function getMediaData($article) {
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
                switch (true) {
                    case $object instanceof Image:
                        $imageId = (string) $object->getId();
                        $imageUrl = $object->getFileUrl();


                        $data['typ'] = 'image';
                        $data['image'] = array(
                            'id' => $imageId,
                            'url' => $imageUrl,
                        );

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

                        $addData = true;

                        break;
                    default:
                        continue;
                }

                if ($addData) {
                    $relatedData[] = $data;
                }
            }
        }

        return $relatedData;
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
