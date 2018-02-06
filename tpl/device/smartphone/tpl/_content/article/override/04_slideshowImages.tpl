<?
/**
 * override slideshow
 * @var content oe24.core.Content
 * @default content 0
 */

// debug($content);

if ( ! $content) {
    return;
}

if ( ! ($content instanceof SlideShow)) {
    return;
}

// --------------------------------------------------
try {
    $device = DeviceContainer::getDevice();
    $emptyImages = $device->getConfig('emptyImages');
    $emptyImage = $emptyImages['emptyImage1x1'];
} catch (Exception $e) {
    $emptyImage = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABAQAAAAA3bvkkAAAAAnRSTlMAAQGU/a4AAAAKSURBVHgBY2gAAACCAIFMF9ffAAAAAElFTkSuQmCC';
}

// $imageFormat = '400x400';
$imageFormat = '960x960MobileGrey';

// --------------------------------------------------

$relatedImages = $content->getRelatedImages();
// debug($relatedImages);

// --------------------------------------------------

$slides = array();

foreach ($relatedImages as $relatedImage) {

    $title = $content->getTitleForImage($relatedImage);
    $description = $content->getDescriptionForImage($relatedImage);

    $copyright = $relatedImage->getCopyright();
    $copyright = ($copyright) ? '© '.$copyright : '';

    $imageSrc = $relatedImage->getFileUrl($imageFormat);

    $slides[] = array(
        'title'       => $title,
        'description' => $description,
        'imageSrc'    => $imageSrc,
        'copyright'   => $copyright,
    );
}

// --------------------------------------------------

// Options für Flickity

$sliderA = 'sliderA_'.uniqid();

$autoplay = false;

$optionsSliderMain = json_encode(array(
    'autoPlay'        => $autoplay,
    'cellSelector'    => '.slide',
    'pageDots'        => false,
    'prevNextButtons' => true,
    'draggable'       => true,
));

$optionsSliderDescription = json_encode(array(
    'autoPlay'        => $autoplay,
    'cellSelector'    => '.slide',
    'pageDots'        => false,
    'prevNextButtons' => false,
    'draggable'       => true,
    'asNavFor'        => '.'.$sliderA,
));

// debug($optionsSliderMain);
// debug($optionsSliderDescription);

// --------------------------------------------------

// In einer Template-Option setzen?
$enableSlider = true;

$classSlider = ($enableSlider) ? 'flickitySlider' : '';
$slides = ($enableSlider) ? $slides : array_slice($slides, 0, 1);

// --------------------------------------------------

// Image Zooming funktioniert nur, wenn Flickity NICHT verwendet wird !
$dataAction = ('' == $classSlider) ? 'data-action="zoom"' : '';

?>

<div class="overrideSlideshow overrideImageSlideshow storySlideshow">

    <div class="<?= $classSlider; ?> <?= $sliderA; ?>" data-options='<?= $optionsSliderMain; ?>'>

        <? foreach ($slides as $key => $slide): ?>

            <div class="slide">

                <div class="slideImageContainer <?= (0 == $key) ? 'slideImageContainerFirst' : ''; ?>">

                    <? if (0 == $key): ?>
                        <img src="<?= $slide['imageSrc']; ?>" <?= $dataAction; ?> data-flickity-lazyload="<?= $slide['imageSrc']; ?>" alt="">
                    <? else: ?>
                        <img src="<?= $emptyImage; ?>" <?= $dataAction; ?> data-flickity-lazyload="<?= $slide['imageSrc']; ?>" alt="">
                    <? endif; ?>

                    <? if ($slide['copyright']): ?>
                    <p class="slideCopyright"><?= $slide['copyright']; ?></p>
                    <? endif;?>

                </div>

            </div>

        <? endforeach; ?>

    </div>

    <div class="<?= $classSlider; ?>" data-options='<?= $optionsSliderDescription; ?>'>

        <? foreach ($slides as $key => $slide): ?>

            <div class="slide">

                <div class="slideTextContainer">

                    <? if (0 && $slide['copyright']): ?>
                    <p class="slideCopyright"><?= $slide['copyright']; ?></p>
                    <? endif;?>

                    <? if ($slide['title']): ?>
                    <h3 class="slideTitle"><?= $slide['title']; ?></h3>
                    <? endif;?>

                    <? if ($slide['description']): ?>
                    <p class="slideDescription"><?= $slide['description']; ?></p>
                    <? endif;?>

                </div>

            </div>

        <? endforeach; ?>

    </div>

</div>
