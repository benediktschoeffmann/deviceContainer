<?
/**
 * OE2016 Business Aktienkurs Suchergebnis
 *
 * @var channel oe24.core.Channel
 * @var box oe24.core.TemplateBox
 *
 * @cache 10m
 * @cache.dependency get
 */

$oe24Config = spunQ::getConfiguration()->getStringsForPrefix("oe24.oe24");

$search = request()->getGetValue("search") ? request()->getGetValue("search") : request()->getGetValue("q");
$search = htmlentities(addslashes(urlencode($search)), ENT_QUOTES, "utf-8");

$xmlBox = new XmlBox();

$xmlBox->setXsltFile("http://".request()->getHost()."/misc/xsl/oe2016businessAktienkursSuchergebnis.xsl");
$xmlBox->setParameters("[default]");

// $xmlBox->setXmlFile($oe24Config["teletraderXml"]."?action=searchSymbol&search=" . $search . "&symbolInfo=All&showQuote=1&quoteInfo=All&showProfile=1&showNews=0&delay=realtime&showChart=0");
// debug($xmlBox->getXmlFile());
// http://ttwsxml.ttweb.net/ttws-net/?action=searchSymbol&search=dax&symbolInfo=All&showQuote=1&quoteInfo=All&showProfile=1&showNews=0&delay=realtime&showChart=0

$args = array(
    'action' => 'searchSymbol',
    'search' => $search,
    'symbolInfo' => 'All',
    'showQuote' => 1,
    'quoteInfo' => 'All',
    'showProfile' => 1,
    'showNews' => 0,
    'delay' => 'realtime',
    'showChart' => 0,
);

$url = $oe24Config["teletraderXml"].'?'.http_build_query($args);

$xmlBox->setXmlFile($url);

$isDevServer = (spunQ::inMode(spunQ::MODE_DEVELOPMENT)) ? true : false;
if ($isDevServer) {
	$xmlBox->setXmlFile('http://oe24dev.oe24.at/misc/xmlDummyDaten/searchDummyErgebnis.xml');
}

$html = $xmlBox->getHtml(true, false);

?>
<div class="atxSearchResult">

	<? if (0): ?>
	<div class="atxSuche clearfix">
		<form method="GET">
			<label for="kursSuche">Kurs:</label>
			<input type="text" id="kursSuche" name="search" value="<?= $search; ?>" />
			<input type="submit" value="Suchen" class="button" />
		</form>
	</div>
	<? endif; ?>

	<?= $html; ?>

</div>
