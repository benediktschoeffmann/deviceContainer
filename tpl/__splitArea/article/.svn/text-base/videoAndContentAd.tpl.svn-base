<?
/**
 * Video und Contentad Template
 *
 * @var channel oe24.core.Channel
 */

// (pj) 2016-01-04 niki will die zeile mit Video und ContentAd nicht mehr haben
return;
// (pj) 2016-01-04 end

// -------------------------------------
// IST EIN VIDEO VORHANDEN?
// -------------------------------------
$videoNewsTvBoxId = 210065874;
if (spunQ::inMode(spunQ::MODE_DEVELOPMENT)) {
	$videoNewsTvBoxId = 161380198;
}
$videoNewsTvBox = db()->getById($videoNewsTvBoxId, 'oe24.core.ContentBox', false);

$contents = (null === $videoNewsTvBox) ? array() : $videoNewsTvBox->getContentOfAllDropAreas(true);
$video = NULL;
foreach ($contents as $content) {
	if (! $content instanceof Video) {
		if (! $content instanceof Text) {
			continue;
		}
		if (NULL === $content->getVideoOptions()) {
			continue;
		}
	}

	$video = $content;
	break;
	// damit ich nur das erste video habe, break
}

// // (pj) Falls gewuenscht ist, dass das Template nicht angezeigt werden soll, bitte einkommentieren
// if (NULL === $video) {
// 	// gibt es kein Video, soll das Template nix ausspielen
// 	return;
// }

// ---------------------------------------------------
// IST DIE CONTENTAD4 POSITION VORHANDEN?
// ---------------------------------------------------
$channelAdSlots = json_decode($channel->getOptions(true, true)->get('AditionAdSlots'), true);
$contentAd4Found = false;
if (is_array($channelAdSlots)) {
	foreach ($channelAdSlots as $adSlot) {
		if ('Contentad (4)' === $adSlot['banner']) {
			$contentAd4Found = true;
		}
	}
}

// // (pj) Falls gewuenscht ist, dass das Template nicht angezeigt werden soll, bitte einkommentieren
// if (false === $contentAd4Found) {
// // gibt es kein Contentad (4) in den AditionAdSlots, soll das Template nix ausspielen
// 	return;
// }

?>
<div class="videoAndContentAd clearfix">
	<?
		if (NULL !== $video) {
			tpl('oe24.oe24.__splitArea.tpl.content.videoPlayer', array(
				'content' => $video,
				'area' => 'videoWithContentAd',
				'forceWideScreen' => true,
				'startMuted' => true,
				'defaultTypeText' => 'News TV',
			));
		}

		if (true === $contentAd4Found) {
			etpl('oe24.oe24.adition.adSlot',array('channel' => $channel, 'id' => 'Contentad4'));
		}
	?>
</div>