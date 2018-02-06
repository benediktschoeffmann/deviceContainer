<?php
/**
 * @var oe24Desktop any
 */
$headerComponent = $oe24Desktop->getComponent(Component::HEADER);

$collection = $headerComponent->getThemenDerWocheCollection($oe24Desktop->getConfig('channel'));
if (!$collection) {
    return;
}

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

$topicsTitleDefault = 'Specials';

$topicsTitle = $headerComponent->getThemenDerWocheTitle($oe24Desktop->getConfig('channel'));
if (null == $topicsTitle) {
    $topicsTitle = $topicsTitleDefault;
}

$topicsTitle = trim($topicsTitle, ' :');

?>

<div class="headerNavTopics clearfix">

    <div class="headerNavTopicsCaptionWrapper">
        <span class="headerNavTopicsCaption">
            <?= $topicsTitle; ?>:
        </span>
    </div>

    <ul class="headerNavTopicsItems">

        <? foreach ($headerNavTopics as $key => $item): ?>
        <li>

            <a href="<?= $item['url']; ?>">
                <?= $item['caption']; ?>
            </a>
            <span class="headerNavTopicsDivider">|</span>

        </li>
        <? endforeach; ?>

    </ul>

</div>
