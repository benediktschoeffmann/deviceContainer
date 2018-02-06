<?
/**
 * outbrain article
 * @var widgetString string
 * @default widgetString MB_11
 */

// MB_11 ist die garantiefähige Widget-Id
// (bs) es gibt jetzt 3 Ids, siehe Jira Task DAILY-855
// - MB_11 - Mobile Footer
// - MB_12 - empty Mobile Footer that injects Bottom Drawer
// - MB_13 - Mobile Footer with Bottom Drawer
//
// Mobile Footer ist das "Auch Interessant"



$device = DeviceContainer::getDevice();

$article = $device->getConfig('article');
$channel = $device->getConfig('channel');

$widgetString = false;

$showOutbrain = $device->getConfig('showOutbrain');
$showOutbrainOverlay = $device->getConfig('showOutbrainOverlay');

switch (true) {
    case ($showOutbrain && $showOutbrainOverlay) :
        $widgetString = 'MB_13';
        break;
    case (!$showOutbrain && $showOutbrainOverlay) :
        $widgetString = 'MB_12';
        break;
    case ($showOutbrain && !$showOutbrainOverlay) :
        $widgetString = 'MB_11';
        break;
    default:
        break;
}

if ($widgetString === false) {
    return;
}

$articleUrl = $article->getUrl();

?>

<div class="OUTBRAIN" data-src="<?= $articleUrl; ?>" data-widget-id="<?= $widgetString; ?>" data-ob-template="AT_Oe24.at" ></div>
