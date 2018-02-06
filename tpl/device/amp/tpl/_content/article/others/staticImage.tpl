<?
/**
 * AMP Statische Bilder
 *
 * @var url string
 * @var class string
 * @default class null
 * @var width integer
 * @default width 135
 * @var height integer
 * @default height 60
 */

$class = ('null' === $class) ? '' : $class;

?>
<amp-img src="<?= $url; ?>" height="<?= $height; ?>" width="<?= $width; ?>" layout="fixed" class="<?= $class; ?>"></amp-img>
