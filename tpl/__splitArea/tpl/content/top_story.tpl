<?php

/**
 * Channel Top-Story - rl2014
 * @var box oe24.core.ContentBox
 * @var content oe24.core.Content
 * @var showTopStoryTitle any
 */

if (!($content instanceof TextualContent)) {
	return null;
}

// -------------------------------------------

$recipeDefaultImages = array(
	'1a-620x310.jpg',
	'1b-620x310.jpg',
);
$recipeDefaultImagesMax = count($recipeDefaultImages) - 1;

// -------------------------------------------

$attr = getContentUrlAttributesArray($content, $box, true, true, true);
$link_href = (isset($attr['href']) && is_string($attr['href'])) ? $attr['href'] : '#';
$link_title = (isset($attr['title']) && is_string($attr['title'])) ? $attr['title'] : '';
$link_target = (isset($attr['target']) && is_string($attr['target']) && '' != $attr['target']) ? 'target="'.$attr['target'].'"' : '';

$image_format = 'bigStory';
$image = $content->getFirstRelatedImage(true, $box);
if (null == $image) {
	if ($content instanceOf Recipe) {
		// $image_src = (null !== $image) ? $image->getFileUrl($image_format) : lp('image', 'rl2014/recipe/dummyRecipe190x095.png');
		// $defaultImage = $recipeDefaultImages[rand(0, $recipeDefaultImagesMax)];
		$defaultImage = $recipeDefaultImages[0];
		$image_src = (null !== $image) ? $image->getFileUrl($image_format) : lp('image', 'rl2014/recipe/defaultImages/'.$defaultImage);
	} else {
		$image_src = (null !== $image) ? $image->getFileUrl($image_format) : 'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7';
	}
} else {
	$image_src = $image->getFileUrl($image_format);
}

// die Top-Stories-Images werden mit geringerer Hoehe als
// 310 Pixel dargestellt, naemlich derzeit mit 250 Pixel.
// $image_dimension = 'width="620" height="310"';
$image_dimension = '';

$pageTitle = trim($content->getPreTitle(true, $box));
$copyright = '© '.trim($content->getCopyright());

// -------------------------------------------

$copyright = (null != $image) ? trim($image->getCopyright()) : 'unbekannt';
$copyright = '&copy; '.$copyright;
// Derzeit keinen Copyright-Vermerk
$copyright = null;

// Ueberpruefen ob content ein Video ist
$videoClass = '';
if ($content instanceof Text) {
	$videoClass = $content->getVideoOptions() ? 'video_container' : '';
} else if ($content instanceof Video) {
	$classVideo = 'video_container';
}

?>
<section class="col col1 channel_box top_story">
	<a href="<?=$link_href?>" title="<?=$link_title?>" <?=$link_target?>>
		<div class="overlay_box">
			<span class="<?=$videoClass;?>">
				<?if(isset($_GET['oe24NoLazy'])){?>
					<img src="<?=$image_src?>" alt="" <?=$image_dimension?> >
				<?} else {?>
					<img data-original="<?=$image_src?>" src="/images/empty.gif" alt="" <?=$image_dimension?> class="oe24Lazy" />
				<?}?>
			</span>
			<? if ($showTopStoryTitle): ?>
			<!--[if lt IE 9]><div class="captionBg">&nbsp;</div><![endif]-->
			<h1 class="caption"><?=$content->getTitle(true, $box)?></h1>
			<? endif ?>
			<? if ($copyright && '' !== $copyright): ?>
			<span class="copyright">© <?=$copyright?></span>
			<? endif ?>
		</div>
	</a>
</section>

