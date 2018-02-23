<?
/**
 * Google Cookies Overlay
 *
 * @var layout string
 * @default layout oe24
 */

?>
<div class="cookiesOverlay <?= 'layout_'.$layout; ?>">
    <p class="clearfix">
        <a class="cookiesOverlayClose" href="#!">&nbsp;</a>
        <? if ('oe24_mobile' == $layout): ?>
        <span class="cookiesOverlayText">Durch die Verwendung dieser Website stimmen Sie dem Einsatz von Cookies zu.</span>
        <? else: ?>
        <span class="cookiesOverlayText">Diese Website verwendet Cookies. Durch die Verwendung dieser Website stimmen Sie dem damit verbundenen Einsatz von Cookies zu.</span>
        <? endif; ?>
    </p>
</div>
