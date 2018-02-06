<?php
/**
 * Adition Adserver Single Sign Request Mobile implementation
 *
 * @var channel oe24.core.Channel
 * @var object any
 * @default object 0
 * @var banner string
 * @var centerAlign boolean
 * @default centerAlign 1
 */

if (State::getInstance()->getIsPreview()) {
    return;
}

$device = DeviceContainer::getDevice();

$showAds = $device->getConfig('showAds');
if ('Keine Werbung laden' === $showAds) {
    return;
}

$validAdTagNames = $device->getConfig('validAdTagNames');
if (!in_array($banner, $validAdTagNames)) {
    // debug("Die Werbung namens $banner ist nicht vergeben. ");
    return;
}

$classCenter = ($centerAlign) ? 'textAlignCenter' : '';

$isCPCSlot = (0 === strpos($banner, 'MobileCPCSlot'));
$classCPCSlot = '';
if ($isCPCSlot) {
    $classCPCSlot = 'aditionMobileCPCSlot';
    $classCenter = '';
}

// Achtung:
// bei dieser einbauart ist die id der bannername!
// die (numerische) id wurde schon in der aditionPageHead.tpl gemappt.

?>
<div class="adSlotAdition <?= $classCenter; ?> <?= $classCPCSlot; ?>" id="<?= $banner ; ?>">
    <script type="text/javascript">
        <!--
        var adition = adition || {};
        adition.srq = adition.srq || [];

        adition.srq.push(function(api) {
            api.renderSlot("<?= $banner; ?>");
        });
        -->
    </script>
</div>
