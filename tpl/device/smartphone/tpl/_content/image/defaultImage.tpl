<?
/**
 * standard image
 * @var image any
 * @var emptyImageFormat any
 * @default emptyImageFormat 0
 * @var withCopyright boolean
 * @default withCopyright 1
 * @var withImageZoom boolean
 * @default withImageZoom 0
 * @var forcedImageFormat any
 * @default forcedImageFormat 0
 */

$device = DeviceContainer::getDevice();

// ------------------------------------------

$layout = $device->getConfig('layout');

// ------------------------------------------

$channel = $device->getConfig('channel');
$channel = ($channel instanceof Channel) ? $channel : null;

$channelOptions = $channel->getOptions(true, true);
$layoutOverride = $channelOptions->get('layoutOverride');

switch ($layoutOverride) {

    case 'madonna':

        $imageConfig = array(
            'small' => array(
                'format' => '310x194',
                'width'  => '310w',
                // 'size'   => '100%',
                'size'   => '',
            ),
            'medium' => array(
                //'format' => '620x388',
                'format' => '620x620',
                'width'  => '620w',
                // 'size'   => '(min-width: 25em) 50%',
                // 'size'   => '100%',
                'size'   => '',
            ),
            'large' => array(
                'format' => '960x600',
                'width'  => '960w',
                // 'size'   => '(min-width: 50em) 33%',
                // 'size'   => '100%',
                'size'   => '',
            ),
        );

        // -> format = 620x388
        // $emptyImageFormat = 'emptyImage16x10';
        // $style = 'padding-bottom:62.5%;';

        // -> format = 620x620
        $emptyImageFormat = 'emptyImage1x1';
        $style = 'padding-bottom:100%;';

        break;

    default:

        $imageConfig = array(
            'small' => array(
                'format' => '360x180Crop',
                'width'  => '360w',
                // 'size'   => '100%',
                'size'   => '',
            ),
            'medium' => array(
                'format' => 'bigStoryCrop',
                'width'  => '620w',
                // 'size'   => '(min-width: 25em) 50%',
                // 'size'   => '100%',
                'size'   => '',
            ),
            'large' => array(
                'format' => '960x480',
                'width'  => '960w',
                // 'size'   => '(min-width: 50em) 33%',
                // 'size'   => '100%',
                'size'   => '',
            ),
        );

        if (0 == $emptyImageFormat) {
            $emptyImageFormat = 'emptyImage2x1';
        }

        $style = 'padding-bottom:50%;';

        break;
}

// ------------------------------------------

$emptyImages = $device->getConfig('emptyImages');
$emptyImage = $emptyImages[$emptyImageFormat];

// ------------------------------------------

// $imageFormatOriginal = 'original';
$imageFormat = $imageConfig['medium']['format'];
$imageFormat = ('0' != $forcedImageFormat) ? $forcedImageFormat : $imageFormat;

// ------------------------------------------

$image = ($image instanceof Image) ? $image : null;

if (null == $image) {
    return;
}

$imageSrc = $image->getFileUrl($imageFormat);

$copyright = trim($image->getCopyright());
$copyright = ($copyright) ? '© '.$copyright : '';

// ------------------------------------------

$imageAlt = '';

$srcset = array();
$sizes = array();

foreach ($imageConfig as $item) {
    $srcset[] = $image->getFileUrl($item['format']).' '.$item['width'];
    $sizes[] = $item['size'];
}

// debug(implode(', ', $srcset));
// debug(implode(', ', $sizes));

// ------------------------------------------

// Image Zooming funktioniert nur, wenn es sich
// nicht um eine Flickity Slideshow handelt.
// Image Zooming nur im Artikel zulassen
$dataAction = ($withImageZoom) ? 'data-action="zoom"' : '';

// ------------------------------------------

// $lazyLoadingClass = 'oe24Lazy';
$lazyLoadingClass = 'responsively-lazy';

// ------------------------------------------

?>


<span class="imageContainer" style="<?= isset($style) ? $style : ''; ?>">
    <img class="<?= $lazyLoadingClass; ?>" src="<?= $emptyImage; ?>" data-srcset="<?= $imageSrc; ?>" <?= $dataAction; ?> alt="<?= $imageAlt; ?>" >
    <? if ($withCopyright): ?>
        <span class="copyright"><?= $copyright; ?></span>
    <? endif;?>
</span>


<? if (0): ?>
<span class="imageContainer" style="<?= isset($style) ? $style : ''; ?>">
    <img src="<?= $imageSrc; ?>" <?= $dataAction; ?> alt="<?= $imageAlt; ?>">
    <? if ($withCopyright): ?>
        <span class="copyright"><?= $copyright; ?></span>
    <? endif;?>
</span>
<? endif; ?>


<? if (0): ?>
<span class="imageContainer" style="<?= isset($style) ? $style : ''; ?>">
    <img src="<?= $imageSrc; ?>" <?= $dataAction; ?> alt="<?= $imageAlt; ?>"
        srcset="<?= implode(', ', $srcset); ?>" sizes="<?= implode(', ', $sizes); ?>" >
    <? if ($withCopyright): ?>
    <span class="copyright"><?= $copyright; ?></span>
    <? endif;?>
</span>
<? endif; ?>
