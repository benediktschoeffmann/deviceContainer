<?
/**
 * Smartphone XLKonsole Box
 *
 * @var channel oe24.core.Channel
 * @var box oe24.core.ContentBox
*/

// ------------------------------------------

$device = DeviceContainer::getDevice();
// $smartphone = Smartphone::getInstance();

// ------------------------------------------

// $tabbedBoxLayoutIdentifier = $smartphone->getConfig('tabbedBoxLayoutIdentifier');
// $tabbedBoxLayoutIdentifier = ($tabbedBoxLayoutIdentifier) ? $tabbedBoxLayoutIdentifier : 'oe24';

// ------------------------------------------

$templateOptions = $box->getTemplateOptions();

// ------------------------------------------

$articleOptions = json_decode($templateOptions->get('articleOptions'), true);

// ------------------------------------------

// (db) 20170221 - mobil immer gleicher Abstand - margin-checkboxen nicht berücksichtigen
// $marginTop = trim($templateOptions->get('Margin-Top'));
// $classMarginTop = ($marginTop) ? 'marginTop' : '';

// $marginBottom = trim($templateOptions->get('Margin-Bottom'));
// $classMarginBottom = ($marginBottom) ? 'marginBottom' : '';

// $classMargin = $classMarginTop.' '.$classMarginBottom;
// (db) 20170221 - end

// ------------------------------------------

$showLeadText = false;

// ------------------------------------------

$emptyImageFormat = 'emptyImage2x1';

$emptyImages = $device->getConfig('emptyImages');
$emptyImage = $emptyImages[$emptyImageFormat];

$imageType = $templateOptions->get('Bild-Typ');
// (db) 2017-07-05 niki möchte das selbe Format wie bei madonna Konsole (620x388)
// (db) 2017-07-10 back to the roots, Mobil gleiches Format wie Desktop
$imageFormat = ('Original' === $imageType) ? null : 'XL-Konsole';
// $imageFormat = ('Original' === $imageType) ? null : '620x388';

// ------------------------------------------------------------------------------------

// (db) 2017-03-03 - helper zur sofortigen Ausspielung der Images oder via LazyLoad
$boxImageCounter = $device->getConfig('boxImageCounter');
$boxImageCounter = ($boxImageCounter) ? $boxImageCounter : 0;
// (db) 2017-03-03 end

// ------------------------------------------

$sClassOverwrite = '';

// ------------------------------------------

$contents = $box->getContentOfAllDropAreas(true);

$stories = array();

foreach ($contents as $key => $content) {

    if (! $content instanceof TextualContent) {
        continue;
    }

    $storyID = $content->getId();

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

    $href = $content->getUrl(true, $box);

    if (strpos($href, 'm.oe24dev') !== false) {
        $href = str_replace('http://m.oe24dev.oe24.at', $device->getConfig('appUrl'), $href).$device->getConfig('appUrlQuery');
    }
    
    // ----------------------------------------------

    $showStoryTitle = (isset($articleOptions[$storyID]['showTitle'])) ? $articleOptions[$storyID]['showTitle'] : false;
    $showStoryTitle = ($showStoryTitle && !empty($title)) ? true : false;
    
    $showStoryPreTitle = (isset($articleOptions[$storyID]['showPreTitle'])) ? $articleOptions[$storyID]['showPreTitle'] : false;
    $showStoryPreTitle = ($showStoryPreTitle && !empty($preTitle)) ? true : false;

    $sClassOverwrite = ($showStoryTitle || $showStoryPreTitle) ? '' : 'overwrite';

    // ----------------------------------------------

    // Kein Override-Image zeigen, Titel und Text
    $image = ($showStoryTitle || $showStoryPreTitle) ? $content->getFirstRelatedImage() : $content->getFirstRelatedImage(true, $box);
    // $image = $content->getFirstRelatedImage();
    $imageUrl = (null === $image) ? $emptyImage : $image->getFileUrl($imageFormat);

     // ----------------------------------------------   

    $stories[] = array(
        'href'     => $href,
        'imageUrl' => $imageUrl,
        'preTitle' => $preTitle,
        'title'    => $title,
        'showStoryTitle' => $showStoryTitle,
        'showStoryPreTitle' => $showStoryPreTitle,
    );
}

// ------------------------------------------

if (empty($stories)) {
    return;
}

// ------------------------------------------

$story = array_shift($stories);

// ------------------------------------------

// Image Zooming funktioniert nur, wenn es sich
// nicht um eine Flickity Slideshow handelt
// $dataAction = 'data-action="zoom"';

// Image Zooming nur im Artikel zulassen
$dataAction = '';

?>

<div class="xlKonsole">

    <a href="<?= $story['href']; ?>" class="story <?= $sClassOverwrite; ?>">

        <? $lazyLoad = (2 > $boxImageCounter && ($key <= 1)) ? false : true; ?>

        <? if ($lazyLoad): ?>
            <?
            if (1) {
                etpl('oe24.oe24.device.smartphone.tpl._content.image.defaultImage', array(
                    'channel' => $channel,
                    'image' => $image,
                    'withCopyright' => 0,
                    'emptyImageFormat' => $emptyImageFormat,
                    'forcedImageFormat' => $imageFormat,
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

        <? $boxImageCounter++; ?>

        <? if ($story['showStoryTitle'] || $story['showStoryPreTitle']): ?>
            <div class="storyText">
                <? if ($story['showStoryPreTitle']): ?>
                    <strong class="storyPreTitle"><?= $story['preTitle']; ?></strong>
                <? endif; ?>
                <? if ($story['showStoryTitle']): ?>
                    <h3 class="storyTitle"><?= $story['title']; ?></h3>
                <? endif; ?>
            </div>
        <? endif; ?>

    </a>

</div>

<? $device->setConfig('boxImageCounter',$boxImageCounter); ?>
