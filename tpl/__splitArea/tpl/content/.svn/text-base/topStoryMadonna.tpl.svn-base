<?php

/**
 * Channel Top-Story - rl2014
 * @var box oe24.core.ContentBox
 * @var content oe24.core.Content
 */

if (!($content instanceof TextualContent)) {
	return null;
}

$linkAttr = getContentUrlAttributesArray($content, $box, true, true, true);
$linkHref = (isset($linkAttr['href']) && is_string($linkAttr['href'])) ? $linkAttr['href'] : '#';
$linkTitle = (isset($linkAttr['title']) && is_string($linkAttr['title'])) ? $linkAttr['title'] : '';
$linkTarget = (isset($linkAttr['target']) && is_string($linkAttr['target']) && '' != $linkAttr['target']) ? 'target="'.$linkAttr['target'].'"' : '';
// (ws) 140804
// Beispiel: http://ad1.adfarm1.adition.com/redi?sid=2700873&kid=1017356&bid=3399153
$linkHref = str_replace(array('&kid', '&bid'), array('&amp;kid', '&amp;bid'), $linkHref);
// (ws) 140804 end

// $imageFormat = 'bigStory';
$imageFormat = '620x388';
$imageDimension = ('620x388' == $imageFormat) ? 'width="620" height="388"' : 'width="620" height="310"';

// $image = $content->getFirstRelatedImage(true, $box);
$image = $content->getFirstRelatedImage();
if (null === $image) {
	return null;
}
$imageSrc = $image->getFileUrl($imageFormat);

$copyright = (null != $image) ? trim($image->getCopyright()) : '';
$copyright = ('' != $copyright) ? '&copy; '.$copyright : '';
$copyright = ''; // keine Copyright-Angabe

$homeChannel = $content->getHomeChannel();
if (!$homeChannel) {
	return;
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

// --------------

?>
<section class="col col1 channel_box madonna topStory">
	<a class="channelName-<?= $channelName; ?>" href="<?= $linkHref; ?>" <?= $linkTarget; ?> title="<?= $linkTitle; ?>">
		<div class="<?= $classImage; ?>">
			<? if (isset($_GET['oe24NoLazy'])): ?>
				<img src="<?= $imageSrc; ?>" <?= $imageDimension; ?> alt="">
			<? else: ?>
				<img class="oe24Lazy" data-original="<?= $imageSrc; ?>" src="/images/empty.gif" <?= $imageDimension; ?> alt="">
			<? endif; ?>
			<? if ('videoContainer' == $classVideo): ?>
			<span class="vBoxPlayButton"><span class="icon icon_arrow4_right"></span></span>
			<? endif; ?>
		</div>
		<div class="madonnaStoryInfo">
			<strong class="story_pretitle"><?= $preTitle; ?></strong>
			<br>
			<h1 class="story_pagetitle">
				<span class="story_pagetitle_background"><?= $pageTitle; ?></span>
			</h1>
			<? if (isset($copyright) && '' != $copyright): ?>
			<p class="story_copyright"><?= $copyright; ?></p>
			<? endif; ?>
		</div>
	</a>
</section>

