<?
/**
 * tracking - google tag manager noscript
 * @var containerId string
 */

// https://developers.google.com/tag-manager/quickstart

// debug(basename(__FILE__).':'.$containerId);
return;

?>

<!-- Google Tag Manager (noscript) -->
<noscript>
    <iframe src="https://www.googletagmanager.com/ns.html?id=<?= $containerId; ?>" height="0" width="0" style="display:none;visibility:hidden"></iframe>
</noscript>
<!-- End Google Tag Manager (noscript) -->
