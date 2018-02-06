<?php
function amp_img_static($url, $width=135, $height=60, $class='') {
	if ('' !== $class) {
		$class = ' class="'.$class.'"';
	}
	$buffer = array();
	$buffer[] = '<amp-img src="';
	$buffer[] = $url;
	$buffer[] = '" height="';
	$buffer[] = $height;
	$buffer[] = '" width="';
	$buffer[] = $width;
	$buffer[] = '" layout=fixed';
	$buffer[] = $class;
	$buffer[] = '></amp-img>';
	$imgTag = implode('', $buffer);
	return $imgTag;
}
