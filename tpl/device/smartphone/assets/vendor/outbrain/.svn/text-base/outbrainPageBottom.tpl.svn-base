<?
/**
 * outbrain
 */

$device = DeviceContainer::getDevice();
$channel = $device->getConfig('channel');
$showOutbrain = $device->getConfig('showOutbrain');
$showOutbrainOverlay = $device->getConfig('showOutbrainOverlay');

if ($device->getConfig('article') == null) {
    tpl('oe24.oe24.device.smartphone.assets.vendor.outbrain.outbrainReferrerTvTeaser', array());
}

if (!$showOutbrain && !$showOutbrainOverlay) {
    return;
}

?>
<script type="text/javascript" src="http://widgets.outbrain.com/outbrain.js"></script>
