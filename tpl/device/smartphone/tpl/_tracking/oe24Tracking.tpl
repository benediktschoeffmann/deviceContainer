<?
/**
* OE24 Tracking JavaScript Template
* Should be at the end of the <body> tag
*/

$device = DeviceContainer::getDevice();
$object = $device->getConfig('article');
$channel = $device->getConfig('channel');
if (!$object) {
    $object = $channel;
}

if (!$object) {
    return;
}

$objectId = $object->getId();
$channelId = $channel->getId();
?>

<!-- OE24 Click Tracking Start -->
<script type="text/javascript">
    function trackRequest(username, httpStatusCode, objId, channelId) {
        var imgParams = 'referer=' + document.referrer +
            '&screenheight=' + screen.height +
            '&screenwidth=' + screen.width +
            '&colordepth=' + screen.colorDepth +
            '&url=' + escape(document.URL) +
            '&charset=' + escape(document.defaultCharset) + "_" + escape(document.characterSet) +
            '&appcodename=' + escape(navigator.appCodeName) +
            '&appname=' + escape(navigator.appName) +
            '&appversion=' + escape(navigator.appVersion) +
            '&language=' + navigator.language +
            '&platform=' + navigator.platform +
            '&useragent=' + navigator.userAgent +
            '&username=' + username +
            '&httpstatuscode=' + httpStatusCode +
            '&typ=landing' +
            '&x=-1' +
            '&y=-1' +
            '&frontendbox=0' +
            '&channelcolumn=0' +
            '&objectid=' + objId +
            '&channelid=' + channelId;
        document.write('<div class="oe24Tracking"><img src="http://tracking.oe24.at/log.php?' + imgParams + '" alt="" class="trackingImg"\/><\/div>');
    }
    trackRequest('smartphone', '200', '<?= $objectId; ?>', '<?= $channelId; ?>');
</script>
<!-- OE24 Click Tracking End -->
