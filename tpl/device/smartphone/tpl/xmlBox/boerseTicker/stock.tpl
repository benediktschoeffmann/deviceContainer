<?
/**
 * stock for money boerse ticker
 * @var channel oe24.core.Channel
 * @cache 10m
 * @cache.dependency get
 */

$device = DeviceContainer::getDevice();

$oe24Config = spunQ::getConfiguration()->getStringsForPrefix('oe24.oe24');

$id = htmlentities(addslashes(urlencode(request()->getGetValue('id'))), ENT_QUOTES, 'utf-8');

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

$isDevServer = $device->getConfig('isDevServer');
if ($isDevServer) {
    // Dummy URL
    $url = 'http://oe24dev.oe24.at/misc/xmlDummyDaten/aktien-grafik.xml';
}

$xmlBox = new XmlBox();

$xmlBox->setXmlFile($url);
$xmlBox->setXsltFile('http://'.request()->getHost().'/misc/xsl/oe2016money_tt.xsl');
$xmlBox->setParameters('[default]');

$xmlBoxHtml = $xmlBox->getHtml(true, false);

?>
<div class="stock">
    <?= $xmlBoxHtml; ?>
</div>
