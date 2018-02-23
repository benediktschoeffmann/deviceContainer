<?php

/**
 * Split Area - Channel Top Stories des Artikel - rl2014
 *
 * @var channel oe24.core.Channel
 * @var content oe24.core.Text
 * @var col_count integer
 * @default col_count 3
 * @var row_count integer
 * @default row_count 1
 */

$max_stories = $col_count * $row_count;
$box = new ContentBox();
$box->setChannels(array($channel));

// --------------------------------------------

$channelLayout = $channel->getOptions(true, true)->get('layoutOverride');

// (db) 2017-12-01 bei layout 'reise' keine 'Mehr News' andrucken
if ('reise' == $channelLayout) {
	return;
}

// --------------------------------------------

$topStories = $channel->getTopContents(true, true);

$stories = array();
foreach ($topStories as $story) {
	if ($story->getId() != $content->getId()) {
		$stories[] = $story;
	}
}

if (count($stories) <= 0) {
	return null;
}

// --------------------------------------------

$moreText = 'Mehr '.$channel->getName().'-News';
if ('news' === $channel->getName()) {
	$moreText = 'Mehr News';
}
if ('cooking24' === $channelLayout) {
	$moreText = 'Mehr WirKochen-News';
}

?>
<div class="channelTopStories clearfix">

	<h2 class="channelTopStoriesHeader"><?=$moreText; ?></h2>

	<?
	tpl('oe24.oe24.__splitArea.tpl.content.stories', array(
		'box' => $box,
		'drop_areas_content' => $stories,
		'col_count' => $col_count,
		'row_count' => $row_count,
		'max_stories' => $max_stories,
	));
	?>

</div>
