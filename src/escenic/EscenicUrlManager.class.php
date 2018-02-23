<?php

class EscenicUrlManager implements spunQ_IUrlManager {

    /**
     * Entry point we're managing.
     * @type spunQ_HttpEntryPoint
     */
    protected $entryPoint;

    /**
     * Constructor.
     * @param $entryPoint Entry point we're managing.
     */
    public function __construct($entryPoint) {
        $this->entryPoint = $entryPoint;
        return NULL;
    }

    /**
     * @implements spunQ_IUrlManager
     */
    public function getEntryPoint() {
        return $this->entryPoint;
    }

    /**
     * @implements spunQ_IUrlManager
     */
    public function getUrlTemplates() {
        if ($this->entryPoint->getName() === 'oe24.oe24.ece.image') {
            return array(EscenicImageUrl::getInstance());
        } else {
            return array(EscenicArticleUrl::getInstance());
        }
    }

    /**
     * @implements spunQ_IUrlManager
     */
    public function processDefaultValue($variable, $typeName, $value) {
        # there are no default values
        return NULL;
    }

    /**
     * @implements spunQ_IUrlManager
     */
    public function createHtmlLink(spunQ_Locale $locale, array $variables) {
        # why would someone link to these pages explicitely?
        # if this really *is* necessary, please contact the development team.
        throw new spunQ_Exception('Not Implemented');
    }

}

