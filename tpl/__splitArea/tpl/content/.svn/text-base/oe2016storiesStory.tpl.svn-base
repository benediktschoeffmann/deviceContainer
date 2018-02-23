<?php
/**
 * OE2016 Standard ContentBox Stories Story
 * @var story array<any>
 * @var columnsCounter integer
 * @var showStoryTime boolean
 * @var hideLeadText boolean
 * @var layoutPortrait boolean
 * @var withTitleOverlay boolean
 * @var withMarker boolean
 * @var layoutIdentifier string
 * @default hideLeadText 0
 * @default layoutIdentifier oe24
 */

$classWithMarker = (true == $withMarker) ? 'withMarker' : '';
$emptyImage = '/images/empty.gif';

$classVideo = (isset($story['isVideo']) && true == $story['isVideo']) ? 'video_container video_container_bottom_left' : '';

// zwecks besserer Lesbarkeit
$showLeadText = !$hideLeadText;

// ----------------------------------------------

$layoutIdentifierExclude = array(
    'madonna',
);

$withTitleOverlay = (in_array($layoutIdentifier, $layoutIdentifierExclude)) ? true : $withTitleOverlay;
$classWithMarker = (in_array($layoutIdentifier, $layoutIdentifierExclude)) ? '' : $classWithMarker;

?>


<? if (1): ?>



<a href="<?= $story['href']; ?>" <?= $story['target']; ?> >


    <div class="storyImage <?= $classVideo; ?>">


        <img class="oe24Lazy" data-original="<?= $story['imageUrl']; ?>" src="<?= $emptyImage; ?>" alt="">


        <? if (1 == $columnsCounter && $showStoryTime): ?>
            <span class="storyTime defaultChannelBackgroundColor"><?= $story['frontendTime']; ?></span>
        <? endif; ?>

        <? if (!empty($story['overlayText'])): ?>
            <span class="overlayText defaultChannelBackgroundColor"><?= $story['overlayText']; ?></span>
        <? endif; ?>


        <? if (true == $withTitleOverlay): ?>

            <? if (false == in_array($layoutIdentifier, $layoutIdentifierExclude)): ?>

                <div class="storiesOverlay">&nbsp;</div>
                <h2 class="storyTitle"><?= $story['title']; ?></h2>

            <? else: ?>

                <div class="storyText">
                    <? if ($story['preTitle']): ?>
                        <strong class="storyPreTitle <?= $classWithMarker; ?>"><?= $story['preTitle']; ?></strong>
                    <? endif; ?>
                    <h2 class="storyTitle">
                        <span class="storyTitleBackground"><?= $story['title']; ?></span>
                    </h2>
                </div>

            <? endif; ?>


        <? endif; ?>

    </div>


    <? if (false == $withTitleOverlay): ?>

        <div class="storyPreTitleContainer clearfix">

            <strong class="storyPreTitle <?= $classWithMarker; ?>"><?= $story['preTitle']; ?></strong>

            <? if ($showStoryTime): ?>
                <span class="storyTime defaultChannelBackgroundColor"><?= $story['frontendTime']; ?></span>
            <? endif; ?>

        </div>

        <h2 class="storyTitle"><?= $story['title']; ?></h2>

    <? endif; ?>

    <? if (false == $hideLeadText && $story['leadText']): ?>
        <p class="storyLeadText"><?= $story['leadText']; ?></p>
    <? endif; ?>


</a>

<? endif; ?>




<? if (0): ?>

<a href="<?= $story['href']; ?>" <?= $story['target']; ?> >


    <div class="storyImage <?= $classVideo; ?>">

        <img class="oe24Lazy" data-original="<?= $story['imageUrl']; ?>" src="<?= $emptyImage; ?>" alt="">

        <? if (1 == $columnsCounter && $showStoryTime): ?>
            <span class="storyTime defaultChannelBackgroundColor"><?= $story['frontendTime']; ?></span>
        <? endif; ?>

        <? if (!empty($story['overlayText'])): ?>
            <span class="overlayText defaultChannelBackgroundColor"><?= $story['overlayText']; ?></span>
        <? endif; ?>

        <? if (true == $withTitleOverlay): ?>
            <div class="storiesOverlay">&nbsp;</div>
            <h2 class="storyTitle"><?= $story['title']; ?></h2>
        <? endif; ?>

    </div>


    <? if (false == $withTitleOverlay): ?>

        <div class="storyPreTitleContainer clearfix">

            <strong class="storyPreTitle <?= $classWithMarker; ?>"><?= $story['preTitle']; ?></strong>

            <? if ($showStoryTime): ?>
                <span class="storyTime defaultChannelBackgroundColor"><?= $story['frontendTime']; ?></span>
            <? endif; ?>

        </div>

        <h2 class="storyTitle"><?= $story['title']; ?></h2>

    <? endif; ?>

    <? if ($story['leadText']): ?>
        <p class="storyLeadText"><?= $story['leadText']; ?></p>
    <? endif; ?>


</a>

<? endif; ?>
