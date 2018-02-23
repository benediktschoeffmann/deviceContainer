<?php

class ArticleCollector extends Component implements ICollector {
    private $headCss;
    private $headJs;
    private $bottomCss;
    private $bottomJs;

    public function __construct($config) {
        $this->headCss = $config['articleHeadCss'];
        $this->headJs = $config['articleHeadJs'];
        $this->bottomJs = $config['articleBottomJs'];
    }

    public function getFileUrl($type, $position) {
        if ($type === 'css') {
            return $this->headCss;
        }

        if ($type === 'js') {
            return ($position === 'head') ? $this->headJs : $this->bottomJs;
        }
    }
}
