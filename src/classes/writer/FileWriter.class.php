<?
class FileWriter implements Writer {
    private $filename;

    public function __construct($filename = '/home/oe24/bs/log/ben.log') {
        if (is_writable($filename)) {
            $this->filename = $filename;
        } else {
            error_log("$filename is not writeable. ");
        }
    }

    public function write($text) {
        $fp = fopen($this->filename, 'a+');
        fwrite($fp, $text);
        fclose($fp);
    }
}
