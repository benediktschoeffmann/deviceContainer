<?php
/**
 * teaserArea for splitArea story.
 *
 * @var channel oe24.core.Channel
 * @var object any
 * @default object 0
 * @var params array<any>
 */
?>
<div class="sidebar">
	<?
	etpl('oe24.oe24.__splitArea.views.tplParts.listArticles', array('contents' => $object->getRelatedStories(), 'headline' => 'Zum Thema', 'showImage' => true, 'showCounter' => false));

	etpl('oe24.oe24.__splitArea._page.standardColumns', array('columnName' => 'Story-Teaser Area', 'channel' => $channel, 'object' => $object));
	?>
</div>