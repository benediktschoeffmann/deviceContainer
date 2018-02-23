<?
/**
 * Adition Aufruf
 *
 * @var channel oe24.core.Channel
 * @var content any
 */

$isContentSet = $content instanceof TextualContent;

$channelName = $channel->getName();

$channelOptions = $channel->getOptions(true, true);
$contentOptions = (true === $isContentSet) ? $content->getOptions(true, true) : NULL;
$options = (true === $isContentSet) ? $contentOptions : $channelOptions;

$aditionAdTags = $options->get('AditionAdTags');
if ("Keine Werbung laden" === $aditionAdTags) {
    return;
}

$adSlots = $options->get('AditionAdSlots');
$reloadAdsLogik = $options->get('reloadAdsLogik');
$reloadAdsInterval = $options->get('reloadAdsInterval');

if (null === $reloadAdsInterval) {
    $reloadAdsInterval = 'aus';
}

if ('aus' !== $reloadAdsInterval) {
    $reloadAdsInterval = $reloadAdsInterval * 1000; // Um Sekunden zu generieren
}

$adKeywords = '';
if (true === $isContentSet) {

    $aditionKeywords = $content->getAditionKeywords();
    if (!is_array($aditionKeywords)) {
        $aditionKeywords = array();
    }
    $aditionKeywordsName = array_map(
        function($x) {
            return $x->getName();
        },
        $aditionKeywords
    );

    $adKeywords = implode(',', $aditionKeywordsName);
}

?>
<!-- BEGIN AudienceScience Adition -->
<script type="text/javascript">
    var aditionLoaded = false;
    var pageWidth = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;

    var adSlots = <?= $adSlots; ?>;
    var adKeywords = '<?= $adKeywords; ?>';
    var adSlotInterval = '<?= $reloadAdsInterval; ?>';
    var reloadAdsLogik = '<?= $reloadAdsLogik; ?>';

    var adSlotsSticky = {
        Superbanner: 'bb_sticky',
        Contentad1: 'cad_sticky',
        Contentad2: 'dummy'
    };

    var globalAdTimer = globalAdTimer || [];

<?    // object zum halten aller Sticky-Werbepositionen ?>
    globalVars.stickyObjects = globalVars.stickyObjects || {};

<?    // Setup callback queue ?>
    var adition = adition || {};
    adition.srq = adition.srq || [];

<?    // Load |srp| ?>
    (function() {
        var script = document.createElement("script");
        script.type = "text/javascript";
        script.src = (document.location.protocol === "https:" ? "https:" : "http:") + "//imagesrv.adition.com/js/srp.js";
        script.charset = "utf-8";
        script.async = true;
        // script.defer = true;
        var firstScript = document.getElementsByTagName("script")[0];
        firstScript.parentNode.insertBefore(script, firstScript);
    })();

    adition.srq.push(function(api) {
<?
        // Configure modules ...
        // api.modules.setLoadingTimeout(5000); // 5000ms ist default
        // // ... yieldlab ...
        // api.modules.configureModule("yieldlab").mapContentunit(10, 100, 1000).mapContentunit(20, 200, 2000).enable();

        // (pj) 2016-03-11 YieldLab einschalten
?>
        var yieldLab = api.modules.configureModule('yieldlab');
        for (var adSlot in adSlots) {
            if (typeof adSlots[adSlot].yieldLab == 'undefined') {
                continue;
            }

            for (var yieldKey in adSlots[adSlot].yieldLab) {
                yieldLab.mapContentunit(adSlots[adSlot].id, adSlots[adSlot].yieldLab[yieldKey].yieldId, adSlots[adSlot].yieldLab[yieldKey].yieldFormat);
            }
        }
        yieldLab.enable();
<?
        // (pj) 2016-03-11 end

        // // ... nuggad ...
        // api.modules.configureModule("nuggad").setCustomerId(12345).setSubdomain("mySubdomain").setCategory("football").enable();
        // // ... criteo.
        // api.modules.configureModule("criteo").setNid(6789).setContentVariableName("criteoContent").setCookieName("cookieName").enable();

        // var contentWidth = parseInt(window.getComputedStyle(document.getElementById('wrap')).width);
        // var contentWidth = document.getElementById('wrap').clientWidth;
?>
        var contentWidth = 990;
        var adWidth = pageWidth - contentWidth;

<?        // Configure single request ... ?>
        api.registerAdfarm("ad1.adfarm1.adition.com");
        api.setProfile('adSlotWidth', adWidth.toString());
        api.setProfile('pageWidth', pageWidth.toString());
        api.setProfile('adPageName', '<?= $channelName; ?>');
        api.setProfile('adReload', 'false');
        if (adKeywords != '') {
            api.setProfile('keyword', adKeywords);
        }

        for (var adSlot in adSlots) {
            adSlots[adSlot].banner = adSlots[adSlot].banner.replace(/[\s\(\)]/g, '');
            if (adSlots[adSlot].banner.match(/^video/i) || adSlots[adSlot].banner.match(/^mobile/i)) {
                continue;
            }

            api.configureRenderSlot(adSlots[adSlot].banner)
               .setContentunitId(parseInt(adSlots[adSlot].id))
               .events
               .onPreRender(function(renderSlotElement, bannerDescriptionApi, renderControlApi) {
                    var diffDate = Math.abs(new Date() - globalAdTimer['global']['start']);
                    diffDate = Math.round(diffDate / 100) / 10;
                    globalAdTimer[renderSlotElement.getAttribute('id')] = globalAdTimer[renderSlotElement.getAttribute('id')] || [];
                    globalAdTimer[renderSlotElement.getAttribute('id')]['preRender'] = diffDate;
                    <? if (isset($_GET['adtimes']) || isset($_GET['addebug'])): ?>
                        console.log('PreRender Slot ' + renderSlotElement.getAttribute('id') + ' (' + diffDate + ' Sekunden)');
                    <? endif; ?>
               })
               .onPostRender(function(renderSlotElement, bannerDescriptionApi, renderControlApi) {
                    // console.log(renderSlotElement, bannerDescriptionApi, bannerDescriptionApi.getOptions());
                    var bannerId = renderSlotElement.getAttribute('id');
                    var bannerOptions = bannerDescriptionApi.getOptions();
<?
                    // ----------------------------------------------------------------------------------------
                    // Bei einem adSlotInterval und nach dem laden des Skyscrapers1 alle ads neu laden
                    // ----------------------------------------------------------------------------------------
?>
                    if ('Skyscraper1' === bannerId) {

                        if (typeof window['Campaign_A1Sitebar_2016_09_05'] === 'function') {
                            Campaign_A1Sitebar_2016_09_05();
                        }

                        if ('All Interval' === reloadAdsLogik && 'aus' !== adSlotInterval) {
                            if (bannerOptions.reload !== 'block') {
                                window.setTimeout(function() {
                                    api.reload();
                                }, adSlotInterval);
                            }
                        }

                    }

<?
                    // ----------------------------------------------------------------------------------------
                    // Alle AdPositionen einzeln reloaden, wenn reload gesetzt ist
                    //
                    // jede AdPosition wird einzeln reloaded -> kann asynchron werden mit der zeit
                    // bei synchroner Lösung eine js-datei überlegen, welche den reload Prozess übernehmen soll.
                    // ----------------------------------------------------------------------------------------
?>
                    if ('Single Interval' === reloadAdsLogik && 'aus' !== adSlotInterval) {

                        for (var adSlot in adSlots) {
                            if (true !== adSlots[adSlot].reload) {
                                continue;
                            }

                            var regex = new RegExp('^' + bannerId + '$', 'i');
                            if (adSlots[adSlot].banner.match(regex)) {
                                // console.log(bannerId, bannerOptions.reload);
                                if (bannerOptions.reload !== 'block') {
                                    // console.log('RELOAD !!!');
                                    window.setTimeout(function() {
                                        api.configureRenderSlot(bannerId).setProfile('reload', '1'); // Setze ProfilVariable auf aktuelle Werbeposition
                                        // api.setProfile('reload', '1'); // Setze ProfilVariable auf ALLE Werbepositionen
                                        api.reload([bannerId]);
                                    }, adSlotInterval);
                                }
                            }
                        }

                    }
               })
               .onFinishLoading(function(renderSlotElement, bannerDescriptionApi, renderControlApi) {

                    var diffDate = Math.abs(new Date() - globalAdTimer['global']['start']);
                    diffDate = Math.round(diffDate / 100) / 10;
                    globalAdTimer[renderSlotElement.getAttribute('id')] = globalAdTimer[renderSlotElement.getAttribute('id')] || [];
                    globalAdTimer[renderSlotElement.getAttribute('id')]['finishLoading'] = diffDate;
                    <? if (isset($_GET['adtimes']) || isset($_GET['addebug'])): ?>
                        console.log('Finished Loading ' + renderSlotElement.getAttribute('id') + ' (' + diffDate + ' Sekunden)');
                    <? endif; ?>

                    <?// switch (renderSlotElement.getAttribute('id')) {
                    //     case 'Contentad1':
                    //     case 'Skyscraper1':
                    //     case 'Skyscraper2':
                    //     case 'Skyscraper':
                    //     case 'Superbanner':
                    //         var googleAnalyticsString = window["GoogleAnalyticsObject"];
                    //         if (typeof googleAnalyticsString === 'undefined') {
                    //             break;
                    //         }
                    //         var analytics = window[googleAnalyticsString];
                    //         // analytics(
                    //         //     'A.send',
                    //         //     'event',
                    //         //     'Adition Tracking',
                    //         //     renderSlotElement.getAttribute('id') + ' (PreRender : Finished Loading)',
                    //         //     globalAdTimer[renderSlotElement.getAttribute('id')]['preRender'] + ' : ' + globalAdTimer[renderSlotElement.getAttribute('id')]['finishLoading']
                    //         // );
                    //         analytics(
                    //             'A.send',
                    //             {
                    //                 hitType: 'event',
                    //                 eventCategory: 'Adition Tracking',
                    //                 eventAction: renderSlotElement.getAttribute('id'),
                    //                 eventLabel: 'PreRender',
                    //                 eventValue: globalAdTimer[renderSlotElement.getAttribute('id')]['preRender']
                    //             }
                    //         );
                    //         analytics(
                    //             'A.send',
                    //             {
                    //                 hitType: 'event',
                    //                 eventCategory: 'Adition Tracking',
                    //                 eventAction: renderSlotElement.getAttribute('id'),
                    //                 eventLabel: 'Finished Loading',
                    //                 eventValue: globalAdTimer[renderSlotElement.getAttribute('id')]['finishLoading']
                    //             }
                    //         );
                    //         break;
                    // }?>

                    var bannerId = renderSlotElement.getAttribute('id');
<?
                    // ----------------------------------------------------------------------------------------
                    // Sticky Werbepositionen (Superbanner, Contentad1, Contentad2, ...)
                    // siehe adSlotsSticky Variable weiter oben
                    // ----------------------------------------------------------------------------------------
?>
                    if (bannerId in adSlotsSticky) {
<?
                        // ------------------------------------------------------------------------------------
                        // OE2016 Logik
                        // ------------------------------------------------------------------------------------
?>
                        globalVars.stickyObjects[bannerId] = {
                            objectQuery:  '#' + bannerId + '.' + adSlotsSticky[bannerId].replace(/^\./, ''),
                            timeout: null
                        };
<?
                        // ------------------------------------------------------------------------------------
                        // Alte Logik
                        // ------------------------------------------------------------------------------------
?>
                        if (typeof OE24InitSticky == "function") {
                            OE24InitSticky('<?= $channelName; ?>', bannerId, adSlotsSticky[bannerId]);
                        } else {
                            var stickyLength = 0;
                            if (typeof window['setOE24Sticky'] !== 'undefined') {
                                stickyLength = window['setOE24Sticky'].length;
                            } else {
                                window['setOE24Sticky'] = [];
                            }
                            window['setOE24Sticky'][stickyLength] = ['<?= $channelName; ?>', renderSlotElement];
                        }
                    }
<?
                    // ----------------------------------------------------------------------------------------
                    // OE2016 Scrollhandler einmal ausfuehren bei einer neu geladenen Werbung
                    // Damit die Werbung auch ohne scrollen einmal Sticky angezeigt wird.
                    // ----------------------------------------------------------------------------------------
?>
                    if (typeof globalVars !== 'undefined' && typeof globalVars.stickyHeader !== 'undefined') {
                        globalVars.stickyHeader.scrollHandler();
                    }
<?
                    // ----------------------------------------------------------------------------------------
                    // Fishtank Logik
                    // ----------------------------------------------------------------------------------------
?>
                    if ('Fishtank' === bannerId) {
                        if (typeof startFishtankParallax == "function") {
                            startFishtankParallax('<?= $channelName; ?>', bannerId, adSlotsSticky[bannerId]);
                        } else {
                            var stickyLength = 0;
                            if (typeof window['setFishtankParallax'] !== 'undefined') {
                                stickyLength = window['setFishtankParallax'].length;
                            } else {
                                window['setFishtankParallax'] = [];
                            }
                            window['setFishtankParallax'][stickyLength] = ['<?= $channelName; ?>', renderSlotElement];
                        }
                    }
<?
                    // ----------------------------------------------------------------------------------------
                    // Bei einem adSlotInterval und nach dem laden des Skyscrapers1 alle ads neu laden
                    // ----------------------------------------------------------------------------------------
?>
                    // if ('Skyscraper1' === bannerId) {

                    //     if (typeof window['Campaign_A1Sitebar_2016_09_05'] === 'function') {
                    //         Campaign_A1Sitebar_2016_09_05();
                    //     }

                    //     if ('All Interval' === reloadAdsLogik && 'aus' !== adSlotInterval) {
                    //         window.setTimeout(function() {
                    //             api.reload();
                    //         }, adSlotInterval);
                    //     }

                    // }

<?
                    // ----------------------------------------------------------------------------------------
                    // Alle AdPositionen einzeln reloaden, wenn reload gesetzt ist
                    //
                    // jede AdPosition wird einzeln reloaded -> kann asynchron werden mit der zeit
                    // bei synchroner Lösung eine js-datei überlegen, welche den reload Prozess übernehmen soll.
                    // ----------------------------------------------------------------------------------------
?>
                    // if ('Single Interval' === reloadAdsLogik && 'aus' !== adSlotInterval) {

                    //     for (var adSlot in adSlots) {
                    //         if (true !== adSlots[adSlot].reload) {
                    //             continue;
                    //         }

                    //         var regex = new RegExp('^' + bannerId + '$', 'i');
                    //         if (adSlots[adSlot].banner.match(regex)) {
                    //             window.setTimeout(function() {
                    //                 api.configureRenderSlot(bannerId).setProfile('reload', '1'); // Setze ProfilVariable auf aktuelle Werbeposition
                    //                 // api.setProfile('reload', '1'); // Setze ProfilVariable auf ALLE Werbepositionen
                    //                 api.reload([bannerId]);
                    //             }, adSlotInterval);
                    //         }
                    //     }

                    // }
               });
        }
    });


<?
    // (function() {
    //     var csid = "F09828";
    //     var bpid = "OE24";
    //     var e = document.createElement("script");
    //     var s = document.getElementsByTagName("script")[0];
    //     e.src = "//js.revsci.net/gateway/gw.js?auto=t&csid=" + csid + "&bpid=" + bpid;
    //     e.async = true;
    //     s.parentNode.insertBefore(e, s);
    // })();
?>
    (function() {
        var cb = new Date().getTime();
        var asiPqTag = false;
        var e = document.createElement("script");
        // DAILY-912 MH 20171027 Quickfix, da Aufuruf in Timeout läuft
        //var src = "http://pq-direct.revsci.net/pql?placementIdList=ehATr9,Co3hrL,9t5ng8,8wb5zW,HYbixp,MztHZt,Wr2WoA,LamrZs,fUb5I5&cb=" + cb;
        var src = '';
        var s = document.getElementsByTagName("script")[0];
        e.async = true;
        e.onload = e.onreadystatechange = e.onerror = function() {

            if (aditionLoaded) {
                return;
            }
            if (!this.readyState || this.readyState === 'loaded' || this.readyState === 'complete') {
                <?
                // var hawkeyePlacements = '';
                // if (typeof asiPlacements != "undefined") {


                //     for(var p in asiPlacements) {
                //         hawkeyePlacements+=(asiPlacements[p]["default"])?""+p+"_":"";
                //     }


                // }
                ?>
                <?
                // console.log('hawkeyePlacements:'+hawkeyePlacements.toString());
                // console.log('hawkeyePlacements length:'+hawkeyePlacements.length);
                ?>
                // Setup callback queue
                adition.srq.push(function(api) {
                    <?
                    // if(hawkeyePlacements.length>0){
                    //     api.setProfile('pgn', hawkeyePlacements.toString());
                    // }
                    ?>

                    <? if (isset($_GET['adtimes']) || isset($_GET['addebug'])): ?>
                        console.log('Starte ADITION');
                    <? endif; ?>
                    globalAdTimer['global'] = [];
                    globalAdTimer['global']['start'] = new Date();

                    api.load().completeRendering();
                    aditionLoaded = true;

                });
            }
        };
        e.src = src;
        s.parentNode.insertBefore(e, s);
    })();



<?    // (ws) 2015-11-24 ?>
    function fixSuperBanner() {
<?        // zum unterdruecken der JS-Fehlermeldung, wenn im Superbanner noch die Funktion aufgerufen wird, die es nicht mehr gibt. ?>
    }
<?    // (ws) 2015-11-24 // ?>

</script>
<!-- END AudienceScience Adition -->
