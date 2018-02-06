<?
/**
*   Keyword Targeting
*/

$device = DeviceContainer::getDevice();
$object = $device->getConfig('article');
$isArticle = (true == $object);
if (!$object) {
    $object = $device->getConfig('channel');
}

$keywordSlot = $device->getConfig('adKeyword');

if (!$keywordSlot) {
    return;
}

$keywordId = $keywordSlot['id'];
$keywordUrl = $keywordSlot['keyword'].'_'.stripDomainFromString($object->getUrl());

?>
<!-- Keyword Targeting BEGIN -->
<div class="keywordTargeting">
    <iframe src="http://ad1.adfarm1.adition.com/banner?sid=<?= $keywordId; ?>&amp;wpt=H&amp;kw=<?= $keywordUrl; ?>" width="1" height="1" style="width:1px; height:1px; background-color:transparent; border:none; position: absolute; ">
    </iframe>
</div>
<!-- Keyword Targeting END -->
