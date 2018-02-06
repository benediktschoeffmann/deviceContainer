<?

include dirname(__FILE__).'/channelColorDefinitions.php';
include dirname(__FILE__).'/channelColorRules.php';
include dirname(__FILE__).'/channelColorExceptions.php';
// ksort($channels);

// ------------------------------------------------------------------------

$cssFilename = dirname(__FILE__).'/channelColors.css.temp';
$cssFilename = realpath(dirname(__FILE__).'/../../assets/css').'/_channelColors.css';
$cssFilenameBackup = realpath(dirname(__FILE__).'/../../assets/css').'/_channelColors_bkup_'.date('Ymd_His').'.css';

// echo $cssFilename."\n";
// echo $cssFilenameBackup."\n";
// exit;

// ------------------------------------------------------------------------

$spunqHeader =
"<?php
/**
 * @collector noauto
 */
?>\n
";

// ------------------------------------------------------------------------

$styles = array();

foreach ($channelColorDefinitions as $channel => $colors) {

    foreach ($channelColorRules as $rule) {

        $temp = implode(",\n", $rule['selectors']);
        $temp = str_replace('{channel}', $channel, $temp);

        $styles[] = $temp;
        $styles[] = " {\n";

        $temp = "\t".implode(";\n\t", $rule['properties']).';';
        $temp = str_replace('{colorLeft}', $colors['colorLeft'], $temp);
        $temp = str_replace('{colorRight}', $colors['colorRight'], $temp);

        $styles[] = $temp."\n";
        $styles[] = "}\n";
    }
}

// ------------------------------------------------------------------------

ob_start();
echo $spunqHeader.implode("", $styles)."\n".implode("", $channelColorException);
$data = ob_get_contents();
ob_end_clean();

// ------------------------------------------------------------------------

$rc = copy($cssFilename, $cssFilenameBackup);
if (false == $rc) {
    error_log(__FILE__.'['.__LINE__.']: Datei `'.$cssFilename.'` kann nicht kopiert werden');
}

// ------------------------------------------------------------------------

$rc = file_put_contents($cssFilename, $data);
if (false == $rc) {
    error_log(__FILE__.'['.__LINE__.']: Datei `'.$cssFilename.'` kann nicht geschrieben werden');
}

?>
