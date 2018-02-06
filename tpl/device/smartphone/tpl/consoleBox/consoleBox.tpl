<?
/**
 * Smartphone Console Box
 *
 * @var channel oe24.core.Channel
 * @var box oe24.core.ConsoleBox
 **/

// --------------------------------------------------

$device = DeviceContainer::getDevice();

// --------------------------------------------------

$templateOptions = $box->getTemplateOptions();

$headline = trim($templateOptions->get('Headline'));
$showHeadline = $templateOptions->get('Show-Headline');
$showHeadline = ($showHeadline) ? true : false;

$autoplay = $templateOptions->get('Autoplay');
$autoplaySpeed = $templateOptions->get('Autoplay-Speed');

$autoplay = ($autoplay) ? true : false;
$autoplay = (true == $autoplay && ctype_digit($autoplaySpeed)) ? (int) $autoplaySpeed : false;

// --------------------------------------------------

$articleOptions = json_decode($templateOptions->get('articleOptions'), true);

// --------------------------------------------------

$objects = $box->getContents();
if (!($objects)){
    return;
}

// --------------------------------------------------

$emptyImages = $device->getConfig('emptyImages');
$emptyImage = $emptyImages['emptyImage2x1'];

$template = $box->getTemplate();
// $imageFormat = '960x480';
// $imageFormat = 'bigStoryCrop'; // 620x310
// $imageFormat = '620x620';

// (db) 2017-05-19 bigStoryCrop wird bei Madonna abgeschnitten - Desktop-Madonna-Console und "Normale"-Desktop-Console greifen beide auf dieses Smartphone Template zu
$madonna = false;
switch ($template) {
    case 'oe24.oe24._consoleBoxes.consoleMadonna':
    case 'oe24.oe24._consoleBoxes.oe2016ConsoleMadonna':
        $imageFormat = '620x388';
        $madonna = true;
        break;

    default:
        // (db) 2017-07-05 niki möchte für alle Konsolen das gleiche Bildformat wie bei Madonna haben
        // (db) 2017-07-10 back to the roots, Bildformat jetzt wieder wie in Desktop-Version
        $imageFormat = 'bigStoryCrop';
        // $imageFormat = '620x388';
        break;
}
// (db) 2017-05-19 end

// ------------------------------------------------------------------------------------

// (db) 2017-03-03 - helper zur sofortigen Ausspielung der Images oder via LazyLoad
$boxImageCounter = $device->getConfig('boxImageCounter');
$boxImageCounter = ($boxImageCounter) ? $boxImageCounter : 0;
// (db) 2017-03-03 end

// --------------------------------------------------

$contents = array();

foreach ($objects as $object) {

    if ($object instanceof ContentCollection) {

        $objectContents = $object->getItemsRecursive(true);

        if ($objectContents) {
            foreach ($objectContents as $objectContent) {
                if ($objectContent instanceof TextualContent){
                    $contents[] = $objectContent;
                }
            }
        }

    } elseif ($object instanceof TextualContent) {

        $objectContent = $object->getPublishedVersion(true);

        if ($objectContent) {
            $contents[] = $objectContent;
        }

    }
}

// --------------------------------------------------

$stories = array();

foreach ($contents as $key => $story) {

    $storyID = $story->getId();

    // ----------------------------------------------

    $linkAttr = getContentUrlAttributesArray($story, $box, true, true, true);

    // ----------------------------------------------

    $href = (isset($linkAttr['href']) && is_string($linkAttr['href'])) ? $linkAttr['href'] : '#!';

    if (strpos($href, 'm.oe24dev') !== false) {
        $href = str_replace('http://m.oe24dev.oe24.at', $device->getConfig('appUrl'), $href) . $device->getConfig('appUrlQuery');
    }

    $aditionPosition = strpos($href,'.adition.');
    if ($aditionPosition > 0) {
        $href = l('oe24.oe24.redir', array()) . '?q=' . urlencode(trim($href));
    }

    // ----------------------------------------------

    $target = (isset($linkAttr['target']) && is_string($linkAttr['target']) && '' != $linkAttr['target']) ? 'target="'.$linkAttr['target'].'"' : '';

    // ----------------------------------------------

    // (ws) 2017-01-31 kein Override
    // (db) 2017-07-10 Einstellungen von Desktop für Mobil übernehmen
    $preTitle = trim($story->getPreTitle(true, $box));
    // $preTitle = trim($story->getPreTitle());

    // (ws) 2017-01-31 kein Override
    // (db) 2017-07-10 Einstellungen von Desktop für Mobil übernehmen
    $title = trim($story->getTitle(true, $box));
    // $title = trim($story->getTitle());

    // ----------------------------------------------

    // (ws) 2017-01-31 kein Override
    // (db) 2017-07-10 Einstellungen von Desktop für Mobil übernehmen
    $leadText = trim($story->getLeadText(true, true, $box));
    // $leadText = trim($story->getLeadText(true));

    // whitespace entfernen
    $leadText = preg_replace('/\s*$/iusU','',$leadText);
    $leadText = trim(str_replace(array("\n\r","\n","\r"), ' ', $leadText));

    // ----------------------------------------------

    // (ws) 2017-01-31 kein Override
    // (db) 2017-07-10 Einstellungen von Desktop für Mobil übernehmen
    $image = $story->getFirstRelatedImage(true, $box);
    // $image = $story->getFirstRelatedImage();

    $imageSrc = $emptyImage;
    if ($image) {
        $imageSrc = $image->getFileUrl($imageFormat);
    }

    // ----------------------------------------------

    // $eventTracking = eventTracking(
    //     array(
    //         'action'       => 'leftClick',
    //         'box'          => $box,
    //         'channel'      => $channel,
    //         'callTemplate' => __FILE__,
    //         'story'        => $story
    //     )
    // );

    // Select
    // $isLiveTicker = true; //$articleOptions[$storyID]['isLiveTicker'];
    $isLiveTicker    = (isset($articleOptions[$storyID]['display']) && 'Live-Ticker' == $articleOptions[$storyID]['display']) ? true : false;
    $isAdvertisement = (isset($articleOptions[$storyID]['display']) && 'Werbung'     == $articleOptions[$storyID]['display']) ? true : false;

    // ----------------------------------------------
    // (db) 2017-07-21 madonna immer title und pre-title andrucken (wie in Desktop-Version)
    $showStoryTitle = (isset($articleOptions[$storyID]['showTitle'])) ? $articleOptions[$storyID]['showTitle'] : false;
    $showStoryTitle = ($madonna) ? true : $showStoryTitle;
    $showStoryTitle = ($showStoryTitle && !empty($title) && !$isAdvertisement) ? true : false;

    $showStoryPreTitle = (isset($articleOptions[$storyID]['showPreTitle'])) ? $articleOptions[$storyID]['showPreTitle'] : false;
    $showStoryPreTitle = ($madonna) ? true : $showStoryPreTitle;
    $showStoryPreTitle = ($showStoryPreTitle && !empty($preTitle) && !$isAdvertisement) ? true : false;

    // ----------------------------------------------

    // Checkbox
    // $isVideoStory = true; //$articleOptions[$storyID]['isVideoStory'];
    $isVideoStory = (isset($articleOptions[$storyID]['isVideoStory'])) ? $articleOptions[$storyID]['isVideoStory'] : false;
    $isVideoStory = ($story instanceof Video) || $isVideoStory;

    // ----------------------------------------------

    $stories[] = array(

        'id'                => $storyID,

        'href'              => $href,
        'target'            => $target,

        'preTitle'          => $preTitle,
        'title'             => $title,
        'leadText'          => $leadText,

        // 'image'             => $image,
        'imageSrc'          => $imageSrc,

        'isLiveTicker'      => $isLiveTicker,
        'isVideoStory'      => $isVideoStory,
        'isAdvertisement'   => $isAdvertisement,
        'showStoryTitle'    => $showStoryTitle,
        'showStoryPreTitle' => $showStoryPreTitle,

        // 'eventTracking'     => $eventTracking,
    );
}

// ------------------------------------------

$storiesCounter = count($stories);

// ------------------------------------------

// $flickityOptions = json_encode(array(
//     'autoPlay' => $autoplay,
// ));

$flickityOptions = array(

    'autoplay'        => $autoplay,
    'prevNextButtons' => true,
    'pageDots'        => false,

    // classCounter ist KEINE flickity-Option
    // wird verwendet um die CSS-Klasse des Zaehlerelements zu uebergeben
    'classCounter'    => '.storiesCounter',
);

$options = json_encode($flickityOptions);

?>

<div class="contentBox console">


    <? if ($showHeadline): ?>
    <div class="headlineBox">
        <h2 class="headline defaultChannelBackgroundColor">
            <a href="#!" onclick="return false;"><?= $headline; ?></a>
        </h2>
    </div>
    <? endif; ?>


    <div class="flickitySlider" data-options='<?= $options; ?>'>

        <? foreach ($stories as $key => $story): ?>

            <?
            $classVideo = (true == $story['isVideoStory']) ? 'videoStory' : '';
            $classNoShadow = ($story['isAdvertisement']) ? 'noShadow' : '';
            ?>

            <a class="story" href="<?= $story['href']; ?>" <?= $story['target']; ?> >

                <div class="imageContainer <?= $classVideo; ?>">
                    <? if (0 == $key): ?>
                        <img src="<?= $story['imageSrc']; ?>" data-flickity-lazyload="<?= $story['imageSrc']; ?>" alt="">
                    <? else: ?>
                        <img src="<?= $emptyImage; ?>" data-flickity-lazyload="<?= $story['imageSrc']; ?>" alt="">
                    <? endif; ?>
                </div>

                <? if ($story['showStoryPreTitle'] || $story['showStoryTitle']): ?>
                    <div class="storyText <?= $classNoShadow ; ?>">
                        <? if ($story['showStoryPreTitle']): ?>
                            <span class="storyPreTitle"><?= $story['preTitle']; ?></span>
                        <? endif; ?>
                        <? if ($story['showStoryTitle']): ?>
                            <h3 class="storyTitle"><span><?= $story['title']; ?></span></h3>
                        <? endif; ?>
                    </div>
                <? endif; ?>

                <? if ($story['isAdvertisement']): ?>
                    <span class="storyAdvertisement">Werbung</span>
                <? endif; ?>

                <?
                // Zur Zeit wird der Pfeil als "Swipe"-Hinweis nicht gezeigt
                // if (0 == $key) {
                //     tpl('oe24.oe24.device.smartphone.assets.img.icons.iconSwipe');
                // }
                ?>

            </a>

        <? endforeach; ?>

        <? if (1): ?>
            <div class="storiesCounter">
                <span>1/<?= $storiesCounter; ?></span>
            </div>
        <? endif; ?>

        <? //tpl('oe24.oe24.device.smartphone.assets.img.icons.iconSwipe'); ?>

    </div>

</div>

<?

if (null == $device->getConfig('AditionMobileTop')) {
    $device->setConfig('AditionMobileTop', true);
    tpl('oe24.oe24.device.smartphone.tpl._adition.adition', array(
        'channel' => $channel,
        'banner'  => 'MobileTop',
    ));
}

?>

<?

// (db) 2017-03-03 boxImageCounter erhöhen, Console "verbraucht" eine Bildhöhe -> für spätere Boxen bekanntgeben
$boxImageCounter++;
$device->setConfig('boxImageCounter',$boxImageCounter);

?>
