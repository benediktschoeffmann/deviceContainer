<?php

class EscenicImageUrl implements spunQ_IUrlTemplate {

    /**
     * Singleton instance.
     * @type EscenicUrl
     */
    private static $instance = NULL;

    /**
     * Singleton getter.
     * @return EscenicUrl
     */
    public static function getInstance() {
        if (self::$instance === NULL) {
            self::$instance = new self();
        }
        return self::$instance;
    }

    /**
     * Url parts to return as required by interface.
     * @type array<spunQ_IUrlTemplatePart>
     */
    private $urlParts = array();

    /**
     * Constructor.
     */
    private function __construct() {
        # foldernumber
        $this->urlParts[] = new EscenicUrlPart($this, true);
        # randomstring
        $this->urlParts[] = new EscenicUrlPart($this, true);
        # underscore
        $this->urlParts[] = new EscenicUrlPart($this, false);
        # oe24Id
        $this->urlParts[] = new EscenicUrlPart($this, true);
        # imageVersion
        $this->urlParts[] = new EscenicUrlPart($this, true);
        # period
        $this->urlParts[] = new EscenicUrlPart($this, false);
        # extension
        $this->urlParts[] = new EscenicUrlPart($this, true);
    }

    /**
     * @implements spunQ_IUrlTemplate
     */
    public function getEntryPoint() {
        return spunQ_HttpEntryPoint::getByName('oe24.oe24.ece.image');
    }

    /**
     * @implements spunQ_IUrlTemplate
     */
    public function getUrlParts() {
        return $this->urlParts;
    }

    /**
     * @implements spunQ_IUrlTemplate
     */
    public function getLocale() {
        return spunQ_HttpRequest::getDefaultLocale();
    }

    /**
     * @implements spunQ_IUrlTemplate
     */
    public function toRegex() {
        return '\d+/.*?_(?P<oe24Id>\d+)(?P<imageVersion>[a-z])\.(jpg|gif|png)$';
    }

    /**
     * @implements spunQ_IUrlTemplate
     */
    public function regexMatchToVariables(array $matches) {
        return array('oe24Id' => (int) $matches['oe24Id'], 'imageVersion' => $matches['imageVersion']);
    }

    /**
     * @implements spunQ_IUrlTemplate
     */
    public function toHumanReadableString() {
        return '(foldernumber)/(randomstring)_{oe24Id}{imageVersion}.(jpg|gif|png)';
    }

}

