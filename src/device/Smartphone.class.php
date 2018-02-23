<?

class Smartphone extends Device {

    private static $startTime = null;

    private static $instance = null;

    private $config        = array();
    private $contents      = array();
    private $boxes         = array();
    private $tplAnnotation = '';

    private $defaultTemplates = array(

        'oe24.core.TabbedBox'   => 'oe24.oe24.device.smartphone.tpl.tabbedBox.tabbedBox',
        'oe24.core.ContentBox'  => 'oe24.oe24.device.smartphone.tpl.contentBox.contentBox',
        'oe24.core.ConsoleBox'  => 'oe24.oe24.device.smartphone.tpl.consoleBox.consoleBox',

        // TODO: was passiert mit diesen BoxTypen?
        'oe24.core.TemplateBox' => 'oe24.oe24.device.smartphone.tpl.templateBox.templateBox',
        'oe24.core.FreeHtmlBox' => 'oe24.oe24.device.smartphone.tpl.htmlBox.htmlBox',
        'oe24.core.XmlBox'      => 'oe24.oe24.device.smartphone.tpl.xmlBox.xmlBox',
    );


    // ---------------------------------------------------


    private function __construct() {}


    // ---------------------------------------------------


    public static function getInstance() {

        if (null === self::$instance) {
            self::$instance = new SmartPhone();
        }

        return self::$instance;
    }


    // ---------------------------------------------------


    public function init($config = array()) {

        $this->config = $config;
        $this->tplAnnotation = $this->getConfig('deviceType').'Tpl';

        if (null != $config['article']) {
            // Wenn es sich um einen Artikel-Request handelt, duerfen
            // die folgenden Ablauefe NICHT durchgefuehrt werden.
            return;
        }

        $this->validColumns = $this->getConfig('validColumns');

        self::$startTime = microtime(true);

        $this->boxes = $this->getBoxes($this->config['channel']);
    }

    private function setBenchmark($message) {
        $time = microtime(true) - self::$startTime;
        $time = number_format($time, 4, '.', '');
        $message = $message . ' : ' . $time;
        error($message);
    }


    public function processDevice() {
        $this->contents = $this->processBoxes($this->boxes);
    }


    // ---------------------------------------------------


    public function getChannelContents() {

        return $this->contents;
    }


    // ---------------------------------------------------


    private function getBoxes($channel) {

        if (!is_array($this->validColumns)) {
            return;
        }

        $column = null;
        $boxes = array();

        foreach ($this->validColumns as $validColumn) {

            if (!is_string($validColumn)) {
                continue;
            }

            $column = $channel->getColumnByName($validColumn, true, false);
            if (!$column) {
                continue;
            }

            $boxes = $column->getBoxes();
            if (!empty($boxes)) {
                // Es wurden Boxen in der Column gefunden
                // debug($column);
                $this->setConfig('usingColumn', $column->getName());
                break;
            }
        }

        if (empty($boxes)) {
            // Noch keine Boxen gefunden? Ok, nachschauen, ob welche im Parent-Channel gesetzt sind
            $parentChannel = $channel->getParent();
            if ($parentChannel instanceof Channel) {
                $boxes = $this->getBoxes($parentChannel);
            }
        }

        $this->boxes = $boxes;
        return $boxes;
    }


    // ---------------------------------------------------


    public function processBoxes($boxes) {

        if (!is_array($boxes)) {
            return null;
        }

        // $before = memory_get_usage();

        $contents = array();

        foreach ($boxes as $box) {
            $boxTemplateString = $box->getTemplate();

            // $errorMessage = 'processBoxes mit ' . $box->getTemplate() . 'id: ' . $box->getId();

            // error($errorMessage);

            // $this->setBenchmark($errorMessage);
            $boxTemplate = spunQ_Template::get($boxTemplateString);

            $annotations = $boxTemplate->getAnnotations();
            $annotationsTpl = $annotations->get($this->tplAnnotation);
            $templateString = (isset($annotationsTpl[0])) ? $annotationsTpl[0] : null;
            if (!$templateString) {
                $boxType = $box->_getType()->getName();
                if ( ! isset($this->defaultTemplates[$boxType])) {
                    error('Der BoxType `'.$boxType.'` ist nicht in den `defaultTemplates` definiert');
                    continue;
                }
                $templateString = $this->defaultTemplates[$boxType];
            }

            try {
                $contents[] = templateAsString($templateString, array(
                    'channel' => $this->getConfig('channel'),
                    'box'     => $box,
                ));

            } catch (spunQ_UnresolvedAliasException $e) {

                error('Ein Template wurde nicht gefunden: `'.$e->getMessage().'`');
                continue;

            } catch (spunQ_Exception $e) {

                // error('Allgemeine Exception in `'.$templateString.'` wurde ausgeloest: '.$e->getBacktrace());
                error('Allgemeine Exception in `'.$e->getFile().' Zeile '.$e->getLine().'` wurde ausgeloest: `'.$e->getMessage().'`');
                continue;

            }

            // $fileInfo = str_replace('Smartphone::', '', __METHOD__).' ['.__LINE__.']';
            // $boxInfo = str_replace('oe24.core.', '', $box->_getType()->getName()).' id '.$box->getId();
            // $this->setBenchmark($fileInfo.' '.$boxInfo.' '.$boxTemplateString);
        }

        // $after = memory_get_usage();
        // $allocatedSize = ($after - $before) / 1024;
        // $this->setBenchmark('Size für BoxId ' . $box->getId() .': ' . $allocatedSize. ' kB');


        return $contents;
    }


    // ---------------------------------------------------
    // ---------------------------------------------------
    // ---------------------------------------------------


    public function getDataURI($image, $mime = '') {
        // https://davidwalsh.name/data-uri-php
        return 'data: '.(function_exists('mime_content_type') ? mime_content_type($image) : $mime).';base64,'.base64_encode(file_get_contents($image));
    }


    // ---------------------------------------------------


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


    // ---------------------------------------------------


    public function getConfig($key = null) {
        if (null == $key) {
            return $this->config;
        }

        if (isset($this->config[$key])) {
            return $this->config[$key];
        } else {
            return null;
        }
    }


    // ---------------------------------------------------
    // ---------------------------------------------------
    // ---------------------------------------------------


    public function getArticleContents($article) {

        $id = $article->getId();

        // ----------------------------------------------

        $frontendDate = $article->getFrontendDate();
        $dateTime = formatDateUsingIntlLangKey('datetime.short', $frontendDate);

        // ----------------------------------------------

        $preTitle = trim($article->getPreTitle(true));

        // ----------------------------------------------

        $title = trim($article->getTitle(true));

        // Am Dev unnoetigen Titel-Prefix entfernen
        // $title = str_replace(array('OEST15 - ', 'mad15 -'), '', $title);

        // ----------------------------------------------

        $leadText = trim($article->getLeadText(true, true));

        // whitespace entfernen
        $leadText = preg_replace('/\s*$/iusU','',$leadText);
        $leadText = trim(str_replace(array("\n\r","\n","\r"), ' ', $leadText));

        // ----------------------------------------------

        // $firstRelatedImage = $article->getFirstRelatedImage(true);
        // $copyright = (null != $firstRelatedImage) ? trim($firstRelatedImage->getCopyright()) : '-';
        // $copyright = '© '.$copyright;

        // $image = array(
        //     'image' => $firstRelatedImage,
        //     'copyright' => $copyright,
        // );

        // ----------------------------------------------

        $relatedImages = $article->getRelatedImages(false, false);
        // $relatedImages = array();

        // ----------------------------------------------

        $isVideoStory = false;

        $videoLength = '--:--';
        if ($article instanceof Video) {
            $isVideoStory = true;
            $videoLength = $article->getVideoLength();
            $videoLength = ($videoLength) ? $videoLength : '--:--';

            // TODO: Soll statt dem LeadText die Video-Dauer gezeigt werden?
            $leadText = $videoLength;
        }

        // ----------------------------------------------

        $relatedVideos = $article->getRelatedVideos();
        $video = reset($relatedVideos);

        // $isVideoStory = ($video) || $isVideoStory;

        // ----------------------------------------------

        // (bs) DAILY-780 Werbung soll im Artikel-Body ausgespielt werden.
        $articleOptions = $article->getOptions(true, true);
        $showAdsInBody  = $articleOptions->get('AditionAdTags') !== 'Keine Werbung Laden';
        $layoutOverride = $articleOptions->get('layoutOverride');

        // (bs) 2017-06-08 Ads should be inserted into article body in all layout overrides.
        // if (1 && $showAdsInBody && ('oe24' === $layoutOverride)) {
        if ($showAdsInBody) {
            $bodyText = $article->getBodyText();
            $explodeTag = '</p>';

            $modifiedBodyText = '';
            $stringLengthSum  = 0;
            $adAdded = false;
            $limit = 1200;

            $pTagsArray = explode($explodeTag, $bodyText);
            foreach ($pTagsArray as $key => $pTag) {
                $pTagLength = mb_strlen($pTag);
                $stringLengthSum += $pTagLength;
                if ($stringLengthSum > $limit && !$adAdded && ($key > 1)) {

                    // (bs) damit es nicht evtl. gestyle <p> Blocke (wie z.B. bei Instagram)
                    // zammhaut, mach weiter
                    if (stripos('<p style', $pTag) !== false) {
                        continue;
                    }

                    $adAdded = true;
                    $adTemplate =
                        templateAsString('oe24.oe24.device.smartphone.tpl._adition.adition',
                            array(
                                'channel'     => $this->getConfig('channel'),
                                'object'      => $article,
                                'banner'      => 'MobileArtikelMiddle',
                                'centerAlign' => true,
                                ));
                    $modifiedBodyText .= $adTemplate;
                }

                $modifiedBodyText .= $pTag . $explodeTag;
            }

            $oldBodyText = $article->getBodyText();
            $article->setBodyText($modifiedBodyText);
        }

        $bodyText = $article->getBodyText(true, true, 'smartphone' /* z.B.: 'madonna' */ );

        if (1 && $showAdsInBody) {
            $article->setBodyText($oldBodyText);
        }

        // ----------------------------------------------
        // ----------------------------------------------

        $contents = array(
            'id'            => $id,
            'dateTime'      => $dateTime,
            'preTitle'      => $preTitle,
            'title'         => $title,
            'leadText'      => $leadText,
            'bodyText'      => $bodyText,

            // 'image'      => $image,
            'relatedImages' => $relatedImages,

            'video'         => $video,
            'isVideoStory'  => $isVideoStory,
            'videoLength'   => $videoLength,
        );

        return $contents;
    }

    public function getDeviceType() {
        return Device::SMARTPHONE;
    }
}
