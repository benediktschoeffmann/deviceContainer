<?php

class ArticleStructureNode {
    private $template;
    private $name;
    private $params;
    private $next;

    public function __construct($template, $params = array(), $name = null) {
        $this->template = $template;
        $this->params = $params;
        $this->name = $name;
        $this->next = null;
    }

    public function getTemplate() {
        return $this->template;
    }

    public function getParams() {
        return $this->params;
    }

    public function getName() {
        return $this->name;
    }

    public function setNext(ArticleStructureNode $node) {
        $this->next = $node;
    }

    public function getNext() {
        return $this->next;
    }

    public function hasNext() {
        return ($this->next != null);
    }

}
