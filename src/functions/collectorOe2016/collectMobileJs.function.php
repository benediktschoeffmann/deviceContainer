<?

function collectMobileJs() {

    $js = array(
        'oe24.oe24.mobile.js.jquery',
        'oe24.oe24.mobile.js.custommodernizr',
        'oe24.oe24.mobile.js.idangerousswiper-24min',
        'oe24.oe24.mobile.js.slick_1_3_7',
        'oe24.oe24.mobile.js.slickSlider',
        'oe24.oe24.mobile.js.app',
        # (bs) Wird über Tpl aufruf am ende der page gelöst
        #'oe24.oe24.mobile.js.ga',
        'oe24.oe24.mobile.js.weltall',
        'oe24.oe24.mobile.js.epaper',
        'oe24.oe24.mobile.js.fbLikeOverlay',

        // (ws) 2015-08-12
        'oe24.oe24.mobile.js.fishtank',

        // (ws) 2015-09-17
        'oe24.oe24.__splitArea.js.v3.cookiesOverlay',

        // (bs) 2016-03-03
        'oe24.oe24.mobile.js.votingMobile',

        // (bs) 2016-04-07
        // 'oe24.oe24.mobile.js.radioVotingMobile',

        // (bs) 2016-04-11
        'oe24.oe24.mobile.js.slideShowVotingMobile',

        // (pj) 2016-09-26 NST AGTT Teletest Tracking
        '_shared.1_0.common.common',
        '_shared.1_0.tracking.agtt.nst.NSTBaseAPI_min',

        // (bs) 2017-01-10 JWPlayer 7
        // '_shared.1_0.jwplayer.7_8_7.jwplayer.jwplayer',
        // '_shared.1_0.jwplayer.7_8_7.jwplayerSetup',

        // (bs) 2017-01-10 JWPlayer 7
        '_shared.1_0.jwplayer.8_0_11.jwplayer.jwplayer',
        '_shared.1_0.jwplayer.8_0_11.jwplayerSetup',


        // (bs) apa IFrame Listener für Höhe
        'oe24.oe24.__splitArea.js.oe2016.apaIFrameListener',

        // (bs) 2016-07-19 js for top video box.
        'oe24.oe24.__splitArea.js.oe2016.oe24tvTopVideoBox',

        // (ws) 2016-07-25
        'oe24.oe24.__splitArea.js.v3.lazyload.jqueryLazyload',
        'oe24.oe24.mobile.js.lazyload',

    );

    return $js;

}

