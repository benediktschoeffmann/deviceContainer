<?php
/**
 * headerNavTopics
 *
 * @var channel oe24.core.Channel
 * @var layout string
 */

// 2017-09-20 (db) - laut keywan bei games24 Navigation nicht andrucken
if ('games24' == $layout) {
    return;
}

// -----------------------------------------------------------------------------

$channelOptions = $channel->getOptions(true, true);

// -----------------------------------------------------------------------------

$collectionId = $channelOptions->get('ThemenDerWocheCollection');
if (!ctype_digit($collectionId)) {
    return;
}

// -----------------------------------------------------------------------------

// $topicsTitleDefault = 'Themen der Woche';
$topicsTitleDefault = 'Specials';

$topicsTitle = $channelOptions->get('ThemenDerWocheTitel');
if (null == $topicsTitle) {
    $topicsTitle = $topicsTitleDefault;
}

$topicsTitle = trim($topicsTitle, ' :');

// -----------------------------------------------------------------------------

// (db) 2018-02-07 channel-olympia2018 'Title' nicht andrucken - produktiv: 319713348, development: 161630052
$displayTitle = true;
$parentChannels = $channel->getParentChannels(true);
foreach($parentChannels as $parentChannel) {
    $displayTitle = (spunQ::inMode(spunQ::MODE_DEVELOPMENT) && $parentChannel->getId()=='161630052' ) ? false : $displayTitle;
    $displayTitle = (!spunQ::inMode(spunQ::MODE_DEVELOPMENT) && $parentChannel->getId()=='319713348' ) ? false : $displayTitle;
}

// -----------------------------------------------------------------------------

$collection = db()->getById($collectionId, 'oe24.core.ContentCollection', false);
if (null == $collection) {
    return;
}

if (false == $collection->isPublished()) {
    return;
}

// -----------------------------------------------------------------------------

$collectionChannels = $collection->getChannels();

$headerNavTopics = array();
foreach ($collectionChannels as $collectionChannel) {
    $pageTitle = $collectionChannel->getPageTitle();
    if (!$pageTitle) {
        continue;
    }
    $channelUrl = $collectionChannel->getUrl();
    if (!$channelUrl) {
        continue;
    }

    // (pj) 2016-04-27 im adition getrackt werden koennen
    $options = $collectionChannel->getOptions(false, true);
    $channelAditionUrl = $options->get('ThemenDerWocheAditionUrl');
    $channelUrl = ($channelAditionUrl) ? $channelAditionUrl : $channelUrl;
    // (pj) 2016-04-27 end

    $headerNavTopics[] = array(
        'caption' => $pageTitle,
        'url' => $channelUrl,
    );
}

?>

<div class="headerNavTopics clearfix">

    <? if ($displayTitle): ?>
        <div class="headerNavTopicsCaptionWrapper"> <? // (pj) 2016-04-19 fuer die css table ?>
            <span class="headerNavTopicsCaption"><?= $topicsTitle; ?>:</span>
        </div>
    <? endif; ?>

    <ul class="headerNavTopicsItems">

        <? foreach ($headerNavTopics as $key => $item): ?>
        <li>

            <? if (0): ?>
                <? if ($key > 0): ?>
                    <span class="headerNavTopicsDivider">|</span>
                <? endif; ?>
                <a href="<?= $item['url']; ?>"><?= $item['caption']; ?></a>
            <? endif; ?>

            <? // (pj) 2016-04-19 damit der Divider in der naechsten Zeile nicht als erstes steht ?>
            <a href="<?= $item['url']; ?>"><?= $item['caption']; ?></a>
            <span class="headerNavTopicsDivider">|</span>

        </li>
        <? endforeach; ?>

    </ul>

</div>
