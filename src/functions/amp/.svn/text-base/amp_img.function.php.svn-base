<?php
function amp_img($image, $width = 480, $height = 240, $layout = 'responsive', $class = '') {

	if (!$image) {
		return '';
	}

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

	// if ($class !== '') {
	// 	$class = ' class="'.$class.'"';
	// }
	//
	// $buffer = array();
	// $buffer[] = '<amp-img src="';
	// $buffer[] = $image->getFileUrl($imageFormatMedium);
	// $buffer[] = '" height="';
	// $buffer[] = ($square) ? '400' : $height;
	// $buffer[] = '" width="';
	// $buffer[] = ($square) ? '400' : $width;
	// $buffer[] = '" layout="';
	// $buffer[] = $layout;
	// $buffer[] = '"'.$class.'></amp-img>';

	$buffer = array();

	$src = $image->getFileUrl($imageFormatMedium);
	$width = ($square) ? '400' : $width;
	$height = ($square) ? '400' : $height;
	$copyright = $image->getCopyright();
	$copyright = ($copyright) ? '© '.$copyright : '&nbsp;';

	$buffer[] = '<figure>';
	$buffer[] = '	<amp-img src="'.$src.'" width="'.$width.'" height="'.$height.'" class="'.$class.'" layout="'.$layout.'" alt=""></amp-img>';
	$buffer[] = '	<figcaption>'.$copyright.'</figcaption>';
	$buffer[] = '</figure>';

	$imgTag = implode('', $buffer);

	return $imgTag;
}
