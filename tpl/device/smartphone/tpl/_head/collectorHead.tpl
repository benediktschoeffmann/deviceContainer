<?
/**
 * Collector information Smartphone Head
 * @var layout string
 * @default layout 'oe24'
 */

$cssHead = array(

    array(1, 'oe24.oe24.device.smartphone.assets.vendor.normalize.normalize-4-1-1'),

    // array(1, 'oe24.oe24.device.smartphone.assets.vendor.flickity.1_2_1.flickity'),
    // array(1, 'oe24.oe24.device.smartphone.assets.vendor.flickity.2_0_3.flickity'),
    // array(1, 'oe24.oe24.device.smartphone.assets.vendor.flickity.2_0_4.flickity'),
    array(1, 'oe24.oe24.device.smartphone.assets.vendor.flickity.2_0_5.flickity'),

    // (ws) 2017-03-02
    array(1, 'oe24.oe24.device.smartphone.assets.vendor.responsivelyLazy.responsivelyLazy'),

    array(1, '_shared.1_0.jwplayer.7_8_7.jwplayerSetup'),
    array(1, 'oe24.oe24.device.smartphone.assets.css.jwplayerSetup'),

    // ----------------------------------------------------------------

    array(1, 'oe24.oe24.device.smartphone.assets.css._base'),
    array(1, 'oe24.oe24.device.smartphone.assets.css._styles'),
    array(1, 'oe24.oe24.device.smartphone.assets.css._channelColors'),

    array(1, 'oe24.oe24.device.smartphone.tpl._navigationTop.navigationTop'),
    array(1, 'oe24.oe24.device.smartphone.tpl._navigationMain.navigationMain'),
    array(1, 'oe24.oe24.device.smartphone.tpl._navigationBottom.navigationBottom'),

    array(1, 'oe24.oe24.device.smartphone.tpl._header.header'),
    array(1, 'oe24.oe24.device.smartphone.tpl._footer.footer'),
    // array(1, 'oe24.oe24.device.smartphone.assets.css.stickyFooterFixed'),
    // array(1, 'oe24.oe24.device.smartphone.assets.css.stickyFooterFluid'),
    // array(1, 'oe24.oe24.device.smartphone.assets.css.stickyFooterTable'),

    // array(1, 'oe24.oe24.device.smartphone.tpl._header.headerNavigationButtonRed'),
    // array(1, 'oe24.oe24.device.smartphone.tpl._header.headerNavigationButtonGray'),

    array(1, 'oe24.oe24.device.smartphone.tpl.tabbedBox.tabbedBox'),

    array(1, 'oe24.oe24.device.smartphone.tpl.consoleBox.consoleBox'),

    array(1, 'oe24.oe24.device.smartphone.tpl.contentBox.contentBox'),
    array(1, 'oe24.oe24.device.smartphone.tpl.contentBox.contentSlider.contentSlider'),
    array(1, 'oe24.oe24.device.smartphone.tpl.contentBox.xlKonsole.xlKonsole'),
    array(1, 'oe24.oe24.device.smartphone.tpl.contentBox.xlKonsoleExtended.xlKonsoleExtended'),
    array(1, 'oe24.oe24.device.smartphone.tpl.contentBox.xlBox.xlBox'),
    array(1, 'oe24.oe24.device.smartphone.tpl.contentBox.oe24tvMobileTeaser.oe24tvMobileTeaser'),
    array(1, 'oe24.oe24.device.smartphone.tpl.contentBox.marketingTeaser.marketingTeaser'),

    array(1, 'oe24.oe24.device.smartphone.tpl.templateBox.channelList.channelList'),

    array(1, 'oe24.oe24.device.smartphone.tpl._content.article.tpl.articleDefault'),
    array(1, 'oe24.oe24.device.smartphone.tpl._content.article.tpl.articleSlideshow'),
    array(1, 'oe24.oe24.device.smartphone.tpl._content.article.tpl.articleVideo'),
    array(1, 'oe24.oe24.device.smartphone.tpl._content.article.tpl.override'),
    array(1, 'oe24.oe24.device.smartphone.tpl._content.article.tpl.articleSocialMedia'),
    array(1, 'oe24.oe24.device.smartphone.tpl._content.article.tpl.articleNewsticker'),

    // (ws) 2017-02-14
    array(1, 'oe24.oe24.device.smartphone.tpl._content.article.tpl.articleRelatedArticles'),
    array(1, 'oe24.oe24.device.smartphone.tpl._content.article.tpl.articleChannelTopStories'),

    array(1, 'oe24.oe24.device.smartphone.tpl._adition.adition'),

    // array(1, '_shared.1_0.tracking.oewa.oewaTracking'),
    array(1, 'oe24.oe24.device.smartphone.tpl._tracking.tracking'),

    array(1, 'oe24.oe24.device.smartphone.tpl.htmlBox.htmlBox'),

    // (ws) 2017-02-13 WetterBox
    array(1, 'oe24.oe24.device.smartphone.tpl.templateBox.wetterBox.wetterBox'),

    // (ws) 2017-02-02 Horoskop
    array(1, 'oe24.oe24.device.smartphone.tpl.templateBox.horoskop.horoskopSigns'),
    array(1, 'oe24.oe24.device.smartphone.tpl.templateBox.horoskop.horoskopContent'),

    // (ws) 2017-02-07 Fishtank
    array(1, 'oe24.oe24.device.smartphone.tpl._adition.fishtank'),

    // (db) 2017-02-24 Sport
    // array(1, 'oe24.oe24.device.smartphone.assets.css.override.sport'),

    // (bs)
    array(1, "oe24.oe24.device.smartphone.assets.css.override.$layout"),

    // (ws) 2017-02-07
    // Override-Datei, die immer hier an letzter Stelle eingebunden werden soll
    array(1, 'oe24.oe24.device.smartphone.assets.css._cssOverride'),
);

$jsHead = array(
    array(1, 'oe24.oe24.device.smartphone.assets.js.cookies'),
    // array(1, 'oe24.oe24.device.smartphone.assets.vendor.modernizr.3-3-1.modernizr'),
);

$goodCss = array();
$lastCssModification = 0;

foreach ($cssHead as $css) {
    $cssFile = spunQ_Module::aliasToTemplateFile($css[1], 'css', false);
    if ($cssFile) {
        $lastCssModification = max ($lastCssModification, $cssFile->getLastModificationTime());
        $goodCss[] = $css[1];
    }
}

$pageLinkCss = l('spunQ.wormhole.css', array('css' => $goodCss), $lastCssModification);

$goodJs = array();
$lastJsModification = 0;
foreach ($jsHead as $js) {
    $jsFile = spunQ_Module::aliasToTemplateFile($js[1], 'js', false);
    if ($jsFile) {
        $lastJsModification = max($lastJsModification, $jsFile->getLastModificationTime());
        $goodJs[] = $js[1];
    }
}

$showJsLink = !empty($goodJs);
$pageLinkJs = l('spunQ.wormhole.js', array('js' => $goodJs), $lastJsModification);

?>

<link rel="stylesheet" type="text/css" href="<? s($pageLinkCss) ?>">

<? if ($showJsLink): ?>
    <script src="<? s($pageLinkJs) ?>"></script>
<? endif; ?>

