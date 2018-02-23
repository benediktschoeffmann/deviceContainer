<?php
/**
 * Story Site - Slideshows new.
 *
 * @var slideshow any
 * @var imageFormat string
 * @var slideshowStories any
 * @default slideshowStories 0
 */

$isArticleHeadline = false;

if (($slideshow instanceof Text)) {
	// Artikeltitelbilder
	$isArticleHeadline = true;
}
elseif (!($slideshow instanceof SlideShow)) {
	return;
}

// -------------------------------------------------------------------------------------------

$slideshowTitle = '';
$additionalClass = '';
if ($isArticleHeadline) {
	$additionalClass = 'articleHeadline';
}
else{
	$slideshowTitle = $slideshow->getTitle();
}

// -------------------------------------------------------------------------------------------

$images = $slideshow->getRelatedImages();

if (empty($images)) {
	return;
}

$imageInfos = array();

foreach ($images as $key => $image) {

	$title = false;
	$description = false;
	$fileUrl = $image->getFileUrl($imageFormat);
	$copyright = $image->getCopyright();

	if ($isArticleHeadline) {
		// (db) 2017-05-30 Pre-Title der Slideshow anstelle der Image-Titel bei Slideshow im Artikelhead
		// $title = htmlspecialchars($image->getTitle());
		$title = $slideshow->getPreTitle();
		// (db) 2017-05-30 end
	}
	else{
		$title = htmlspecialchars($slideshow->getTitleForImage($image));
		$description = nl2br($slideshow->getDescriptionForImage($image));
	}
	
	$imageInfos[] = array(
		'title'			=> $title,
		'description'	=> $description,
		'fileUrl'		=> $fileUrl,
		'copyright'		=> $copyright,
	);
}

$emptyImage = ($slideshowStories) ? lp('image', 'empty_1x1_transparent.png') : lp('image', 'empty_2x1_transparent.png');

// -------------------------------------------------------------------------------------------

// $countSlides = count($imageInfos); // falls altes format doch wieder genommen wird - ist countSlides noch auskommentiert

// -------------------------------------------------------------------------------------------

// Options für Flickity

$options = json_encode(array(
	'cellSelector' => '.slide',
	'draggable'    => true,
	'lazyLoad'     => 2,
	'classCounter' => '.sliderCounter',
));

// -------------------------------------------------------------------------------------------


?>

<?
// <div class="imageSlideShowWrapper<?//=$additionalSlideshowClass;? >" data-images-per-page="<?= $imagesPerPage; ? >">
?>

<div class="articleContentSliderBox <?= $additionalClass; ?>">

	<? if ($isArticleHeadline): ?>

		<? /* slider für Artikeltitelbilder */ ?>

		<? if (1): ?>

			<div class="flickitySlider" data-options='<?= $options; ?>'>

				<? foreach ($imageInfos as $key => $image): ?>

					<div class="slide">

						<div class="overlay_box">

							<? if (0 == $key): ?>
								<img src="<?= $image['fileUrl']; ?>" alt="">
							<? else: ?>
								<img src="<?= $emptyImage; ?>" data-flickity-lazyload="<?= $image['fileUrl']; ?>" alt="">
							<? endif; ?>

							<? if ($image['title']): ?>
								<h2 class="caption">
									<span class="title"><?= $image['title']; ?></span>
								</h2>
							<? endif; ?>

						</div>

						<? if (1): ?>
							<?
								$showCopyright = false;
								
								if($image['copyright']) {
									$showCopyright = true;
								}
								
							?>
							<? if ($showCopyright): ?>
								<div class="descriptionContent">
									<? if ($showCopyright): ?>
										<p class="copyright">© <?= $image['copyright']; ?></p>
									<? endif; ?>
								</div>
							<? endif; ?>
						<? endif; ?>

					</div>

				<? endforeach; ?>

			</div>

		<? endif; ?>

	<? else: ?>

		<? /* normaler Slider im Artikeldetail */ ?>
		<div class="oe2016InlineHeadline">
			<span class="type">Diashow </span>
			<span class="title"><?=$slideshowTitle;?></span>
		</div>
		
		<? if (1): ?>

			<div class="flickitySlider" data-options='<?= $options; ?>'>

				<? foreach ($imageInfos as $key => $image): ?>

					<div class="slide">

						<div class="overlay_box">

							<? if (0 == $key): ?>
								<img src="<?= $image['fileUrl']; ?>" alt="">
							<? else: ?>
								<img src="<?= $emptyImage; ?>" data-flickity-lazyload="<?= $image['fileUrl']; ?>" alt="">
							<? endif; ?>

							<? if ($image['title']): ?>
								<h2 class="caption">
									<span class="title"><?= $image['title']; ?></span>
								</h2>
							<? endif; ?>

						</div>

						<? if (1): ?>
							<?
								$showCopyright = false;
								$showDescription = false;

								if($image['copyright']) {
									$showCopyright = true;
								}
								
								if($image['description']) {
									$showDescription = true;
								}
							?>
							<? if ($showCopyright || $showDescription): ?>
								<div class="descriptionContent">
									<? if ($showCopyright): ?>
										<p class="copyright">© <?= $image['copyright']; ?></p>
									<? endif; ?>

									<? if ($showDescription): ?>
										<p class="description"><?= $image['description']; ?></p>
									<? endif; ?>
								</div>
							<? endif; ?>
						<? endif; ?>

					</div>

				<? endforeach; ?>

				<span class="sliderCounter">1 / <?= count($imageInfos); ?></span>

			</div>

		<? endif; ?>
	<? endif; ?>



	<? if (0): ?>


	<div class="sliderWrapper">
		<? if (0): ?>
			<div class="contentSlider clearfix js-flickMain" data-count-slides="<?= $countSlides; ?>" data-stories-per-row="<?= $storiesPerRow; ?>" data-slider-rows="<?= $rows; ?>">
		<? endif; ?>
		<div class="contentSlider clearfix js-flickMain">

			<? foreach ($imageInfos as $keySlides => $image): ?>
				<? if (0): ?>
			 	<div class="slide <?= $classCol; //.' '.$classWithoutDate; //.' '.$classClear; ?> js-flickSlideItem">
				<? endif; ?>
				<div class="slide js-flickSlideItem">

					<?
					$classRow = $keySlides + 1;
					?>

					<div class="slideBox<?= $classRow; ?>">

						<? if (1): // lazy loading ---------------------- ?>
						<div class="overlay_box ">
							<? if (0 == $keySlides): ?>
								<img src="<?= $image['fileUrl']; ?>" alt="<?= $image['title']; ?>">
							<? else: ?>
								<img src="<?= $emptyImage; ?>" alt="<?= $image['title']; ?>" data-flickity-lazyload="<?= $image['fileUrl']; ?>">
							<? endif; ?>
							<h2 class="caption">
								<span class="title"><?= $image['title']; ?></span>
							</h2>
						</div>
						<? endif; // ------------------------------------ ?>

					</div>

					<? if ($image['copyright'] || $image['description']): ?>
						<div class="descriptionContent">
							<? if ($image['copyright']): ?>
								<p class="copyright">© <?= $image['copyright']; ?></p>
							<? endif; ?>
							<p class="description"><?= $image['description']; ?></p>
						</div>
					<? endif; ?>

				</div>

			<? endforeach; ?>




		<?
			/*
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
			*/
		?>

		</div>
		<span class="contentSliderBoxCounter">1 / <?= count($imageInfos); ?></span>		
	</div>

	<? endif; ?>


</div>

