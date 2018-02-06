<?php
/**
 * content box stories story
 * @var story array<any>
 */

$deleted = false;
// (db) 2017-03-29 nur überprüfen, wenn ein image-object mitgegeben wurde
$checkImageStatus = ( isset ($story['image']) && $story['image'] ) ? true : false;
if ( $checkImageStatus ) {
    $deleted = $story['image']->checkDeleted($story['image']->getStatus());
}
// (db) 2017-03-29 end

$classVideo = (true == $story['isVideoStory']) ? 'videoStory' : '';
$classSlideShow = (true == $story['isSlideShowStory']) ? 'slideShowStory' : '';
$displayVideoLength = (true == $story['isVideoStory'] && $story['videoLength']) ? true : false;

$emptyImageFormat = 'emptyImage2x1';

// ------------------------------------------

$device = DeviceContainer::getDevice();
$layout = $device->getConfig('layout');

switch ($layout) {
    case 'madonna':
        $showLeadText = false;
        break;
    default:
        $showLeadText = true;
        break;
}

// ------------------------------------------

?>
<a class="story" href="<?= $story['href']; ?>" <?= $story['target']; ?> >

    <div class="storyImage <?= $classVideo; ?> <?= $classSlideShow; ?>">

        <? if (1): ?>
        <?
        if (!$deleted) {
            tpl('oe24.oe24.device.smartphone.tpl._content.image.defaultImage', array(
                'image'            => $story['image'],
                'emptyImageFormat' => $emptyImageFormat,
                'withCopyright'    => false,
                'withImageZoom'    => false,
            ));
        }
        ?>
        <? endif; ?>

        <? if (true == $story['showStoryTime']): ?>
            <span class="storyTime"><?= $story['frontendTime']; ?></span>
        <? endif; ?>

        <? if (!empty($story['overlayText'])): ?>
            <span class="overlayText"><?= $story['overlayText']; ?></span>
        <? endif; ?>

         <? if ($displayVideoLength): ?>
            <span class="videoLength"><?= $story['videoLength']; ?></span>
        <? endif; ?>

    </div>

    <div class="storyText">
        
        <? if ($story['preTitle']): ?>
            <strong class="storyPreTitle defaultChannelColor"><?= $story['preTitle']; ?></strong>
        <? endif; ?>

        <h3 class="storyTitle"><span><?= $story['title']; ?></span></h3>

        <? if (isset($showLeadText) && true == $showLeadText): ?>
            <p class="storyLeadText"><?= $story['leadText']; ?></p>
        <? endif; ?>

    </div>

</a>

