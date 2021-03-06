<?
/**
 * article default story image
 * @var relatedImages array<oe24.core.Image>
 */

// debug($relatedImages);
// $relatedImages = array_slice($relatedImages, 0, 1);
// debug($relatedImages);

// --------------------------------------------------

$imagesCounter = count($relatedImages);
if ($imagesCounter <= 0) {
    return;
}

// --------------------------------------------------

// $smartphone = Smartphone::getInstance();
$device = DeviceContainer::getDevice();

$layout = $device->getConfig('layout');
$layout = ($layout) ? $layout : 'oe24';

// --------------------------------------------------

$emptyImageFormat = 'emptyImage2x1';

$emptyImages = $device->getConfig('emptyImages');
$emptyImage = $emptyImages[$emptyImageFormat];

// (db) 2017-05-03 madonna mit eigenem Bildformat - bild bis zum Rand, nicht "abgeschnitten"
switch ($layout) {
    case 'madonna':
        $imageFormat = '960x600';
        $containerStyle = 'style="padding-bottom: 62.5%;"';
        break;

    default:
        // $imageFormat = '400x400';
        // (bs) 2017-02-20
        // $imageFormat = '960x480';
        $imageFormat = 'bigStory';
        $containerStyle = 'style="padding-bottom: 50%;"';
        break;
}


// --------------------------------------------------

$slides = array();

foreach ($relatedImages as $relatedImage) {

    $title = $relatedImage->getTitle();

    $copyright = trim($relatedImage->getCopyright());
    $copyright = ($copyright) ? '© '.$copyright : '';

    $imageSrc = $relatedImage->getFileUrl($imageFormat);

    $slides[] = array(
        'title'       => '', // $title,
        'description' => '',
        'imageSrc'    => $imageSrc,
        'copyright'   => $copyright,
    );
}

// --------------------------------------------------

// Options für Flickity

$autoplay = false;

$options = json_encode(array(
    'autoPlay' => $autoplay,
    'pageDots' => false,
    'prevNextButtons' => true,
    'cellSelector' => '.slide',
));

// --------------------------------------------------

$classSlider = ($imagesCounter > 1) ? 'flickitySlider' : '';
$slides = ($imagesCounter > 1) ? $slides : array_slice($slides, 0, 1);

// --------------------------------------------------

// Image Zooming funktioniert nur, wenn es sich
// nicht um eine Flickity Slideshow handelt
$dataAction = ('' == $classSlider) ? 'data-action="zoom"' : '';

?>

<div class="overrideSlideshow overrideImageSlideshow storySlideshow">

    <div class="<?= $classSlider; ?>" data-options='<?= $options; ?>'>

        <? foreach ($slides as $key => $slide): ?>

            <div class="slide">

                <div class="slideImageContainer"<?= $containerStyle; ?>>

                    <? if (1): ?>

                        <? if (0 == $key): ?>
                            <img
                                src="<?= $slide['imageSrc']; ?>"
                                alt=""
                                data-original="<?= $slide['imageSrc']; ?>"
                                data-flickity-lazyload="<?= $slide['imageSrc']; ?>"
                                <?= $dataAction; ?>
                                >
                        <? else: ?>
                            <img
                                src="<?= $emptyImage; ?>"
                                alt=""
                                data-original="<?= $slide['imageSrc']; ?>"
                                data-flickity-lazyload="<?= $slide['imageSrc']; ?>"
                                <?= $dataAction; ?>
                                >
                        <? endif; ?>

                        <? if (!empty($slide['copyright'])): ?>
                        <p class="copyright"><?= $slide['copyright']; ?></p>
                        <? endif;?>

                    <? endif; ?>

                </div>

            </div>
        <? endforeach; ?>

    </div>

</div>
