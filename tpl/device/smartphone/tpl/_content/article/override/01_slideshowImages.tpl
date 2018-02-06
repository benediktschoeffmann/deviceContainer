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

$device = DeviceContainer::getDevice();

// --------------------------------------------------

$emptyImages = $device->getConfig('emptyImages');
$emptyImage = $emptyImages['emptyImage1x1'];

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

$autoplay = false;

$options = json_encode(array(
    'autoPlay'              => $autoplay,
    'cellSelector'          => '.slide',
    'pageDots'              => false,
    'prevNextButtons'       => true,
));

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

    <div class="<?= $classSlider; ?>" data-options='<?= $options; ?>'>

        <? foreach ($slides as $key => $slide): ?>

            <div class="slide">

                <div class="slideImageContainer <?= (0 == $key) ? 'slideImageContainerFirst' : ''; ?>">

                    <? if (1): ?>

                        <? if (0 == $key): ?>
                            <img src="<?= $slide['imageSrc']; ?>" <?= $dataAction; ?> data-flickity-lazyload="<?= $slide['imageSrc']; ?>" alt="">
                        <? else: ?>
                            <img src="<?= $emptyImage; ?>" <?= $dataAction; ?> data-flickity-lazyload="<?= $slide['imageSrc']; ?>" alt="">
                        <? endif; ?>

                        <? if ($slide['copyright']): ?>
                        <p class="slideCopyright"><?= $slide['copyright']; ?></p>
                        <? endif;?>

                    <? endif; ?>

                    <? if (!$options['prevNextButtons']): ?>

                        <button class="slideshowButton previous" type="button" aria-label="previous">
                            <svg viewBox="0 0 100 100">
                                <path d="M 10,50 L 60,100 L 70,90 L 30,50  L 70,10 L 60,0 Z" class="arrow"></path>
                            </svg>
                        </button>

                        <button class="slideshowButton next" type="button" aria-label="next">
                            <svg viewBox="0 0 100 100">
                                <path d="M 10,50 L 60,100 L 70,90 L 30,50  L 70,10 L 60,0 Z" class="arrow" transform="translate(100, 100) rotate(180) "></path>
                            </svg>
                        </button>

                    <? endif; ?>

                </div>

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
