<?php
/**
*   Facebook Referrer Tv Teaser
*
*   Wenn beim request Header als Referrer FB drinsteht, dann soll outbrain nicht
*   ausgespielt werden und die mobile Tv Teaser Box dafür.
*
*/
$device = DeviceContainer::getDevice();

// (bs) die Entscheidung, ob der TvTeaser aufgrund von Referrer Facebook ausgespielt wird, wird in der index.tpl getroffen, da die articleOutbrain.tpl vor dem facebookReferrerTvTeaser.tpl ausgespielt wird.

if ($device->getConfig('showTvTeaser') === true) {

    $boxId = ($device->getConfig('isDevServer')) ? 161583089 : 273862327;
    $teaserBox = db()->getById($boxId, 'oe24.core.ContentBox', false);

    if (!$teaserBox) {
        return;
    }

    tpl('oe24.oe24.device.smartphone.tpl.contentBox.mobileTeaserOe24Tv.mobileTeaserOe24Tv',
        array(
            'channel' => $device->getConfig('channel'),
            'box'     => $teaserBox
            )
        );
}


