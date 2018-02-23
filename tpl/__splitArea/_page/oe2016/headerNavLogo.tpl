<?php
/**
 * The header template for the oe24 project.
 *
 * @var channel oe24.core.Channel
 * @var layout string
 * @var navMainLink string
 */

// --------------------------------------------------------------

// $logoPortal = '/images/oe2016/logo-oe24-215x68.svg';
$logoPortal = '/images/oe2016/logo-oe24.svg';
$portalString = 'Das Internet-Portal von';
$logoOesterreich = '/images/oe2016/logo-oesterreich-504x68.svg';
$latestCover = 'http://file.oe24.at/tz-cover/epaper_320x437.jpg';
$latestCoverUrl = 'https://www.epaper-oesterreich.at/shelf.act?filter=CITYW';

// ACHTUNG: PNG's durch SVG ersetzen
switch ($layout) {

    case 'sport':
        // $logoPortal = '/images/rl2014/logo/logo_sport.png';
        $logoPortal   = '/images/oe2016/logo-sport24.svg';
        $portalString = 'Das Sport-Portal von';
        break;

    case 'sport_euro2016':
        $logoPortal   = '/images/oe2016/logo-sport24.svg';
        $portalString = 'Das Sport-Portal von';
        break;

    case 'tv':
    case 'tv2016':
        // $logoPortal = '/images/rl2014/logo/logo_tv.png';
        // $logoPortal   = '/images/oe2016/logo-oe24tv.svg';
        // $logoPortal   = '/images/oe2016/logo-oe24TV_v2.svg';
        $logoPortal   = '/images/oe2016/logo-oe24TV_v3.svg';

        if (strpos($channel->getUrl(), 'oe24.at/tv/werbung') !== false) {
            $logoPortal = '';
        }

        // $portalString = 'Das Fernseh-Portal von';
        $showTvLive = true;
        $logoTvLive = '/images/oe2016/logo-tv-live.png';
        $logoTvLiveUrl = 'http://www.oe24.at/tv/news/oe24-TV-Der-24-Stunden-News-Sender/251215975';
        break;

    case 'radiooe24':
        $logoPortal   = '/images/oe2016/logo-radiooe24.svg';
        $portalString = 'Der Radio-sender von';
        break;

    case 'society':
        // $logoPortal = '/images/oe2016/logo-stars24.svg';
        $logoPortal   = '/images/oe2016/logo-stars24_v2.svg';
        $portalString = 'Das Society-Portal von';
        // $navMainLink = 'http://www.oe24.at/leute';
        $navMainLink = '/leute';
        break;

    case 'advent':
        $logoPortal   = '/images/oe2016/logo-oe24.svg';
        $portalString = 'Das Internet-Portal von';
        $logoPortal   = '/images/rl2014/logo/logo_advent.png';
        $logoPortal   = '/images/oe2016/logo-advent24.png';
        // $portalString = 'Advent auf';
        break;

    // (pj) 2016-11-21 Antenne Salzburg
    case 'antenne_salzburg':
        $logoPortal   = '/images/layout/antenne/logo_salzburg.jpg';
        $portalString = '';
        $logoOesterreich = '/images/layout/antenne/slogan_salzburg.png';
        $navMainLink = 'http://antennesalzburg.oe24.at/';
        break;
    // (pj) 2016-11-21 end

    // (mh) 2016-11-29 Antenne Tirol
    case 'antenne_tirol':
        $logoPortal   = '/images/layout/antenne/logo_tirol.jpg';
        $portalString = '';
        $logoOesterreich = '/images/layout/antenne/slogan_tirol.png';
        $navMainLink = 'http://antennetirol.oe24.at/';
        break;
    // (mh) 2016-11-29 end

    // (bs) 2017-02-03 DAILY-664 Joe24
    case 'reise':
        $logoPortal   = '/images/oe2016/logo-reise24.svg';
        $portalString = 'Das Reiseportal von';
        // $logoOesterreich = '/images/layout/antenne/slogan_tirol.png';
        $navMainLink = 'http://j.oe24.at/';
        break;
    // (bs) end

    case 'money':
        $logoPortal   = '/images/oe2016/logo-money.svg';
        $portalString = 'Das Wirtschafts-Portal von';
        $navMainLink = 'http://money.oe24.at/';
        break;

    case 'business':
        $logoPortal   = '/images/oe2016/logo-business.svg';
        $logoPortalLive = '/images/oe2016/logo-business-live.svg';
        $portalString = 'Das Wirtschaftsportal von';
        $navMainLink = 'http://www.oe24.at/businesslive';
        break;

    // (ws) 2017-02-15
    case 'meinauto24':
        $logoPortal   = '/images/oe2016/logo-meinAuto24.svg';
        $portalString = ''; //'Das Auto-Portal von';
        $navMainLink = 'http://www.meinauto24.at/';
        break;

    // (db) 2017-03-09
    case 'gesund24':
        // $logoPortal = '/images/rl2014/logo/logo_gesund24.png';
        $logoPortal = '/images/oe2016/logo-gesund24.svg';
        $portalString = 'Das Gesundheits-Portal von';
        $navMainLink = 'http://www.gesund24.at/';
        break;

    // (db) 2017-03-16
    case 'cooking24':
        // $logoPortal = '/images/rl2014/logo/logo_cooking24.png';
        $logoPortal = '/images/oe2016/logo-cooking24.svg';
        $portalString = 'Das Koch-Portal von';
        $navMainLink = 'http://www.wirkochen.at/';
        break;

    case 'games24':

        // $logoPortal = '/images/oe2016/logo-games24.svg';
        $logoPortal = '/images/oe2016/logo-games24-v2.svg';

        // Anstelle des "Oesterreich-Logos" soll das "oe24-Logo gezeigt werden"
        $logoOesterreich = '/images/oe2016/logo-oe24.svg';

        $portalString = 'Das Gaming-Portal von';

        // $navMainLink = 'http://games24.oe24.at/';
        $navMainLink = 'http://www.oe24.at/games24/';

        $navOesterreichLogoLink = 'http://www.oe24.at/';

        break;

    default:
        // $logoPortal = '/images/oe2016/logo-oe24-215x68.svg';
        $logoPortal   = '/images/oe2016/logo-oe24.svg';
        $portalString = 'Das Internet-Portal von';
        break;
}

// --------------------------------------------------------------

// $showLogoOesterreich = ('sport_euro2016' != $layout) ? true : false;
$noLogoOesterreichLayouts = array(
    'sport_euro2016',
    'tv',
    // 'madonna',
);

$showLogoOesterreich = true;
if (in_array($layout, $noLogoOesterreichLayouts)) {
    $showLogoOesterreich = false;
}

// --------------------------------------------------------------

$noLatestCoverLayouts = array(
    'tv',
    'antenne_salzburg',
    'antenne_tirol',
    // 'madonna',
    'games24',
);

$showLatestCover = true;
if (in_array($layout, $noLatestCoverLayouts)) {
    $showLatestCover = false;
}

// MH 20161206 No link to Österreich.at for antenne
$nowOesterreichHref = array(
    'antenne_salzburg',
    'antenne_tirol',
);
$showOesterreichHref = true;
if (in_array($layout, $nowOesterreichHref)) {
    $showOesterreichHref = false;
}


// --------------------------------------------------------------

// Das games24-Portal zeigt anstatt des Oestereich-Logos das oe24-Logo, deshalb soll auch die URL eine andere sein
$navOesterreichLogoLink = (!isset($navOesterreichLogoLink)) ? 'http://www.österreich.at' : $navOesterreichLogoLink;

// --------------------------------------------------------------

// (ws) 2016-06-02 (Special -> additionalClass added)
// Bei der Euro 2016 soll die Header-Farbe die vom Sport-Kanal sein,
// Das "ÖSTERREICH"-Logo nicht gezeigt werden, dafuer der Schriftzug
// "EURO 2016" wie im Euro2016-Kanal
//MH 20161206 Keine Verlinkung auf Österreich bei Antenne Salzburg und Tirol
$additionalClass = ''; // ('sport' == $layout) ? 'specialEventEuro2016' : '';

// --------------------------------------------------------------

?>

<div class="headerNavLogo clearfix">


    <div class="headerNavLogoCol logoPortal">
        <a href="<?= $navMainLink; ?>">
            <img src="<?= $logoPortal; ?>" alt="">
        </a>
    </div>


    <? if (0 && 'sport_euro2016' == $layout && is_string($logoEuro2016) && !empty($logoEuro2016)): ?>
    <div class="headerNavLogoCol logoEuro2016">
        <a href="http://sport.oe24.at/fussball/euro-2016">
            <img src="<?= $logoEuro2016; ?>" alt="">
        </a>
    </div>
    <? endif; ?>


    <?
    // (ws) 2016-06-02 (Special -> additionalClass added)
    if ('sport_euro2016' == $layout || (isset($additionalClass) && !empty($additionalClass))) {
        // Logo oder Text fuer die Euro 2016
        tpl('oe24.oe24.__splitArea._page.oe2016.headerNavLogoEuro2016', array());
    }
    ?>



    <? if ('business' == $layout): ?>
    <div class="headerNavLogoCol logoLive">
        <a href="<?= $navMainLink; ?>">
            <img src="<?= $logoPortalLive; ?>" alt="">
        </a>
    </div>
    <? endif; ?>



    <? if (('business' != $layout) && $showLogoOesterreich): ?>

    <? // (ws) 2016-06-02 (Special -> additionalClass added) ?>
    <div class="headerNavLogoCol logoOesterreich <?= (isset($additionalClass) && !empty($additionalClass)) ? $additionalClass : ''; ?>">

        <? if (isset($portalString) && is_string($portalString) && !empty($portalString)): ?>
        <span><?= $portalString; ?></span>
        <? endif; ?>

        <? if ($showOesterreichHref): ?>
            <a href="<?= $navOesterreichLogoLink; ?>" target="_blank">
                <img src="<?= $logoOesterreich; ?>" alt="">
            </a>
        <? else: ?>
            <img src="<?= $logoOesterreich; ?>" alt="">
        <? endif; ?>

    </div>

    <? endif; ?>



    <? if ('business' == $layout): ?>

        <div class="headerNavLogoCol logoOesterreich <?= (isset($additionalClass) && !empty($additionalClass)) ? $additionalClass : ''; ?>">
            <a href="<?= $navOesterreichLogoLink; ?>" target="_blank">
                <span><?= $portalString; ?></span>
                <img src="<?= $logoOesterreich; ?>" alt="">
            </a>
        </div>

    <? endif; ?>



    <? if ($showLatestCover): ?>

    <div class="headerNavLogoCol latestCover">
        <a href="<?= $latestCoverUrl; ?>" target="_blank">
            <img src="<?= $latestCover; ?>" alt="">
        </a>
    </div>

    <? endif; ?>


    <? // (ws) 2016-09-19 ?>
    <? if (isset($showTvLive) && true == $showTvLive && isset($logoTvLive) && is_string($logoTvLive) && !empty($logoTvLive)): ?>

        <div class="headerNavLogoCol oe24TvLive">
            <a href="<?= (isset($logoTvLiveUrl) && is_string($logoTvLiveUrl) && !empty($logoTvLiveUrl)) ? $logoTvLiveUrl : '#!'; ?>">
                <img src="<?= $logoTvLive; ?>" alt="">
            </a>
        </div>

    <? endif; ?>


</div>
