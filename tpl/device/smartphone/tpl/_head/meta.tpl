<?
/**
 * _pageHead meta
 */

$device = DeviceContainer::getDevice();

$channel = $device->getConfig('channel');
$article = $device->getConfig('article');

// --------------------------------------------------

$layout = $device->getConfig('layout');
$channelOptions = $channel->getOptions(false, true);

switch ($layout) {
    case 'oe24':
    case 'sport':
    case 'sport_euro2016':
    case 'society':
        $appleStoreId = $channelOptions->get('AppStoreID');
        break;

    default:
        $appleStoreId = '';
        break;
}

// --------------------------------------------------

$isArticle = (null != $article);
$tags = array();

if ($isArticle) {

    $ogDescription = $article->getLeadText(true);
    $ogImage = $article->getFirstRelatedImage();

    $ogImageUrl = null;
    if ($ogImage) {
        $ogImageUrl = $ogImage->getFileUrl('consoleMadonnaNoStretch2');
    }

    $tags = $article->getTags();
}

// --------------------------------------------------

$robotIndex = ($isArticle) ? $article->getOptions(false, true)->get('robotIndex') : $channelOptions->get('robotIndex');

// --------------------------------------------------

// URL HANDLING

if ($isArticle) {
    $desktopUrl = $article->getUrl();
} else {
    $desktopUrl = $channel->getUrl();
}

$host = parse_url($desktopUrl, PHP_URL_HOST);

if (count(explode('.', $host)) > 3) {
    $desktopUrl = str_replace("http://m.", "http://", $desktopUrl);
} else {
    $desktopUrl = str_replace("http://m.", "http://www.", $desktopUrl);
}

$metaDescription = ($isArticle) ? $article->getLeadText() : $device->getConfig('pageTitle');


// --------------------------------------------------

// Google AMP Canonical Urls

$ampUrl = '';
if ($isArticle) {

    // $host = $_SERVER['SERVER_NAME'];
    $host = $_SERVER['HTTP_HOST'];

    $url = $article->getUrl();

    $productionServerList = array(

        'm.oe24.at',
        'm.sport.oe24.at',
        'm.madonna.oe24.at',
        'm.money.oe24.at',

        'www.oe24.at',
        'sport.oe24.at',
        'madonna.oe24.at',
        'money.oe24.at',
        'www.gesund24.at',
        'www.wirkochen.at',
    );

    $urlPath = parse_url($url, PHP_URL_PATH);

    if (in_array($host, $productionServerList)) {
        $ampUrl = 'http://'.$host.$urlPath.'/amp';
    } else {
        $ampUrl = 'http://'.$host.'/_mobile'.$urlPath.'/amp';
    }
}

// --------------------------------------------------



?>


<link rel="canonical" href="<?= $desktopUrl; ?>">

<? if (false === $robotIndex): ?>
    <meta name="robots" content="noindex, nofollow" />
<? endif; ?>

<? if (0) : ?>
<meta name="description" content="<?= $metaDescription; ?>">
<? endif; ?>

<? // -------------------------------------------------- ?>

<? if (!empty($appleStoreId)): ?>
    <meta name="apple-itunes-app" content="app-id=<?= $appleStoreId; ?>">
<? endif; ?>

<? // -------------------------------------------------- ?>

<? if ($isArticle): ?>

    <? // -------------------------------------------------- ?>

    <meta property="og:title" content="<?= $article->getPageTitle(); ?>" />
    <meta property="og:type" content="article" />
    <meta property="og:url" content="<?= $desktopUrl; ?>" />
    <meta property="og:description" content="<?= $ogDescription; ?>" />

    <? if ($ogImageUrl): ?>
        <meta property="og:image" content="<?= $ogImageUrl; ?>" />
    <? endif; ?>

    <? // -------------------------------------------------- ?>

    <meta property="article:published_time" content="<?= date("o-m-d", $article->getFrontendDate()->getTimestamp()); ?>" />

    <? if ($tags): ?>
        <? foreach ($tags as $tag): ?>
            <meta property="article:tag" content="<?= $tag->getName(); ?>" />
        <? endforeach; ?>
    <? endif; ?>

    <meta property="article:section" content="<?= $channel->getName(); ?>" />

    <? // -------------------------------------------------- ?>

    <link rel="amphtml" href="<?= $ampUrl; ?>">

    <? // -------------------------------------------------- ?>

<? endif; ?>
