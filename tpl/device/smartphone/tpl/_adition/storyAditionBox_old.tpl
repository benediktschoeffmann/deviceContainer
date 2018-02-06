<?
/**
 * article bottom cpc boxes
 */

$device = DeviceContainer::getDevice();
$channel = $device->getConfig('channel');
$article = $device->getConfig('article');

$layoutOverride = $channel->getOptions(true, true)->get('layoutOverride');

$mobileAdSlots = array(
    'MobileCPCSlot1',
    'MobileCPCSlot2',
    'MobileCPCSlot3'
);

$showAds = $device->getConfig('showAds');
if ('Keine Werbung laden' === $showAds) {
    return;
}

$adSlots = $device->getConfig('adSlots');

$showAdBox = false;
foreach ($mobileAdSlots as $key => $mobileAdSlot) {
    if (isset($adSlots[$mobileAdSlot])) {
        $showAdBox = true;
        break;
    }
}

if (!$showAdBox) {
    return;
}

?>
<div class="headlineBox layout_<?= $layoutOverride; ?>">
    <h2 class="headline defaultChannelBackgroundColor">
        <span>Werbung</span>
    </h2>
</div>
<?


foreach ($mobileAdSlots as $key => $mobileAdSlot) {
    tpl('oe24.oe24.device.smartphone.tpl._adition.adition', 
        array(
            'channel'   => $channel, 
            'object'    => $article,
            'banner'    => $mobileAdSlot,
            )
        );
}
