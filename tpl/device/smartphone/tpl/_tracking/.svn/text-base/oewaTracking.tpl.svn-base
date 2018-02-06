<?
/**
* Template to include OEWA-Tag
* @var channel oe24.core.Channel
*/

$channelOptions = $channel->getOptions(true, true);
$domain = str_replace(array('www.', 'oe24dev.'), '', $channel->getDomain(true));

$oewaSiteArray = array(
    'gesund24.at',
    'madonna.oe24.at',
    'buzz.oe24.at',
    'wirkochen.at',
);

if ($domain === null || !in_array($domain, $oewaSiteArray)) {
    $configOe24 = spunQ::getConfiguration()->getStringsForPrefix('oe24.oe24');
    $domain = $configOe24['oewaSite'];
}

$specialDomain = $channelOptions->get('OewaDomainString');
$specialDomain = (null === $specialDomain) ? '' : $specialDomain;

// if ($channelOptions->get('OewaTracking') && $channel->getOewaTag(true)) {
//     etpl('_shared.1_0.tracking.oewa.v2.oewaTracking', array(
//         'uriSchema' => $channel->getOewaTag(true)->getUrlSchemaName(),
//         'domain' => $domain,
//         'channelUrl' => preg_replace("~http(.*?)//([^/]*)~i", "", $channel->getUrl()),
//         'pageWidth' => 0,
//         'specialDomain' => $specialDomain,
//     ));
// }

$oewaTracking = $channelOptions->get('OewaTracking');
$oewaTag = $channel->getOewaTag(true);

if ($oewaTracking && $oewaTag instanceof OEWATag) {

    $urlSchema = $oewaTag->getUrlSchemaName();

    $channelUrl = $channel->getUrl();
    $channelUrl = preg_replace("~http(.*?)//([^/]*)~i", "", $channelUrl);



    etpl('_shared.1_0.tracking.oewa.v2.oewaTrackingForSmartphone', array(
        'uriSchema'     => $urlSchema,
        'domain'        => $domain,
        'channelUrl'    => $channelUrl,
        'pageWidth'     => 0,
        'specialDomain' => $specialDomain,
        'oewaTag'       => $oewaTag,
    ));
}
