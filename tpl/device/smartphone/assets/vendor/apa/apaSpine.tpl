<?
/**
 * apa spine
 */

$device = DeviceContainer::getDevice();

// ---------------------------------------------

$layout = $device->getConfig('layout');
$channel = $device->getConfig('channel');

$parentChannels = $channel->getParentChannels(true);
$isDevelopment = (spunQ::inMode(spunQ::MODE_DEVELOPMENT)) ? true : false;

// ---------------------------------------------------

$event = '';
foreach ($parentChannels as $key => $oChannel) {
    // olympia-channel dev: 161630052, prod:
    $event = ($oChannel->getId() == '161630052' && $isDevelopment) ? 'olympia2018' : $event;
}

debug("event: $event");

?>

<? if('olympia2018' == $event): ?>
    <script src="http://file.oe24.at/center/apa_spine_wintergames/apa.spine.3.0.min.js"></script>
<? else: ?>
    <script src="http://file.oe24.at/center/apa_spine/apa.spine.3.0.min.js"></script>
<? endif; ?>



