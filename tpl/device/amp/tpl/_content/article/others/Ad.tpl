<?
/**
 * AMP Ad Tag
 *
 * @var channel oe24.core.Channel
 * @var width integer
 * @default width 300
 * @var height integer
 * @default height 250
 */

$parentChannels = $channel->getParentChannels();
if (empty($parentChannels)) {
    return;
}

$frontpage = $parentChannels[0];
$adSlots = $frontpage->getOptions(true)->get('AditionAdSlots');
$adSlots = json_decode($adSlots, true);

$adWpId = NULL;
foreach ($adSlots as $key => $adSlot) {
    if ($adSlot['banner'] == 'Mobile Amp' && $adSlot['artikel'] == true) {
        $adWpId = $adSlot['id'];
        break;
    }
}

if (NULL === $adWpId) {
    return;
}

$adVersion = '1';
$adFarm = 'ad1';

?>
<div class="headlineBlockAd">Anzeige</div>
<amp-ad width="<?= $width; ?>" height="<?= $height; ?>" class="ampAdCentered"
    type="adition"
    data-version="<?= $adVersion; ?>"
    data-farm="<?= $adFarm; ?>"
    data-wp_id="<?= $adWpId; ?>">
</amp-ad>
