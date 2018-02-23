<?php

class EscenicUrlPart implements spunQ_IUrlTemplatePart {

    /**
     * The url template this object is a part of.
     * @type spunQ_IUrlTemplate
     */
    protected $urlTemplate;

    /**
     * Whether this part is a regular expression.
     * @type boolean
     */
    protected $isregex;

    /**
     * Constructor.
     * @param $urlTemplate The url template this object is a part of.
     * @param $isregex Whether this part is a regular expression.
     */
    public function __construct($urlTemplate, $isregex) {
        $this->urlTemplate = $urlTemplate;
        $this->isregex = $isregex;
        return NULL;
    }

    /**
     * @implements spunQ_IUrlTemplatePart
     */
    public function getUrlTemplate() {
        return $this->urlTemplate;
    }

    /**
     * @implements spunQ_IUrlTemplatePart
     */
    public function isRegularExpression() {
        return $this->isregex;
    }

}

