<?php
/**
 * Story Site - Slideshows new.
 *
 * @var slideshow any
 * @var imageVersion string
 * @var showThumbnails boolean
 * @default showThumbnails 0
 */

if (!($slideshow instanceof SlideShow)) {
	return;
}

$images = $slideshow->getRelatedImages();
if (empty($images)) {
	return;
}

// const imageFormats
$thumbnailImageFormat = '100x100';

$channel = $slideshow->getHomeChannel();
// $options = $slideshow->getOptions(true, true);

$imageInfos = array();
$thumbnails = array();

foreach ($images as $key => $image) {
	$imageInfos[] = array(
		'title'			=> htmlspecialchars($slideshow->getTitleForImage($image)),
		'description'	=> nl2br($slideshow->getDescriptionForImage($image)),
		'fileUrl'		=> $image->getFileUrl($imageVersion),
		'copyright'		=> $image->getCopyright(),
		);
	if ($showThumbnails) {
		$thumbnails[] = $image->getFileUrl($thumbnailImageFormat);
	}
}

// $id = uniqid();
$slideshowCounter = count($imageInfos);
$imagesPerPage = 5;
if ($showThumbnails) {
	$countPages = ceil($slideshowCounter / $imagesPerPage);
	// $thumbnails = array_chunk($thumbnails, $imagesPerPage);
}

$slideshowTitle = ($slideshow->getTitle())?$slideshow->getTitle():'';

// $showOE2016Headline = true;
// $additionalSlideshowClass = '';
// if ($isFirstSlideshow) {
// 	$additionalSlideshowClass = ' noHeadline';
// 	$showOE2016Headline = false;
// }
// -------------------------------------------------------------------------------------------

?>

<div class="imageSlideShowWrapper<?//=$additionalSlideshowClass;?>" data-images-per-page="<?= $imagesPerPage; ?>">
	<div class="oe2016InlineHeadline">
		<span class="type">Diashow </span>
		<span class="title"><?=$slideshowTitle;?></span>
	</div>
	<div class="bigSlideShow">
		<div class="imageSlideShow">
			<? foreach ($imageInfos as $key => $image): ?>
				<? $class = (0 === $key) ? '' : 'hide'; ?>
				<div class="slide <?= $class; ?>">
					<div class="overlay_box">
						<img data-lazy="<?= $image['fileUrl']; ?>" alt="<?= $image['title']; ?>">
						<h2 class="caption">
							<span class="title"><?= $image['title']; ?></span>
						</h2>
					</div>
					<? if ($image['copyright']): ?>
						<p class="copyright">© <?= $image['copyright']; ?></p>
					<? endif; ?>
					<p class="description"><?= $image['description']; ?></p>
				</div>
			<? endforeach; ?>
		</div>
		<div class="js-oewaLink arrow arrowPrev unselectable" onclick="<?=eventTracking(array("callTemplate" => __FILE__, "channel" => $channel, "content" => $slideshow, "action" => "slideshowBack"))?>"><span>&lsaquo;</span></div>
		<div class="js-oewaLink arrow arrowNext unselectable" onclick="<?=eventTracking(array("callTemplate" => __FILE__, "channel" => $channel, "content" => $slideshow, "action" => "slideshowForw"))?>"><span>&rsaquo;</span></div>
		<div class="bigSliderCounter">1 / <?= count($imageInfos); ?></div>

		<? // (bs) 2015-11-19 OE2016-24 eumel kommt weg. ?>
 		<div class="slideshowOverlayBanner">
			<span class="icon icon_camera">&nbsp;</span>
			<span>Diashow</span>
		</div>


	</div>

	<? if ($showThumbnails): ?>
		<div class="thumbnailSlideShow">
			<div class="imageSlideShowThumbs">
				<? foreach ($thumbnails as $key => $thumbnail): ?>
					<div class="slideThumb">
						<img data-lazy="<?= $thumbnail; ?>" alt="">
					</div>
				<? endforeach; ?>
			</div>

			<? if ($countPages > 1): ?>
				<div class="slideshowPages">
					Seiten:
					<? for($n = 1; $n <= $countPages; $n++): ?>
					<? $classActive = ($n == 1) ? 'active' : ''; ?>
					<a href="#" class="<?= $classActive; ?>">
						<?= ' '.$n; ?>
					</a>
					<?endfor;?>
				</div>
			<? endif; ?>
		</div>
	<? endif; ?>
</div>
