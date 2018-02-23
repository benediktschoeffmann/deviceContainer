<?php
/**
 * The header template for the oe24 project.
 *
 * @var channel oe24.core.Channel
 * @var layout string
 * @var portal oe24.core.Portal
 * @default layout oe24
 * @var object any
 * @default object 0
 * @var navigation any
 * @var oe2016layouts array<string>
 * @var useNewCollector any
 * @default useNewCollector 0
 * @var useNewLayout any
 * @default useNewLayout 0
 */

$isArticle = $object instanceof TextualContent;
// $devMode = spunQ::inMode(spunQ::MODE_DEVELOPMENT);

$additionalWrapClass = '';


if (in_array($layout, $oe2016layouts) && ($isArticle)) {
    $additionalWrapClass = ' a2016';
}

if (in_array($layout, $oe2016layouts) && ($useNewLayout === 'oe2016')) {
    $additionalWrapClass = $additionalWrapClass . ' oe2016';
}

$useNewCollector = $useNewCollector && (in_array($layout, $oe2016layouts));
$metaDescription = NULL;
$metaKeywords = "";
$metaNewsKeywords = "";
$aTags = array();
$aPageTitleTags = array();
$aAllTags = array();
$tags = $channel->getTags(true);
if($tags){
    $aTags = array_map(function($t) { return $t->getName(); }, $tags);
    $metaKeywords = implode(",", $aTags);
}
if($object instanceof TextualContent){
    $metaDescription = htmlentities($object->getRobotsDescription(), ENT_COMPAT);
    if(!$metaDescription){
        $metaDescription = htmlentities($object->getLeadText(true), ENT_COMPAT);
    }
    $tags = $object->getTags();
    if($tags){
        $aTags = array_map(function($t) { return $t->getName(); }, $tags);
        $metaKeywords = implode(",", $aTags);
    }
    $aPageTitleTags = array_filter(
        explode(" ", $object->getPageTitle()),
        function($a) { return( preg_match('/^[A-Z]{1}/', $a) ); }
    );
    $aAllTags = array_diff_key($aPageTitleTags, $aTags) + $aTags;
    $metaNewsKeywords = implode(",", $aAllTags);
}

$content = $object;

if($content){
    $options = $content->getOptions(true, true);
    $optionsNoParent = $channel->getOptions();
}elseif($channel){
    $options = $channel->getOptions(true, true);
    $optionsNoParent = $channel->getOptions();
}else{
    return NULL;
}

if(!$metaDescription && $options->get("metaDescription")){
    $metaDescription = $options->get("metaDescription");
}elseif(!$metaDescription){
    $metaDescription = "Österreich / oe24.at - Das Online-Portal der Tageszeitung &quot;Österreich&quot; bietet aktuelle Text-, Bild- und Video-Nachrichten, sowie Leser- und Redaktions-Blogs.";
}

$faviconsToOverrides = array(
    'oe24' => 'O24',
    'gesund24' => 'G24',
    'madonna' => 'M24',
    // 'society' => 'S24',
    'madonnasociety' => 'S24',
    'madonnasocietyblue' => 'S24blue',
    'antenne_salzburg' => 'Antenne',
    'antenne_tirol' => 'Antenne',
    'business'  => 'business',
    'games24' => 'games24',
    );
$favicon = "O24";
if($options->get("layoutOverride")){
    $override = $options->get("layoutOverride");
    $favicon = isset($faviconsToOverrides[$override]) ? $faviconsToOverrides[$override] : $favicon;
}

$url = request()->getUri(true);
$patternPrint = "#(/print)$#";
$patternMail = "#(/mailto)$#";
$patternArticleList = "#(/articleList/)#";
$isChannel = $object ? false : true;

$robotIndex = $options->get('robotIndex');

if ($object) {

    // (ws) 2018-02-14
    // $desktopUrl = null;
    // $channelItem->getRawUrl() kann u.U. zu einem Fehler fuehren, wenn $channelItem kein gueltiges Objekt ist.
    // Laut PHP-Log passiert das auch. Welche Faelle das sind laesst sich auf Grund der Fehlermeldung nicht
    // herausfinden, weil die URL nicht mitgeloggt wird.

    $desktopUrl = 'http://www.oe24.at';

    $channels = $object->getChannels();
    // (pj) 2015-01-27 Erster HomeChannel (im spunQ der erste HomeChannel) aus allen HomeChannels rausholen fuer Canonical URL
    $channelItem = reset($channels);

    if ($channelItem) {
        // (pj) 2015-02-23 Canonical Url war falsch
        // $desktopUrl = $channelItem->getPortal()->getUrl(true).$channelItem->getRawUrl().str_replace($channel->getRawUrl(), '', stripDomainFromString($object->getUrl()));
        $channelString = $channelItem->getRawUrl();
        if ($channelItem->getDomain(true, true) !== $channelItem->getPortal()->getUrl()) {
            $channelString = trim($channelString, '/ ');
            $channelStringArray = explode('/', $channelString);
            $channelStringArray[0] = '';
            $channelString = implode('/', $channelStringArray);
        }
        $desktopUrl = 'http://' . $channelItem->getDomain(true, true).$channelString.str_replace($channel->getUrl(), '', $object->getUrl());
        // (pj) 2015-02-23 end
    }
    // (pj) 2015-01-27 end
    // $desktopUrl = $object->getUrl();

} else {
    $desktopUrl = $channel->getUrl();
}

// (bs) 2016-06-28 DAILY-326 Verlinkung der AMP-Pages
if ($object instanceof TextualContent) {
    $ampUrl = '';

    if (spunQ::inMode(spunQ::MODE_DEVELOPMENT)) {
        $host = $_SERVER['HTTP_HOST'];
        $urlPath = parse_url($desktopUrl, PHP_URL_PATH);
        $ampUrl = 'http://'.$host.'/_mobile'.$urlPath.'/amp';

    } else {
        if (substr($desktopUrl, 0, strlen('http://www')) === 'http://www') {
            $ampUrl = str_replace("http://www.", "http://m.", $desktopUrl);
        } else {
            $ampUrl = str_replace("http://", "http://m.", $desktopUrl);
        }
        $ampUrl .= '/amp';
    }
}
?>
<!DOCTYPE html>
<!--[if IE]><![endif]-->
<html>
<head>
    <? //<meta charset="utf-8" /> // (pj) 2015-05-18 html quick wins ?>
    <meta name="description" content="<?s($metaDescription)?>" />
    <? if (false): // (pj) 2015-05-18 html quick wins ?>
        <meta name="keywords" content="<?=$metaKeywords?>" />
    <? endif; ?>
    <!-- BEGIN ChartBeat -->
    <script type='text/javascript'>var _sf_startpt=(new Date()).getTime()</script>
    <!-- END ChartBeat -->
    <link rel="canonical" href="<?= $desktopUrl ?>" />
    <? if($object instanceof TextualContent) { ?>
        <meta name="news_keywords" content="<?=$metaNewsKeywords?>" />
        <? if((preg_match($patternPrint, $url) == 1) || (preg_match($patternMail, $url) == 1)) { ?>
            <link rel="canonical" href="<?=$object->getUrl()?>" />
        <? } ?>
    <? } ?>
    <? if(preg_match($patternArticleList, $url) == 1) { ?>
        <meta name="ROBOTS" content="NOINDEX, NOARCHIVE, FOLLOW" />
    <? } ?>
    <? if (false === $robotIndex): ?>
        <meta name="robots" content="noindex, nofollow" />
    <? endif; ?>


    <? // (pj) 2016-01-12 Test fuer apple-news-feed-by-siri ?>
    <? // (pj) 2016-01-12 wurde von lib/oe24_oe24/page/article/facebook.page kopiert ?>

    <? if (!$isArticle && $channel): ?>
        <? // (db) 2017-11-13 OpenGraph Metatags für Übersichtsseiten ?>
        <meta property="og:url" content="<?= $channel->getUrl(); ?>" />
        <meta property="og:title" content="<?= htmlentities($channel->getSeoPageTitle(), ENT_COMPAT, 'UTF-8'); ?>" />
        <meta property="og:type" content="website" />
        <meta property="og:description" content="<?= htmlentities($metaDescription, ENT_COMPAT, 'UTF-8'); ?>" />
        <?
            // meta-property: og:image
            etpl('oe24.oe24.__splitArea._page.oe2016.headerOgImage',array('channel' => $channel, 'layout' => $layout));
        ?>
        <?
            /*
                fb:pages
                143689735528 ... oe24.at
                319561537533 ... oe24.tv
                220812574978371 ... sport24at
                526985287389331 ... radio.oe24
                254647118634 ... madonna24
                291224890932278 ... gesund24.at
            */
        ?>
        <meta property="fb:pages" content="143689735528">
        <meta property="fb:pages" content="319561537533">
        <meta property="fb:pages" content="220812574978371">
        <meta property="fb:pages" content="526985287389331">
        <meta property="fb:pages" content="254647118634">
        <meta property="fb:pages" content="291224890932278">

    <? endif; ?>

    <? if ($content instanceof TextualContent): ?>
        <?
        $image = $content->getFirstRelatedImage();
        // (pj) 2016-05-19 fbAppId und fbAdminIds
        $fbAppId = $content->getOptions(true, true)->get('FacebookAppId');
        $fbAdminIds = json_decode($content->getOptions(true, true)->get('FacebookAdminIds'), true);
        $fbAdminIds = (NULL === $fbAdminIds) ? array() : $fbAdminIds;
        // (pj) 2016-05-19 end
        ?>

        <? // DAILY-791 (bs) 2017-06-21 Twitter Cards einbindung ?>
        <meta property="twitter:card" contents="summary_large_image">
        <meta property="twitter:site" contents="@oe24News">
        <meta property="twitter:creator" contents="@oe24News">
        <meta property="twitter:title" content="<?= htmlentities($content->getPageTitle(), ENT_COMPAT, 'UTF-8'); ?>">
        <meta property="twitter:description" content="<?= htmlentities($content->getLeadText(), ENT_COMPAT, 'UTF-8');?>">

        <meta property="og:title" content="<?= htmlentities($content->getPageTitle(), ENT_COMPAT, 'UTF-8'); ?>" />
        <meta property="og:type" content="article" />
        <meta property="og:url" content="<?= $content->getUrl(); ?>" />
        <meta property="og:description" content="<?= htmlentities($content->getLeadText(true), ENT_COMPAT, 'UTF-8'); ?>" />
        <? if ($image): ?>
            <meta property="og:image" content="<?= $image->getFileUrl("consoleMadonnaNoStretch2"); ?>" />
            <meta property="twitter:image" content="<?= $image->getFileUrl("consoleMadonnaNoStretch2"); ?>" />
        <? endif; ?>
        <meta property="article:published_time" content="<?= date("o-m-d",$content->getFrontendDate()->getTimestamp()); ?>" />
        <? if ($tags): ?>
            <? foreach ($tags as $tag): ?>
                <meta property="article:tag" content="<?= htmlentities($tag->getName(), ENT_COMPAT, 'UTF-8'); ?>" />
            <? endforeach; ?>
        <? endif; ?>
        <meta property="article:section" content="<?= $channel->getName(); ?>" />

        <? // (pj) 2016-05-19 fbAppId und fbAdminIds ?>
        <? if (NULL != $fbAppId): ?>
            <meta property="fb:app_id" content="<?= $fbAppId; ?>" />
        <? endif; ?>

        <? // (bs) 2017-12-04 FB sagt entweder Admins oder AppId ?>
        <? if (!$fbAppId) :?>
            <? foreach ($fbAdminIds as $key => $fbAdminId): ?>
                <meta property="fb:admins" content="<?= $fbAdminId; ?>" />
            <? endforeach; ?>
        <? endif; ?>


        <? // (pj) 2016-05-19 end ?>

    <? endif; ?>
    <? // (pj) 2016-01-12 end ?>


    <? if (1 || 'tv' == $layout || 'oe24' == $layout || 'radiooe24' == $layout):
    // (ws) 2016-08-29
    // font-family: 'Oswald', sans-serif;
    // font-family: 'Open Sans', sans-serif;
    // font-family: 'Open Sans Condensed', sans-serif;
    // <link href="https://fonts.googleapis.com/css?family=Open+Sans+Condensed:300|Open+Sans:400,700|Oswald:300,400" rel="stylesheet">
    // (ws) 2016-10-17
    // Auf Wunsch von Niki soll die Sidebar-Video-Box so aussehen, wie auf oe24TV
    // Dazu muss der Oswald-Font auch fuer Layout-Override "oe24" eingebunden werden.
    ?>
    <link href="https://fonts.googleapis.com/css?family=Oswald:300,400" rel="stylesheet">
    <? endif; // (ws) 2016-08-29 end ?>


    <link rel="shortcut icon" href="<?slp("image", "layout/favicons/$favicon.ico")?>" />

    <title><?=$object && $object instanceof TextualContent ? $object->getPageTitle() : $channel->getSeoPageTitle()?></title>
    <?
        if ($useNewCollector) {
            tpl('oe24.oe24.__splitArea._page.oe2016cssJsHead', array('layout' => $layout));

            $cssCollector = spunQ_html::getCssCollector();
            $cssVersion = $cssCollector->getVersion();

            $cssLinkHref = l('spunQ.wormhole.css', array(
                'css' => array('oe24.oe24.__splitArea.css.v3.ie.ie9'),
                'timestamp' => $cssVersion,
            ));
            ?>
            <!--[if IE]>
                <link rel="stylesheet" href="<?= $cssLinkHref; ?>"/>
            <![endif]-->
            <?

        } else {
            if (spunQ::inMode(spunQ::MODE_DEVELOPMENT)) {
                getJsAndCssWormhole('css', 'SplitArea', 'preHeader', 'oe24.frontend');
                getJsAndCssWormhole('css', 'SplitArea', 'preHeader');
                getJsAndCssWormhole('css', 'SplitArea', 'header');
            } else {
                getJsAndCssWormhole('css', 'SplitArea', 'headerList');
            }

            getJsAndCssWormhole('css', ucfirst($layout), 'header');
            if (spunQ::inMode(spunQ::MODE_DEVELOPMENT)) {
                getJsAndCssWormhole('css', 'SplitArea', 'dev');
            }
            ?>
            <!--[if lt IE 9]>
            <?
                getJsAndCssWormhole('css', 'SplitArea', 'headerIE8');
            ?>
            <![endif]-->
            <!--[if lt IE 8]>
            <?
                getJsAndCssWormhole('css', 'SplitArea', 'headerIE7');
            ?>
            <![endif]-->

            <?
                $cssCollector = spunQ_html::getCssCollector();
                $cssVersion = $cssCollector->getVersion();
            ?>
                <link rel="stylesheet" href="<?= l('spunQ.wormhole.css', array('css' => array('_shared.1_0.tracking.oewa.oewaTracking', '_shared.1_0.jwplayer.7_6_1.jwplayerSetup'), 'timestamp' => $cssVersion)); ?>"/>
            <?
                getJsAndCssWormhole('js', 'SplitArea', 'header');
            ?>

            <?
                $jsCollector = spunQ_html::getJsCollector();
                $jsVersion = $jsCollector->getVersion();
            ?>
                <script src="<?= l('spunQ.wormhole.js', array('js' => array('_shared.1_0.common.common'), 'timestamp' => $jsVersion)); ?>"></script>
            <?
        }
    ?>
    <?=$options->get("headerHtml");?>

    <script>
    var globalVars = {};
    var globalGravityOptions = {};
    </script>

    <?
        tpl('oe24.oe24.__splitArea._page.adition', array(
            'channel' => $channel,
            'content' => $content,
        ));
    ?>

    <link rel="dns-prefetch" href="//file.oe24.at" />
    <link rel="dns-prefetch" href="//tracking.oe24.at" />
    <link rel="dns-prefetch" href="//pq-direct.revsci.net" />
    <link rel="dns-prefetch" href="//static.chartbeat.com" />

    <?
        tpl('_shared.1_0.tracking.google.analytics', array(
            'portal' => $portal,
            'channel' => $channel,
            'content' => $object,
        ));
    ?>
    <? tpl("oe24.frontend.adsAndTrackers", array("channel" => $channel, "object" => $object, "portal" => $portal)); ?>

<?

// (ws) Header 2016-01-14

$headerNavigation = $navigation->getHeaderNavigation(__FILE__);
$navMainLink = $navigation->getImageUrl();

$channelOptions = $channel->getOptions(true, true);

$showWeather = false;
$weatherDomain = 'http://www.wetter.at';
$weatherId = $channelOptions->get('weatherId');
$weatherJson = array();

if(!empty($weatherId)){

    $weatherJson = jsonCache::getjsonData($weatherDomain . '/json/weatherData?id='.$weatherId.'&f=0', null, true);
    if(!empty($weatherJson) && isset($weatherJson['places']) && isset($weatherJson['places'][0]) && isset($weatherJson['places'][0]['name'])&& isset($weatherJson['places'][0]['icon'])&&isset($weatherJson['places'][0]['temp'])){
        $rc = array_walk($weatherJson['places'], function(&$item){
            unset($item['iconLink']);
        });
        $showWeather = true;
    } else {
        $showWeather = false;
        $weatherJson = array();
    }
}

// zwecks Test
// $weatherJson = array();
// zwecks Test end

// $facebookAppId = '203583476343648';

// (ws) Header 2016-01-14 end

?>

<? // (ws) Header END ?>


<? // (bs) 2016-04-18 Für Captcha ?>
<? // <script src='https://www.google.com/recaptcha/api.js'></script> --> ?>


<? // (bs) 2016-06-28 DAILY-326 Google AMP
   // Verlinkung für den AMP-Artikel ?>

<? if ($object instanceof TextualContent) : ?>
     <link rel="amphtml" href="<?= $ampUrl; ?>">
<? endif; ?>

<? // (bs) DAILY-784 Neustar Integration ?>
<script type="text/javascript">
    function setUpAgknTag(tag) {
        tag.setBpId("Oe24");
    }
</script>
<script src="//js.agkn.com/prod/v0/tag.js" async></script>
<? // (bs) Neustar end ?>
<? // (db) 2018-01-08 Test Neue SSA Version ?>
<script type="text/javascript" src="https://s407.mxcdn.net/bb-mx/serve/mtrcs_943913.js" async></script>

<? // (bs) 2018-02-05 DAILY-995 ?>
<meta name="google-site-verification" content="zQSTNlNR1DBo5L8zu_GlHydWX28SQDhA_OGobufkaZA" />
<? // (bs) end ?>
</head>
<body>
    <? etpl('oe24.oe24._page.backToMobile',array('channel' => $channel, 'object' => $object)); ?>
    <? // tpl("oe24.frontend.adsAndTrackersBody", array("channel" => $channel, "object" => $object, "portal" => $portal)); ?>

    <?
        $configOe24 = spunQ::getConfiguration()->getStringsForPrefix("oe24.oe24");
        $domain = str_replace(array('www.', 'oe24dev.'), '', $channel->getDomain(true));
        if ($domain === null || ($domain != 'gesund24.at' && $domain != 'madonna.oe24.at' && $domain != 'buzz.oe24.at' && $domain != 'wirkochen.at')) {
            $domain = $configOe24["oewaSite"];
        }

        $specialDomain = $options->get('OewaDomainString');
        $specialDomain = (NULL === $specialDomain) ? '' : $specialDomain;

        if ($options->get("OewaTracking") && $channel->getOewaTag(true)) {
            etpl('_shared.1_0.tracking.oewa.v2.oewaTracking', array(
                'uriSchema' => $channel->getOewaTag(true)->getUrlSchemaName(),
                'domain' => $domain,
                'channelUrl' => preg_replace("~http(.*?)//([^/]*)~i", "", $channel->getUrl()),
                'pageWidth' => 0,
                'specialDomain' => $specialDomain,
            ));
        }

        etpl('_shared.1_0.tracking.fb.fbTracking', array(
        ));
    ?>

    <? //tpl('oe24.oe24.__splitArea._page.gravity'); ?>

    <!-- #wrap start -->
    <div id="wrap" class="clearfix wrapper <?=$isChannel ? 'channel' : 'story'?> layout_<?=$layout?> <?=$additionalWrapClass;?>">

        <div class="Superbanner_div">

            <? etpl('oe24.oe24.adition.adSlot',array('channel' => $channel, 'id' => 'Superbanner')); ?>

            <?
            // Bitte den iframe-Tag kopieren und an die jeweiligen Testanforderungen anpassen,
            // damit fuer zukuenftige Tests des GLEICHEN iframe-src nicht wieder nach dem RICHTIGEN src
            // gesucht werden muss !!! DANKE
            ?>
            <? // <iframe src="/dev/ad1.html" width="300" height="0" frameborder="0"></iframe> ?>

            <? // <iframe src="/dev/pjMediaMarktColorAd" width="300" height="0" frameborder="0"></iframe> ?>

        </div>

        <?//<div class="Skyscraper_div">?>
        <? //etpl('oe24.oe24.adition.adSlot',array('channel' => $channel, 'id' => 'Skyscraper1')); ?>
        <? //etpl('oe24.oe24.adition.adSlot',array('channel' => $channel, 'id' => 'Skyscraper2')); ?>
        <?//</div>?>

        <? if ('oe2016' == $useNewLayout && 'madonna' != $layout): ?>

            <div class="headerBox">

                <div class="Skyscraper_div" id="Skyscrapers">
                    <? tpl('oe24.oe24.adition.adSlot',array('channel' => $channel, 'id' => 'Skyscraper1')); ?>
                    <? /*etpl('oe24.oe24.adition.adSlot',array('channel' => $channel, 'id' => 'Skyscraper2'));*/ ?>
                </div>

                <div class="headerNav">

                    <?
                    tpl('oe24.oe24.__splitArea._page.oe2016.headerNavPortal', array(
                        'headerNavPortal' => $headerNavigation['tabs'],
                        'weatherJson' => $weatherJson,
                        'showWeather' => $showWeather,
                    ));

                    if ($showWeather) {
                        tpl('oe24.oe24.__splitArea._page.oe2016.headerNavPortalWeatherDropDown', array(
                            'weatherDomain' => $weatherDomain,
                            'weatherJson' => $weatherJson,
                        ));
                    }
                    ?>

                    <div class="headerNavContainer">

                        <?
                        tpl('oe24.oe24.__splitArea._page.oe2016.headerNavLogo', array(
                            'channel' => $channel,
                            'layout' => $layout,
                            'navMainLink' => $navMainLink,
                        ));
                        ?>

                        <?
                        tpl('oe24.oe24.__splitArea._page.oe2016.headerNavMain', array(
                            'channel' => $channel,
                            'layout' => $layout,
                            'headerNavMain' => $headerNavigation['menue'],
                        ));
                        ?>

                    </div>

                    <?
                    tpl('oe24.oe24.__splitArea._page.oe2016.headerNavTopics', array(
                        'channel' => $channel,
                        'layout'  => $layout,
                    ));
                    ?>
                    <?
                    tpl('oe24.oe24.__splitArea._page.oe2016.headerNavSocial', array(
                        'channel' => $channel,
                        'layout'  => $layout,
                    ));
                    ?>
                    <div class="clearfix"></div>

                </div>

            </div>

        <? else: ?>

            <div class="headerContainer">
                <div class="Skyscraper_div" id="Skyscrapers">
                    <? tpl('oe24.oe24.adition.adSlot',array('channel' => $channel, 'id' => 'Skyscraper1')); ?>
                    <? // etpl('oe24.oe24.adition.adSlot',array('channel' => $channel, 'id' => 'Skyscraper2')); ?>
                </div>
                <?

                if ($navigation instanceof Navigation2014) {
                    $tplAlias = 'oe24.frontend.__splitArea._page.header.nav_header';
                } else {
                    $tplAlias = 'oe24.frontend.__splitArea._page.header.navHeader';
                }

                // (ws) 2015-12-14
                // if ($useNewLayout === 'oe2016') {
                //  $tplAlias = 'oe24.frontend.__splitArea._page.header.oe2016NavHeader';
                // }
                // (ws) 2015-12-14 //

                tpl($tplAlias, array(
                    'portal' => $portal,
                    'channel' => $channel,
                    'object' => $object,
                    'navigation' => $navigation,
                    'layout' => $layout,
                ));
                ?>
            </div>

        <? endif; ?>
