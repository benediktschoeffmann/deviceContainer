<?
/**
 * content slider
 *
 * @var channel oe24.core.Channel
 * @var box oe24.core.ContentBox
 */

// (db) 2017-02-28 - vorläufig spezielle mobile Slider unter www.oe24.at/leute nicht anzeigen, bis Lösung für Bildproblem gefunden wurde
/*switch ($box->getId()) {
    case 226478283: // die schönsten Star-Fotos
    case 225577423: // die schönsten Kultur-Momente
    case 225579982: // die besten Filmbilder
    case 226479894: // so feiern die VIPs
        return;
        break;

}*/
// (db) 2017-02-28 end

// Beispiel: "Top Gelesen" Slider
// Am Dev-Server: Box 161573932 und 161550073

// ------------------------------------------

$device = DeviceContainer::getDevice();
// $smartphone = Smartphone::getInstance();

// ------------------------------------------

$templateOptions = $box->getTemplateOptions();

// ------------------------------------------

$hideMobileBox = $templateOptions->get('Hide-Mobile-Box');
if ($hideMobileBox) {
    return;
}

// ------------------------------------------

$articleOptions = json_decode($templateOptions->get('articleOptions'), true);

// ------------------------------------------

$headline = trim($templateOptions->get('Headline'));
$headline = ($headline) ? $headline : '';

if ($headline == '') {
    $headline = trim($templateOptions->get('headline'));
    $headline = ($headline) ? $headline : '';
}

$storiesPerRow = $templateOptions->get('Stories-Per-Row');
$storiesPerRow = ($storiesPerRow) ? $storiesPerRow : 2;

$rows = $templateOptions->get('Rows');
$rows = ($rows) ? $rows : 1;

$withNumbers = $templateOptions->get('Story-mit-Nummer');
$withNumbers = ($withNumbers) ? true : false;

// ACHTUNG: Wenn das Datum NICHT gezeigt wird, soll der LeadText gezeigt werden !!!
$showDate = $templateOptions->get('Story-mit-Datum');
$showDate = ($showDate) ? true : false;

$showPreTitle = $templateOptions->get('Story-mit-PreTitle');
$showPreTitle = ($showPreTitle) ? true : false;

$showLeadText = $templateOptions->get('Story-mit-LeadText');
$showLeadText = ($showLeadText) ? true : false;

$distanceTop = $templateOptions->get('Abstand-Oben');
$distanceBottom = $templateOptions->get('Abstand-Unten');

$layoutIdentifier = $templateOptions->get('Layout-Identifier');
$layoutIdentifier = ($layoutIdentifier) ? $layoutIdentifier : 'oe24';

if ($box->getTemplate() === 'oe24.oe24._contentBoxes.oe2016businessSliderWithArticles') {
    $layoutIdentifier = 'business';
}

$mobileNoSlider = $templateOptions->get('Mobil-Kein-Slider');
$mobileNoSlider = ($mobileNoSlider) ? true : false;

// ------------------------------------------

$emptyImages = $device->getConfig('emptyImages');

// $imageFormat = '960x480';
// $imageFormat = 'bigStoryCrop'; // 620x310
// $imageFormat = '620x620';

// ------------------------------------------

$slideshowStories = $templateOptions->get('Slideshow-Stories');
$slideshowStories = ($slideshowStories) ? true : false;

// (db) 2017-07-04 top-gelesen wie madonna - "slideshowstories" davon ausnehmen
if ($slideshowStories) {
    $imageFormat = '300x300';
    $emptyImage = $emptyImages['emptyImage1x1'];
    $isSlideShowStory = 'slideshowstory';
}
else {
    // $imageFormat = '200x200';
    $imageFormat = 'bigStoryCrop';
    $emptyImage = $emptyImages['emptyImage2x1'];
    $isSlideShowStory = '';
}

// // $imageFormat = '200x200';
// $imageFormat = '300x300';
// $emptyImage = $emptyImages['emptyImage1x1'];

// $imageFormat = 'bigStoryCrop'; // 620x310
// $emptyImage = $emptyImages['emptyImage2x1'];

// (db) 2017-05-04 contentSlider für Madonna auf 1:1
$imageFormat = ('madonna' == $layoutIdentifier) ? '200x200' : $imageFormat;


// ------------------------------------------

$contentStories = $box->getContentOfAllDropAreas(true, true);

// ------------------------------------------

$temp = array();

$additionalBoxID = trim($templateOptions->get('Additional-Box-ID'));

if (ctype_digit($additionalBoxID)) {
    $additionalBox = db()->getById($additionalBoxID, 'oe24.core.ContentBox', false);
    if ($additionalBox instanceof ContentBox) {
        $additionalBoxStories = $additionalBox->getContentOfAllDropAreas(true, true);
        foreach ($additionalBoxStories as $story) {
            if (!($story instanceof TextualContent)) {
                continue;
            }
            $id = $story->getId();
            $temp[$id] = $story;
        }
    }
}

// schon vorhandene Stories werden jetzt "ueberschrieben"
foreach ($contentStories as $key => $story) {
    if (!($story instanceof TextualContent)) {
        continue;
    }
    $id = $story->getId();
    $temp[$id] = $story;
}

// ------------------------------------------

// Zusammenfassen aller gefundenen Stories. Zugleich die Array-Keys auf nummerisch 0 bis n setzen

$contentStories = array_slice($temp, 0);

if (count($contentStories) <= 0) {
    return;
}

// (ws) 2016-09-23 end

// -------------------------------------------

$channelOptions = $channel->getOptions();
$channelLayoutOverride = $channelOptions->get('layoutOverride');

// ------------------------------------------

$stories = array();
if ($mobileNoSlider) {
    $stories = $contentStories;

    // nur maximal x Links anzeigen für TV-Startseite - wenn Parent keinen Parent hat, sind wir bereits auf der Frontpage
    $parent = $channel->getParent();
    $parent = ($parent->getParent()) ? $parent->getParent() : $parent;

    $maxStories = ('tv' == $channelLayoutOverride && $parent instanceof Portal) ? 5 : null;

    if ($maxStories) {
        $stories = array_slice($stories, 0, $maxStories);
    }

    $overlay = 'Channel';
    $showStoryTime = false;

    ?>
    <div class="mobile_<?= $channelLayoutOverride; ?>">
    <?
        tpl('oe24.oe24.device.smartphone.tpl.contentBox.contentBoxStories', array(
            'channel' => $channel,
            'box' => $box,
            'stories' => $stories,
            'showStoryTime' => $showStoryTime,
            'overlay' => $overlay,
            'layoutIdentifier' => $layoutIdentifier,
        ));
    ?>
    </div>
    <?
    return;
}
else {
    foreach ($contentStories as $key => $story) {

        $storyID = $story->getId();

        // ----------------------------------------------

        $channelList = array();
        $portalName = '';

        // if (null == $story->getHomeChannel()) {
        //     $channelList = $story->getChannels();
        //     $portalName = $channelList[0]->getPortal()->getName();
        // }

        if (null == $story->getHomeChannel()) {
            $channelList = $story->getChannels();
            if (!$channelList) {
                continue;
            }
            $portalName = $channelList[0]->getPortal()->getName();
        }

        // ----------------------------------------------

        $frontendDate = $story->getFrontendDate();
        $frontendTime = formatDateUsingIntlLangKey('time.short', $frontendDate);

        // ----------------------------------------------

        $preTitle = trim($story->getPreTitle(true, $box));
        $preTitle = (empty($preTitle)) ? '&nbsp;' : $preTitle;

        // ----------------------------------------------

        $title = trim($story->getTitle(true, $box));
        $title = (empty($title)) ? '&nbsp;' : $title;

        // ----------------------------------------------

        $leadText = trim($story->getLeadText(true, true, $box));

        // whitespace entfernen
        $leadText = preg_replace('/\s*$/iusU','',$leadText);
        $leadText = trim(str_replace(array("\n\r","\n","\r"), ' ', $leadText));

        // ACHTUNG: Das Datum soll anstatt des Lead-Textes gezeigt werden
        if ($showDate) {
            $dateLong = formatDateUsingIntlLangKey('date.long', $story->getFrontendDate());
            $timeShort = formatDateUsingIntlLangKey('time.short', $story->getFrontendDate());
            $leadText = $dateLong.' '.$timeShort;
        }

        // ----------------------------------------------

        $linkAttr = getContentUrlAttributesArray($story, $box, true, true, true);

        $href = (isset($linkAttr['href']) && is_string($linkAttr['href'])) ? $linkAttr['href'] : '#!';
        $target = (isset($linkAttr['target']) && is_string($linkAttr['target']) && '' != $linkAttr['target']) ? 'target="'.$linkAttr['target'].'"' : '';

        // (ws) 2014-08-04
        // Beispiel: http://ad1.adfarm1.adition.com/redi?sid=2700873&kid=1017356&bid=3399153
        $href = str_replace(array('&kid', '&bid'), array('&amp;kid', '&amp;bid'), $href);

        // ----------------------------------------------

        $image = $story->getFirstRelatedImage(true, $box);
        $imageUrl = $emptyImage;

        if ($image) {
            $imageUrl = $image->getFileUrl($imageFormat);
        }

        // ----------------------------------------------

        $copyright = (null != $image) ? trim($image->getCopyright()) : 'unbekannt';
        $copyright = '&copy; '.$copyright;

        // (ws) 2014-11-25 Copyright wird nicht angezeigt
        $copyright = '';

        // ----------------------------------------------

        $isVideoStory = false;
        $duration = '--:--';
        if ($story instanceof Video) {
            $isVideoStory = true;
            $duration = $story->getVideoLength();
            $duration = ($duration) ? $duration : '--:--';
        }

        $isAdvertisement = (isset($articleOptions[$storyID]['display']) && 'Werbung' == $articleOptions[$storyID]['display']) ? true : false;

        // ----------------------------------------------
        // ----------------------------------------------

        $stories[] = array(
            'id'              => $storyID,
            'portalName'      => $portalName,
            'href'            => $href,
            'target'          => $target,
            'preTitle'        => $preTitle,
            'title'           => $title,
            'leadText'        => $leadText,
            'frontendTime'    => $frontendTime,
            'imageUrl'        => $imageUrl,
            'copyright'       => $copyright,
            'storyNumber'     => $key + 1,
            'isVideoStory'    => $isVideoStory,
            'isAdvertisement' => $isAdvertisement,
            'duration'        => $duration,
        );
    }
}

if(0 == count($stories)) {
    return;
}
// ------------------------------------------

$showHeadline = !empty($headline);

// ------------------------------------------

$storiesCounter = count($stories);
// (db) 2017-07-04 top-gelesen wie madonn - slideshowStories weiterhin einzeln andrucken
// $slideCounter = ('madonna' == $layoutIdentifier || !$slideshowStories) ? ceil($storiesCounter/2) : $storiesCounter;
$slideCounter = ceil($storiesCounter/2);
// ------------------------------------------

// (db) 2017-05-04 zwei Bilder als ein Slide bei Madonna
// (db) 2017-07-04 top-gelesen wie madonna - bei slideshowStories weiterhin einzeln
// $groupCellsActive = ('madonna' == $layoutIdentifier || !$slideshowStories) ? true : false;
$groupCellsActive = true;

$flickityOptions = array(

    'autoplay'        => false,
    'prevNextButtons' => true,
    'pageDots'        => false,
    'groupCells'      => $groupCellsActive,

    // classCounter ist KEINE flickity-Option
    // wird verwendet um die CSS-Klasse des Zaehlerelements zu uebergeben
    'classCounter'    => '.storiesCounter',
);

$options = json_encode($flickityOptions);

// -------------------------------------------

// return;

?>

<div class="contentBox console contentSlider <?= $isSlideShowStory; ?>">


    <? if ($showHeadline): ?>
    <div class="headlineBox layout_<?= $layoutIdentifier; ?>">
        <h2 class="headline defaultChannelBackgroundColor">
            <span><?= $headline; ?></span>
        </h2>
    </div>
    <? endif; ?>


    <div class="flickitySlider layout_<?= $layoutIdentifier; ?>" data-options='<?= $options; ?>'>

        <? foreach ($stories as $key => $story): ?>

            <?
            $classVideo = (true == $story['isVideoStory']) ? 'videoStory' : '';
            //$classNoShadow = ($story['isAdvertisement']) ? 'noShadow' : '';
            ?>

            <a class="story" href="<?= $story['href']; ?>" <?= $story['target']; ?> >


                <div class="imageContainer <?= $classVideo; ?>">

                    <? if (0 == $key || 1 == $key): ?>
                        <img src="<?= $story['imageUrl']; ?>" data-flickity-lazyload="<?= $story['imageUrl']; ?>" alt="">
                    <? else: ?>
                        <img src="<?= $emptyImage; ?>" data-flickity-lazyload="<?= $story['imageUrl']; ?>" alt="">
                    <? endif; ?>

                    <? if ($story['isAdvertisement']): ?>
                        <span class="storyAdvertisement">Werbung</span>
                    <? endif; ?>

                </div>


                <? if (1):?>

                    <div class="storyText">

                        <? if (!empty($story['preTitle'])): ?>
                            <span class="storyPreTitle defaultChannelColor"><?= $story['preTitle']; ?></span>
                        <? endif; ?>

                        <? if (!empty($story['title'])): ?>
                            <h3 class="storyTitle"><?= $story['title']; ?></h3>
                        <? endif; ?>

                        <? if (0): // LeadText derzeit nicht zeigen (ws) 2017-02-16 ?>
                            <? if ('tv' == $channelLayoutOverride): ?>
                                <? if ($showLeadText): ?>
                                    <p class="storyLeadText"><?= $story['leadText']; ?></p>
                                <? else: ?>
                                    <p class="storyLeadText"><?= $story['duration']; ?></p>
                                <? endif; ?>
                            <? else: ?>
                                <? if ($showLeadText): ?>
                                    <p class="storyLeadText"><?= $story['leadText']; ?></p>
                                <? endif; ?>
                            <? endif; ?>
                        <? endif;?>

                    </div>

                    <? if ($withNumbers): ?>
                        <span class="storyNumber defaultChannelBackgroundColor"><?= $story['storyNumber']; ?></span>
                    <? endif; ?>

                <? endif; ?>



                <? if (0): ?>

                    <div class="storyText <?= $classNoShadow ; ?>">

                        <? if (!$story['isAdvertisement']): ?>
                            <? if ("&nbsp;" != $story['preTitle']): ?>
                                <span class="storyPreTitle defaultChannelColor"><?= $story['preTitle']; ?></span>
                            <? endif; ?>
                        <? endif; ?>

                        <? if (!$story['isAdvertisement']): ?>
                            <h3 class="storyTitle"><span><?= $story['title']; ?></span></h3>
                        <? endif; ?>

                        <? if (0): // LeadText nicht zeigen (ws) 2017-02-16 ?>
                            <? if ('tv' == $channelLayoutOverride): ?>
                                <? if ($showLeadText): ?>
                                    <p class="storyLeadText"><?= $story['leadText']; ?></p>
                                <? else: ?>
                                    <p class="storyLeadText"><?= $story['duration']; ?></p>
                                <? endif; ?>
                            <? else: ?>
                                <? if ($showLeadText): ?>
                                    <p class="storyLeadText"><?= $story['leadText']; ?></p>
                                <? endif; ?>
                            <? endif; ?>
                        <? endif;?>

                    </div>

                    <? if ($story['isAdvertisement']): ?>
                        <span class="storyAdvertisement">Werbung</span>
                    <? endif; ?>

                    <? if ($withNumbers): ?>
                        <span class="storyNumber"><?= $story['storyNumber']; ?></span>
                    <? endif; ?>

                <? endif; ?>

            </a>

        <? endforeach; ?>

        <? if (1): ?>
            <div class="storiesCounter">
                <span>1/<?= $slideCounter; ?></span>
            </div>
        <? endif; ?>

    </div>

</div>
