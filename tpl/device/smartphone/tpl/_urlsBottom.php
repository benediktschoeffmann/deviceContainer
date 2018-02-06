<?

// Die Variable MUSS $js heissen !!!

$js = array(

    array(0, 'oe24.oe24.device.smartphone.assets.js.helper'),

    // jwplayer setup braucht jQuery :(
    // array(0, 'oe24.oe24.__splitArea.js.v3.jquery.jquery_1_11_0'),
    array(0, 'oe24.oe24.__splitArea.js.v3.jquery.jquery_1_11_0_min'),
    // array(0, 'oe24.oe24.__splitArea.js.v3.jquery.jquery_3_1_1_min'),

    // (ws) 2017-03-02
    array(0, 'oe24.oe24.device.smartphone.assets.vendor.responsivelyLazy.responsivelyLazy'),

    // array(0, 'oe24.oe24.__splitArea.js.v3.lazyload.jqueryLazyload'),
    // array(0, 'oe24.oe24.device.smartphone.assets.js.lazyloadSmartphone'),

    // array(0, 'oe24.oe24.device.smartphone.assets.vendor.flickity.1_2_1.flickity_pkgd'),
    // array(0, 'oe24.oe24.device.smartphone.assets.vendor.flickity.2_0_3.flickity_pkgd'),
    // array(0, 'oe24.oe24.device.smartphone.assets.vendor.flickity.2_0_4.flickity_pkgd'),
    array(0, 'oe24.oe24.device.smartphone.assets.vendor.flickity.2_0_5.flickity_pkgd'),
    array(0, 'oe24.oe24.device.smartphone.assets.js.flickitySlider'),

    // (bs) DONT REMOVE THIS - TRACKING FOR VIDEOS
    array(0, '_shared.1_0.common.common'),
    array(0, '_shared.1_0.tracking.agtt.nst.NSTBaseAPI_min'),

    array(0, '_shared.1_0.jwplayer.7_8_7.jwplayer.jwplayer'),
    array(0, '_shared.1_0.jwplayer.7_8_7.jwplayerSetup'),

    // array(0, '_shared.1_0.jwplayer.8_0_11.jwplayer.jwplayer'),
    // array(0, '_shared.1_0.jwplayer.8_0_11.jwplayerSetup'),

    // ----------------------------------------------------------------

    // (ws) 2017-07-31 Die Navigation soll schon reagieren, bevor die Seite vollstaendig geladen ist.
    // Dazu muessen zumindest .header und .navigationMain geladen sein.
    // Deshalb wird das zustaendige JS im Template
    // ... device/smartphone/tpl/_navigationMain/navigationMainJs.tpl
    // geladen und nicht hier.
    array(0, 'oe24.oe24.device.smartphone.tpl._navigationMain.navigationMain'),

    // array(0, 'oe24.oe24.device.smartphone.tpl.consoleBox.consoleBox'),

    // ----------------------------------------------------------------

    // (bs) 2017-03-06
    // dieses JavaScript z.B. ist für die Pfeile bei Konsolen.
    array(0, '_shared.1_0.tracking.oewa.v2.oewaTracking'),

    // http://desmonding.me/zooming/
    // https://github.com/kingdido999/zooming
    // https://github.com/kingdido999/zooming/releases
    array(0, 'oe24.oe24.device.smartphone.assets.vendor.zooming.0_8_2.zooming'),
    // (ws) 2016-12-23
    array(0, 'oe24.oe24.device.smartphone.assets.js.zoomingInit'),

    // (ws) 2016-02-13 WetterBox
    array(0, 'oe24.oe24.device.smartphone.tpl.templateBox.wetterBox.wetterBox'),

    // (ws) 2017-02-07 Fishtank
    array(0, 'oe24.oe24.device.smartphone.tpl._adition.fishtank'),

    // (bs) 2017-02-07 App.JS
    // (bs) 2017-03-06 ohne jQuery
    array(0, 'oe24.oe24.device.smartphone.assets.js.oe24App'),

    // (bs) 2016-01-24 AddThis Einbindung und Fade-In
    // (bs) 2017-03-06 ohne jQuery
    array(0, 'oe24.oe24.device.smartphone.assets.js.addThis'),

    // (db) 2017-09-25 addLoad via Visibility
    // array(0, 'oe24.oe24.device.smartphone.tpl._adition.contentAdLoad'),

    // (db) 2017-06-02 top-VideoBox mit wichtigsten Videos
    array(0, 'oe24.oe24.device.smartphone.tpl.contentBox.oe24tvTopVideoBox.videoBox'),

    // (db) 2017-05-24 Navigation im Artikeldetail
    array(0, 'oe24.oe24.device.smartphone.assets.js.articlePages'),

    // (db) 2017-06-06 SlideshowVoting
    array(0, 'oe24.oe24.device.smartphone.assets.js.voting'),

    // (ws) 2017-03-07 Money Ticker
    array(0, 'oe24.oe24.device.smartphone.tpl.xmlBox.boerseTicker.boerseTicker'),

    //
    // array(0, 'oe24.oe24.device.smartphone.tpl.contentBox.oe24tvMobileTeaser.oe24tvMobileTeaser'),

    // (db) 2017-06-26 Newsletter Registration Emarsys
    array(0, 'oe24.oe24.device.smartphone.tpl.templateBox.newsletter.newsletter'),

    // (ws) 2017-09-19
    array(0, 'oe24.oe24.device.smartphone.tpl.templateBox.bundestagswahl.bundestagswahl'),

    // (db) 2017-09-22
    array(0, 'oe24.oe24.device.smartphone.tpl.templateBox.nationalratswahl.nationalratswahl'),

    // (ws) 2017-10-11
    array(0, 'oe24.oe24.__splitArea.js.oe2016.oe2016wahlCharts'),

    // (ws) 2017-10-25
    array(1, 'oe24.oe24.__splitArea.article.slideshowVoting.slideshowVoting'),

    // (ws) 2018-02-01
    array(1, 'oe24.oe24.device.smartphone.tpl._misc.cookiesOverlay.cookiesOverlay'),

    // (bs) 2017-03-09 Google Analytics
    array(0, 'oe24.oe24.device.smartphone.assets.vendor.googleAnalytics.googleAnalytics'),

);
