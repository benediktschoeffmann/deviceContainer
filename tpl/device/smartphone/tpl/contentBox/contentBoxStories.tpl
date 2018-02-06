<?
/**
 * content box stories
 * @var channel oe24.core.Channel
 * @var box oe24.core.FrontendBox
 * @var stories array<any>
 * @var showStoryTime boolean
 * @var overlay string
 * @var layoutIdentifier any
 */

// --------------------------------------------------
// debug("contentBoxStories");
// $smartphone = Smartphone::getInstance();
$device = DeviceContainer::getDevice();

// --------------------------------------------------

// debug($box->getId());
// debug($box->getTemplate());

// ------------------------------------------

$classWithStoryTime = '';
if ($showStoryTime) {
    $classWithStoryTime = 'withStoryTime';
}

// ------------------------------------------

$storiesData = array();

foreach ($stories as $key => $story) {

    $frontendDate = $story->getFrontendDate();
    $frontendTime = formatDateUsingIntlLangKey('time.short', $frontendDate);

    // ----------------------------------------------

    // (ws) 2017-01-31 kein Override
    // $preTitle = trim($story->getPreTitle(true, $box));

    // (ws) 2017-06-07 Override doch wieder verwenden
    // $preTitle = trim($story->getPreTitle());
    $preTitle = trim($story->getPreTitle(true, $box));

    // ----------------------------------------------

    // (ws) 2017-01-31 kein Override
    // $title = trim($story->getTitle(true, $box));

    // (ws) 2017-06-07 Override doch wieder verwenden
    // $title = trim($story->getTitle());
    $title = trim($story->getTitle(true, $box));

    // Am Dev unnoetigen Titel-Prefix entfernen
    // $title = str_replace(array('OEST15 - ', 'mad15 -'), '', $title);

    // ----------------------------------------------

    // (ws) 2017-01-31 kein Override
    // $leadText = trim($story->getLeadText(true, true, $box));

    // (ws) 2017-06-07 Override doch wieder verwenden
    // $leadText = trim($story->getLeadText(true));
    $leadText = trim($story->getLeadText(true, true, $box));

    // whitespace entfernen
    $leadText = preg_replace('/\s*$/iusU','',$leadText);
    $leadText = trim(str_replace(array("\n\r","\n","\r"), ' ', $leadText));

    // ----------------------------------------------

    $linkAttr = getContentUrlAttributesArray($story, $box, true, true, true);

    $href = (isset($linkAttr['href']) && is_string($linkAttr['href'])) ? $linkAttr['href'] : '#!';

    // (ws) 2014-08-04
    // Beispiel: http://ad1.adfarm1.adition.com/redi?sid=2700873&kid=1017356&bid=3399153
    $href = str_replace(array('&kid', '&bid'), array('&amp;kid', '&amp;bid'), $href);

    // debug($href);
    if (strpos($href, 'm.oe24dev') !== false) {
        $href = str_replace('http://m.oe24dev.oe24.at', $device->getConfig('appUrl'), $href).$device->getConfig('appUrlQuery');
    }
    // debug($href);

    // Redirect Ad
    $aditionPosition = strpos($href,'.adition.');
    if ($aditionPosition > 0) {
        $href = l('oe24.oe24.redir', array()) . '?q=' . urlencode(trim($href));
    }

    $target = (isset($linkAttr['target']) && is_string($linkAttr['target']) && '' != $linkAttr['target']) ? 'target="'.$linkAttr['target'].'"' : '';

    // ----------------------------------------------

    // (ws) 2017-01-31 kein Override
    // $image = $story->getFirstRelatedImage(true, $box);

    // (ws) 2017-06-07 Override doch wieder verwenden
    // $image = $story->getFirstRelatedImage();
    $image = $story->getFirstRelatedImage(true, $box);

    // ----------------------------------------------

    $copyright = (null != $image) ? trim($image->getCopyright()) : 'unbekannt';
    $copyright = '&copy; '.$copyright;

    // (ws) 2014-11-25 Copyright wird z.Z. nicht angezeigt
    $copyright = '';

    // ----------------------------------------------

    switch ($overlay) {
        case 'Channel':
            $storyChannels = $story->getChannels();
            $homeChannel = $story->getHomeChannel();
            $homeChannel = ($homeChannel) ? $homeChannel : reset($storyChannels);
            $overlayText = ($homeChannel) ? $homeChannel->getPageTitle() : '';
            break;

        case 'Tag':
            $tags = $story->getTags();
            $overlayText = (isset($tags[0])) ? $tags[0]->getName() : '';
            break;

        default:
            // $overlayText = '';
        $overlayText = (!empty($overlay)) ? $overlay : '';
            break;
    }

    // ----------------------------------------------

    $isVideoStory = false;
    $videoLength = '--:--';

    if ($story instanceof Video) {
        $isVideoStory = true;
        $videoLength = $story->getVideoLength();
        $videoLength = ($videoLength) ? $videoLength : '--:--';
    }

    // ----------------------------------------------

    $isSlideShowStory = false;
    if ($story instanceof SlideShow) {
        $isSlideShowStory = true;
    }

    // ----------------------------------------------
    // ----------------------------------------------

    $storiesData[] = array(
        'preTitle'         => $preTitle,
        'title'            => $title,
        'leadText'         => $leadText,
        'href'             => $href,
        'target'           => $target,
        'image'            => $image,
        'copyright'        => $copyright,
        'overlayText'      => $overlayText,
        'frontendTime'     => $frontendTime,
        'showStoryTime'    => $showStoryTime,
        'videoLength'      => $videoLength,
        'isVideoStory'     => $isVideoStory,
        'isSlideShowStory' => $isSlideShowStory,
    );
}

// ------------------------------------------
#debug("count - stories: ".count($storiesData));
?>

<div class="contentBox layout_<?= $layoutIdentifier; ?> <?= $classWithStoryTime; ?>">

    <div class="contentBoxChannel">

        <? if (0 && $showTitle && $boxPageTitle): ?>
        <h2><?= $boxPageTitle; ?></h2>
        <? endif; ?>

        <? foreach ($storiesData as $key => $story): ?>

            <div class="contentBoxStory">
                <?
                    #debug("key: $key");
                tpl('oe24.oe24.device.smartphone.tpl.contentBox.contentBoxStory', array(
                    'story' => $story,
                ));
                ?>
            </div>

        <? endforeach; ?>

    </div>

</div>
