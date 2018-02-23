<?
/**
 * zum definieren der JS-Dateien im Head
 *
 * wird als Funktion geschrieben, damit auch die .page datei auf die gleichen Dateien zugreifen kann,
 * wie die eigentliche Seite
 * FOR TESTING ONLY !!!
 */
function collectHeadJs($layout) {

	$jsHead = array(

        array(0, 'oe24.oe24.__splitArea.js.v3.modernizr.modernizr_2_7_1_custom'),
		array(0, 'oe24.frontend.js.oe24Tracking'),

		array(0, '_shared.1_0.common.common'),
        array(0, 'oe24.oe24.__splitArea.js.oe2016.apaIFrameListener'),
        // array(1, '_shared.1_0.jwplayer.8_0_11.jwplayer.jwplayer'),
        // array(1, '_shared.1_0.jwplayer.8_0_11.jwplayer.license'),

	);

	return $jsHead;
}

function groupHeadJs($layout) {

    $items = collectHeadJs($layout);

    $prevSingleTag = 0;
    $outputIndex = 0;
    $output = array();
    foreach ($items as $key => $item) {

        if ($key > 0 && spunQ::inMode(spunQ::MODE_DEVELOPMENT)) {
            if (1 === $item[0] || 1 === $prevSingleTag) {
                $outputIndex++;
            }
        }

        $output[$outputIndex][] = $item[1];

        $prevSingleTag = $item[0];

    }

    return $output;

}
