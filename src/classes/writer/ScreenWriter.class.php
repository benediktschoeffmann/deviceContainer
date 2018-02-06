<?
class ScreenWriter implements Writer {

    public function __construct() {
        // nothing to do
    }

    public function write($text) {
        echo $text;
    }

}
