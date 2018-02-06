<?
/**
 * Outbrain Referrer Tv Teaser.
 *
 * Wenn als $_Get-Parameter utm_source=outbrain&utm_campaign=amplify reinkommt, soll
 * die Tv - Teaser Box auf jeden Fall ausgespielt werden.
 *
 * Da genau dieser Get-Parameter abgefragt wird, ist auch der Varnish egal.
 */

$campaign1 = ((isset($_GET['utm_source']) && ('outbrain' === $_GET['utm_source'])));
$campaign2 = ((isset($_GET['utm_campaign']) && ('amplify' === $_GET['utm_campaign'])));

$campaign = $campaign1 && $campaign2;

if (!$campaign) {
     return;
}

$device = DeviceContainer::getDevice();
// if ($device->getConfig('article')) {
//     return;
// }

$desktopTplName    = 'oe24.oe24._contentBoxes.mobileTeaserOe24Tv';
$smartphoneTplName = 'oe24.oe24.device.smartphone.tpl.contentBox.mobileTeaserOe24Tv.mobileTeaserOe24Tv';
$boxFound          = false;

$boxId        = ($device->getConfig('isDevServer')) ? 161583089 : 273862327;
$validColumns = array('Smartphone Channel', 'Split Area 2016');
$channel      = $device->getConfig('channel');

// schau nach, ob die Box im Channel schon gesetzt ist, wenn ja, dann hör auf.
foreach ($validColumns as $key => $column) {

    $channelColumn = $channel->getColumnByName($column, true, false);
    if (!$channelColumn) {
        continue;
    }
    $goodBox = array_filter($channelColumn->getBoxes(), function ($box) use ($desktopTplName) {
        return $box->getTemplate() === $desktopTplName;
    });

    if (!empty($goodBox)) {
        $boxFound = $goodBox;
        break;
    }

    // wenn die Box noch nicht ausgepielt wurde, ausspielen.
    if ($boxFound == false) {
        $teaserBox = db()->getById($boxId, 'oe24.core.ContentBox', false);
        if ($teaserBox) {
            tpl($smartphoneTplName , array(
                'channel' => $channel,
                'box'     => $teaserBox)
            );
        }
    }
}

