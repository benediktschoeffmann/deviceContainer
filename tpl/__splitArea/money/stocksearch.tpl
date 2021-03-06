<?php
/**
* stocksearch for money
*
* @var channel oe24.core.Channel
*
* @cache 10m
* @cache.dependency get
*/

$oe24Config = spunQ::getConfiguration()->getStringsForPrefix("oe24.oe24");

$search = request()->getGetValue("search") ? request()->getGetValue("search") : request()->getGetValue("q");
$search = htmlentities(addslashes(urlencode($search)), ENT_QUOTES, "utf-8");

$xmlBox = new XmlBox();
$xmlBox->setXmlFile($oe24Config["teletraderXml"]."?action=searchSymbol&search=" . $search . "&symbolInfo=All&showQuote=1&quoteInfo=All&showProfile=1&showNews=0&delay=realtime&showChart=0");
// $xmlBox->setXmlFile('http://oe24dev.oe24.at/misc/dummy_xml/kurs_search.xml');
$xmlBox->setXsltFile("http://".request()->getHost()."/misc/xsl/rl2014money_ts.xsl");
$xmlBox->setParameters("[default]");

?>
<div class="row row_margin_top">
	<div class="row_margin_inner">
	</div>
</div>

<div class="row">

	<div class="row_caption">
		<div class="row_caption_body row_caption_body_noimage">
			<div class="row_caption_title">
				<h2>Suchergebnisse</h2>
			</div>

			<div class="row_caption_info"></div>
		</div>
	</div>

	<div class="content">
		<div class="col col1 atxSearchResult">
			<div class="atxSuche clearfix">
				<form method="GET">
					<label for="kursSuche">Kurs:</label>
					<input type="text" id="kursSuche" name="search" value="<?= $search; ?>" />
					<input type="submit" value="Suchen" class="button" />
				</form>
			</div>

    		<?=$xmlBox->getHtml(true, false)?>
		</div>
    </div>

	<div class="sidebar">
		<?
			etpl('oe24.oe24.__splitArea._page.standardColumnsSplitArea', array(
				'columnName' => 'Split-Story-Teaser Area',
				'channel' => $channel,
				'object' => null,
				'hide' => array(),
			));

		?>
	</div>

</div>
