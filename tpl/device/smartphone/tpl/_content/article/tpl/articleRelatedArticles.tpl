<?
/**
 * related articles
 */

$device = DeviceContainer::getDevice();
$article = $device->getConfig('article');
$channel = $device->getConfig('channel');

// $channel = $article->getHomeChannel();
$box = new ContentBox();

$layoutIdentifier = $channel->getOptions(true, true)->get('layoutOverride');
if ('' == $layoutIdentifier) {
    $layoutIdentifier = 'oe24';
}
$layoutClass = ' layout_' . $layoutIdentifier;

// (db) 2017-12-01 bei 'reise' keine related articles andrucken
if ('reise' == $layoutIdentifier) {
    return;
}

// ------------------------------------------

$showStoryTime = false;
$overlay = '';

$stories = $article->getRelatedStories();

if (0 === count($stories)) {
    return;
}

// ------------------------------------------

?>
<div class="headlineBox<?= $layoutClass; ?>">
    <h2 class="headline defaultChannelBackgroundColor">
        <span>Mehr zum Thema</span>
    </h2>
</div>

<?
    tpl('oe24.oe24.device.smartphone.tpl.contentBox.contentBoxStories', array(
        'channel'          => $channel,
        'box'              => $box,
        'stories'          => $stories,
        'showStoryTime'    => $showStoryTime,
        'overlay'          => $overlay,
        'layoutIdentifier' => $layoutIdentifier,
    ));
?>
