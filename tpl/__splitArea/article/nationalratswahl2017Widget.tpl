<?
/**
* Nationalratswidget 2017
*
* @var channel oe24.core.Channel
* @var content oe24.core.Content
*/

// channel überprüfen
$channelId = $channel->getId();
$parentId = ($channel->getParent()) ? $channel->getParent()->getId() : false;
$isDevServer = (spunQ::inMode(spunQ::MODE_DEVELOPMENT)) ? true : false;

// nur andrucken, wenn wir im 'Wahl2017- Channel sind'
// Test/Development - id: '161622022'
// Produktiv - id: '296327773'

if ($isDevServer) {
	if ($channelId != '161622022' && $parentId != '161622022') {
		return;
	}
}
else {
	if ($channelId != '296327773' && $parentId != '296327773') {
		return;
	}
}

// ---------------------------------------------------------

?>

<div class="article_share">
	
	<iframe width="100%" height="400" src="http://file.oe24.at/center/nrwahl/index.result_article.html" frameborder="0" scrolling="no"></iframe>
	
</div>


