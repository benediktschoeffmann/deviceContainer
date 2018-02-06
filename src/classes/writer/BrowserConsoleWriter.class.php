<?

class BrowserConsoleWriter implements Writer {

    public function write($text) {
        $output  = "<script>console.log( 'PHP debugger: ";
        $output .= json_encode(print_r($text, true));
        $output .= "' );</script>";
        echo $output;
    }

}
