<?
/**
 * New Stories Overlay
 * @var channel oe24.core.Channel
 * @var layout string
 * @default layout oe24
 * @var object any
 * @default object 0
 */

// Task-ID: DAILY-619

// svn commit -m "DAILY-619 New Stories Overlay init" tpl/__splitArea/css/oe2016/newStoriesOverlay.css tpl/__splitArea/js/oe2016/newStoriesOverlay.js tpl/__splitArea/_page/newStoriesOverlay.tpl tpl/__splitArea/_page/footer.tpl src/functions/collectorOe2016/collectHeadCss.function.php src/functions/collectorOe2016/collectBottomJs.function.php

// ------------------------------------------------------------

// Live-Ticker

if ($object instanceof Text && $object->isNewsticker()) {
    return;
}

// ------------------------------------------------------------

// Bezahlter Channel

// $showPaidContentMarker = false;
// // kann true, false oder null sein.
// if (!$object instanceof TextualContent && $channel->getOptions(true, true)->get('EntgeltlicherContent')) {
//     $showPaidContentMarker = true;
// }
// if (true == $showPaidContentMarker) {
//     return;
// }

// ------------------------------------------------------------

$logoPortal = '/images/oe2016/logo-oe24.svg';
$newStoriesMessage = 'Es gibt neue Nachrichten<br>auf oe24.at';
$newStoriesButtonText = 'Jetzt Startseite laden';

$request = request();
$requestUri = $request->getUri();

$usesSsl = $request->getUsesSsl();
$schema = ($usesSsl) ? 'https' : 'http';

$domain = $channel->getDomain(true, true);
$pageLoadUri = $schema.'://'.$domain;

$url = $pageLoadUri.$requestUri;
$parsedUrl = parse_url($url);

// ------------------------------------------------------------

$validLayoutOverrides = array(
    'oe24',
);

// ------------------------------------------------------------

// Overlay nur in Channels/Artikel mit dem definierten Layout-Override zeigen
if ( ! in_array($layout, $validLayoutOverrides)) {
    return;
}

// ------------------------------------------------------------

// // !!! Nur waehrend der Entwicklung, danach auskommentieren / loeschen !!!

// $validRequestUris = array(
//     // Dev-Server-Channels
//     'test/ws/oe2016stories',
//     'test/ws/dummy-start-page',
//     // Dev-Server-Artikel
//     'oesterreich/politik/Testartikel-Niessl-Aus-fuer-Medizin-Aufnahmetest/161553560',
//     // Prod-Server-Artikel
//     'oesterreich/politik/Testartikel-Niessl-Aus-fuer-Medizin-Aufnahmetest/253860625',
// );

// $requestUri = trim($parsedUrl['path'], '/ ');

// if ( ! in_array($requestUri, $validRequestUris)) {
//     return;
// }

// $pageLoadUri = $pageLoadUri.'/test/ws/dummy-start-page';

// // !!! Nur waehrend der Entwicklung, danach auskommentieren / loeschen !!! ENDE

// ------------------------------------------------------------
// (bs) DAILY-863
// ------------------------------------------------------------


// $maxStories = 2;
// $secondaryHeadline = 'Auch interessant';
// $emptyImage2x1 = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAIAAAABAQAAAADcWUInAAAAAnRSTlMAAQGU/a4AAAAKSURBVHgBYzgAAADCAMFphPI4AAAAAElFTkSuQmCC';

// $additionalStories = array();
// $additionalStories = $channel->getPublishedTexts($maxStories + 1);

// $stories = array();
// foreach ($additionalStories as $key => $story) {
//     if (($object && $object->getId() === $story->getId()) || $key >= $maxStories) {
//         continue;
//     }

//     $img = $story->getFirstRelatedImage();
//     $imageUrl = ($img) ? $img->getFileUrl('292x146NoStretch') : $emptyImage2x1;
//     $title = $story->getTitle(true);
//     $preTitle = $story->getPreTitle(true);
//     $url = $story->getUrl();

//     $stories[] = array(
//         'imageUrl' => $imageUrl,
//         'title'    => $title,
//         'preTitle' => $preTitle,
//         'url'      => $url,
//     );
// }

$dataSrc = ($object) ? $object->getUrl() : $channel->getUrl();

// $showStories = (spunQ::inMode(spunQ::MODE_DEVELOPMENT)) ? true : ($channel->getId() === 1662921);
// $showStories = $showStories && (count($stories) > 1);

// ------------------------------------------------------------
// (bs) end
// ------------------------------------------------------------
?>

<? if (1): ?>

<div class="newStoriesOverlay <?= 'layout_'.$layout; ?>">

    <div class="newStoriesModal">

        <a class="newStoriesButton newStoriesButtonClose" href="#!">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                <path class="p1" d="M437.5 386.6L306.9 256l130.6-130.6c14.1-14.1 14.1-36.8 0-50.9-14.1-14.1-36.8-14.1-50.9 0L256 205.1 125.4 74.5c-14.1-14.1-36.8-14.1-50.9 0-14.1 14.1-14.1 36.8 0 50.9L205.1 256 74.5 386.6c-14.1 14.1-14.1 36.8 0 50.9 14.1 14.1 36.8 14.1 50.9 0L256 306.9l130.6 130.6c14.1 14.1 36.8 14.1 50.9 0 14-14.1 14-36.9 0-50.9z"/>
            </svg>
        </a>

        <div class="newStoriesImage">
            <img src="<?= $logoPortal; ?>" alt="">
        </div>

        <div class="newStoriesText">
            <?= $newStoriesMessage; ?>
        </div>

        <div>
            <a class="newStoriesButton newStoriesButtonLoad" href="<?= $pageLoadUri; ?>"><?= $newStoriesButtonText; ?></a>
        </div>

        <div>
            <a class="newStoriesButton newStoriesButtonCancel" href="#!">Abbrechen</a>
        </div>

        <? if (0 && $showStories) : ?>
            <div class="headline">
                <?= $secondaryHeadline; ?>
            </div>
            <div class="storyWrapper">
                <? foreach ($stories as $story) : ?>
                    <a class="newStoryOverlayNewStory" href="<?= $story['url']; ?>" target="_blank">
                        <div class="imgWrapper">
                            <img src="<?=$story['imageUrl']; ?>">
                        </div>
                        <strong class="preTitle"><?=$story['preTitle'];?></strong>
                        <span class="title"><?=$story['title'];?>
                    </a>
                <? endforeach; ?>
            </div>
        <? endif;?>

        <? // (bs) DAILY-863 ?>
        <div class="OUTBRAIN" data-src="<?= $dataSrc; ?>" data-widget-id="SF_1" data-ob-template="AT_Oe24.at" >

        </div>
        <script type="text/javascript" src="http://widgets.outbrain.com/outbrain.js"></script>
        <? // (bs) end?>

    </div>
</div>

<? endif; ?>
