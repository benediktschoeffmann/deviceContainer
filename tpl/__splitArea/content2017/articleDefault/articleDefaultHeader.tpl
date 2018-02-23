<?
/**
* content articleDefaultHeader
*
* @var channel oe24.core.Channel
* @var params array<any>
* @var object oe24.core.Text
* @var layout string
* @var oe2016layouts array<string>
*/

// ----------------------------------------

$title = $object->getTitle();
$leadText = $object->getLeadText(true);

// Datum + Uhrzeit: 17. August 2010, 14:16
$frontendDate = $object->getFrontendDate();
$articleDateTime = formatDateUsingIntlLangKey('date.long', $frontendDate).' '.formatDateUsingIntlLangKey('time.short', $frontendDate);

// ----------------------------------------

$emptyImage1x1   = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABAQAAAAA3bvkkAAAAAnRSTlMAAQGU/a4AAAAKSURBVHgBY2gAAACCAIFMF9ffAAAAAElFTkSuQmCC';
$emptyImage2x1   = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAIAAAABAQAAAADcWUInAAAAAnRSTlMAAQGU/a4AAAAKSURBVHgBYzgAAADCAMFphPI4AAAAAElFTkSuQmCC';
$emptyImage16x9  = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAJAQAAAAATUZGfAAAAAnRSTlMAAQGU/a4AAAANSURBVHgBY/j/HxcCAPIoEe+JMKgiAAAAAElFTkSuQmCC';
$emptyImage16x10 = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAKAQAAAACVxeMxAAAAAnRSTlMAAQGU/a4AAAANSURBVHgBY/j/Hw8CACsBE+1t+fJZAAAAAElFTkSuQmCC';

$relatedImages = $object->getRelatedImages();

switch ($layout) {
    case 'madonna':
        $imageFormat = '620x388';
        $emptyImage = $emptyImage16x10;
        break;
    default:
        $imageFormat = 'bigStory';
        $emptyImage = $emptyImage2x1;
        break;
}

$images = array();

foreach ($relatedImages as $key => $image) {
    $copyright = $image->getCopyright();
    $images[] = array(
        'src'        => $image->getFileUrl($imageFormat),
        'copyright'  => ($copyright && !empty($copyright)) ? '© '.$copyright : '&nbsp;',
        'empytImage' => $emptyImage,
    );
}

// ----------------------------------------

$videos = $object->getRelatedVideos();
$firstVideo = reset($videos);

// ----------------------------------------

?>


<div class="articleHeader">

    <p class="articleDateTime"><?= $articleDateTime; ?></p>

    <div class="articleContainer">
        articleContainer
    </div>

</div>
