<?php

class ArticleStructureNodeList {
    private $head, $tail;
    private $iterator;
    private $names = array();

    public function __construct() {
        $this->head = new ArticleStructureNode(null, null, 'dummy');
        $this->tail = new ArticleStructureNode(null, null, 'dummy');
        $this->head->setNext($this->tail);
        $this->iterator = $this->head;
    }

    public function addNode(ArticleStructureNode $node) {
        $this->tail->setNext($node);
        $this->tail = $node;


        if (null !== $node->getName()) {
            $this->names[$node->getName()][] = $node;
        }

        return $node;
    }

    public function getNextNode() {

        $tmp = $this->iterator;
        if (!$tmp) {
            return null;
        }
        $this->iterator = $tmp->getNext();
        return $tmp;
    }

    public function hasMoreNodes() {
        return $this->iterator->getNext() != null;
    }

    public function reset() {
        $this->iterator = $this->head;
    }

    public function getAllNames() {
        return $this->names();
    }

    public function getNodeByName($name) {
        return (isset($this->names[$name])) ? $this->names[$name] : null;
    }

}
