<?
function amp_carousel($slideShowId, $class = '', $width = 400, $height = 400, $layout = 'responsive', $images = null) {

	// funktioniert entweder mit SlideshowId oder einem Array von images

	if ($images == null) {
		try {
			$slideshow = db()->getById($slideShowId, 'oe24.core.SlideShow');
			$slideShowImages = $slideshow->getRelatedImages();
		} catch (Exception $e) {
			return '';
		}
	} else {
		if (!is_array($images)) {
			return '';
		}
	}

	if ($layout != '') {
		$layout = 'layout="'.$layout.'"';
	}

	if ($images != null) {
		$slideShowImages = $images;
	}

	// $buffer = array();
	// $buffer[] = '<div class="carousel">';
	// $buffer[] = "<amp-carousel width=\"$width\" height=\"$height\" type=slides controls loop $layout $class>";

	// foreach ($slideShowImages as $key => $picture) {
	// 	$buffer[] = amp_img($picture, $width, $height, 'responsive', true);
	// }

	// $buffer[] = "</amp-carousel>";
	// $buffer[] = "</div>";
	// $carousel = implode('', $buffer);
	// return $carousel;

	$heightCarousel = $height + 14;

	$buffer = array();
	$buffer[] = '<div class="carousel">';
	$buffer[] = "<amp-carousel width=\"$width\" height=\"$heightCarousel\" type=\"slides\" controls loop $layout class=\"$class\">";

	foreach ($slideShowImages as $key => $picture) {
		$buffer[] = amp_img($picture, $width, $height, 'responsive');
	}

	$buffer[] = "</amp-carousel>";
	$buffer[] = "</div>";

	$carousel = implode('', $buffer);

	return $carousel;
}
