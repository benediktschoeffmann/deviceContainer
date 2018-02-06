<?
/**
 * html box
 * @var channel oe24.core.Channel
 * @var box oe24.core.FreeHtmlBox
 */

// (ws) ich weiss nicht, ob die Box schon online gezeigt werden soll, vermutlich nicht ;)
// return;

$html = $box->getHtml();

$needle1 = '<div class="apaOuterFrame"';
$needle2 = '<iframe src="http://file.oe24.at/center/sport_widgets/oe24_widgets/';
$needle3 = '<div class="newsletterFrame';
$needle4 = '<div class="sportdaten-center">';
$needle5 = '<div class="mobileHtmlBox"';

$pos1 = strpos($html, $needle1);
$pos2 = strpos($html, $needle2);
$pos3 = strpos($html, $needle3);
$pos4 = strpos($html, $needle4);
$pos5 = strpos($html, $needle5);

if ((false === $pos1) &&
    (false === $pos2) &&
    (false === $pos3) &&
    (false === $pos4) &&
    (false === $pos5)) {
    return;
}

tpl('oe24.oe24.device.smartphone.tpl.htmlBox.apaHtmlBox', array(
    'channel' => $channel,
    'box'     => $box,
    'html'    => $html,
));


