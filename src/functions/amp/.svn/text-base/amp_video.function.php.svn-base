<?php
function amp_video($videoId) {
	try {
		$video = db()->getById($videoId, 'oe24.core.Video');
	} catch (Exception $e) {
		return '';
	}

	$poster = '';
	$img = $video->getFirstRelatedImage();
	if ($img) {
		// $poster = 'poster="'.$img->getFileUrl().'"';
		$poster = 'poster="'.$img->getFileUrl('624x351').'"';
	}

	$buffer = array();
	$buffer[] = '<amp-video ';
	$buffer[] = 'src="//media.oe24.at/';
	$buffer[] = $video->getVideoId().'/'.$video->getVideoId().'.mp4"';
	$buffer[] = 'width="480"';
	// $buffer[] = 'height="240"';
	$buffer[] = 'height="270"';
	$buffer[] = $poster;
	$buffer[] = 'layout="responsive" controls>';
	// $buffer[] = '<div fallback><p>Your browser doesn’t support HTML5 video</p></div>';
	$buffer[] = '</amp-video>';

	$videoTag = implode('', $buffer);

	return $videoTag;
}
