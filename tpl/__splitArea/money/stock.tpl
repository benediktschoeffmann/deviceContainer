<?php
/**
 * stock for money
 *
 * @var channel oe24.core.Channel
 *
 * @cache 10m
 * @cache.dependency get
 */

$oe24Config = spunQ::getConfiguration()->getStringsForPrefix("oe24.oe24");

$id = htmlentities(addslashes(urlencode(request()->getGetValue("id"))), ENT_QUOTES, "utf-8");

$xmlBox = new XmlBox();
$xmlBox->setXmlFile($oe24Config["teletraderXml"]."?action=getSymbols&id=" . $id . "&symbolInfo=All&showQuote=1&quoteInfo=All&showProfile=1&showNews=0&delay=realtime&showChart=1&chartSize=500,300");
// $xmlBox->setXmlFile('http://oe24dev.oe24.at/misc/dummy_xml/atxTTS399905.xml');
// $xmlBox->setXmlFile('http://oe24dev.oe24.at/misc/xmlDummyDaten/aktien-grafik.xml');
$xmlBox->setXsltFile("http://".request()->getHost()."/misc/xsl/rl2014money_tt.xsl");
$xmlBox->setParameters("[default]");

?>
<div class="row row_margin_top">
	<div class="row_margin_inner">
	</div>
</div>

<div class="row">

	<!-- div.content wird in der xsl datei geschrieben inkl. dem row_header, damits schöner wirkt. -->
	<?=$xmlBox->getHtml(true, false);?>

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
