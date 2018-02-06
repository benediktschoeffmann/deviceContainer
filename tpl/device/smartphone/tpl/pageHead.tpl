<?
/**
 * _pageHead
 */

$device = DeviceContainer::getDevice();

// --------------------------------------------------

$channel = $device->getConfig('channel');
$article = ($device->getConfig('article')) ? $device->getConfig('article') : null;

$layout = $device->getConfig('layout');
$pageTitle = $device->getConfig('pageTitle');
$containerId = $device->getConfig('googleContainerId');

// --------------------------------------------------

// In der _urlsHead.php sind die Arrays fuer CSS bzw. JS.
// Die Variable MUSS $css bzw. $js heissen !!!
// Diese Arrays werden in der Page-Datei, fuer die Pfad-Aufloesung,
// lesen der Dateien und Zusammenfassen des Contents verwendet.

$filename = realpath(dirname(__FILE__).'/_urlsHead.php');
if (false == file_exists($filename)) {
    return;
}

include($filename);

$cssUrls = deviceGetUrls($css, $layout, 'css', $filename);
$jsUrls = deviceGetUrls($js, $layout, 'js', $filename);

// --------------------------------------------------

?>
<meta charset="UTF-8">
<meta name="viewport" content="initial-scale=1.0">

<title><?= (isset($pageTitle) && is_string($pageTitle)) ? $pageTitle : ''; ?></title>

<?
tpl('oe24.oe24.device.smartphone.tpl._head.meta', array());
?>


<?
tpl('oe24.oe24.device.smartphone.tpl._head.fonts', array('layout' => $layout));
?>


<?
// Google Tag Manager
// https://www.google.com/intl/de/tagmanager/
// https://developers.google.com/tag-manager/
tpl('oe24.oe24.device.smartphone.tpl._tracking.googleTagManager', array('containerId' => $containerId));
?>


<?
tpl('oe24.oe24.device.smartphone.tpl._tracking.chartBeatHead');
?>


<? if (is_array($cssUrls)): ?>

    <? foreach ($cssUrls as $key => $cssUrl): ?>
        <link rel="stylesheet" href="<?= $cssUrl; ?>">
    <? endforeach; ?>

<? endif; ?>


<? if (is_array($jsUrls)): ?>

    <? foreach ($jsUrls as $key => $jsUrl): ?>
        <script src="<?= $jsUrl; ?>"></script>
    <? endforeach; ?>

<? endif; ?>


<?
// <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
// <link rel="icon" href="/favicon.ico" type="image/x-icon">
?>

<link rel="apple-touch-icon" href="<?= slp('image', 'mobile/icon/76x76.jpg') ?>">
<link rel="apple-touch-icon" sizes="76x76" href="<?= slp('image', 'mobile/icon/76x76.jpg') ?>">
<link rel="apple-touch-icon" sizes="120x120" href="<?= slp('image', 'mobile/icon/120x120.jpg') ?>">
<link rel="apple-touch-icon" sizes="152x152" href="<?= slp('image', 'mobile/icon/152x152.jpg') ?>">
<? /*<script src="https://cdnjs.cloudflare.com/ajax/libs/postscribe/2.0.8/postscribe.min.js"></script>*/ ?>
<? // (db) 2018-01-08 Neue SSA Version für Gfk-Messung ?>
<script type="text/javascript" src="https://s407.mxcdn.net/bb-mx/serve/mtrcs_943913.js" async></script>
<?
    // (bs) Werbung/Yieldlab
    // tpl('oe24.oe24.device.smartphone.tpl._adition.aditionPageHead',
    //     array(
    //         'channel' => $channel,
    //         'content' => $article,
    //     )
    // );
?>
