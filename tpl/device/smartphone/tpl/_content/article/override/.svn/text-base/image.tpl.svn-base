<?
/**
 * override image
 * @var image oe24.core.Image
 * @default image 0
 */

if ( ! $image) {
    return;
}

// (ws) 2017-03-06

// ------------------------------------------

$withImageZoom = true;
$withCopyright = true;

// ------------------------------------------

$device = DeviceContainer::getDevice();

// ------------------------------------------

$emptyImageFormat = 'emptyImage1x1';
$emptyImages = $device->getConfig('emptyImages');
$emptyImage = $emptyImages[$emptyImageFormat];

// ------------------------------------------

$imageFormat = 'XL-Konsole';

$imageSrc = $image->getFileUrl($imageFormat);
$imageAlt = '';

$copyright = trim($image->getCopyright());
$copyright = ($copyright) ? '© '.$copyright : '';

// ------------------------------------------

// (ws) 2017-03-14 vorlaeufig rausnehmen
$withImageZoom = false;

// Image Zooming funktioniert nur, wenn es sich
// nicht um eine Flickity Slideshow handelt.
// Image Zooming nur im Artikel zulassen
$dataAction = ($withImageZoom) ? 'data-action="zoom"' : '';

// ------------------------------------------

// $lazyLoadingClass = 'oe24Lazy';
$lazyLoadingClass = 'responsively-lazy';

// ------------------------------------------

?>
<span class="overrideImage">

    <?
    // tpl('oe24.oe24.device.smartphone.tpl._content.image.defaultImage', array(
    //     'image'            => $image,
    //     'withCopyright'    => true,
    //     'withImageZoom'    => true,
    // ));
    ?>

    <span class="imageContainer inlineImage">
        <img class="<?= $lazyLoadingClass; ?>" src="<?= $emptyImage; ?>" data-srcset="<?= $imageSrc; ?>" <?= $dataAction; ?> alt="<?= $imageAlt; ?>" >
        <? if ($withCopyright && '' != $copyright): ?>
            <span class="copyright"><?= $copyright; ?></span>
        <? endif;?>
    </span>

</span>
