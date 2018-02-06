<?php
/**
 * Mobile Teaser oe24TV
 *
 * @var channel oe24.core.Channel
 * @var box oe24.core.ContentBox
 **/

// TASK-ID: NPORT-51

// tpl/_contentBoxes/mobileTeaserOe24Tv.tpl
// tpl/device/smartphone/tpl/contentBox/mobileTeaserOe24Tv/mobileTeaserOe24Tv.tpl
// tpl/device/smartphone/tpl/contentBox/mobileTeaserOe24Tv/mobileTeaserOe24Tv.js
// tpl/device/smartphone/tpl/contentBox/mobileTeaserOe24Tv/mobileTeaserOe24Tv.css

// Am Produktions-Server: Alte Box ID: 259789947
// Am Produktions-Server: Neue Box ID: 273862327

// Am Development-Server: Neue Box ID: 161583089


// ------------------------------------

// (ws) 2018-01-30
// Niki Anforderung: Box aus den Artikeln rausnehmen

$device = DeviceContainer::getDevice();
$configArticle = $device->getConfig('article');
$isArticle = (null == $configArticle) ? false : true;

if ($isArticle) {
    return;
}

// ------------------------------------

// (ws) 2018-01-30
// Niki Anforderung:
// Box soll NUR auf der Startseite (frontpage) gezeigt werden
// Development-Server frontpage ID: 2846
// Produktions-Server frontpage ID: 2846

$httpHost = $_SERVER['HTTP_HOST'];
$httpHostParts = explode('.', $httpHost);
$isDevServer = ('oe24dev' == $httpHostParts[0]) ? true : false;

$validChannelIdsDev = array(
    2846, // /frontpage
    2849, // /welt (zwecks Test)
    161632987, // /test/ws/smartphone/cookiesOverlay (zwecks Test)
);

$validChannelIdsProd = array(
    2846,
);

$validChannels = ($isDevServer) ? $validChannelIdsDev : $validChannelIdsProd;

$channelId = $channel->getId();

if ( ! in_array($channelId, $validChannels)) {
    return;
}

// ------------------------------------


// in 'tv'-channels mobile-Teaser nicht andrucken

$channelOptions = $channel->getOptions();
$channelLayoutOverride = $channelOptions->get('layoutOverride');
$channelLayoutOverride = (mb_strlen($channelLayoutOverride)) ? $channelLayoutOverride : 'oe24';

// (db) 2017-07-03 mobile Teaser bei Madonna nicht andrucken
// (db) 2017-07-20 mobile Teaser bei Business nicht andrucken
// (db) 2017-07-21 tv nur noch bei oe24 andrucken
$allowTV = array(
    'oe24',
);

if ( !in_array($channelLayoutOverride, $allowTV) ) {
    return;
}

$templateOptions = $box->getTemplateOptions();

$autoplay = $templateOptions->get('Autoplay');
$autoplay = ($autoplay) ? true : false;
$autoplay = ('tv' == $channelLayoutOverride) ? false : $autoplay;

$setMuted = $templateOptions->get('Ton-Aus');
$setMuted = ($setMuted) ? true : false;
$setMuted = ('tv' == $channelLayoutOverride) ? true : $autoplay;

$volume = $templateOptions->get('Lautstärke');
$volume = (ctype_digit($volume) && $volume >= 0 && $volume <= 99) ? $volume : 0;
$volume = ('tv' == $channelLayoutOverride) ? 0 : $volume;

$teaserIsCollapsed = ('tv' == $channelLayoutOverride) ? 'collapsed' : '';

// --------------------------------------------------------

$imageFormat = '190x95Crop';

// --------------------------------------------------------

$stories = $box->getContentOfAllDropAreas();
if ( (count($stories) <= 0) || (false == isset($stories[0])) || (false == ($stories[0] instanceof Video)) ) {
    return;
}

$story = $stories[0];

$preTitle = trim($story->getPreTitle(true, $box));
$title = trim($story->getTitle(true, $box));

$image = $story->getFirstRelatedImage();
$src = $image->getFileUrl($imageFormat);

$linkAttr = getContentUrlAttributesArray($story, $box, true, true, true);
$href = (isset($linkAttr['href']) && is_string($linkAttr['href'])) ? $linkAttr['href'] : '#!';
$target = (isset($linkAttr['target']) && is_string($linkAttr['target']) && '' != $linkAttr['target']) ? 'target="'.$linkAttr['target'].'"' : '';

// --------------------------------------------------------

$urlInfo = parse_url($href);

if ('m.oe24dev.oe24.at' == $urlInfo['host']) {
    $urlInfo['host'] = 'oe24dev.oe24.at/_mobile';
}

// $href = $urlInfo['scheme'].'://'.$urlInfo['host'].$urlInfo['path'];
$href = $urlInfo['scheme'].'://'.$urlInfo['host'].'/tv';

// --------------------------------------------------------

if (spunQ::inMode(spunQ::MODE_DEVELOPMENT)) {
    $videoId = 161573764;
} else {
    $videoId = 251215975;
}

$video = db()->getById($videoId, 'oe24.core.Video');

// --------------------------------------------------------

// (ws) 2016-12-20
// $source_m3u8 = 'http://apasfoe24l.sf.apa.at/ipad/oe24-live1/oe24.sdp_240p/playlist.m3u8';
// $source_mpd  = 'http://apasfoe24l.sf.apa.at/dash/oe24-live1/oe24.sdp_240p/manifest.mpd';

// (ws) 2016-12-21
// $source_m3u8 = 'http://apasfoe24l.sf.apa.at/ipad/oe24-live1-lq/oe24.sdp_240p/playlist.m3u8';
// $source_mpd  = 'http://apasfoe24l.sf.apa.at/dash/oe24-live1-lq/oe24.sdp_240p/manifest.mpd';

// (ws) 2017-03-15
// HLS
$sourceHLS = 'http://apasfoe24l.sf.apa.at/ipad/oe24-live1-lq/oe24.sdp/playlist.m3u8';
// DASH
$sourceDASH = 'http://apasfoe24l.sf.apa.at/dash/oe24-live1-lq/oe24.sdp/manifest.mpd';

// Low Quality HLS-Source
$video->setVideoId($sourceHLS);
$video->setFilename($sourceHLS);

// --------------------------------------------------------

$tplName = '_shared.1_0.jwplayer.jwplayerSetupProxy';

// --------------------------------------------------------

?>

<div class="mobileTeaserOe24Tv <?= $teaserIsCollapsed; ?>">


    <? if (1): ?>

        <a class="teaserLink clearfix" href="<?= $href; ?>" <?= $target; ?> >


            <div class="teaserText">
                <? if (!empty($preTitle)): ?>
                    <span class="teaserPreTitle"><?= $preTitle; ?></span>
                <? endif; ?>
                <? if (!empty($title)): ?>
                    <span class="teaserTitle"><?= $title; ?></span>
                <? endif; ?>
            </div>


            <? if (1): ?>
                <div class="teaserFigure">
                    <? if ($autoplay): ?>
                        <?
                            tpl($tplName, array(
                                'video'     => $video,
                                'autostart' => $autoplay,
                                'setMuted'  => $setMuted,
                                'events'    => array(),
                                'params'    => array(
                                    'volume'            => $volume,
                                    'showRelatedVideos' => false,
                                    'showReplayButton'  => false,
                                    'controls'          => false,
                                    'channel'           => $channel,
                                    'customId'          => 'mobileTeaserOe24TvCustom',
                                ),
                            ));
                        ?>
                    <? else: ?>
                        <img src="<?= $src; ?>" alt="">
                    <? endif; ?>
                </div>
            <? endif; ?>


        </a>

    <? endif; ?>


    <? if (1): ?>

        <a class="teaserControl" href="#">

            <div class="teaserIcon">

                <? if (1): ?>
                <div class="teaserIconCross">
                    <svg viewBox="0 0 30 30">
                        <path d="M4,4 L26,26" stroke-width="4" />
                        <path d="M4,26 L26,4" stroke-width="4" />
                    </svg>
                </div>
                <? endif; ?>

                <? if (1): ?>
                <div class="teaserIconPlus">
                    <svg viewBox="0 0 30 30">
                        <path d="M4,15 L26,15" stroke-width="4" />
                        <path d="M15,4 L15,26" stroke-width="4" />
                    </svg>
                </div>
                <? endif; ?>

            </div>

        </a>

    <? endif; ?>


</div>

<?

// Mail Donnerstag, 16. Februar 2017 um 16:15

// Wenn URL mit GET Parameter:

// m.oe24.at/?app[ios]=v1
// document.cookie = 'isApp=ios;domain=oe24.at;path=/;';

// Wenn Cookie:

// document.cookie = 'is_ios_app=true;domain=oe24.at;path=/;';
// document.cookie = 'is_android_app=true;domain=oe24.at;path=/;';

// wird die jeweilige ÖWA App Logik ausgeführt!

// LG, Georg

// Zwecks Test

// PHP
// $appOs = isset($_GET['app']['ios']) ? 'ios' : 'android';
// $appOs = isset($_GET['app']['bnApp']) ? 'bnApp' : $appOs;

// JavaScript
// var cookieTTL = (new Date()).getTime() + 365 * 24 * 60 * 60 * 1000;
// document.cookie = 'isApp=<?= $appOs ?##>;domain=oe24.at;path=/;expires=' + new Date(cookieTTL).toGMTString();
// console.log(document.cookie);

// Zwecks Test Ende

?>

<script>

var mobileTeaserOe24TvInit = function() {

    // Fuer iPhones mit iOS Version < 10 gilt:
    // Es wird der "native" Player fuer Videos gestartet, daher wird
    // mit Einverstaendnis von Niki die TV-Teaser Box nicht eingeblendet

    // ACHTUNG: Google Chrome Version 58.0.3029.110 (64-bit) gibt sich
    // im Device-Modus als iPhone/iPad mit Major-Version 9 aus.
    // Dadurch wird die Box im Chrome Browser NICHT gezeigt.

    var iosVersion = iOSVersion();

    if (false !== iosVersion && iosVersion < 10) {
        return;
    }

    var navigationMain = document.querySelector('.smartphone .navigationMain');
    var footer = document.querySelector('.smartphone .wrapper .footer');

    var teaser = document.querySelector('.smartphone .mobileTeaserOe24Tv');
    var teaserControl = teaser.querySelector('.teaserControl');
    var teaserClassName = teaser.className;

    var teaserLink = teaser.querySelector('.teaserLink');
    var teaserLinkHref = teaserLink.getAttribute('href');

    var teaserFigure = teaser.querySelector('.teaserFigure');
    var teaserFigureClassName = teaserFigure.className;

    // var teaserPlayer = jwplayer();
    var teaserPlayer = jwplayer('mobileTeaserOe24TvCustom');
    var teaserPlayerState = null;

    var playList = teaserPlayer.getPlaylist();

    var cookieIsApp = isAppForMobileTeaser();
    var cookieMobileTeaserOe24Tv = getCookie('mobileTeaserOe24Tv');

    var channelLayout = '<?= $channelLayoutOverride; ?>';
    // ----------------------------------------------------------

    // 1) true  -> Soll der per Cookie festgehaltene Zustand der Box ("collapsed" oder "expanded") wieder hergestellt werden?
    // 2) false -> Soll die Box beim laden der Seite immer geoeffnet ("expanded") werden?
    // TODO: Modus 2) muss noch getestet werden!!!
    var useCookieAtStartup = false;

    // ----------------------------------------------------------

    if (null === teaser) {
        return;
    }

    if (cookieIsApp) {
        teaser.style.display = 'none';
        teaserPlayer.stop();
        return;
    }

    // ----------------------------------------------------------

    teaser.style.display = 'block';

    if (null !== navigationMain) {
        navigationMain.style.paddingBottom = '150px';
    }

    if (null !== footer) {
        footer.style.padding = '3px 5% 150px';
    }

    // ----------------------------------------------------------

    function teaserCollapse() {
        teaser.className = teaserClassName + ' collapsed';
        teaserPlayerState = teaserPlayer.getState();
        if ('paused' !== teaserPlayerState) {
            // teaserPlayer.pause(true);
            playList = teaserPlayer.getPlaylist();
            teaserPlayer.stop();
        }
    }

    function teaserExpand() {
        teaser.className = teaserClassName;
        teaserPlayerState = teaserPlayer.getState();
        if ('playing' !== teaserPlayerState) {
            teaserPlayer.load(playList);
            teaserPlayer.play(true);
        }
    }

    function startUp() {

        if (useCookieAtStartup) {
            if ('collapsed' === cookieMobileTeaserOe24Tv) {
                teaser.className = teaserClassName + ' collapsed';
                teaserCollapse();
            } else {
                teaser.className = teaserClassName;
                teaserExpand();
            }
        } else {
            if ('tv' == channelLayout) {
                // channel 'tv' nicht aktivieren
                teaserCollapse();
            }
            else{
                // Box wird bei JEDEM Laden der Website "expanded"
                teaserExpand();
            }
        }
    }

    // ----------------------------------------------------------

    // startUp();

    function teaserLoadHandler() {
        // ...
        startUp();
    }

    window.addEventListener('load', function(e) {
        teaserLoadHandler();
    });

    // ----------------------------------------------------------

    function teaserTouchEndHandler(e) {
        var state = teaserPlayer.getState();
        var idTimeout = setTimeout(function() {
            teaserPlayer.play(true);
            clearTimeout(idTimeout)
        }, 750);
    }

    window.addEventListener('touchend', teaserTouchEndHandler, false);

    // ----------------------------------------------------------

    function teaserClickHandler(e) {
        if (Utilities.hasClass(teaser, 'collapsed')) {
            teaser.className = teaser.className.replace(' collapsed', '');
            setCookie('mobileTeaserOe24Tv', 'expanded', 365);
            teaserExpand();
        } else {
            teaser.className = teaserClassName + ' collapsed';
            setCookie('mobileTeaserOe24Tv', 'collapsed', 365);
            teaserCollapse();
        }
    }

    teaserControl.addEventListener('click', function(e) {
        e.preventDefault();
        teaserClickHandler(e);
    });

    // ----------------------------------------------------------

    // https://developer.jwplayer.com/jw-player/docs/javascript-api-reference/

    // teaserPlayer.on('play', function(e) {
    //     console.log('play', teaserPlayer.getState());
    // });

    // teaserPlayer.on('pause', function(e) {
    //     console.log('pause', teaserPlayer.getState());
    // });

    // teaserPlayer.on('buffer', function(e) {
    //     console.log('buffer', teaserPlayer.getState());
    // });

    // teaserPlayer.on('idle', function(e) {
    //     console.log('idle', teaserPlayer.getState());
    // });

    // teaserPlayer.on('complete', function(e) {
    //     console.log('complete', teaserPlayer.getState());
    // });

    // teaserPlayer.on('firstFrame', function(e) {
    //     console.log('firstFrame', teaserPlayer.getState());
    // });

    // teaserPlayer.on('error', function(e) {
    //     console.log('error', teaserPlayer.getState());
    // });

    // teaserPlayer.on('all', function(e) {
    //     console.log('all', teaserPlayer.getState());
    //     // console.log(e);
    // });

    // ----------------------------------------------------------

    // http://stackoverflow.com/questions/38910235/detect-ios-version
    // modified (ws)

    function iOSVersion() {

        if (window.MSStream) {
            // There is some iOS in Windows Phone...
            // https://msdn.microsoft.com/en-us/library/hh869301(v=vs.85).aspx
            return false;
        }

        var match = (navigator.appVersion).match(/OS (\d+)_(\d+)_?(\d+)?/);
        var majorVersion = 0;

        if (match !== undefined && match !== null) {
            majorVersion = parseInt(match[1], 10);
            return majorVersion;
        }

        return false;
    }

    // function iOSVersion() {

    //     if (window.MSStream) {
    //         // There is some iOS in Windows Phone...
    //         // https://msdn.microsoft.com/en-us/library/hh869301(v=vs.85).aspx
    //         return false;
    //     }

    //     var match = (navigator.appVersion).match(/OS (\d+)_(\d+)_?(\d+)?/);
    //     var version;

    //     if (match !== undefined && match !== null) {
    //         version = [
    //             parseInt(match[1], 10),
    //             parseInt(match[2], 10),
    //             parseInt(match[3] || 0, 10)
    //         ];
    //         return parseFloat(version.join('.'));
    //     }

    //     return false;
    // }

    // ----------------------------------------------------------

    teaserPlayer.on('displayClick', function(e) {
        window.location.href = teaserLinkHref;
    });

}

functionQueue.add(mobileTeaserOe24TvInit);

</script>
