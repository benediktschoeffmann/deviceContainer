<?php

class EscenicArticleUrl implements spunQ_IUrlTemplate {

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
        $this->urlParts[] = new EscenicUrlPart($this, true);
        $this->urlParts[] = new EscenicUrlPart($this, true);
        $this->urlParts[] = new EscenicUrlPart($this, true);
        $this->urlParts[] = new EscenicUrlPart($this, false);
    }

    /**
     * @implements spunQ_IUrlTemplate
     */
    public function getEntryPoint() {
        return spunQ_HttpEntryPoint::getByName('oe24.oe24.ece.article');
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
        return '.*?(_|-|article)(?P<oe24Id>\d+)\.ece$';
    }

    /**
     * @implements spunQ_IUrlTemplate
     */
    public function regexMatchToVariables(array $matches) {
        return array('oe24Id' => ((int) $matches['oe24Id']));
    }

    /**
     * @implements spunQ_IUrlTemplate
     */
    public function toHumanReadableString() {
        return '(randomstring)(_|-|article){oe24Id}.ece';
    }

}

