<?
/**
 * zum definieren der CSS-Dateien im Head
 *
 * wird als Funktion geschrieben, damit auch die .page datei auf die gleichen Dateien zugreifen kann,
 * wie die eigentliche Seite
 * FOR TESTING ONLY !!!
 */

function collectHeadCss($layout) {

    $css = array(

        array(0, 'oe24.oe24.__splitArea.css.v3.normalize.normalize_3_0_0'),

        // array(0, 'oe24.oe24.__splitArea.css.oe2016.dummy20170418'),

        array(0, 'oe24.frontend.__splitArea.css.v3.header'),
        array(0, 'oe24.oe24.__splitArea.css.oe2016.header'),
        array(0, 'oe24.oe24.__splitArea.css.oe2016.headerNavPortal'),
        array(0, 'oe24.oe24.__splitArea.css.oe2016.headerNavLogo'),
        array(0, 'oe24.oe24.__splitArea.css.oe2016.headerNavMain'),
        array(0, 'oe24.oe24.__splitArea.css.oe2016.headerNavMainSubNav'),
        array(0, 'oe24.oe24.__splitArea.css.oe2016.headerNavTopics'),
        array(0, 'oe24.oe24.__splitArea.css.oe2016.headerNavSocial'),

        array(0, 'oe24.oe24.__splitArea.css.oe2016.headerSpecialSport'),
        array(0, 'oe24.oe24.__splitArea.css.oe2016.headerSpecialSociety'),
        array(0, 'oe24.oe24.__splitArea.css.oe2016.headerSpecialSportEuro2016'),
        // (pj) 2016-11-21 Antenne Salzburg
        array(0, 'oe24.oe24.__splitArea.css.oe2016.headerSpecialAntenneSalzburg'),
        // (pj) 2016-11-21 end
        // (pj) 2016-11-29 Antenne Tirol
        array(0, 'oe24.oe24.__splitArea.css.oe2016.headerSpecialAntenneTirol'),
        // (pj) 2016-11-29 end

        // (ws) 2017-02-03
        array(0, 'oe24.oe24.__splitArea.css.oe2016.headerSpecialReise'),
        // (ws) 2017-02-03 end

        // (ws) 2017-02-03
        array(0, 'oe24.oe24.__splitArea.css.oe2016.headerSpecialMoney'),
        // (ws) 2017-02-03 end

        // (ws) 2017-02-03
        array(0, 'oe24.oe24.__splitArea.css.oe2016.headerSpecialBusiness'),
        // (ws) 2017-02-03 end

        // (ws) 2017-05-30
        array(0, 'oe24.oe24.__splitArea.css.oe2016.headerSpecialGames24'),
        // (ws) 2017-05-30 end

        // (ws) 2017-02-15
        array(0, 'oe24.oe24.__splitArea.css.oe2016.headerSpecialMeinAuto24'),
        // (ws) 2017-02-15 end

        // (db) 2017-03-03
        array(0, 'oe24.oe24.__splitArea.css.oe2016.headerSpecialGesund24'),
        // (db) 2017-03-03 end

        // (db) 2017-03-16
        array(0, 'oe24.oe24.__splitArea.css.oe2016.headerSpecialCooking24'),
        array(0, 'oe24.oe24.__splitArea.css.oe2016.kochenRezeptsuche'),
        array(0, 'oe24.oe24.__splitArea.css.oe2016.sidebarMagazinGewinnspiel'),
        // (db) 2017-03-16 end

        array(0, 'oe24.oe24.__splitArea.css.v3.base'),
        array(0, 'oe24.oe24.__splitArea.css.oe2016.base'),
        array(0, 'oe24.oe24.__splitArea.css.v3.footer'),
        array(0, 'oe24.oe24.__splitArea.css.v3.styles'),


        // array(0, 'oe24.oe24.__splitArea.css.v3.addthis'), // (pj) 2016-04-18
        array(0, 'oe24.oe24.__splitArea.css.v3.adition'),
        // array(0, 'oe24.oe24.__splitArea.css.v3.antenne'), // (pj) 2016-04-18
        array(0, 'oe24.oe24.__splitArea.css.v3.article'),
        // (db) 2017-08-30 article social box
        array(0, 'oe24.oe24.__splitArea.css.oe2016.oe2016articleSocial'),
        // array(0, 'oe24.oe24.__splitArea.css.v3.articleAutoshop'), // (pj) 2016-04-18
        // array(0, 'oe24.oe24.__splitArea.css.v3.autoshopBox'), // (pj) 2016-04-18
        // array(1, 'oe24.oe24.__splitArea.css.v3.breakingNewsBox'),
        array(0, 'oe24.oe24.__splitArea.css.oe2016.oe2016breakingNews'),
        // array(0, 'oe24.oe24.__splitArea.css.v3.buzzTeaser'), // (pj) 2016-04-18
        // array(0, 'oe24.oe24.__splitArea.css.v3.careesmaSuche'), // (pj) 2016-04-18
        // array(0, 'oe24.oe24.__splitArea.css.v3.channelTags'), // (pj) 2016-04-18
        array(0, 'oe24.oe24.__splitArea.css.v3.comments'),

        // array(0, 'oe24.oe24.__splitArea.css.v3.console'), // (pj) 2016-04-18
        // array(0, 'oe24.oe24.__splitArea.css.v3.console_oe24tv'), // (pj) 2016-06-07 NICHT MEHR EINBINDEN !!!!!!!!!! KONSOLE SONST IN GEFAHR !!!!!!!!!!!
        // array(0, 'oe24.oe24.__splitArea.css.v3.console_v2'), // (pj) 2016-04-18
        array(0, 'oe24.oe24.__splitArea.css.oe2016.console'),

        array(0, 'oe24.oe24.__splitArea.css.v3.cookiesOverlay'),
        // array(0, 'oe24.oe24.__splitArea.css.v3.country'), // (pj) 2016-04-18
        // array(0, 'oe24.oe24.__splitArea.css.v3.coverbox'), // (pj) 2016-04-18
        // array(0, 'oe24.oe24.__splitArea.css.v3.font.digital-7'), // (pj) 2016-04-18
        array(0, 'oe24.oe24.__splitArea.css.v3.font.fontface'),
        array(0, 'oe24.oe24.__splitArea.css.v3.font.icomoon'),
        array(0, 'oe24.oe24.__splitArea.css.v3.font.weather'),
        array(0, 'oe24.oe24.__splitArea.css.v3.gravity'),
        // array(0, 'oe24.oe24.__splitArea.css.v3.horoskop'), // (pj) 2016-04-18
        array(0, 'oe24.oe24.__splitArea.css.v3.horoskopSigns'),
        array(0, 'oe24.oe24.__splitArea.css.v3.imageBox'),
        array(0, 'oe24.oe24.__splitArea.css.v3.imageSlideShow'),
        // array(0, 'oe24.oe24.__splitArea.css.v3.immoadsImmobilien'), // (pj) 2016-04-19
        // array(0, 'oe24.oe24.__splitArea.css.v3.lexikon'), // (pj) 2016-04-19
        array(0, 'oe24.oe24.__splitArea.css.oe2016.lexikon'), // (db) 2017-03-14
        array(0, 'oe24.oe24.__splitArea.css.v3.listbox'),
        array(0, 'oe24.oe24.__splitArea.css.v3.login'),
        array(0, 'oe24.oe24.__splitArea.css.v3.marker'),
        array(0, 'oe24.oe24.__splitArea.css.v3.marketingTeaser'),
        // array(0, 'oe24.oe24.__splitArea.css.v3.moneyKursSuche'), // (pj) 2016-04-18
        // array(0, 'oe24.oe24.__splitArea.css.v3.moneyRechner'), // (pj) 2016-04-18
        array(0, 'oe24.oe24.__splitArea.css.v3.moneyTicker'),
        array(0, 'oe24.oe24.__splitArea.css.v3.oe24TvDefaultContentBox'),
        array(0, 'oe24.oe24.__splitArea.css.v3.oe24TvShowBox'),
        array(0, 'oe24.oe24.__splitArea.css.v3.oe24TvTabbox'),
        array(0, 'oe24.oe24.__splitArea.css.v3.oe24TvTopBox'),
        // array(0, 'oe24.oe24.__splitArea.css.v3.oesterreichTeaser'), // (pj) 2016-04-19
        // array(0, 'oe24.oe24.__splitArea.css.v3.oesterreich_konsole'), // (pj) 2016-04-19
        // array(0, 'oe24.oe24.__splitArea.css.v3.pageSlider'), // (pj) 2016-04-19
        // array(0, 'oe24.oe24.__splitArea.css.v3.radiooe24playlist'), // (pj) 2016-04-19
        // array(0, 'oe24.oe24.__splitArea.css.v3.recipe'), // (pj) 2016-04-19
        array(0, 'oe24.oe24.__splitArea.css.v3.remodal.1_0_2.remodal-default-theme'),
        array(0, 'oe24.oe24.__splitArea.css.v3.remodal.1_0_2.remodal'),

        array(0, 'oe24.oe24.__splitArea.css.v3.row'),
        array(0, 'oe24.oe24.__splitArea.css.v3.row_caption'),

        // array(0, 'oe24.oe24.__splitArea.css.v3.row_topbox'), // (pj) 2016-04-19
        array(0, 'oe24.oe24.__splitArea.css.v3.search'),
        array(0, 'oe24.oe24.__splitArea.css.v3.sidebar'),
        array(0, 'oe24.oe24.__splitArea.css.v3.slickSlider.1_3_7.slick_1_3_7'),
        array(0, 'oe24.oe24.__splitArea.css.v3.slideshow'),
        array(0, 'oe24.oe24.__splitArea.css.v3.slideshowVoting'),
        // array(0, 'oe24.oe24.__splitArea.css.v3.standaloneTeaser'), // (pj) 2016-04-19
        // array(0, 'oe24.oe24.__splitArea.css.v3.storySlider'), // (pj) 2016-04-19
        array(0, 'oe24.oe24.__splitArea.css.v3.text_slideshow'),
        array(0, 'oe24.oe24.__splitArea.css.v3.themenseite'),
        // array(0, 'oe24.oe24.__splitArea.css.v3.tickerbox'), // (pj) 2016-04-19
        array(0, 'oe24.oe24.__splitArea.css.v3.user'),
        // array(0, 'oe24.oe24.__splitArea.css.v3.vBoxSingle'), // (pj) 2016-04-19
        array(0, 'oe24.oe24.__splitArea.css.v3.vbox'),
        // array(0, 'oe24.oe24.__splitArea.css.v3.videoPlayButton'), // (pj) 2016-04-19
        // array(0, 'oe24.oe24.__splitArea.css.v3.videoRelatedVideos'), // (pj) 2016-04-19
        array(0, 'oe24.oe24.__splitArea.css.v3.wetter'),
        array(0, 'oe24.oe24.__splitArea.css.v3.xml_linkbox'),
        array(0, 'oe24.oe24.__splitArea.css.oe2016.contentScrollBox'),
        array(0, 'oe24.oe24.__splitArea.css.oe2016.fremdPortalTeaser'),
        array(0, 'oe24.oe24.__splitArea.css.oe2016.sidebar'),

        array(0, 'oe24.oe24.__splitArea.css.oe2016.tabbedBoxSpecial'),
        array(0, 'oe24.oe24.__splitArea.css.oe2016.tabbedBoxWetter'),

        // (ws) 2016-06-16
        array(0, 'oe24.oe24.__splitArea.css.oe2016.tabbedBoxTeams'),

        array(0, 'oe24.oe24.__splitArea.css.oe2016.channelColors'),
        array(0, 'oe24.oe24.__splitArea.css.oe2016.marketingTeaser'),

        array(0, 'oe24.oe24.__splitArea.css.oe2016.sidebarRadioBox'),
        array(0, 'oe24.oe24.__splitArea.css.oe2016.sidebarVideoBox'),

        // (ws)
        array(0, 'oe24.oe24.__splitArea.css.oe2016.editorsComment'),
        array(0, 'oe24.oe24.__splitArea.css.oe2016.horoskop'),
        array(0, 'oe24.oe24.__splitArea.css.oe2016.standardContentBox'),
        array(0, 'oe24.oe24.__splitArea.css.oe2016.standardContentBoxFullwide'),
        array(0, 'oe24.oe24.__splitArea.css.oe2016.standardContentBoxMultipleAds'),
        array(0, 'oe24.oe24.__splitArea.css.oe2016.gruppenWidgetBoxFullwide'),
        array(0, 'oe24.oe24.__splitArea.css.oe2016.nationalteam'),
        array(0, 'oe24.oe24.__splitArea.css.oe2016.collectionChannelsList'),
        array(0, 'oe24.oe24.__splitArea.css.oe2016.sportdatenCenter'),
        array(0, 'oe24.oe24.__splitArea.css.oe2016.moneyStockSearch'),
        // (ws) end

        // (ws) 2016-04-07
        array(0, '_shared.1_0.flickity.1_2_1.flickity.flickity'),
        // (ws) 2016-04-07 end

        // (ws) 2016-04-14
        array(0, 'oe24.oe24.__splitArea.css.oe2016.standardContentSlider'),
        // (ws) 2016-04-14 end

        array(0, 'oe24.oe24.__splitArea.css.v3.theme.' . $layout),

        array(0, '_shared.1_0.tracking.oewa.oewaTracking'),

        // (bs) preparations for switch to 7.8.7.
        // array(0, '_shared.1_0.jwplayer.7_8_2.jwplayerSetup'),
        // array(0, '_shared.1_0.jwplayer.7_8_7.jwplayerSetup'),
        array(0, '_shared.1_0.jwplayer.8_0_11.jwplayerSetup'),

        // (ws) 2016-04-15 Wahl 2016
        array(0, 'oe24.oe24.__splitArea.css.v3.rl2014wahlDetailSuche'),
        array(0, 'oe24.oe24.__splitArea.css.v3.wahlergebnisse'),
        array(0, 'oe24.oe24.__splitArea.css.oe2016.bundespraesidentenwahl'),
        // (ws) 2016-04-15

        // (pj) 2016-04-18 XL-Konsole
        array(0, 'oe24.oe24.__splitArea.css.oe2016.xlKonsole'),
        array(0, 'oe24.oe24.__splitArea.css.oe2016.xlBox'),
        // (pj) 2016-04-18

        // (bs) 2016-05-18 APA Fussball Widget
        array(0, 'oe24.oe24.__splitArea.css.oe2016.apaFussballWidget'),
        // (bs) 2016-04-18

        // (pj) 2016-06-21 ie10 und ie11 conditional comments
        array(0, 'oe24.oe24.__splitArea.css.v3.ie.ie'),

        // (ws) 2016-07-11 oe24tv
        array(0, 'oe24.oe24.__splitArea.css.oe2016.oe24tv'),
        array(0, 'oe24.oe24.__splitArea.css.oe2016.oe24tvSidebarVideoBox'),
        array(0, 'oe24.oe24.__splitArea.css.oe2016.oe24tvNewsTicker'),
        // (ws) 2016-07-11


        // (ws) 2017-04-20
        array(0, 'oe24.oe24.__splitArea.css.oe2016.headerSpecialMadonna'),


        // (bs) 2016-07-12 oe24tv big top box
        array(0, 'oe24.oe24.__splitArea.css.oe2016.oe24tvTopVideoBox'),

        // (pj) 2016-10-03 oe24tv sidebar video box Article
        array(0, 'oe24.oe24.__splitArea.css.oe2016.oe24tvSidebarVideoBoxArticle'),

        // (db) 2018-01-17 oe24tv big top layer
        array(0, 'oe24.oe24.__splitArea.css.oe2016.oe24tvTopVideoLayer'),

        // (pj) 2016-08-08 Olympia Info Box auf Desktop
        array(0, 'oe24.oe24.__splitArea.css.oe2016.olympiaInfoBox'),

        // (ws) 2016-09-21 Countdown Box
        array(0, 'oe24.oe24.__splitArea.css.oe2016.oe2016countdownBox'),

        // (ws) 2016-09-22 Top Video Bar
        // array(0, 'oe24.oe24.__splitArea.css.oe2016.oe24tvTopVideoBar'),

        // (ws) 2016-10-05 Modal Dialog New Stories Overlay
        array(0, 'oe24.oe24.__splitArea.css.oe2016.newStoriesOverlay'),

        // (ws) 2016-10-14 Adventkalender
        array(0, 'oe24.oe24.__splitArea.css.v3.adventkalender'),

        // (bs) 2016-11-30 Apa Video Platform
        array(0, 'oe24.oe24.__splitArea.css.oe2016.apaVideoPlatform'),

        // (ws) 2016-12-29 Silvester Countdown
        array(0, 'oe24.oe24.__splitArea.css.oe2016.silvesterCountdown'),

        // (ws) 2017-05-11 Business Teletrader Slider
        array(0, 'oe24.oe24.__splitArea.css.oe2016.oe2016teleTraderXmlBox'),

        // (ws) 2017-05-11 Business Slider
        array(0, 'oe24.oe24.__splitArea.css.oe2016.oe2016businessSlider'),

        // (db) 2017-08-28 TV Programm Slider
        array(0, 'oe24.oe24.__splitArea.css.oe2016.oe2016tvProgrammSlider'),

        // (bs) 2017-07-06 Business Trades and Provinces Box
        array(0, 'oe24.oe24.__splitArea.css.oe2016.standardContentBoxFullwideBusiness'),

        // (ws) 2017-07-11 OE2016 Sidebar Business Insider Box
        array(0, 'oe24.oe24.__splitArea.css.oe2016.oe2016sidebarBusinessInsider'),

        // (db) 2017-05-08 Emarsys Newsletter Stuff
        array(0, 'oe24.oe24.__splitArea.css.oe2016.newsletter'),

        // (ws) 2017-05-29 Teaser Story Box
        array(0, 'oe24.oe24.__splitArea.css.oe2016.oe2016teaserStoryBox'),

        // (ws) 2017-05-29 Teaser XL Headline
        array(0, 'oe24.oe24.__splitArea.css.oe2016.oe2016xlHeadline'),

        // (bs) 2017-07-26 spunQ RelatedArticles, DAILY-825
        array(0, 'oe24.oe24.__splitArea.css.oe2016.spunQRelatedArticles'),

        // (ws) 2017-07-28
        array(0, 'oe24.oe24.__splitArea.content2017.articleDefault.articleDefault'),

        // (ws) 2017-08-03
        // array(1, 'oe24.oe24.__splitArea.css.oe2016.oe2016berufeNavigation'),
        array(0, 'oe24.oe24.__splitArea.css.oe2016.oe2016professionNavigation'),

        // (db) 2017-09-04
        array(0, 'oe24.oe24.__splitArea.css.oe2016.oe2016oe24Countdown'),

        // (ws) 2017-09-13
        array(0, 'oe24.oe24.__splitArea.css.oe2016.oe2016wahl2017ParteienStories'),

        // (ws) 2017-09-19
        array(0, 'oe24.oe24.__splitArea.css.oe2016.bundestagswahl'),

        // (db) 2017-09-21
        array(0, 'oe24.oe24.__splitArea.css.oe2016.oe2016nationalratswahl'),

        // (ws) 2017-10-11
        array(0, 'oe24.oe24.__splitArea.css.oe2016.oe2016wahlCharts'),

        // (ws) 2017-11-13
        array(1, 'oe24.oe24.__splitArea.article.slideshowVoting.slideshowVotingDesktop_321'),

        // (db) 2017-11-29
        array(0, 'oe24.oe24.__splitArea.css.oe2016.oe2016joe24ReiseAngebot'),

        // (ws) 2018-01-16
        array(0, 'oe24.oe24.__splitArea.css.oe2016.oe2016newstickerChannel'),

        // (db) 2017-12-13
        array(1, 'oe24.oe24.__splitArea.css.oe2016.adLoad'),

        // (db) 2018-01-19
        array(1, 'oe24.oe24.__splitArea.css.oe2016.olympia2018'),

        // array(0, 'oe24.oe24.__splitArea.css.oe2016.headerSpecialImmoads'),

    );
    return $css;
}


// function groupHeadCss($layout) {

//     $items = collectHeadCss($layout);

//     $prevSingleTag = 0;
//     $outputIndex = 0;
//     $output = array();

//     foreach ($items as $key => $item) {

//         if ($key > 0 && spunQ::inMode(spunQ::MODE_DEVELOPMENT)) {
//             if (1 === $item[0] || 1 === $prevSingleTag) {
//                 $outputIndex++;
//             }
//         }

//         if (!spunQ::inMode(spunQ::MODE_DEVELOPMENT) && ($key % 50) === 0) {
//             $outputIndex++;
//         }

//         $output[$outputIndex][] = $item[1];

//         $prevSingleTag = $item[0];

//     }

//     return $output;
// }


function groupHeadCss($layout) {

    $items = collectHeadCss($layout);

    $prevSingleTag = 0;
    $outputIndex = 0;
    $output = array();

    foreach ($items as $key => $item) {

        if ($key > 0 && spunQ::inMode(spunQ::MODE_DEVELOPMENT)) {
            if (1 === $item[0] || 1 === $prevSingleTag) {
                $outputIndex++;
            }
        }

        // if (!spunQ::inMode(spunQ::MODE_DEVELOPMENT) && ($key % 50) === 0) {
        //     $outputIndex++;
        // }

        $output[$outputIndex][] = $item[1];

        $prevSingleTag = $item[0];

    }

    // if (!spunQ::inMode(spunQ::MODE_DEVELOPMENT)) {
    //     $outputTemp = array_chunk($output[0], 50);
    //     // debug($outputTemp);
    //     $output = $outputTemp;
    // }

    return $output;
}
