<?
/**
 * Smartphone Content Box
 *
 * @var channel oe24.core.Channel
 * @var box oe24.core.ContentBox
 */

// ------------------------------------------

$device = DeviceContainer::getDevice();
// $smartphone = Smartphone::getInstance();

// ------------------------------------------

$templateOptions = $box->getTemplateOptions();

$headline = trim($templateOptions->get('Headline'));

$headlineFontSize = trim($templateOptions->get('Headline-Font-Size'));
$headlineFontSize = ($headlineFontSize && ctype_digit($headlineFontSize)) ? $headlineFontSize : 48;
$headlineFontSize = ($headlineFontSize / 16) . 'rem;';

$showHeadline = $templateOptions->get('Show-Headline');
$showHeadline = ($showHeadline && !empty($headline)) ? true : false;

$headlineURL = trim($templateOptions->get('Headline-URL'));

$columns = $templateOptions->get('Columns');
$columns = ($columns) ? $columns : 2;

$layoutIdentifier = $templateOptions->get('Layout-Identifier');
if (!$layoutIdentifier) {
    $layoutIdentifier = 'oe24';
}

$headlineBackground = (empty($layoutIdentifier)) ? '' : 'defaultChannelBackgroundColor';

$marginTop = trim($templateOptions->get('Margin-Top'));
$classMarginTop = ($marginTop) ? 'marginTop' : '';

$marginBottom = trim($templateOptions->get('Margin-Bottom'));
$classMarginBottom = ($marginBottom) ? 'marginBottom' : '';

$paddingTop = trim($templateOptions->get('Padding-Top'));
$classPaddingTop = ($paddingTop) ? 'paddingTop' : '';

$paddingBottom = trim($templateOptions->get('Padding-Bottom'));
$classPaddingBottom = ($paddingBottom) ? 'paddingBottom' : '';

// ------------------------------------------------------------------------------------

$mobileBigStories = $templateOptions->get('Mobile-Big-Stories');
$mobileBigStories = ($mobileBigStories) ? true : false;

// ------------------------------------------------------------------------------------

$mobileAsDesktop = $templateOptions->get('Mobile-as-Desktop');
$mobileAsDesktop = ($mobileAsDesktop) ? true : false;

// ------------------------------------------------------------------------------------

$articleOptions = json_decode($templateOptions->get('articleOptions'), true);

// ------------------------------------------------------------------------------------

$emptyImageFormat = 'emptyImage2x1';

$emptyImages = $device->getConfig('emptyImages');
$emptyImage = $emptyImages[$emptyImageFormat];

$imageFormatHalfWidth = '190x95Crop';
// $imageFormatFullWidth = '960x480';
// (db) 2017-07-05 auf Wunsch von Niki das selbe Format wie bei Madonna Konsole
// (db) 2017-07-10 back to the roots - Mobile Format wie Desktop
// $imageFormatFullWidth = 'bigStoryCrop';
$imageFormatFullWidth = '620x388';


// Image Format 1:1 fuer die .firstStory
// (ws) 2017-01-31 auf Wunsch von Niki werden ALLE Images im Format 2:1 gezeigt, ausser in der Konsole
// $imageFormatFullWidth = '620x620';

// ------------------------------------------------------------------------------------

// (db) 2017-03-03 - helper zur sofortigen Ausspielung der Images oder via LazyLoad
$boxImageCounter = $device->getConfig('boxImageCounter');
$boxImageCounter = ($boxImageCounter) ? $boxImageCounter : 0;
// (db) 2017-03-03 end

// ------------------------------------------------------------------------------------

$contents = $box->getContentOfAllDropAreas(true);

// ------------------------------------------------------------------------------------

$tempContents = array();
foreach ($contents as $key => $content) {
    if (! $content instanceof TextualContent) {
        continue;
    }
    $tempContents[] = $content;
}

$tempContents = array_slice($tempContents, 0, $columns);
if (empty($tempContents)) {
    return;
}

// ------------------------------------------------------------------------------------

$countStories = count($tempContents);

if ($countStories < $columns) {
    return;
}

// ------------------------------------------------------------------------------------

$stories = array();

foreach ($tempContents as $key => $content) {

    $href = $content->getUrl(true, $box);

    if (strpos($href, 'm.oe24dev') !== false) {
        $href = str_replace('http://m.oe24dev.oe24.at', $device->getConfig('appUrl'), $href).$device->getConfig('appUrlQuery');
    }
    
    // ----------------------------------------------

    // (ws) 2017-01-31 kein Override
    // (db) 2017-07-10 mobil wie Desktop
    // $preTitle = trim($content->getPreTitle(true, $box));
    $preTitle = trim($content->getPreTitle());

    // (ws) 2017-01-31 kein Override
    // (db) 2017-07-10 mobil wie Desktop
    // $title = trim($content->getTitle(true, $box));
    $title = trim($content->getTitle());

    // ----------------------------------------------

    // (ws) 2017-01-31 kein Override
    // (db) 2017-07-10 mobil wie Desktop
    $leadText = trim($content->getLeadText(true, true, $box));
    // $leadText = trim($content->getLeadText(true));

    // whitespace entfernen
    $leadText = preg_replace('/\s*$/iusU','',$leadText);
    $leadText = trim(str_replace(array("\n\r","\n","\r"), ' ', $leadText));

    // ----------------------------------------------

    $storyID = $content->getId();

    // $showStoryTitle = false;
    // $showStoryPreTitle = false;
    $showStoryTitle = true;
    $showStoryPreTitle = true;
    $isVideoStory = false;
    $display = '';
    $isLiveTicker = false;

    $sClassOverwrite = '';
    
    $useFormatFullWidth = (0 == $key || $mobileBigStories) ? true : false;
    if ($mobileAsDesktop && ($useFormatFullWidth) && isset($articleOptions[$storyID])) {

        $showStoryTitle = (isset($articleOptions[$storyID]['showTitle'])) ? $articleOptions[$storyID]['showTitle'] : false;
        $showStoryTitle = ($showStoryTitle && !empty($title)) ? true : false;
        // title und pretitle immer andrucken bei kleiner Bildansicht -> Text ist dann neben Bild ... betrifft alle Stories ab der zweiten
        // $showStoryTitle = (!$mobileBigStories && 0 < count($stories)) ? true : $showStoryTitle;

        $showStoryPreTitle = (isset($articleOptions[$storyID]['showPreTitle'])) ? $articleOptions[$storyID]['showPreTitle'] : false;
        $showStoryPreTitle = ($showStoryPreTitle && !empty($preTitle)) ? true : false;
        // title und pretitle immer andrucken bei kleiner Bildansicht -> Text ist dann neben Bild ... betrifft alle Stories ab der zweiten
        // $showStoryPreTitle = (!$mobileBigStories && 0 < count($stories)) ? true : $showStoryPreTitle;

        // Checkbox (Artikel enthaelt Video)
        $isVideoStory = (isset($articleOptions[$storyID]['isVideoStory'])) ? $articleOptions[$storyID]['isVideoStory'] : false;

        // Select (Darstellung)
        $display = (isset($articleOptions[$storyID]['display'])) ? $articleOptions[$storyID]['display'] : '';
        $isLiveTicker = ('Live-Ticker' == $display) ? true : false;

        $sClassOverwrite = 'overwrite';
        // gleiches Format wie Desktop ermitteln
        $imageFormatFullWidth = (2 == $columns && $key == 0) ? 'bigStoryCrop' : $imageFormatFullWidth;
    }

    

    // ----------------------------------------------

    // (ws) 2017-01-31 kein Override
    // (db) 2017-07-10 Mobil: Fullwidth-Bilder von Desktop übernehmen (Achtung: Option "Mobile-Big-Stories" beachten), kleine Bilder
    // $image = $content->getFirstRelatedImage(true, $box);
    // $image = $content->getFirstRelatedImage();
    // $image = ($key <= 0 || $mobileBigStories) ? $content->getFirstRelatedImage(true, $box) : $content->getFirstRelatedImage();
    $image = ($mobileAsDesktop && $useFormatFullWidth) ? $content->getFirstRelatedImage(true, $box) : $content->getFirstRelatedImage();

    $imageUrl = $emptyImage;
    // $imageUrl = $imageFormatFullWidth;

    if ($image) {
        if ($useFormatFullWidth) {
            $imageUrl = $image->getFileUrl($imageFormatFullWidth);
        } else {
            $imageUrl = $image->getFileUrl($imageFormatHalfWidth);
        }
    }
    else {
        $image = $content->getFirstRelatedImage(true, $box);
        $imageUrl = $image->getFileUrl('bigStoryCrop');
    }

    // ----------------------------------------------

    $stories[] = array(
        'href'              => $href,
        'preTitle'          => $preTitle,
        'title'             => $title,
        'leadText'          => $leadText,
        'image'             => $image,
        'imageUrl'          => $imageUrl,
        'isLiveTicker'      => $isLiveTicker,
        'isVideoStory'      => $isVideoStory,
        'showStoryTitle'    => $showStoryTitle,
        'showStoryPreTitle' => $showStoryPreTitle,
        'classOverwrite'    => $sClassOverwrite,
    );
}

// --------------------------------------------------

$classMargin = $classMarginTop.' '.$classMarginBottom;
$classPadding = $classPaddingTop.' '.$classPaddingBottom;

// --------------------------------------------------

// Image Zooming funktioniert nur, wenn es sich
// nicht um eine Flickity Slideshow handelt
// $dataAction = 'data-action="zoom"';

// Image Zooming nur im Artikel zulassen
$dataAction = '';

// Zur Zeit soll der Ledtext nicht gezeigt werden
$showLeadText = false;

?>
<div class="xlKonsoleExtended <?= $classMargin; ?> <?= 'layout_'.$layoutIdentifier; ?>">

    <div class="xlKonsoleExtendedInner clearfix <?= $classPadding; ?>">


        <? if ($showHeadline): ?>
        <div class="headlineBox <?= 'layout_'.$layoutIdentifier; ?>">
            <h2 class="headline defaultChannelBackgroundColor">
                <a href="#!" onclick="return false;"><?= $headline; ?></a>
            </h2>
        </div>
        <? endif; ?>


        <div class="xlKonsoleExtendedStories defaultChannelColor">


        <? foreach ($stories as $key => $story): ?>

            <? 
                // (db) - 2017-03-31 option 'Mobile-Small-Stories' - erster Eintrag groß, alle weiteren mit kleinem Bild andrucken
                if ($mobileBigStories) {
                    $classStory = 'firstStory';                     
                }
                else {
                    $classStory = (0 == $key) ? 'firstStory' : 'nextStory'; 
                }
                // (db) - 2017-03-31 end

                // (db) 2017-02-27 bei drei Artikeln soll jeder gleich gewichtet sein -> alle auf großes Layout
                // bei zwei Artikeln, soll der erste groß, der zweite klein dargestellt werden
                // if (2 == $columns || 2 == count($stories)) {
                //     $classStory = (0 == $key) ? 'firstStory' : 'nextStory'; 
                // }
                // else {
                //     $classStory = 'firstStory'; 
                // }
                // (db) 2017-02-27 end
            ?>

            <a class="<?= $classStory; ?> <?= $story['classOverwrite']; ?> clearfix" href="<?= $story['href']; ?>">

                <? $lazyLoad = (2 > $boxImageCounter && ($key <= 1)) ? false : true; ?>

                <? if($lazyLoad): ?>
                    <?
                    if (1) {
                        etpl('oe24.oe24.device.smartphone.tpl._content.image.defaultImage', array(
                            'channel' => $channel,
                            'image' => $story['image'],
                            'withCopyright' => 0,
                            'emptyImageFormat' => $emptyImageFormat,
                            'forcedImageFormat' => $imageFormatFullWidth,
                        ));
                    }
                    ?>

                    <? if (0): ?>
                        <img class="oe24Lazy" src="<?= $emptyImage; ?>" data-original="<?= $story['imageUrl']; ?>" <?= $dataAction; ?> alt="">
                    <? endif; ?>

                <? else: ?>

                    <div class="imageContainer">

                        <? if (1): ?>
                            <img src="<?= $story['imageUrl']; ?>" <?= $dataAction; ?> alt="">
                        <? endif; ?>

                    </div>

                <? endif; ?>

                <? 
                    // Image-counter für LazyLoading (kleine Bilder verbrauchen weniger Platz)
                    $boxImageCounter = ('firstStory' == $classStory) ? $boxImageCounter + 1 : $boxImageCounter + 0.5;
                ?>
                <? if (0): ?>
                <div class="textContainer">

                    <? if (!empty($story['preTitle'])): ?>
                        <strong class="storyPreTitle"><?= $story['preTitle']; ?></strong>
                    <? endif; ?>

                    <? if (!empty($story['title'])): ?>
                        <h3 class="storyTitle defaultChannelColor"><?= $story['title']; ?></h3>
                    <? endif; ?>

                    <? if ($showLeadText && !empty($story['leadText']) && 0 == $key): ?>
                        <p class="storyLeadText"><?= $story['leadText']; ?></p>
                    <? endif; ?>

                </div>
                <? endif; ?>


                <? if (1): ?>
                    <? if ($story['showStoryPreTitle'] || $story['showStoryTitle']): ?>
                        <div class="textContainer textContainerOverlay">

                            <? if ('firstStory' == $classStory): ?>

                                <? if ($story['showStoryPreTitle']): ?>
                                    <strong class="storyPreTitle defaultChannelBackgroundColor"><?= $story['preTitle']; ?></strong>
                                <? endif; ?>

                                <? if ($story['showStoryTitle']): ?>
                                    <h3 class="storyTitle"><?= $story['title']; ?></h3>
                                <? endif; ?>

                                <? if ($showLeadText && !empty($story['leadText']) && 0 == $key): ?>
                                    <p class="storyLeadText"><?= $story['leadText']; ?></p>
                                <? endif; ?>

                            <? else: ?>
                                <? /* bei kleiner Bildansicht (class == 'nextStory') Title und PreTitle, wenn vorhanden immer andrucken */ ?>
                                <? if ($story['showStoryPreTitle']): ?>
                                    <strong class="storyPreTitle"><?= $story['preTitle']; ?></strong>
                                <? endif; ?>

                                <? if ($story['showStoryTitle']): ?>
                                    <h3 class="storyTitle defaultChannelColor"><?= $story['title']; ?></h3>
                                <? endif; ?>

                                <? if ($showLeadText && !empty($story['leadText']) && 0 == $key): ?>
                                    <p class="storyLeadText"><?= $story['leadText']; ?></p>
                                <? endif; ?>

                            <? endif; ?>

                        </div>
                    <? endif; ?>
                <? endif; ?>


            </a>

        <? endforeach; ?>


        </div>

    </div>

</div>

<? $device->setConfig('boxImageCounter',$boxImageCounter); ?>