<?
/**
 * index
 *
 * @var portal oe24.core.Portal
 * @var channel oe24.core.Channel
 * @var article any
 **/

// @var article oe24.core.Content

// Testkanaele
//
// 161423081
// http://oe24dev.oe24.at/_mobile/test/ws/smartphone?smartphone
//
// 4697926
// http://oe24dev.oe24.at/_mobile/antennesalzburg?smartphone

// ---------------------------------------------------------------

// svn status | grep -i device/smartphone | grep -v 01_* | grep -v 02_* | grep -v 03_* | grep -v 04_*

// ---------------------------------------------------------------

// ./page/mobile/channel/index.page:18:$useSmartPhoneDir = (isset($_GET['smartphone'])) ? true : false;
// ./page/mobile/slideshow.page:48:$useSmartPhoneDir = (isset($_GET['smartphone'])) ? true : false;
// ./page/mobile/article/amp_index.page:17:$useSmartPhoneDir = (isset($_GET['smartphone'])) ? true : false;
// ./page/mobile/article/index.page:19:$useSmartPhoneDir = (isset($_GET['smartphone'])) ? true : false;

// ---------------------------------------------------------------
// ---------------------------------------------------------------
// ---------------------------------------------------------------

$appDir = realpath(dirname(__FILE__));

// ---------------------------------------------------------------

// Dieser Part ist am Dev-Server notwendig, um "korrekte" Links
// waehrend der Entwicklung zu erzeugen.
// Schoen waere es, wenn man diesen Part ersatzlos streichen koennte.

// $httpHost = $_SERVER['SERVER_NAME'];
$httpHost = $_SERVER['HTTP_HOST'];

$httpHostParts = explode('.', $httpHost);
$isDevServer = ('oe24dev' == $httpHostParts[0]) ? true : false;

// $isDevServer = spunQ::inMode(spunQ::MODE_DEVELOPMENT);

// ---------------------------------------------------------------

// Die gueltigen Channel-Columns, in denen der Reihe nach Boxen
// gesucht werden. Sobald eine Spalte mit Boxen gefunden wurde,
// werden diese Boxen verwendet.

$validColumns = array(
    'Smartphone Channel',
    'Split Area 2016',
    'Mobile Column',
    // 'Split Area',
    // 'Content Area',
);

// ---------------------------------------------------------------

$pageTitle = response()->getTitle();

// ---------------------------------------------------------------

$layout = $channel->getOptions(true, true)->get('layoutOverride');
$layout = (is_string($layout) && !empty($layout)) ? $layout : 'oe24';

// ---------------------------------------------------------------
// (db) 2017-02-03 - Produktive Home-Urls basierend auf Layout

if ($isDevServer) {
    $appUrl = 'http://oe24dev.oe24.at/_mobile';
    // $appUrlQuery = '?smartphone';
    $appUrlQuery = '';
} else {
    $appUrl = 'http://m.oe24.at';
    $appUrlQuery = '';

    switch ($layout) {
        case 'sport':
            $appUrl = 'http://m.sport.oe24.at';
            break;

        case 'society':
            $appUrl = 'http://m.oe24.at/leute';
            break;

        case 'money':
            $appUrl = 'http://m.money.oe24.at/';
            break;

        case 'business':
            $appUrl = 'http://m.oe24.at/businesslive';
            break;

        case 'madonna':
            $appUrl = 'http://m.madonna.oe24.at/';
            break;

        case 'oe24tv':
            $appUrl = 'http://m.oe24.at/tv';
            break;

        case 'tv':
            $appUrl = 'http://m.oe24.at/video';
            break;

        case 'gesund24':
            $appUrl = 'http://m.gesund24.at/';
            break;

        case 'radiooe24':
            $appUrl = 'http://m.radio-ö24.oe24.at/';
            break;

        case 'advent':
            $appUrl = 'http://m.oe24.at/advent';
            break;

        case 'antenne_salzburg':
            $appUrl = 'http://m.antennesalzburg.at';
            break;

        case 'antenne_tirol':
            $appUrl = 'http://m.antennetirol.at';
            break;

        case 'reise':
            $appUrl = 'http://m.oe24.at/reise';
            break;

        case 'cooking24':
            $appUrl = 'http://m.wirkochen.at';
            break;

        case 'games24':
            $appUrl = 'http://m.oe24.at/games24';
            break;
    }
}
// (db) 2017-02-03 end

// ---------------------------------------------------------------

$navigationConfig = array(
    'header' => array(
        'menue' => 'mobil',
        'top'   => 'mobilTop',
    ),
);

$navigation = new Navigation($portal, $channel, $layout, $navigationConfig);
$navigationItems = $navigation->getAllNavigationItems();

// Weil es am Dev-Server offenbar nicht moeglich ist,
// die "korrekte" URL's zu generieren, muss ich mir leider so helfen

foreach ($navigationItems as $key => $navigationItem) {
    foreach ($navigationItem as $itemKey => $item) {
        if ($isDevServer && strpos($item['href'], 'm.oe24dev') !== false) {
            $navigationItems[$key][$itemKey]['href'] = str_replace('http://m.oe24dev.oe24.at', $appUrl, $item['href']).$appUrlQuery;
        }

    }
}

// ---------------------------------------------------------------

if (!is_string($pageTitle)) {
    $pageTitle = 'oe24';
    // debug('Invalid pageTitle');
}

if (!is_array($navigationItems)) {
    $navigationItems = array();
    // debug('Invalid navigationItems');
}

if (!is_string($layout)) {
    $layout = 'oe24';
    // debug('Invalid layout');
}

// ---------------------------------------------------------------

// // zwecks Test - kann später auskommentiert werden bzw. geloescht

// $testLayoutsForDebugging = array(
//     'oe24',
//     'sport',
//     'society',
//     'tv',
//     'radiooe24',
//     'madonna',
// );

// // if ($isDevServer && isset($_GET['layout']) && in_array($_GET['layout'], $testLayoutsForDebugging)) {
// //     $layout = $_GET['layout'];
// // }

// if (isset($_GET['layout']) && in_array($_GET['layout'], $testLayoutsForDebugging)) {
//     $layout = $_GET['layout'];
// }

// // zwecks Test Ende

// ---------------------------------------------------------------

$deviceType = Device::SMARTPHONE;

// ---------------------------------------------------------------

$emptyImage1x1   = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABAQAAAAA3bvkkAAAAAnRSTlMAAQGU/a4AAAAKSURBVHgBY2gAAACCAIFMF9ffAAAAAElFTkSuQmCC';
$emptyImage2x1   = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAIAAAABAQAAAADcWUInAAAAAnRSTlMAAQGU/a4AAAAKSURBVHgBYzgAAADCAMFphPI4AAAAAElFTkSuQmCC';
$emptyImage16x9  = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAJAQAAAAATUZGfAAAAAnRSTlMAAQGU/a4AAAANSURBVHgBY/j/HxcCAPIoEe+JMKgiAAAAAElFTkSuQmCC';
$emptyImage16x10 = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAKAQAAAACVxeMxAAAAAnRSTlMAAQGU/a4AAAANSURBVHgBY/j/Hw8CACsBE+1t+fJZAAAAAElFTkSuQmCC';

// ---------------------------------------------------------------

$isArticle = ($article && $article instanceof TextualContent);

// ---------------------------------------------------------------

// Eventuell aus Backend initialisieren?
$useChartBeat = !($isDevServer);

// ---------------------------------------------------------------

$outbrainOverrides = array(
    'oe24',
    'society',
    'sport',
    'gesund24',
    'madonna',
    'cooking24',
    'money',
    'business',
    'games24',
);

$options = ($isArticle) ? $article->getOptions(true, true) : $channel->getOptions(true, true);
$showOutbrain = $options->get('hideOutbrain') ? false : true;
$showOutbrainOverlay = false;

// (bs) im Channel gibts eh kein Outbrain ?!
if ($isArticle && in_array($layout, $outbrainOverrides)) {
    $showOutbrainOverlay = true && $showOutbrain;
    $showOutbrain = true && $showOutbrain;
}

// (bs) ob der TvTeaser wegen Facebook-Referer ausgespielt wird, muss leider auch hier gecheckt werden,
// da die articleOutbrain.tpl vor dem facebookReferrerTvTeaser.tpl ausgespielt wird.

$requestHeaders = request()->getHeaders();
$referer = $requestHeaders['Referer'];
// for testing:
// $referer = 'www.facebook.com';


$rc = preg_match("/(.)*(\.(facebook|fb)\.com)(.)*/", $referer, $match);

$showTvTeaser = false;
$showTvTeaser = ((1 === $rc) && (is_array($match) && isset($match[0]) && $match[0] === $referer)) ? true : false;
if ($showTvTeaser) {
    $showOutbrainOverlay = false;
}

// (bs) 2017-11-20 fb teaser soll auf allen Artikeln ausser Tv ausgespielt werden.
if ($layout != 'tv') {
    $showTvTeaser = true;
    $showOutbrainOverlay = false;
}

if ($isArticle) {
    $videos = $article->getRelatedVideos();
    if ($videos && !empty($videos)) {
        $showTvTeaser = false;
        $showOutbrainOverlay = true;
    }

    $oe24App = request()->getGetValues()->get('oe24App');
    if ($oe24App) {
        $showTvTeaser = false;
    }

}

// ---------------------------------------------------------------

$validSportLayouts = array(
    'sport',
    'sport_euro2016',
);

// ---------------------------------------------------------------


$adSlotOptions = $options;
$aditionAdTags = $adSlotOptions->get('AditionAdTags');
$adSlotJson = $adSlotOptions->get('AditionAdSlots');

$adSlotArray = array();
$adSlotArray = json_decode($adSlotJson, true);

$adSlotsFiltered = array();
if (!$adSlotArray) {
    $adSlotArray = array();
}

foreach ($adSlotArray as $key => $adSlot) {

    if (!isset($adSlot['banner']) || strpos($adSlot['banner'], 'Mobile') !== 0) {
        continue;
    }

    if  ( ($isArticle  && isset($adSlot['artikel']) && $adSlot['artikel'] === true) ||
        (!($isArticle) && isset($adSlot['channel']) && $adSlot['channel'] === true)) {

        $aditionTag = (str_replace(array(')', '(', ' '), '', $adSlot['banner']));

        $adSlotsFiltered[$aditionTag] = array(
            'id'     => isset($adSlot['id']) ? $adSlot['id'] : 0,
            'reload' => isset($adSlot['reload']) ? $adSlot['reload'] : 0,
        );

        if (strpos($adSlot['banner'], 'Mobile Keywords') === 0) {
            if (isset($adSlot['keyword'])) {
                $adSlotsFiltered[$aditionTag]['keyword'] = $adSlot['keyword'];
            } else {
                unset($adSlotsFiltered[$aditionTag]);
            }
        }

    }

}



// ---------------------------------------------------------------


$config = array(

    'appDir'            => $appDir,
    'appUrl'            => $appUrl,
    'appUrlQuery'       => $appUrlQuery,
    'validColumns'      => $validColumns,

    'isDevServer'       => $isDevServer,

    'deviceType'        => $deviceType,

    'portal'            => $portal,
    'channel'           => $channel,
    'article'           => $article,
    'pageTitle'         => $pageTitle,
    'layout'            => $layout,

    'navigationItems'   => $navigationItems,

    'useChartBeat'      => $useChartBeat,
    'showOutbrain'      => $showOutbrain,
    'validSportLayouts' => $validSportLayouts,
    'adSlots'           => $adSlotsFiltered,
    'showAds'           => $aditionAdTags,
    'showOutbrain'      => $showOutbrain,
    'showOutbrainOverlay' => $showOutbrainOverlay,
    'showTvTeaser'      => $showTvTeaser,

    'emptyImages'     => array(
        'emptyImage1x1'   => $emptyImage1x1,
        'emptyImage2x1'   => $emptyImage2x1,
        'emptyImage16x9'  => $emptyImage16x9,
        'emptyImage16x10' => $emptyImage16x10,
    ),

    // Google Tag Manager
    // https://www.google.com/intl/de/tagmanager/
    // https://developers.google.com/tag-manager/
    'googleContainerId' => 'GTM-XXXX', // TODO: "echte" ID einsetzen

    // (db) 2017-03-03 Zähler für Übersichtsbilder -> die ersten sollen sofort (src) ausgespielt werden, spätere mit LazyLoad
    'boxImageCounter'   => 0,
);

// ---------------------------------------------------------------

try {

    $deviceContainer = DeviceContainer::initialize($config);
    $device = DeviceContainer::getDevice(Device::SMARTPHONE);
    $device->processDevice();

} catch (DeviceInitialisationException $e) {

    error('DeviceInitialisationException in `'.$e->getFile().' Zeile '.$e->getLine().'` wurde ausgeloest: `'.$e->getMessage().'`');
    return;

} catch (Exception $e) {

    error('Allgemeine Exception in `'.$e->getFile().' Zeile '.$e->getLine().'` wurde ausgeloest: `'.$e->getMessage().'`');
    return;
}

// ---------------------------------------------------------------
// TODO den switch block - brauchen wir nicht mehr !
switch (true) {

    case $device instanceof Smartphone:
        tpl('oe24.oe24.device.smartphone.tpl.page', array('device' => $device));
        break;

    default:
        break;
}

// ---------------------------------------------------------------
