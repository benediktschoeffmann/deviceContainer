<?
/**
 * article social media
 */

$device = DeviceContainer::getDevice();

$article = $device->getConfig('article');
$object = ($article) ? $article : $device->getConfig('channel');

$hideSocialMedia = $object->getOptions(true, true)->get('hideSocialButtons');
if ($hideSocialMedia) {
    return;
}
$showMailButton = false;

// (bs) 2017-10-02 DAILY-883
// Wenn der Referrer Facebook ist, soll der Tv-Teaser ausgespielt werden, und AddThis nicht
$requestHeaders = request()->getHeaders();
$referer = $requestHeaders['Referer'];

$rc = preg_match("/^\w(.)*(\.(facebook|fb)\.com)(.)\/*$/", $referer, $match);
if (1 === $rc) {
    return;
}
$showMailButton = false;
// $showMailButton = $article->getOptions(false, true)->get('mailto');

// if ($showMailButton) {
//     $mailUri = 'mailto:?subject=' . rawurlencode($article->getTitle()) . '&body='.urlencode($article->getUrl());
// }

// $mailButtonIcon = 'oe24.oe24.device.smartphone.assets.img.icons.iconEmail';

// (bs) 2017-02-07 ursprünglich wollten wir die Mail-Funktionalität selbst abbilden, dafür die auskommentierten Zeilen.
// Ich lasse den Code derweil hier, damit mans im Falle nicht neu implementieren muss.

?>

<?
// <script type="text/javascript">
//     var addthis_config = {
//         services_exclude: 'email'
//     }
// </script>
?>

<div class="oe24AddThis addthis_responsive_sharing">
    <? if (0 && $showMailButton) : ?>
        <a class="mail-button at-icon-wrapper at-share-btn" href="<?= $mailUri; ?>">
            <?= tpl($mailButtonIcon); ?>
        </a>
    <? endif; ?>
</div>


