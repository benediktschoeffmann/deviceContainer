<?php

class ArticleStructure {
    private $structure;            // points to an ArticleStructureNodeList
    private $articleHandler;       // points to an ArticleHandler
    private $writer;               // points to an implementation of the writer interface

    public function __construct() {
        $this->articleHandler = null;
        $this->structure = new ArticleStructureNodeList();
        $this->writer = null;

    }

    public static function createFromStructureFile($filePath) {

        $obj = new ArticleStructure();

        include($filePath);

        $obj->structure = $exportStructure;
        return $obj;
    }

    public static function findStructureFile(ParamStore $paramStore, boolean $useArticleType = true, boolean $useLayoutOverride = true) {
        $baseAlias = 'oe24.oe24.article18.structures';

        $layout = ($useLayoutOverride) ? $paramStore->pull('layoutOverride') : 'oe24';
        $alias = "$baseAlias.$layout";

        $type = ($useArticleType) ? $paramStore->pull('articleType') : 'article';
        $alias = "$alias.$type";

        $file = spunQ_Module::aliasToTemplateFile($alias, 'php', false);

        if (!$file) {
            return null;
        }
        return $file;
    }

    public function traverse(ParamStore $paramStore) {
        if (!$this->structure) {
            error('No Structure defined. ');
            return;
        }

        $this->structure->reset();
        while (($node = $this->structure->getNextNode()) !== null) {


            if (in_array($node->getName(), array('dummy'))) {
                continue;
            }

            $html = $this->handleNode($node, $paramStore);

            if ($this->writer instanceof Writer) {
                $this->writer->write($html);
            }
        }
    }

    private function handleNode(ArticleStructureNode $node, ParamStore $paramStore) {
        $variables = array();
        $neededParams = $node->getParams();

        foreach ($neededParams as $param) {
            $variables[$param] = $paramStore->pull($param);
        }

        if ($node->getName() && !in_array($node->getName(), array('dummy'))) {
            $this->articleHandler->recieveEvent($node->getName());
        }

        $path = 'oe24.oe24.article17.' . $node->getTemplate();

        $html = templateAsString($path, $variables);
        return $html;
    }

    public function setArticleHandler(ArticleHandler $articleHandler) {
        $this->articleHandler = $articleHandler;
    }

    public function setWriter(Writer $w) {
        $this->writer = $w;
    }

    public function setStructure(ArticleStructure $structure) {
        $this->structure = $structure;
    }
}
