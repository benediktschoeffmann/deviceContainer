<?php
/**
 * Adition Adserver Mobile implementation
 *
 * @var channel oe24.core.Channel
 * @var object any
 * @default object 0
 * @var banner string
 * @var centerAlign boolean
 * @default centerAlign 1
 */

// (bs) für yieldlab
// if (1) {
//     tpl('oe24.oe24.device.smartphone.tpl._adition.aditionSSR',
//         array(
//             'channel'     => $channel,
//             'object'      => $object,
//             'banner'      => $banner,
//             'centerAlign' => $centerAlign,
//         )
//     );
//     return;
// }

if (State::getInstance()->getIsPreview()) {
    return;
}

$device = DeviceContainer::getDevice();

$showAds = $device->getConfig('showAds');
if ('Keine Werbung laden' === $showAds) {
    return;
}

$adSlots = $device->getConfig('adSlots');


if (!$adSlots || !is_array($adSlots) || !isset($adSlots[$banner])) {
    return;
}

// $configKey = 'Adition' . $banner; // z.b. AditionMobileTop
// if ($device->getConfig($configKey) !== null) {
//     debug('tpl/device/smartphone/adition/adition.tpl already used position '.$banner);
//     return;
// }
// $device->setConfig($configKey, true);

$adSlotId = isset($adSlots[$banner]['id']) ? $adSlots[$banner]['id'] : 0;

$isCPCSlot = (0 === strpos($banner, 'MobileCPCSlot'));

$classCenter = ($centerAlign) ? 'textAlignCenter' : '';
$classSticky = preg_match('/sticky/i', $banner) ? ' columns' : '';
$classCPCSlot = '';
if ($isCPCSlot) {
    $classCPCSlot = 'aditionMobileCPCSlot';
    $classCenter = '';
}

// debug("id - adition_$banner ... adSlotId: $adSlotId");

// -----------------------------------------------------

// (db) 2017-09-22 Werbepositionen, die hier aufgeführt sind, werden erst geladen, wenn sie im Browserfenster sichtbar sind
// zu finden in tpl/__splitArea/js/oe2016/oe2016contentAdLoad.js
$visibleLoad = array(
    'MobileTop',
);
// $loadNow = (in_array($id, $visibleLoad)) ? false : true;
// $loadNow = (in_array($banner, $visibleLoad)) ? true : false;
$loadNow = true;

// (bs) 2018-02-19 der Code unten hat mit DAILY-851 zu tun. IST NICHT ONLINE.
// wir warten immer noch auf die Freigabe seitens GF bzw. Kampagnen.

?>

<div class="adSlotAdition <?= $classCenter ?><?= $classSticky; ?> <?= $classCPCSlot; ?>" id="adition_<?= $banner; ?>" adid="<?= $adSlotId; ?>">
    <? if ($loadNow): ?>
    	<script type="text/javascript" src="http://ad1.adfarm1.adition.com/js?wp_id=<?= $adSlotId; ?>"></script>
    <? endif; ?>

	<? if (0): ?>
    	<script type="text/javascript">
			<!--

			var adition = adition || {};
			adition.srq = adition.srq || [];
			adition.srq.push(function(api) {
				api.renderSlot("<?= $banner; ?>");
			});
			-->
		</script>
	<? endif; ?>

</div>

