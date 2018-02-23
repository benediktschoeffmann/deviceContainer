<?php

class ArticleHandler {
    private $paramStore;
    private $articleStructure;

    public function __construct($content) {
        $homeChannel = $content->getHomeChannel();
        $type = self::getContentType($content);

        $options = $content->getOptions(true, true);
        $layoutOverride = $options->get('layoutOverride');
        $bodyText = $content->getBodyText();

        $this->paramStore = new ParamStore(
            array(
                'channel'        => $homeChannel,
                'content'        => $content,
                'options'        => $options,

                'articleType'    => $type,
                'layoutOverride' => $layoutOverride,

                'bodyText'       => $bodyText,
            ));

        $structureFile = $this->findStructureFile();
        $this->articleStructure = ArticleStructure::createFromStructureFile($structureFile);
        // $this->articleStructure = $this->articleStructure->createFromStructureFile($structureFile);
    }

    public function start() {
        $this->articleStructure->setWriter(new ScreenWriter());
        $this->articleStructure->setArticleHandler($this);
        $this->articleStructure->traverse($this->paramStore);

        // $v = $this->paramStore->pull('new');
        // echo $v.'<br>';
    }

    // dummy method
    public function recieveEvent($e) {
        debug('ArticleHandler recieved Event ' . $e);
    }

    // TODO: auslagern.
    private static function getContentType(Content $content) {
        $type = null;

        switch (true) {
            case ($content instanceof Video) :
                $type = 'video';
                break;
            case ($content instanceof SlideShowVoting) :
                $type = 'slideShowVoting';
                break;
            case ($content instanceof Slideshow) :
                $type = 'slideshow';
                break;
            case ($content instanceof Recipe) :
                $type = 'recipe';
                break;
            case ($content instanceof TextualContent):
                $type = ($content->isNewsTicker()) ? 'article' : 'newsticker';
                break;
            default:
                error('no article type');
            break;
        }

        return $type;
    }

    private function findStructureFile() {
        $structureFile = ArticleStructure::findStructureFile($this->paramStore);

        if (null === $structureFile) {
            $structureFile = ArticleStructure::findStructureFile($this->paramStore, false);
        }

        if (null === $structureFile) {
            $structureFile = ArticleStructure::findStructureFile($this->paramStore, false, false);
        }

        return $structureFile;
    }
}
