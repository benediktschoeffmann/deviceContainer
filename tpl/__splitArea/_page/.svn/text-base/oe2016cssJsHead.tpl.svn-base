<?
/**
 * CSS und JS Dateien im Head-Bereich laden
 *
 * @var layout string
 */

$cssArray = groupHeadCss($layout);
$jsHeadArray = groupHeadJs($layout);

$cssLinks = array();
foreach ($cssArray as $key => $cssFiles) {

    if (count($cssFiles) > 1) {

        $cssTimestamp = -1;
        $files = array_map(function($fileString) {
            $result = spunQ_Module::aliasToCssFile($fileString, false);
            return $result;
        }, $cssFiles);

        foreach ($files as $file) {
            if (NULL === $file) {
                continue;
            }

            if (!$file->exists()) {
                continue;
            }

            $cssTimestamp = max($cssTimestamp, $file->getLastModificationTime());
        }

        $link = l('oe24.oe24.wormhole.cssGroup', array('layout' => $layout, 'groupIndex' => $key, 'timestamp' => $cssTimestamp, 'position' => 'head'));
        if (isset($_GET['a'])) {
            $link = $link . '?a';
        }
        $cssLinks[] = $link;

    } else {

        $cssFile = $cssFiles[0];
        $result = spunQ_Module::aliasToCssFile($cssFile, false);
        if (NULL === $result) {
            continue;
        }

        $fileName = explode('.', $cssFile);
        $fileName = array_pop($fileName) . '.css';

        $link = l('oe24.frontend.wormhole.cssStatic', array('css' => array($cssFile), 'fileName' => $fileName));
        if (isset($_GET['a'])) {
            $link = $link . '?a';
        }
        $cssLinks[] = $link;

    }

}

$jsHeadLinks = array();
foreach ($jsHeadArray as $key => $jsHeadFiles) {

    if (count($jsHeadFiles) > 1) {

        $jsTimestamp = -1;
        $files = array_map(function($fileString) {
            $result = spunQ_Module::aliasToJsFile($fileString, false);
            return $result;
        }, $jsHeadFiles);

        foreach ($files as $file) {
            if (NULL === $file) {
                continue;
            }

            if (!$file->exists()) {
                continue;
            }

            $jsTimestamp = max($jsTimestamp, $file->getLastModificationTime());
        }

        $link = l('oe24.oe24.wormhole.jsGroup', array('layout' => $layout, 'groupIndex' => $key, 'timestamp' => $jsTimestamp, 'position' => 'head'));
        if (isset($_GET['a'])) {
            $link = $link . '?a';
        }
        $jsHeadLinks[] = $link;

    } else {

        $jsFile = $jsHeadFiles[0];
        $result = spunQ_Module::aliasToJsFile($jsFile, false);
        if (NULL === $result) {
            continue;
        }

        $fileName = explode('.', $jsFile);
        $fileName = array_pop($fileName) . '.js';

        $link = l('oe24.frontend.wormhole.jsStatic', array('js' => array($jsFile), 'fileName' => $fileName));
        if (isset($_GET['a'])) {
            $link = $link . '?a';
        }
        $jsHeadLinks[] = $link;

    }

}

?>

<? foreach ($cssLinks as $cssLink): ?>
    <link rel="stylesheet" href="<?= $cssLink; ?>">
<? endforeach; ?>

<? foreach ($jsHeadLinks as $jsHeadLink): ?>
    <script src="<?= $jsHeadLink; ?>"></script>
<? endforeach; ?>
