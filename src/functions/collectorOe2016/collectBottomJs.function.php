<?
/**
 * zum definieren der JS-Dateien im Head
 *
 * wird als Funktion geschrieben, damit auch die .page datei auf die gleichen Dateien zugreifen kann,
 * wie die eigentliche Seite
 * FOR TESTING ONLY !!!
 */
function collectBottomJs($layout) {

	$jsBottom = array(

		array(0, 'oe24.oe24.__splitArea.js.v3.jquery.jquery_1_11_0'),


        // (pj) 2016-09-19 NPORT-36 TeleTracking
        array(0, '_shared.1_0.tracking.agtt.nst.NSTBaseAPI_min'),
        // (pj) 2016-09-19 end

		// (pj) 2016-04-15 JWPlayer 7.6.1
		// array(0, '_shared.1_0.jwplayer.7_6_1.jwplayer.jwplayer'),
		// array(0, '_shared.1_0.jwplayer.7_6_1.jwplayerSetup'),
		// (pj) 2016-04-15 end

        // (bs) 2017-01-09 switch to 7.8.7.
        array(0, '_shared.1_0.jwplayer.7_8_7.jwplayer.jwplayer'),
        array(0, '_shared.1_0.jwplayer.7_8_7.jwplayerSetup'),
        // (bs) end

        // (bs) 2018-01-04 switch to 8.0.11
        // array(1, '_shared.1_0.jwplayer.8_0_11.jwplayer.jwplayer'),
        // array(1, '_shared.1_0.jwplayer.8_0_11.jwplayerSetup'),
        // (bs) end

		array(0, 'oe24.oe24.__splitArea.js.v3.lazyload.jqueryLazyload'),
		array(0, 'oe24.oe24.__splitArea.js.v3.lazyload.lazyload'),
		array(0, 'oe24.oe24.__splitArea.js.v3.slickSlider.1_3_7.slick_1_3_7'),
		array(0, 'oe24.oe24.__splitArea.js.v3.article_pages'),
		// array(0, 'oe24.oe24.__splitArea.js.v3.article_social'), // (pj) 2016-04-19
		array(0, 'oe24.oe24.__splitArea.js.v3.autoComplete.jquery-auto-complete'),
		array(0, 'oe24.oe24.__splitArea.js.v3.comments'),
		// array(0, 'oe24.oe24.__splitArea.js.v3.console'), // (pj) 2016-04-19
		// array(0, 'oe24.oe24.__splitArea.js.v3.consoleMadonna'), // (pj) 2016-04-19
		array(0, 'oe24.oe24.__splitArea.js.oe2016.consoleMadonna'), // (db) 2017-03-28
		array(0, 'oe24.oe24.__splitArea.js.v3.console_v2'),
		array(0, 'oe24.oe24.__splitArea.js.v3.cookiesOverlay'),
		// array(0, 'oe24.oe24.__splitArea.js.v3.country'), // (pj) 2016-04-19
		// array(0, 'oe24.oe24.__splitArea.js.v3.ePaperOesterreich'), // (pj) 2016-04-19
		// array(0, 'oe24.oe24.__splitArea.js.v3.easyTicker.2_0_0.easy_ticker'), // (pj) 2016-04-19 fuer was war das?
		array(0, 'oe24.oe24.__splitArea.js.v3.fishtank'),
		// array(0, 'oe24.oe24.__splitArea.js.v3.gravity'),

        // (ws) 2015-01-14
		array(0, 'oe24.oe24.__splitArea.js.v3.header'),
		array(0, 'oe24.oe24.__splitArea.js.oe2016.header'),
		array(0, 'oe24.oe24.__splitArea.js.oe2016.headerNavWeather'),
		array(0, 'oe24.oe24.__splitArea.js.oe2016.headerSubNav'),
		array(0, 'oe24.oe24.__splitArea.js.oe2016.console'),
		array(0, 'oe24.oe24.__splitArea.js.oe2016.editorsComment'),
		array(0, 'oe24.oe24.__splitArea.js.oe2016.nationalteam'),
		array(0, 'oe24.oe24.__splitArea.js.oe2016.standardContentBox'),
		// (ws) 2015-01-14 end

		// (ws) 2015-04-07
		array(0, '_shared.1_0.flickity.1_2_1.flickity.flickity_pkgd'),
		array(0, '_shared.1_0.flickity.1_2_1.flickitySetup'),
		// (ws) 2015-04-07 end

		// (ws) 2015-04-25
		array(0, 'oe24.oe24.__splitArea.js.oe2016.standardContentSlider'),
		// (ws) 2015-04-25 end

        // (ws) 2017-04-06
        array(0, 'oe24.oe24.__splitArea.js.oe2016.articleContentSlider'),
        // (ws) 2017-04-06 end

		// array(0, 'oe24.oe24.__splitArea.js.v3.horoskop'), // (pj) 2016-04-19
		// array(0, 'oe24.oe24.__splitArea.js.v3.iframe_height_changer'), // (pj) 2016-04-19
		// array(0, 'oe24.oe24.__splitArea.js.v3.lazyload.lazyload'),
		array(0, 'oe24.oe24.__splitArea.js.v3.moneyTicker'),
		array(0, 'oe24.oe24.__splitArea.js.v3.observeDOM'),
		// array(0, 'oe24.oe24.__splitArea.js.v3.oe2016articleTopGelesen'),
		// array(0, 'oe24.oe24.__splitArea.js.v3.oesterreich_konsole'), // (pj) 2016-04-19
		// array(0, 'oe24.oe24.__splitArea.js.v3.oesterreich_teaser'),
		// array(0, 'oe24.oe24.__splitArea.js.v3.pageSlider'), // (pj) 2016-04-19
		array(0, 'oe24.oe24.__splitArea.js.v3.paginator'),
		// array(0, 'oe24.oe24.__splitArea.js.v3.radioOe24'), // (pj) 2016-04-19
		// array(0, 'oe24.oe24.__splitArea.js.v3.recipe'), // (pj) 2016-04-19
		array(0, 'oe24.oe24.__splitArea.js.v3.remodal.1_0_2.remodal'),
		array(0, 'oe24.oe24.__splitArea.js.v3.rl2014oe24tvDefaultContentBoxSlider'),
		array(0, 'oe24.oe24.__splitArea.js.v3.sidebarCad'),
		// (db) 2017-08-22 channel-view, contentadd
		array(0, 'oe24.oe24.__splitArea.js.oe2016.oe2016sidebarCad'),
		// (db) 2017-09-12
		array(0, 'oe24.oe24.__splitArea.js.oe2016.oe2016contentAdLoad'),

		array(0, 'oe24.oe24.__splitArea.js.v3.slideshow'),
		array(0, 'oe24.oe24.__splitArea.js.v3.slideshow_slick'),
		array(1, 'oe24.oe24.__splitArea.js.v3.slideshow_voting'),
		// array(0, 'oe24.oe24.__splitArea.js.v3.storySlider'), // (pj) 2016-04-19

		array(0, 'oe24.oe24.__splitArea.js.v3.subnav_oe24'),

		array(0, 'oe24.oe24.__splitArea.js.v3.text_slideshow'),
		// array(0, 'oe24.oe24.__splitArea.js.v3.tickerbox'), // (pj) 2016-04-19
		array(0, 'oe24.oe24.__splitArea.js.v3.viewport.jquery_viewport'),
		array(0, 'oe24.oe24.__splitArea.js.v3.voting'),
		array(0, 'oe24.oe24.__splitArea.js.v3.weatherTicker'),
		array(0, 'oe24.oe24.__splitArea.js.v3.wetter'),

		array(0, '_shared.1_0.tracking.oewa.v2.oewaTracking'),

		array(0, 'oe24.oe24.__splitArea.js.oe2016.contentScrollBox'),
		array(0, 'oe24.oe24.__splitArea.js.oe2016.oesterreichTabbedBox'),

		array(0, 'oe24.oe24.__splitArea.js.oe2016.sidebarRadioBox'),

        // (ws) 2016-04-15 Wahl 2016
		array(0, 'oe24.oe24.__splitArea.js.v3.rl2014wahlDetailSuche'),
        array(0, 'oe24.oe24.__splitArea.js.oe2016.bundespraesidentenwahl'),
        // (ws) 2016-04-15

        // (bs) 2016-05-13
		// array(0, 'oe24.oe24.__splitArea.js.oe2016.apaIFrameListener'),
        // (bs) end

        // (bs) 2016-07-13
        array(0, 'oe24.oe24.__splitArea.js.oe2016.oe24tvTopVideoBox'),
        // (bs) end
        // (db) 2018-01-17
        array(0, 'oe24.oe24.__splitArea.js.oe2016.oe24tvTopVideoLayer'),

        // (ws) 2016-07-13
        array(0, 'oe24.oe24.__splitArea.js.oe2016.oe24tvNewsTicker'),
        // (ws) 2016-07-13 end

        // ----------------------------------------------------------------------

        // (pj) 2016-09-02 A1 Sitebar, DAILY-600
        array(0, 'oe24.oe24.__splitArea.js.kampagnen.2016_09_05_a1_sitebar'),
        // (pj) 2016-09-02 end

        // (ws) 2016-09-21 Countdown Box
        array(0, 'oe24.oe24.__splitArea.js.jquery-countdown.2-2-0.jquery-countdown'),
        array(0, 'oe24.oe24.__splitArea.js.oe2016.oe2016countdownBox'),

        // (ws) 2016-10-05 Modal Dialog New Stories Overlay
        array(0, 'oe24.oe24.__splitArea.js.oe2016.newStoriesOverlay'),

        // (ws) 2016-10-14 Adventkalender
        array(0, 'oe24.oe24.__splitArea.js.v3.adventkalender'),

        // (ws) 2016-12-29 Silvester Countdown
        array(1, 'oe24.oe24.__splitArea.js.oe2016.silvesterCountdown'),

        // (ws) 2017-05-11 Business Teletrader Slider
        array(1, 'oe24.oe24.__splitArea.js.oe2016.oe2016teleTraderXmlBox'),

        // (ws) 2017-05-11 Business Slider
        array(1, 'oe24.oe24.__splitArea.js.oe2016.oe2016businessSlider'),

        // (db) 2017-08-28 TV Progamm Slider
        array(1, 'oe24.oe24.__splitArea.js.oe2016.oe2016tvProgrammSlider'),

        // (db) 2017-06-26 Newsletter Registration Emarsys
        array(0, 'oe24.oe24.__splitArea.js.oe2016.newsletter'),

        // (ws) 2017-10-11
        array(1, 'oe24.oe24.__splitArea.js.oe2016.oe2016wahlCharts'),

        // (ws) 2017-11-13
        array(1, 'oe24.oe24.__splitArea.article.slideshowVoting.slideshowVoting'),

	);

	// $jsBottom = array(
	// );

	return $jsBottom;
}

function groupBottomJs($layout) {

    $items = collectBottomJs($layout);

    $prevSingleTag = 0;
    $outputIndex = 0;
    $output = array();
    foreach ($items as $key => $item) {

        if ($key > 0 && spunQ::inMode(spunQ::MODE_DEVELOPMENT)) {
            if (1 === $item[0] || 1 === $prevSingleTag) {
                $outputIndex++;
            }
        }

        $output[$outputIndex][] = $item[1];

        $prevSingleTag = $item[0];

    }

    return $output;

}
