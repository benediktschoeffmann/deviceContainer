<?
/**
 * content ad stories
 * @var channel oe24.core.Channel
 * @var box oe24.core.TemplateBox
 */

$templateOptions = $box->getTemplateOptions();

//$adServer = 'http://ad1.adfarm1.adition.com/js?wp_id=';

$adLinks = $templateOptions->get('Ad-Links');
$adMitte = $templateOptions->get('Ad-Mitte');
$adRechts = $templateOptions->get('Ad-Rechts');

$mobileAdSlots = array();
if(!$adLinks || empty($adLinks) || $adLinks == '' || $adLinks == 'CPCSlot11') {
    $mobileAdSlots[] = 'MobileCPCSlot1';
}

if(!$adMitte || empty($adMitte) || $adMitte == '' || $adMitte == 'CPCSlot12') {
    $mobileAdSlots[] = 'MobileCPCSlot2';
}

if(!$adRechts || empty($adRechts) || $adRechts == '' || $adRechts == 'CPCSlot13'){
    $mobileAdSlots[] = 'MobileCPCSlot3';
}

if (empty($mobileAdSlots)) {
    return;
}

$device = DeviceContainer::getDevice();

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

// $layoutOverride = $channel->getOptions(true, true)->get('layoutOverride');
$object = isBoxInTabBox($channel, $box);

$useChannelOptions = true;
if ($object && ($object instanceof TabbedBox)) {
    $templateOptionsTabbedBox = $object->getTemplateOptions();
    $layoutOverride = $object->getTemplateOptions()->get('Layout-Identifier');
    $useChannelOptions = ($layoutOverride == NULL);
}
if ($useChannelOptions) {
    $layoutOverride = $channel->getOptions(true, true)->get('layoutOverride');
}

?>

<div class="headlineBox layout_<?= $layoutOverride; ?>">
    <h2 class="headline defaultChannelBackgroundColor">
        <span>Werbung</span>
    </h2>
</div>

<?
foreach ($mobileAdSlots as $key => $mobileAdSlot) {
    tpl('oe24.oe24.device.smartphone.tpl._adition.adition', array(
        'channel'   => $channel,
        'banner'    => $mobileAdSlot
    ));
}

