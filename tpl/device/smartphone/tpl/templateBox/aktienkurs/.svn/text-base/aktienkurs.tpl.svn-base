<?
/**
 * OE2016 Business Aktienkurs
 *
 * @var channel oe24.core.Channel
 * @var box oe24.core.TemplateBox
 */

$oe24Config = spunQ::getConfiguration()->getStringsForPrefix('oe24.oe24');

$id = htmlentities(addslashes(urlencode(request()->getGetValue('id'))), ENT_QUOTES, 'utf-8');
// debug($id);

// $url = $oe24Config['teletraderXml'].'?action=getSymbols&id='.$id.'&symbolInfo=All&showQuote=1&quoteInfo=All&showProfile=1&showNews=0&delay=realtime&showChart=1&chartSize=500,300';
// debug($url);

$args = array(
    'action'      => 'getSymbols',
    'id'          => $id,
    'symbolInfo'  => 'All',
    'showQuote'   => '1',
    'quoteInfo'   => 'All',
    'showProfile' => '1',
    'showNews'    => '0',
    'delay'       => 'realtime',
    'showChart'   => '1',
    'chartSize'   => '500,300',
);

$url = $oe24Config["teletraderXml"].'?'.http_build_query($args);

$isDevServer = (spunQ::inMode(spunQ::MODE_DEVELOPMENT)) ? true : false;
if ($isDevServer) {
    // Dummy URL
    $url = 'http://oe24dev.oe24.at/misc/xmlDummyDaten/aktien-grafik.xml';
}

$xmlBox = new XmlBox();

$xmlBox->setXmlFile($url);
$xmlBox->setXsltFile('http://'.request()->getHost().'/misc/xsl/oe2016ttBusinessAktienkurs.xsl');
$xmlBox->setParameters('[default]');

$xmlBoxHtml = $xmlBox->getHtml(true, false);

// -----------------------------------------

// $layoutIdentifier = $channel->get('layoutOverride');
// if (!$layoutIdentifier) {
//     $layoutIdentifier = 'oe24';
// }

$layoutIdentifier = 'business';

?>

<div class="aktienkurs">
    <?= $xmlBoxHtml; // .standardHeadline.business & .content -> xsl ?>
</div>
