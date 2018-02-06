<?
/**
 * content ad stories
 * @var channel oe24.core.Channel
 * @var box oe24.core.TemplateBox
 */

$templateOptions = $box->getTemplateOptions();

$adLinks = $templateOptions->get('Ad-Links');
$adMitte = $templateOptions->get('Ad-Mitte');
$adRechts = $templateOptions->get('Ad-Rechts');


$adsDesktop = array($adLinks, $adMitte, $adRechts);

$mobileAdSlots = array();

// bei der Desktop-Box ist vorgegeben, dass wenn die Slots leer sind, CPCSlot11-13
// genommen werden soll.
foreach ($adsDesktop as $key => $ad) {
    if (!$ad) {
        $mobileAdSlots[] = 'MobileCPCSlot' . strval($key + 1);
    }
    if (strpos($ad, 'CPCSlot1') === 0) {
        $mobileAdSlots[] = 'MobileCPCSlot' . substr($ad, -1);
    }
    if (strpos($ad, 'TNTSlot') === 0) {
        $mobileAdSlots[] = 'Mobile'.$ad;
    }
}

if (empty($mobileAdSlots)) {
    return;
}

try {
    $device = DeviceContainer::getDevice();
} catch (Exception $e) {
    return;
}

$showAds = $device->getConfig('showAds');
if ('Keine Werbung laden' === $showAds) {
    return;
}

// $adSlots = $device->getConfig('adSlots');
// $showAdBox = false;
// foreach ($mobileAdSlots as $key => $mobileAdSlot) {
//     if (isset($adSlots[$mobileAdSlot])) {
//         $showAdBox = true;
//         break;
//     }
// }

$validAdTagNames = $device->getConfig('validAdTagNames');

$showAdBox = false;
foreach ($mobileAdSlots as $key => $mobileAdSlot) {
    if (in_array($mobileAdSlot, $validAdTagNames)) {
        $showAdBox = true;
        break;
    }
}

if (!$showAdBox) {
    return;
}

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
