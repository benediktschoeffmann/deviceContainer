<?
/**
 * deviceGetUrls
 *
 * Verwendung z.B. in der head.tpl:
 * $cssUrls = deviceGetUrls($css, $layout, 'css');
 *
 * Verwendung z.B. in der bottom.tpl:
 * $jsUrls = deviceGetUrls($js, $layout, 'js');
 *
 * @return url-array mit allen urls
 * @author
 **/
function deviceGetUrls($input2DArray, $layout = 'oe24', $type, $filename) {
    $file2DArray = deviceGroupFiles($input2DArray, $layout, $type);

    $urlsPath = substr($filename, strpos($filename, 'tpl') + 4);
    $urlsPath = str_replace('/', '.', $urlsPath);

    $output = array();

    foreach($file2DArray as $fileArray) {
        if (count($fileArray) <= 0) {
            continue;
        }

        $inhalt = array();

        foreach ($fileArray as $file) {

            $spunqFile = ('css' === $type) ? spunQ_Module::aliasToCssFile($file, false) : spunQ_Module::aliasToJsFile($file, false);
            if (!$spunqFile) {
                continue;
            }

            $prettyPath = $spunqFile->getPrettyPath();
            $inhalt[] = file_get_contents($prettyPath);
        }

        if (empty($inhalt)) {
            continue;
        }

        $hash = sha1(implode('', $inhalt));

        $pageAlias    = ('css' === $type) ? 'oe24.oe24.wormhole.sha1Css' : 'oe24.oe24.wormhole.sha1Js';
        $pageFilename = ('css' === $type) ? '_all.css' : '_all.js';
        $pageFilename = (count($fileArray) === 1) ? basename($prettyPath) : $pageFilename;

        $pagePath = l($pageAlias, array(
            'layout'   => $layout,
            'urlsPath' => $urlsPath,
            'sha1Hash' => $hash,
            'filename' => $pageFilename,
            )
        );

        $output[] = $pagePath;
    }

    return $output;
}

/**
 * deviceGetFiles
 *
 * wenn der hash mit der url der page-datei uebereinstimmt
 *
 * @return css-array oder js-array
 * @author
 **/

function deviceGetFiles($input2DArray, $layout, $type, $inputHash) {
    $file2DArray = deviceGroupFiles($input2DArray, $layout, $type);

    $lastFileArray = array();

    foreach ($file2DArray as $fileArray) {

        $inhalt = array();

        foreach ($fileArray as $file) {

            $spunqFile = ('css' === $type) ? spunQ_Module::aliasToCssFile($file, false) : spunQ_Module::aliasToJsFile($file, false);
            if (!$spunqFile) {
                continue;
            }

            $prettyPath = $spunqFile->getPrettyPath();

            $inhalt[] = file_get_contents($prettyPath);
        }

        $hash = sha1(implode('', $inhalt));

        if ($hash === $inputHash) {
            return $fileArray;
        }

        $lastFileArray = $fileArray;
    }

    return $lastFileArray;
}

/**
 * deviceGroupFiles
 *
 * wird nur hier intern aufgerufen
 *
 * @return 2D Array
 * @author pj
 **/

function deviceGroupFiles($file2DArray, $layout, $type) {
    $prevSingleTag = 0;
    $outputIndex = 0;
    $output = array();

    foreach ($file2DArray as $key => $item) {

        if ($key > 0 && spunQ::inMode(spunQ::MODE_DEVELOPMENT)) {
            if (1 == $item[0] || 1 == $prevSingleTag) {
                $outputIndex++;
            }
        }

        $output[$outputIndex][] = $item[1];
        $prevSingleTag = $item[0];

    }
    return $output;
}
