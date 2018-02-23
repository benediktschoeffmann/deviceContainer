<?
/**
 * Output a complete Column
 *
 * @var portal oe24.core.Portal
 * @var channel oe24.core.Channel
 * @var params any
 * @var object any
 * @var oe2016layouts any
 * @var layout any
 *
 * @default params 0
 * @default object 0
 * @default oe2016layouts 0
 * @default layout 0
 */

if (!isset($params['channelTag']) || !$params['channelTag'] instanceof strg_Tag) {
	return;
}

$channelTag = $params['channelTag'];

// (pj) 2014-11-25 Seitenanzahl fuer Rezepte
$page = (int)request()->getGetValue("s");
$page = (!$page) ? 1: $page;

$limit = 100;

$contents = $channel->getRelatedContentsByTagId($channelTag->getId(),$limit+1, ($limit * $page) - $limit, Array('oe24.core.Recipe'), true);
// (pj) ENDE

etpl('oe24.oe24.__splitArea.tpl.content.channelTag', array(
	'portal' => $portal,
	'channel' => $channel,
	'channelTag' => $channelTag,
	'contents' => $contents,
	'searchLimit' => $limit,
	'searchPage' => $page,
	'oe2016layouts' => $oe2016layouts,
	'layout' => $layout,
));



?>