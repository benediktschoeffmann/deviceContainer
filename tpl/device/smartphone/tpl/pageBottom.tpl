<?
/**
 * pageBottom
 */

// Hier bitte NUR Elemente einbinden, die KEINEN Einfluss auf das Seiten-Layout haben,
// insbesondere keine Hoehe > 0 ergeben, etc.
// Gedacht ist dieses Template dafuer, dass hier die ueblichen JavaScripts, die unmittelbar
// vor dem body-Endtag werden sollen, hier eingebunden werden!

// --------------------------------------------------

$device = DeviceContainer::getDevice();
$layout = $device->getConfig('layout');

// --------------------------------------------------

// In der _urlsBottom.php ist das Arrays JS.
// Die Variable MUSS $js heissen !!!
// Dieses Array wird in der Page-Datei, fuer die Pfad-Aufloesung,
// lesen der Dateien und Zusammenfassen des Contents verwendet.

// if (isset($_GET['newCollector'])) {
//     $jsUrls = smartPhoneGenerateLinks('js', 'bottom');
// } else {
    $filename = realpath(dirname(__FILE__).'/_urlsBottom.php');
    if (false == file_exists($filename)) {
        return;
    }

    include($filename);
    $jsUrls = deviceGetUrls($js, $layout, 'js', $filename);

    // debug($jsUrls);
// }

// --------------------------------------------------

?>

<? if (is_array($jsUrls)): ?>

    <? foreach ($jsUrls as $key => $jsUrl): ?>
        <script src="<?= $jsUrl; ?>"></script>
    <? endforeach; ?>

<? endif; ?>


<?
if (1) {
    tpl('oe24.oe24.device.smartphone.tpl._tracking.oe24Tracking');
}
?>

<?
$useChartBeat = $device->getConfig('useChartBeat');
if ($useChartBeat) {
    tpl('oe24.oe24.device.smartphone.tpl._tracking.chartBeatBottom');
}
?>


<?
/* $useTwitter = $device->getConfig('useTwitter') */;
if (1 /* && true == $useTwitter */) {
   tpl('oe24.oe24.device.smartphone.assets.vendor.twitter.twitterPageBottom');
}
?>


<?
$validSportLayouts = $device->getConfig('validSportLayouts');
if (1 && is_array($validSportLayouts) && in_array($layout, $validSportLayouts)) {
    tpl('oe24.oe24.device.smartphone.assets.vendor.apa.apaSpine');
}
?>

<?
tpl('oe24.oe24.device.smartphone.assets.vendor.facebook.facebookApiPageBottom');
?>

<?
// (bs) showOutbrain gets checked inside the template
// (bs) 2017-09-08 showOutbrain can also be changed in assets/vendor/facebook/facebookReferrerTvTeaser
tpl('oe24.oe24.device.smartphone.assets.vendor.outbrain.outbrainPageBottom');
?>


<?
// MH 20170411 DAILY-743
tpl('oe24.oe24.device.smartphone.assets.vendor.xaxis.xaxisPageBottom');
?>


<? if (1): ?>
    <? // (bs) 2017-07-11 DAILY-919 Mindtake Integration ?>
    <? $d = new spunQ_Date(); $ts = $d->getTimeStamp(); ?>
    <script src="https://t.mindtake.com/tag/cid/9C0R4/trace.js?Publisher=Oesterreich&uid=<?= $ts; ?>" type="text/javascript" async></script>
    <? // (bs) end; ?>
<? endif; ?>
