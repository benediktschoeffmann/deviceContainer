<?php

/**
 * Channel Stories - rl2014
 * @var box oe24.core.ContentBox
 * @var stories array<any>
 * @var storiesPerLine integer
 * @var rowCount integer
 * @var colCount integer
 */

//
// Madonna Stories - Eine Zeile (3 Stories bzw. 4 Stories)
//
// +-----+ +-----+
// |     | |     |
// |     | +-----+
// |     |
// |     | +-----+
// |     | |     |
// +-----+ +-----+
//
// bzw.
//
// +-----+ +-----+
// |     | |     |
// +-----+ +-----+
//
// +-----+ +-----+
// |     | |     |
// +-----+ +-----+
//

$emptyImage1x1 = '/images/empty_1x1.png';
$emptyImage300x620 = '/images/empty_300x620.png';

$emptyImage1x1 = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAEElEQVR42gEFAPr/AP///wAI/AL+Sr4t6gAAAABJRU5ErkJggg==';
$emptyImage300x620 = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAASwAAAJsAQAAAABvtqMpAAAAAnRSTlMAAQGU/a4AAABjSURBVHgB7cohAQAACAMw+qelAVS4vNj05hKraZqmaZqmaZqmaZqmaZqmaYVN0zRN0zRN0zRN0zRN0zRN0zRN0zRN0zRN0zRN0zRN0zRN0zRN0zRN0zRN0zRN0zRN0zRN07QHLEqM+nbkAY4AAAAASUVORK5CYII=';

$emptyImage = $emptyImage1x1;

$imageFormatStory         = '300x300';
$imageFormatStoryPortrait = null; // Override Image

$storiesOut = array();

foreach ($stories as $key => $content) {

	$linkAttr = getContentUrlAttributesArray($content, $box, true, true, true);
	$linkHref = (isset($linkAttr['href']) && is_string($linkAttr['href'])) ? $linkAttr['href'] : '#';
	$linkTitle = (isset($linkAttr['title']) && is_string($linkAttr['title'])) ? $linkAttr['title'] : '';
	$linkTarget = (isset($linkAttr['target']) && is_string($linkAttr['target']) && '' != $linkAttr['target']) ? 'target="'.$linkAttr['target'].'"' : '';
	// (ws) 140804
	// Beispiel: http://ad1.adfarm1.adition.com/redi?sid=2700873&kid=1017356&bid=3399153
	$linkHref = str_replace(array('&kid', '&bid'), array('&amp;kid', '&amp;bid'), $linkHref);
	// (ws) 140804 end


	if (3 == $storiesPerLine) {

		if ((0 == ($key % 3))) {
			$classStory = 'break portrait';
			$image = $content->getFirstRelatedImage(true, $box);
			$imageFormat = $imageFormatStoryPortrait;
			// $imageDimension = 'width="300" height="620"';

			$strgImage = strg_ImageFile::get($image->getFile()->getPath());
			if (!$strgImage) {
				continue;
			}
			$meta = $strgImage->getMetadata(true);
			if (!$meta) {
				continue;
			}
			$imageWidth = $meta->getWidth();
			$imageHeight = $meta->getHeight();
			if ($imageHeight < 620) {
				$classStory = 'break portrait missing';
			}

			$emptyImage = $emptyImage300x620;

		} else {
			$classStory = 'last';
			$image = $content->getFirstRelatedImage();
			$imageFormat = $imageFormatStory;
			// $imageDimension = 'width="300" height="300"';
			$emptyImage = $emptyImage1x1;
		}

	} else {

		if (0 == ($key % 2)) {
			$classStory = 'break';
		} else {
			$classStory = 'last';
		}

		$image = $content->getFirstRelatedImage();
		$imageFormat = $imageFormatStory;
		// $imageDimension = 'width="300" height="300"';
		$emptyImage = $emptyImage1x1;
	}

	$imageDimension = '';

	// $image = $content->getFirstRelatedImage(true, $box);
	$imageSrc = (null !== $image) ? $image->getFileUrl($imageFormat) : 'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7';

	$copyright = (null != $image) ? trim($image->getCopyright()) : '';
	$copyright = ('' != $copyright) ? '&copy; '.$copyright : '';
	$copyright = ''; // keine Copyright-Angabe

	$homeChannel = $content->getHomeChannel();
	if (!$homeChannel) {
		continue;
	}
	$channelTitle = $homeChannel->getPageTitle();
	$channelName = $homeChannel->getName();

	$preTitle = trim($content->getPreTitle(true, $box));
	$pageTitle = trim($content->getTitle(true, $box));
	$leadText = trim($content->getLeadText(true, true, $box));

	// --------------

	// Ueberpruefen ob content ein Video ist
	$classVideo = '';
	if ($content instanceof Text) {
		$classVideo = $content->getVideoOptions() ? 'videoContainer' : '';
	}

	// Ueberpruefen ob content ein oesterreich.at content ist
	$classAt = '';
	// if (preg_match('/[www|oe24dev].xn--sterreich-z7a.at/i', $linkHref)) {
	// 	$classAt = 'oesterreich_article';
	// }

	$classImage = $classVideo.' '.$classAt;

	// --------------

	// Dev
	$pageTitle = preg_replace('/^mad.+ - /', '', $pageTitle);
	// Dev //

	$storiesOut[] = array(
		'linkHref'       => $linkHref,
		'linkTitle'      => $linkTitle,
		'linkTarget'     => $linkTarget,
		'classStory'     => $classStory,
		'classImage'     => $classImage,
		'classVideo'     => $classVideo,
		'imageSrc'       => $imageSrc,
		'imageDimension' => $imageDimension,
		'copyright'      => $copyright,
		'channelTitle'   => $channelTitle,
		'channelName'    => $channelName,
		'preTitle'       => $preTitle,
		'pageTitle'      => $pageTitle,
		'leadText'       => $leadText,
		'emptyImage'     => $emptyImage,
	);
}

?>

<? foreach ($storiesOut as $key => $story): ?>

<div class="col col<?= $colCount; ?> channel_box madonna <?= $story['classStory']; ?>">
	<a class="channelName-<?= $story['channelName']; ?>" href="<?= $story['linkHref']; ?>" <?= $story['linkTarget']; ?> title="<?= $story['linkTitle']; ?>">
		<div class="storyImage <?= $story['classImage']; ?>">
			<? if (isset($_GET['oe24NoLazy'])): ?>
				<img src="<?= $story['imageSrc']; ?>" <?= $story['imageDimension']; ?> alt="">
			<? else: ?>
				<? if (0): ?>
				<img class="oe24Lazy" data-original="<?= $story['imageSrc']; ?>" src="/images/empty.gif" <?= $story['imageDimension']; ?> alt="">
				<? endif; ?>
				<? if (1): ?>
				<img class="oe24Lazy" src="<?= $story['emptyImage']; ?>" data-original="<?= $story['imageSrc']; ?>" <?= $story['imageDimension']; ?> alt="">
				<? endif; ?>
			<? endif; ?>
			<? if ('videoContainer' == $story['classVideo']): ?>
			<span class="vBoxPlayButton"><span class="icon icon_arrow4_right"></span></span>
			<? endif; ?>
		</div>
		<div class="madonnaStoryInfo">
			<strong class="story_pretitle"><?= $story['preTitle']; ?></strong>
			<br>
			<h1 class="story_pagetitle">
				<span class="story_pagetitle_background"><?= $story['pageTitle']; ?></span>
			</h1>
			<? if (isset($story['copyright']) && '' != $story['copyright']): ?>
			<p class="story_copyright"><?= $story['copyright']; ?></p>
			<? endif; ?>
		</div>
	</a>
</div>

<? endforeach; ?>
