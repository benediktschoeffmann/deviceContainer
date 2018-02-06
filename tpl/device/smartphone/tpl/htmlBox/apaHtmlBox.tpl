<?
/**
 * apa html box
 * @var channel oe24.core.Channel
 * @var box oe24.core.FreeHtmlBox
 * @var html string
 * @default html 0
 */


if ('0' == $html) {
    $html = '';
}

$templateOptions = $box->getTemplateOptions();

$cssClass = 'defaultHtmlBox';
$cssClass.= $templateOptions->get('CSS-Class') ? (' '.$templateOptions->get('CSS-Class')) : '';

$hideSpace = $templateOptions->get('Hide-Space-After-Box');

?>
<div class="<?= $cssClass; ?>">
    <? if (1) : ?>
        <?= $html; ?>
    <? endif;?>
</div>

<? if (!$hideSpace) : ?>
    <div class="marginBottom"></div>
<? endif; ?>
