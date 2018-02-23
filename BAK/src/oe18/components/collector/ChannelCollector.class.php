<?php

class ChannelCollector extends Component implements ICollector {
    private $headCss;
    private $headJs;
    private $bottomCss;
    private $bottomJs;

    public function __construct($config) {
        // $this->headCss = $config['channelHeadCss'];
        // $this->headJs = $config['channelHeadJs'];
        // $this->bottomJs = $config['channelBottomJs'];

        // TODO: fix
        $this->headCss = 'http://www.oe24.at/css/1516092668/0/oe24/head';
        $this->headJs = 'http://www.oe24.at/js/1473936364/0/oe24/head';
        $this->bottomJs = 'http://www.oe24.at/js/1516099397/0/oe24/bottom';

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
