<?
/**
 * footerInfo
 */

$device = DeviceContainer::getDevice();

$urlImpressum = 'http://m.oe24.at/service/Impressum-OE24/1637563';
$appUrl = $device->getConfig('appUrl') . $device->getConfig('appUrlQuery');

$showPaidContentMarker = false;
$channelOptions = $device->getConfig('channel')->getOptions(false, true);
$article = $device->getConfig('article');

if ($article) {
    $showPaidContentMarker = ($article->getOptions()->get('EntgeltlicherContent')) ? true : false;
} elseif ($channelOptions->get('EntgeltlicherContent')) {
    $showPaidContentMarker = true;
}

$paidContentText = 'Entgeltliche Einschaltung';

$fullVersionLinks = array(
    // override => link
    'cooking24' => 'http://www.wirkochen.at',
    'gesund24'  => 'http://www.gesund24.at',
    'madonna'   => 'http://madonna.oe24.at',
    'sport'     => 'http://sport.oe24.at',
);

$fullVersionDomains = array(
    'cooking24' => 'wirkochen.at',
    'gesund24'  => 'gesund24.at',
    'sport'     => 'sport.oe24.at',
    'madonna'   => 'madonna.oe24.at',
);

$layoutOverride = $channelOptions->get('layoutOverride');
$portalLink = (isset($fullVersionLinks[$layoutOverride])) ? $fullVersionLinks[$layoutOverride] : 'http://www.oe24.at';

$domain = (isset($fullVersionDomains[$layoutOverride])) ? $fullVersionDomains[$layoutOverride] : 'oe24.at';

?>
<div class="footerInfo">
    <? if ($showPaidContentMarker): ?>
        <p><?= $paidContentText; ?></p>
    <? endif; ?>
    <p><a class="toPageBodyTop" href="#pageBodyTop">Seitenanfang</a> | <a href="<?= $urlImpressum; ?>">Impressum</a></p>
    <p><a class="js-desktopVersion" href="<?= $portalLink; ?>" target="_self" data-domain="<?= $domain; ?>"> Zur Vollversion Wechseln </a> </p>
    <p>© <?= date('Y'); ?> <a href="<?= $appUrl; ?>">oe24</a> GmbH.</p>
</div>
