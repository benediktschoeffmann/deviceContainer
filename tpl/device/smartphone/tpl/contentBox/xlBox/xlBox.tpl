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

$channel = $device->getConfig('channel');
$templateOptions = $box->getTemplateOptions();

$headline = trim($templateOptions->get('Headline'));

$headlineFontSize = trim($templateOptions->get('Headline-Font-Size'));
$headlineFontSize = ($headlineFontSize && ctype_digit($headlineFontSize)) ? $headlineFontSize : 48;
$headlineFontSize = ($headlineFontSize / 16) . 'rem;';

$showHeadline = $templateOptions->get('Show-Headline');
$showHeadline = ($showHeadline && !empty($headline)) ? true : false;

$headlineURL = trim($templateOptions->get('Headline-URL'));
if($headlineURL){
    $headlineURL = ("http" != mb_substr($headlineURL, 0,4)) ? "http://".$headlineURL : $headlineURL;
}

$columns = $templateOptions->get('Columns');
$columns = ($columns) ? $columns : 2;

$layoutIdentifier = $templateOptions->get('Layout-Identifier');
if (!$layoutIdentifier) {
    $layoutIdentifier = 'oe24';
}

$headlineBackground = (empty($layoutIdentifier)) ? '' : 'defaultChannelBackgroundColor';

// margin und padding optionen werden mobil nicht berücksichtigt
// $marginTop = trim($templateOptions->get('Margin-Top'));
// $classMarginTop = ($marginTop) ? 'marginTop' : '';

// $marginBottom = trim($templateOptions->get('Margin-Bottom'));
// $classMarginBottom = ($marginBottom) ? 'marginBottom' : '';

// $paddingTop = trim($templateOptions->get('Padding-Top'));
// $classPaddingTop = ($paddingTop) ? 'paddingTop' : '';

// $paddingBottom = trim($templateOptions->get('Padding-Bottom'));
// $classPaddingBottom = ($paddingBottom) ? 'paddingBottom' : '';

// ------------------------------------------------------------------------------------

$mobileSmallStories = $templateOptions->get('Mobile-Small-Stories');
$mobileSmallStories = ($mobileSmallStories) ? true : false;

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
// (db) 2017-07-05 Niki möchte bei xlBoxen das selbe Format wie Madonna Konsole haben (620x388)
// (db) 2017-07-10 back to the roots - Formate wie Desktop
// $imageFormatFullWidth = 'bigStoryCrop';
$imageFormatFullWidth = '620x388';
// $imageFormatFullWidth = 'XL-Konsole';

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

    if(count($tempContents)>=16){
        break;
    }
}

if (empty($tempContents)) {
    return;
}

// ------------------------------------------------------------------------------------

$stories = array();

foreach ($tempContents as $key => $content) {

    // kein override - 
    // (db) 2017-03-03 doch wieder override
    $href = $content->getUrl(true, $box);
    // $href = $content->getUrl();

    if (strpos($href, 'm.oe24dev') !== false) {
        $href = str_replace('http://m.oe24dev.oe24.at', $device->getConfig('appUrl'), $href).$device->getConfig('appUrlQuery');
    }

    // ----------------------------------------------

    // (ws) 2017-01-31 kein Override
    // (db) 2017-07-10 Mobil wie Desktop, Override wird übernommen
    $preTitle = trim($content->getPreTitle(true, $box));
    // $preTitle = trim($content->getPreTitle());
    
    // (ws) 2017-01-31 kein Override
    // (db) 2017-07-10 Mobil wie Desktop, Override wird übernommen
    $title = trim($content->getTitle(true, $box));
    // $title = trim($content->getTitle());

    // ----------------------------------------------

    // (ws) 2017-01-31 kein Override
    // (db) 2017-07-10 Mobil wie Desktop, Override wird übernommen
    $leadText = trim($content->getLeadText(true, true, $box));
    // $leadText = trim($content->getLeadText(true));

    // whitespace entfernen
    $leadText = preg_replace('/\s*$/iusU','',$leadText);
    $leadText = trim(str_replace(array("\n\r","\n","\r"), ' ', $leadText));

    // ----------------------------------------------

    $storyID = $content->getId();

    // mobil immer pre-title und title andrucken
    $showStoryTitle = true;
    if ($mobileAsDesktop) {
        $showStoryTitle = (isset($articleOptions[$storyID]['showTitle'])) ? $articleOptions[$storyID]['showTitle'] : false;
        $showStoryTitle = (($showStoryTitle && !empty($title)) || 0 < $key) ? true : false;        
    }
    $showStoryTitle = ('#leer#' == $title) ? false : $showStoryTitle;

    $showStoryPreTitle = true;
    if ($mobileAsDesktop) {
        $showStoryPreTitle = (isset($articleOptions[$storyID]['showPreTitle'])) ? $articleOptions[$storyID]['showPreTitle'] : false;
        $showStoryPreTitle = (($showStoryPreTitle && !empty($title)) || 0 < $key) ? true : false;
    }
    $showStoryPreTitle = ('#leer#' == $preTitle) ? false : $showStoryPreTitle;

    $sClassOverwrite = '';
    // $sClassOverwrite = ($showStoryTitle || $showStoryPreTitle) ? '' : 'overwrite';
    $sClassOverwrite = ($mobileAsDesktop && $key == 0) ? 'overwrite' : '';

    $isVideoStory = false;
    $cssVideoContainer = '';
    $display = '';
    $isLiveTicker = false;

    if (isset($articleOptions[$storyID])) {
        // $showStoryTitle = (isset($articleOptions[$storyID]['showTitle'])) ? $articleOptions[$storyID]['showTitle'] : false;
        // $showStoryPreTitle = (isset($articleOptions[$storyID]['showPreTitle'])) ? $articleOptions[$storyID]['showPreTitle'] : false;

        // Checkbox (Artikel enthaelt Video)
        $isVideoStory = (isset($articleOptions[$storyID]['isVideoStory'])) ? $articleOptions[$storyID]['isVideoStory'] : false;
        $cssVideoContainer = ($isVideoStory) ? 'videoContainer' : '';

        // Select (Darstellung)
        $display = (isset($articleOptions[$storyID]['display'])) ? $articleOptions[$storyID]['display'] : '';
        $isLiveTicker = ('Live-Ticker' == $display) ? true : false;
    }

    // link-properties
    $map = $content->mergeOverride("linkProperties", $box);
    $linkTarget = (!empty($map) && $map->get('target')) ? $map->get('target') : '_self'; 
    
    // (vorerst) nicht zeigen ???
    $isLiveTicker = false;

    // ----------------------------------------------

    // (ws) 2017-01-31 kein Override
    // (db) 2017-07-10 Mobil wie Desktop, Override wird übernommen bei erstem Bild (gFullWidth)
    // $image = $content->getFirstRelatedImage(true, $box);
    $image = $content->getFirstRelatedImage();
    if ($mobileAsDesktop) {
        $image = ($key <= 0) ? $image = $content->getFirstRelatedImage(true, $box) : $content->getFirstRelatedImage();
    }
    
    $forcedImageFormat = $imageFormatFullWidth;
    $imageUrl = $emptyImage;

    if ($image) {
        if ($key > 0) {
            $forcedImageFormat = $imageFormatHalfWidth;
            $imageUrl = $image->getFileUrl($forcedImageFormat);
        } else {
            $forcedImageFormat = ($mobileAsDesktop) ? 'XL-Konsole' : $imageFormatFullWidth;

            $imageUrl = $image->getFileUrl($forcedImageFormat);
        }
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
        'videoContainer'    => $cssVideoContainer,
        'showStoryTitle'    => $showStoryTitle,
        'showStoryPreTitle' => $showStoryPreTitle,
        'classOverwrite'    => $sClassOverwrite,
        'forcedImageFormat' => $forcedImageFormat,
        'linkTarget'        => $linkTarget,
    );
}

// --------------------------------------------------

// Image Zooming funktioniert nur, wenn es sich
// nicht um eine Flickity Slideshow handelt
// $dataAction = 'data-action="zoom"';

// Image Zooming nur im Artikel zulassen
$dataAction = '';

// Zur Zeit soll der Ledtext nicht gezeigt werden
$showLeadText = false;

$singleElement = (count($stories) <= 1) ? 'singleElement' : '';
?>
<div class="xlBox <?= 'layout_'.$layoutIdentifier; ?>">

    <div class="xlBoxInner clearfix ">


        <? if ($showHeadline): ?>
        <div class="headlineBox <?= 'layout_'.$layoutIdentifier; ?>">
            <h2 class="headline defaultChannelBackgroundColor">
                <? if ($headlineURL): ?>
                    <a href="<?= $headlineURL ?>"><?= $headline; ?></a>
                <? else: ?>
                    <a href="#!" onclick="return false;"><?= $headline; ?></a>
                <? endif; ?>
            </h2>
        </div>
        <? endif; ?>


        <div class="xlBoxStories defaultChannelColor <?= $singleElement; ?>">


        <? foreach ($stories as $key => $story): ?>

            <? $classStory = (0 == $key) ? 'firstStory' : 'nextStory'; ?>

            <a class="<?= $classStory; ?> <?= $story['videoContainer']; ?> <?= $story['classOverwrite']; ?> clearfix" href="<?= $story['href']; ?>" target="<?= $story['linkTarget']; ?>">
               
               <? $lazyLoad = (2 > $boxImageCounter) ? false : true; ?>
               
               <? if ($lazyLoad): ?>
                   <?
                    if (1) {
                        etpl('oe24.oe24.device.smartphone.tpl._content.image.defaultImage', array(
                            'channel' => $channel,
                            'image' => $story['image'],
                            'withCopyright' => 0,
                            'emptyImageFormat' => $emptyImageFormat,
                            'forcedImageFormat' => $story['forcedImageFormat'],
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
                    $boxImageCounter = (0 == $key) ? $boxImageCounter + 1 : $boxImageCounter + 0.5;
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
