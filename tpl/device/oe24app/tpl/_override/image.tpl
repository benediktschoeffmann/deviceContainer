<?
/**
 * override image for oe24app
 * @var image oe24.core.Image
 * @default image 0
 */

if (!$image) {
    return;
}

$device = DeviceContainer::getDevice();

// ------------------------------------------

// $imageFormat = 'XL-Konsole';
$imageFormat = 'Oe24AppXL-Konsole';

$imageSrc = $image->getFileUrl($imageFormat);
$imageAlt = '';

$copyright = trim($image->getCopyright());
$copyright = ($copyright) ? '© '.$copyright : '';

// ------------------------------------------

?>
<span class="overrideImage">
    <span class="imageContainer inlineImage">
        <img src="<?= $imageSrc; ?>" alt="<?= $imageAlt; ?>" >
        <? if ('' != $copyright): ?>
            <span class="copyright"><?= $copyright; ?></span>
        <? endif;?>
    </span>

</span>
