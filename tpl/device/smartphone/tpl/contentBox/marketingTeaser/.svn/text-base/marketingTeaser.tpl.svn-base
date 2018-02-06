<?
/**
 * Marketing Teaser
 *
 * @var channel oe24.core.Channel
 * @var box oe24.core.ContentBox
 */

$templateOptions = $box->getTemplateOptions();
$linkUrl = $templateOptions->get('Link');
$marginTop = $templateOptions->get('Abstand-Oben');
$marginBottom = $templateOptions->get('Abstand-Unten');

$contents = $box->getContentOfAllDropAreas(true);

$image = null;
$firstImageFound = false;
foreach ($contents as $key => $content) {
    if ($content instanceof Image) {
        $image = $content;
        if ($firstImageFound === true) {
            break;
        } else {
            $firstImageFound = true;
        }
    }
}

if (!is_string($linkUrl)) {
    return;
}

$urlInfo = parse_url($linkUrl, PHP_URL_SCHEME);
if (null == $urlInfo) {
    $linkUrl = 'http://'.$linkUrl;
}

if (!$image || !$linkUrl || empty($linkUrl)) {
    return;
}

$imageUrl = $image->getFileUrl();

$additionalCssClass = ($marginTop) ? 'marginTop' : '';
$additionalCssClass = ($marginBottom) ? $additionalCssClass.' marginBottom' : $additionalCssClass;
?>

<div class="marketingTeaser <?= $additionalCssClass; ?>">
    <a href="<?= $linkUrl; ?>" target="_self">
        <img src="<?= $imageUrl; ?>" alt="">
    </a>
</div>
