<?php
/**
 * Smartphone Ad Slot
 *
 * @var channel oe24.core.Channel
 * @var box oe24.core.TemplateBox
 */

$device = DeviceContainer::getDevice();
if (!$device) {
    return;
}

$templateOptions = $box->getTemplateOptions();
$banner = $templateOptions->get('banner');

// (ws) 2017-04-14
//
// Ad-Slot soll mehrfach auf der Seite ausgespielt werden koennen
// -> MobileTop, MobileMiddle, ...
// Die jeweilige Ad-Position nur einmal


if (null == $device->getConfig('Adition'.$banner)) {
    $device->setConfig('Adition'.$banner, true);
    tpl('oe24.oe24.device.smartphone.tpl._adition.adition', array(
        'channel' => $channel,
        'banner'  => $banner,
    ));
}

// (ws) 2017-04-14 end
