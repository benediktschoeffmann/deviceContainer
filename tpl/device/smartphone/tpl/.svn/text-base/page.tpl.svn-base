<?
/**
 * page
 * @var device any
 */

// $article ist entweder NULL oder eben das Artikel-Objekt
$article = $device->getConfig('article');
$classArticle = (null == $article) ? '' : 'articleBody';

$layout = $device->getConfig('layout');
$containerId = $device->getConfig('googleContainerId');


/* (bs) 2018-01-15 */
/* if a page gets called from the app, dont show header and reset padding from sticky header.  */
$getValues = request()->getGetValues();
$isOe24App = isset($getValues['oe24App']);
// debug($getValues);
$showHeader = !$isOe24App;
$contentContainerStyle = ($showHeader) ? '' : 'style="padding-top: 0px;"';
/* (bs) end. */

// -------------------------------------------------------

?>
<!DOCTYPE html>
<html lang="de" class="no-js-do-not-use">
<head>

<? tpl('oe24.oe24.device.smartphone.tpl.pageHead'); ?>

<script type="text/javascript">
    var functionQueue = new FunctionQueue();
</script>

</head>
<body id="pageBodyTop" class="smartphone <?= 'layout_'.$layout; ?> <?= $classArticle; ?>">


    <?
    // (bs) 2016-12-20 preparing for OEWA-Call
    tpl('oe24.oe24.device.smartphone.tpl._tracking.oewaTracking', array('channel' => $device->getConfig('channel')));
    ?>


    <?
    // https://developers.facebook.com/docs/plugins/embedded-posts
    tpl('oe24.oe24.device.smartphone.assets.vendor.facebook.facebookApi');
    ?>


    <?
    // Google Tag Manager
    // https://www.google.com/intl/de/tagmanager/
    // https://developers.google.com/tag-manager/
    // tpl('oe24.oe24.device.smartphone.tpl._tracking.googleTagManagerNoScript', array('containerId' => $containerId));
    ?>


    <div class="wrapper">


        <? if (1 && $showHeader): ?>
            <header class="header clearfix">
                <? tpl('oe24.oe24.device.smartphone.tpl._header.header'); ?>
            </header>
        <? endif; ?>


        <? if (1 && $showHeader): ?>

            <div class="navigationMain">
                <? tpl('oe24.oe24.device.smartphone.tpl._navigationMain.navigationMain'); ?>
            </div>

            <?
            // (ws) 2017-07-31 Die Navigation soll schon reagieren, bevor die Seite vollstaendig geladen ist.
            // Dazu muessen zumindest .header und .navigationMain geladen sein.
            // tpl('oe24.oe24.device.smartphone.tpl._navigationMain.navigationMainJs');
            ?>

        <? endif; ?>


        <? if (1): ?>
        <div class="contentContainer" <?=$contentContainerStyle;?>>

            <? if (0): // (ws) 2017-02-15 wird z. Z. nicht gebraucht. Am Prod-Server fehlen auch noch die Navigations-Daten ?>
                <div class="navigationTop">
                    <? tpl('oe24.oe24.device.smartphone.tpl._navigationTop.navigationTop'); ?>
                </div>
            <? endif; ?>

            <? if (1): ?>
                <div class="container">

                    <?
                    // (db) 2017-08-07 Ad MobileTop nur fuer Reise
                    if ('reise' == $layout) {
                        if (!$device->getConfig('article')) {
                            tpl('oe24.oe24.device.smartphone.tpl._adition.adition', array(
                                'channel' => $device->getConfig('channel'),
                                'banner'  => 'MobileTop',
                            ));
                        }
                    }
                    ?>

                    <?
                    // tpl('oe24.oe24.device.smartphone.tpl._dummyContent');
                    tpl('oe24.oe24.device.smartphone.tpl._content.content');
                    ?>

                    <?
                    // (bs) 2017-07-10 DAILY-811
                    if (!$device->getConfig('article')) {
                        tpl('oe24.oe24.device.smartphone.tpl._adition.adition', array(
                            'channel' => $device->getConfig('channel'),
                            'banner'  => 'MobileBottom',
                        ));
                    }
                    ?>

                </div>
            <? endif; ?>

            <? if (1) : ?>
                <? tpl('oe24.oe24.device.smartphone.tpl._adition.keyWordTargeting'); ?>
            <? endif; ?>

        </div>
        <? endif; ?>


        <? if (1): ?>
            <footer class="footer">
                <? tpl('oe24.oe24.device.smartphone.tpl._footer.footer'); ?>
            </footer>
        <? endif; ?>


        <?
        // (ws) 2016-02-08 Cookies-Overlay rausnehmen
        // (ws) 2018-02-02 Cookies-Overlay zeigen, falls noch nicht "weggeklickt"
        tpl('oe24.oe24.device.smartphone.tpl._misc.cookiesOverlay.cookiesOverlay', array(
            'channel' => $device->getConfig('channel'),
        ));
        ?>


    </div>


    <? tpl('oe24.oe24.device.smartphone.tpl.pageBottom'); ?>


    <script>
        Utilities.docReady(
            function () {
                functionQueue.run();
            }
        );
    </script>


    <? if (0): ?>
        <script>
        console.log('end of body');
        </script>
    <? endif; ?>


</body>
</html>
