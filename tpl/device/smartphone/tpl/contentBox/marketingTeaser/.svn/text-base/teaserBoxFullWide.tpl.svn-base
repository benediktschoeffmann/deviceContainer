<?
/**
 * Teaserbox Fullwide
 *
 * @var channel oe24.core.Channel
 * @var box oe24.core.ContentBox
 */

$templateOptions = $box->getTemplateOptions();

// ---------------------------------------------------

$spaceBefore = $templateOptions->get('Abstand-Oben');
$spaceBefore = ($spaceBefore) ? 'distanceTop' : '';

$spaceAfter = $templateOptions->get('Abstand-Unten');
$spaceAfter = ($spaceAfter) ? 'distanceBottom' : '';

// ---------------------------------------------------

$contents = $box->getContentOfAllDropAreas(true);

if (!is_array($contents)) {
    return;
}

$article = reset($contents);
if (!($article instanceof TextualContent)) {
    return;
}

$image = $article->getFirstRelatedImage(true, $box);

if (!$image) {
    return;
}
$url = $article->getUrl(true, $box);
// ---------------------------------------------------

$imageSrc = $image->getFileUrl('XL-Konsole');

?>

<div class="teaserBoxFullWide <?= $spaceBefore; ?> <?= $spaceAfter; ?>">
    <a href="<?= $url; ?>" target="_self">
        <img src="<?= $imageSrc; ?>" alt="">
    </a>
</div>
