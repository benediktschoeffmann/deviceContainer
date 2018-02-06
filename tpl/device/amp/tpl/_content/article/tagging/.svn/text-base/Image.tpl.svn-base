<?
/**
 * AMP spunQ_Image Tag
 *
 * @var spunqTag array<any>
 * @var class string
 * @default class null
 * @var layout string
 * @default layout responsive
 * @var width integer
 * @default width 480
 * @var height integer
 * @default height 240
 */

$id = $spunqTag['attributes']['id'];
$image = (is_numeric($id)) ? db()->getById($id, 'oe24.core.Image', false) : NULL;

if (NULL === $image) {
    return;
}

$class = ('null' === $class) ? '' : $class;

// maybe put this in the spunQ.conf
$imageFormatSmall = '292x146NoStretch';
$imageFormatMedium = '360x180';
$imageFormatLarge = '620x310BigStory';

$square = false;
if ($width == $height) {
    $imageFormatMedium = '400x400';
    $square = true;
}

$smallBreakPoint = '319';
$mediumBreakPoint = '479';

$src = $image->getFileUrl($imageFormatMedium);
$width = ($square) ? '400' : $width;
$height = ($square) ? '400' : $height;
$copyright = $image->getCopyright();
$copyright = ($copyright) ? '© '.$copyright : '&nbsp;';

?>
<figure>
   <amp-img src="<?= $src; ?>" width="<?= $width; ?>" height="<?= $height; ?>" class="<?= $class; ?>" layout="<?= $layout; ?>" alt=""></amp-img>
   <figcaption><?= $copyright; ?></figcaption>
</figure>
