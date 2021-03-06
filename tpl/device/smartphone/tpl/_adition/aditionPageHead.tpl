<?
/**
 * Adition Single Sign On Request Mobile Initialisation
 *
 * @var channel oe24.core.Channel
 * @var content any
 */
$device = DeviceContainer::getDevice();

$isContentSet = $content instanceof TextualContent;
$channelName = $channel->getName();

if ("Keine Werbung laden" === $device->getConfig('showAds')) {
    return;
}

$adSlotsJson       = $device->getConfig('adSlotsJson');
$adPositionsJson   = $device->getConfig('adPositionsJson');
$adTypeLengthsJson = $device->getConfig('adTypeLengthsJson');

$reloadAdsLogik    = $device->getConfig('reloadAdsLogik');
$reloadAdsInterval = $device->getConfig('reloadAdsInterval');
$adKeywords        = '';
?>
<!-- BEGIN AudienceScience Adition -->
<script type="text/javascript">
    var aditionLoaded = false;
    var pageWidth = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth || '320px';

    var adSlots        = <?= $adPositionsJson; ?>;
    var adTypesLengths = <?= $adTypeLengthsJson; ?>;
    var adKeywords     = '<?= $adKeywords; ?>';
    var adSlotInterval = '<?= $reloadAdsInterval; ?>';
    var reloadAdsLogik = '<?= $reloadAdsLogik; ?>';
    var globalAdTimer = globalAdTimer || [];

    // console.log("ad slot length: " + adSlots.length);
    // console.log('adTypesLengths: ' + adTypesLengths);
    // var sum = Number(adTypesLengths[0]) + Number(adTypesLengths[1]) + Number(adTypesLengths[2]);
    // console.log("alles zusammengeszählt: " + sum);

<?    // Setup callback queue ?>
    var adition = adition || {};
    adition.srq = adition.srq || [];

<?    // Load |srp| ?>
    (function() {
        var script      = document.createElement("script");
        script.type     = "text/javascript";
        script.src      = (document.location.protocol === "https:" ? "https:" : "http:") + "//imagesrv.adition.com/js/srp.js";
        script.charset  = "utf-8";
        script.async    = true;
        // script.defer = true;
        var firstScript = document.getElementsByTagName("script")[0];
        firstScript.parentNode.insertBefore(script, firstScript);
    })();

    var yieldLabAdSlots = adSlots.slice(adTypesLengths[0]);
    // console.log(yieldLabAdSlots);

    adition.srq.push(function(api) {
        // console.log('push');
        var yieldLab = api.modules.configureModule('yieldlab');
        for (var adSlot in yieldLabAdSlots) {
            // if (typeof adSlots[adSlot].yieldLab == 'undefined') {
            //     continue;
            // }
            // console.log('register yieldlab bannername ' + adSlots[adSlot].banner);

            for (var yieldKey in adSlots[adSlot].yieldLab) {
                // console.log(yieldKey);
                // console.log(adSlots[adSlot].yieldLab[yieldKey].yieldId);
                // console.log(adSlots[adSlot].yieldLab[yieldKey].yieldFormat);
                yieldLab.mapContentunit(
                     adSlots[adSlot].id,
                     adSlots[adSlot].yieldLab[yieldKey].yieldId,
                     adSlots[adSlot].yieldLab[yieldKey].yieldFormat
                );
            }
        }
    yieldLab.enable();

    var contentWidth = Math.max(
        document.documentElement.clientWidth, window.innerWidth || 320
        );
    var adWidth = pageWidth - contentWidth;

    <?  // Configure single request ... ?>
    api.registerAdfarm("ad1.adfarm1.adition.com");
    api.setProfile('adSlotWidth', adWidth.toString());
    api.setProfile('pageWidth', pageWidth.toString());
    api.setProfile('adPageName', '<?= $channelName; ?>');
    api.setProfile('adReload', 'false');
    if (adKeywords != '') {
        api.setProfile('keyword', adKeywords);
    }

    for (var adSlot in adSlots) {
        // console.log('schleife');

        //wirds wohl nicht mehr brauchen die zeile
        // adSlots[adSlot].banner = adSlots[adSlot].banner.replace(/[\s\(\)]/g, '');

        // das ebenso nicht, passiert schon im php
        if (!adSlots[adSlot].banner.startsWith('Mobile')) {
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
                // console.log(
                //      renderSlotElement,
                //      bannerDescriptionApi,
                //      bannerDescriptionApi.getOptions()
                // );

                var bannerId = renderSlotElement.getAttribute('id');
                var bannerOptions = bannerDescriptionApi.getOptions();
<?
                // ---------------------------------------------------------------------
                // Bei einem adSlotInterval und nach dem laden des Skyscrapers1 alle ads neu laden
                // ---------------------------------------------------------------------
                //
                // (bs) SkyScraper wirds Mobile wohl nicht geben.
?>
                // if ('Skyscraper1' === bannerId) {

                //     if (typeof window['Campaign_A1Sitebar_2016_09_05'] === 'function') {
                //         Campaign_A1Sitebar_2016_09_05();
                //     }

                //     if ('All Interval' === reloadAdsLogik && 'aus' !== adSlotInterval) {
                //         if (bannerOptions.reload !== 'block') {
                //             window.setTimeout(function() {
                //                 api.reload();
                //             }, adSlotInterval);
                //         }
                //     }

                // }

<?
                // ---------------------------------------------------------------------
                // Alle AdPositionen einzeln reloaden, wenn reload gesetzt ist
                //
                // jede AdPosition wird einzeln reloaded -> kann asynchron werden mit der zeit
                // bei synchroner Lösung eine js-datei überlegen, welche den reload Prozess übernehmen soll.
                // ---------------------------------------------------------------------
?>

                if ('Single Interval' === reloadAdsLogik && 'aus' !== adSlotInterval) {
                    var reloadAdsSlots = adSlots.slice(adTypesLengths[0] + adTypesLengths[1]);
                    // console.log("reloadAdsSlots");
                    // console.log(reloadAdsSlots);
                    for (var adSlot in reloadAdsSlots) {
                        // bs die Zeile könn ma uns dann auch sparen.
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


                var bannerId = renderSlotElement.getAttribute('id');

<?
                // ---------------------------------------------------------------------
                // Bei einem adSlotInterval und nach dem laden des Skyscrapers1 alle ads neu laden
                // ---------------------------------------------------------------------
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
                // ---------------------------------------------------------------------
                // Alle AdPositionen einzeln reloaden, wenn reload gesetzt ist
                //
                // jede AdPosition wird einzeln reloaded -> kann asynchron werden mit der zeit
                // bei synchroner Lösung eine js-datei überlegen, welche den reload Prozess übernehmen soll.
                // ---------------------------------------------------------------------
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

    (function() {
        var cb = new Date().getTime();
        var asiPqTag = false;
        var e = document.createElement("script");
        var src = "http://pq-direct.revsci.net/pql?placementIdList=ehATr9,Co3hrL,9t5ng8,8wb5zW,HYbixp,MztHZt,Wr2WoA,LamrZs,fUb5I5&cb=" + cb;
        var s = document.getElementsByTagName("script")[0];
        e.async = true;
        e.onload = e.onreadystatechange = e.onerror = function() {

            if (aditionLoaded) {
                return;
            }
            if (!this.readyState || this.readyState === 'loaded' || this.readyState === 'complete') {

                <? // Setup callback queue ?>
                adition.srq.push(function(api) {
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

    function fixSuperBanner() {
    }

</script>
<!-- END AudienceScience Adition -->
