<?
/**
 * CSS und JS Dateien im Bottom-Bereich laden
 *
 * @var layout string
 */

$jsBottomArray = groupBottomJs($layout);

$jsBottomLinks = array();
foreach ($jsBottomArray as $key => $jsBottomFiles) {

    if (count($jsBottomFiles) > 1) {

        $jsTimestamp = -1;
        $files = array_map(function($fileString) {
            $result = spunQ_Module::aliasToJsFile($fileString, false);
            return $result;
        }, $jsBottomFiles);

        foreach ($files as $file) {
            if (NULL === $file) {
                continue;
            }

            if (!$file->exists()) {
                continue;
            }

            $jsTimestamp = max($jsTimestamp, $file->getLastModificationTime());
        }

        $link = l('oe24.oe24.wormhole.jsGroup', array('layout' => $layout, 'groupIndex' => $key, 'timestamp' => $jsTimestamp, 'position' => 'bottom'));
        if (isset($_GET['a'])) {
            $link = $link . '?a';
        }
        $jsBottomLinks[] = $link;

    } else {

        $jsFile = $jsBottomFiles[0];
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
        $jsBottomLinks[] = $link;

    }

}
?>

<? foreach ($jsBottomLinks as $jsBottomLink): ?>
    <script src="<?= $jsBottomLink; ?>"></script>
<? endforeach; ?>
