<?php
/**
 * Amp Article Index File.
 *
 * @var content oe24.core.Content
 * @var channel oe24.core.Channel
 */

/* IMAGES --------------------------------------------------------------------------*/

$relatedHeaderImages = array();
$relatedHeaderImages = $content->getRelatedImages();
$showContentImage = false;
$hasContentImage = false;
if (!empty($relatedHeaderImages)) {
    $showContentImage = true;
    $hasContentImage = true;
    $contentImage = $relatedHeaderImages[0];
}

$addCarousel = false;
$showContentSlideshow = false;
if (count($relatedHeaderImages) > 1) {
    $showContentSlideshow = true;
    $showContentImage = false;
    $addCarousel = true;
}

$showContentVideo = false;
$relatedVideos = $content->getRelatedVideos();
if (!empty($relatedVideos)) {
    $showContentVideo = true;
    $showContentImage = false;
    $showContentSlideshow = false;
    $contentVideo = $relatedVideos[0];
}

/* RELATED STORIES -----------------------------------------------------------------*/

$relatedStories = array();

foreach ($content->getRelatedStories() as $key => $story) {
  $storyHomeChannel = $story->getHomeChannel();
  if (!$storyHomeChannel) {
    continue;
  }

  $relatedImages = $story->getRelatedImages();
  if (!$relatedImages || empty($relatedImages)) {
    continue;
  }
  $relatedStories[] = array('image' => $relatedImages[0],
                            'title' => $story->getTitle(),
                            'preTitle' => $story->getPreTitle(true),
                            'url' => $story->getUrl().'/amp',
                            );
}

$showRelatedStories = false;
if (count($relatedStories) > 0) {
    $showRelatedStories = true;
}

/* HTML TAGGING --------------------------------------------------------------------*/

// (bs) 2016-05-11
$bodyText = $content->getBodyText();
// $usedTags = amp_tagging($bodyText);

// (pj) 2016-07-06 schoenere Variante
$usedTags = array();
$spunqTags = TextualProcessor::extractSpunQTags($bodyText);
foreach ($spunqTags as $spunqTag) {

    $spunqTagName = $spunqTag['name'];
    $taggingAlias = 'oe24.oe24.device.amp.tpl._content.article.tagging.' . $spunqTagName;

    if (NULL === spunQ_Module::aliasToTplFile($taggingAlias, false)) {
        $newText = isset($spunqTag['linkText']) ? $spunqTag['linkText'] : '';
        $bodyText = str_replace($spunqTag['originalString'], $newText, $bodyText);
        continue;
    }

    switch ($spunqTagName) {
        case 'SlideShow':
            $usedTags['Carousel'] = true;
            break;

        case 'IFrame':
            $protocol = (isset($spunqTag['attributes']['protocol'])) ? $spunqTag['attributes']['protocol'] : NULL;
            if (NULL === $protocol) {
                break;
            }
            $usedTags[$protocol] = true;
            break;
    }

    $buffer = new spunQ_OutputBuffer();

    tpl($taggingAlias, array(
        'spunqTag' => $spunqTag,
        'imageIds' => array(),
    ));

    $bufferString = $buffer->get();
    $bodyText = str_replace($spunqTag['originalString'], $bufferString, $bodyText);

}
// (pj) 2016-07-06 end

// $bodytext is changed via reference
// $usedTags is the return value of the function 'amp_tagging'.

/* GET USED TAGS -------------------------------------------------------------------*/

$scriptBuffer = array();
if (isset($usedTags['Carousel']) || $addCarousel) {
  $scriptBuffer[] = '<script async custom-element="amp-carousel" src="https://cdn.ampproject.org/v0/amp-carousel-0.1.js"></script>';
}
if (isset($usedTags['Youtube'])) {
  $scriptBuffer[] = '<script async custom-element="amp-youtube" src="https://cdn.ampproject.org/v0/amp-youtube-0.1.js"></script>';
}
if (isset($usedTags['Facebook'])) {
  $scriptBuffer[] = '<script async custom-element="amp-facebook" src="https://cdn.ampproject.org/v0/amp-facebook-0.1.js"></script>';
}

// tag for ads, do not remove !!
// On the Google-Website it is encouraged to use this tag.  However, it only works without the tag.
// $scriptBuffer[] = '<script async custom-element="amp-ad" src="https://cdn.ampproject.org/v0/amp-ad-0.1.js"></script>';

// OEWA
$scriptBuffer[] = '<script async custom-element="amp-analytics" src="https://cdn.ampproject.org/v0/amp-analytics-0.1.js"></script>';

$usedScriptTags = implode('', $scriptBuffer);

/* URLS ----------------------------------------------------------------------------*/

$desktopUrl = $content->getUrl();
$host = parse_url($desktopUrl, PHP_URL_HOST);
if (count(explode('.', $host)) > 3) {
  $desktopUrl = str_replace("http://m.", "http://", $desktopUrl);
} else {
  $desktopUrl = str_replace("http://m.", "http://www.", $desktopUrl);
}

$canonicalUrl = $desktopUrl;

$bannerAdditionalStyle = '';

$logoPortal = lp('image', 'mobile/amp/amp-logo-oe24.png');
$logoPortalWithBackground = lp('image', 'mobile/amp/amp-logo-oe24-bkgrnd.png');
$logoPortalWidth = 161;
$logoPortalHeight = 60;
// $logoPortalWidth = 129;
// $logoPortalHeight = 48;

if (isOverride('sport', $channel) || isOverride('sport_euro2016', $channel)) {
    $logoPortal = lp('image', 'mobile/amp/amp-logo-sport24.png');
    $logoPortalWithBackground = lp('image', 'mobile/amp/amp-logo-sport24-bkgrnd.png');
    $logoPortalWidth = 185;
    $logoPortalHeight = 60;
    // $logoPortalWidth = 148;
    // $logoPortalHeight = 48;
    $bannerAdditionalStyle = 'sport';
}

?>
<!doctype html>
<html amp>
<head>
    <meta charset="utf-8">
    <link rel="canonical" href="<?= $canonicalUrl; ?>" >
    <meta name="viewport" content="width=device-width,minimum-scale=1,initial-scale=1">


<!-- tpl/device/amp/tpl/_content/article/ampindex.tpl -->
<!-- AMP BOILERPLATE CODE - SEE https://github.com/ampproject/amphtml/blob/master/spec/amp-boilerplate.md -->
<style amp-boilerplate>body{-webkit-animation:-amp-start 8s steps(1,end) 0s 1 normal both;-moz-animation:-amp-start 8s steps(1,end) 0s 1 normal both;-ms-animation:-amp-start 8s steps(1,end) 0s 1 normal both;animation:-amp-start 8s steps(1,end) 0s 1 normal both}@-webkit-keyframes -amp-start{from{visibility:hidden}to{visibility:visible}}@-moz-keyframes -amp-start{from{visibility:hidden}to{visibility:visible}}@-ms-keyframes -amp-start{from{visibility:hidden}to{visibility:visible}}@-o-keyframes -amp-start{from{visibility:hidden}to{visibility:visible}}@keyframes -amp-start{from{visibility:hidden}to{visibility:visible}}</style><noscript><style amp-boilerplate>body{-webkit-animation:none;-moz-animation:none;-ms-animation:none;animation:none}</style></noscript>

<!-- OE24 CUSTOM STYLES -->

<style amp-custom>

    body {
        font-family: "Helvetica", Helvetica, Arial, sans-serif;
        font-size: 16px;
    }
    h1 {
        font-size: 180%;
        line-height: 1.1em;
    }
    h2 {
        font-size: 160%;
        line-height: 1.1em;
    }
    h3 {
        font-size: 140%;
        line-height: 1.1em;
        margin: 15px 0;
    }
    p {
        font-size: 110%;
        line-height: 1.4em;
        margin: 5px 0 0;
    }
    a,
    a:hover {
        text-decoration: none;
        color: #d0113a;
    }
    .clear {
        clear: both;
    }
    .clearfix:before,
    .clearfix:after {
        content: " ";
        font-size: .1rem;
        line-height: .1;
        display: table;
        border-collapse: collapse;
        border-spacing: 0;
    }
    .clearfix:after {
        clear: both;
    }
/*    .clearfix {
        *zoom: 1;
    }*/


    .oe24Banner {
        background-color: #d0113a;
        padding: 2px 0;
    }
    .oe24Banner.sport {
        background-color: #22b480;
        padding: 0;
    }
    .oe24Logo {
        margin: 0 auto;
        display: block;
    }


    .breadcrumbs {
        margin: 0 0 5px 0;
        padding: 0 10px;
        background: #ebebeb;
    }
    .breadcrumbs li {
        font-size: 12px;
        line-height: 24px;
        list-style: none;
        display: inline-block;
    }
    .breadcrumbs li:nth-child(2):before {
        content: '\203A';
    }
    .breadcrumbs a {
        font-weight: 400;
    }


    .articleWrapper {
        padding: 0 10px;
    }


    .date {
        font-size: 80%;
        font-weight: 400;
        margin: 5px 0 5px 0;
        display: block;
        color: #747474;
    }
    .preTitle {
        font-size: 15px;
        text-transform: uppercase;
        display: block;
        padding: 5px 0 3px 0;
        margin: 0;
        color: #d0113a;
    }
    .headline {
        margin: 0 0 10px -1px;
        display: block;
    }
    .leadText {
        margin: 0;
    }


    .articleImage {
        margin: 10px -10px;
    }


    /* (ws) */
    .articleImage figure,
    .articleImage figcaption,
    .articleText figure,
    .articleText figcaption,
    .relatedImage figure,
    .relatedImage figcaption {
        padding: 0;
        border: none;
        margin: 0;
        color: #000;
    }
    .articleImage figcaption,
    .articleText figcaption,
    .relatedImage figcaption {
        font-size: 12px;
        text-align: right;
        padding: 2px 10px;
    }
    .articleText figcaption,
    .relatedImage figcaption {
        padding: 2px 0;
    }
    /* (ws) // */


    .articleSocial {
        margin: 5px 0 10px;
    }
    .articleSocial a {
        float: left;
        width: 33.33%;
        display: block;
    }
    .articleSocial .fbShare,
    .articleSocial .waShare,
    .articleSocial .twShare {
        text-align: center;
        height: 33px;
    }

    .articleSocial .fbShare {
        background: #3b5998;
    }
    .articleSocial .waShare {
        background: #4dc247;
    }
    .articleSocial .twShare {
        background: #1da1f2;
    }


    footer {
        font-size: 12px;
        line-height: 20px;
        text-align: center;
        padding: 10px;
        margin: 8px 0 0 0;
        color: #fff;
        background-color: #212121;
    }
    footer a {
        text-decoration: none;
        color: #fff;
    }
    footer p:first-child {
        padding-top: 5px;
    }

    .ampAdCentered {
        display: block;
        margin: 10px auto;
    }

    .relatedImage {
        width: 100%;
    }
    .relatedTextWrapper {
        width: 90%;
        padding: 8px 0 0 0;
    }
    .relatedTitle .preTitle {
        font-size: 14px;
        font-weight: 700;
    }
    .relatedTitle .headline {
        font-size: 17px;
        font-weight: 700;
        color: #212121;
    }
    .relatedStories {
        /*position: relative;*/
        /*overflow: hidden;*/
        margin: 10px 0 15px 0;
    }
    .relatedStories a {
        text-decoration: none;
    }
    .relatedStories:last-child {
        margin: 0;
    }


    .headlineBlock {
        font-size: 140%;
        font-weight: 700;
        padding: 5px 0 5px 10px;
        margin: 10px 0 0 0;
        color: #fff;
        background-color: #d0113a;
    }
    .headlineBlockAd {
        font-size: 12px;
        line-height: 24px;
        padding: 2px 10px;
        margin: 10px 0 0 0;
        color: #000;
        background-color: #ebebeb;
    }


</style>

<?
// (ws) 2016-06-29
$jsonData = array(
    'canonicalUrl' => $canonicalUrl,
    'logoUrl'      => $logoPortalWithBackground,
    'logoWidth'    => $logoPortalWidth,
    'logoHeight'   => $logoPortalHeight,
);
?>

<?
    tpl('oe24.oe24.device.amp.tpl._content.article.others.ldJson', array(
        'content' => $content,
        'jsonData' => $jsonData,
    ));
?>

<script async src="https://cdn.ampproject.org/v0.js"></script>

<?= $usedScriptTags; ?>

</head>
<body>

    <div class="pageWrapper">

        <a href="http://m.oe24.at" target="_self">
            <div class="oe24Banner <?= $bannerAdditionalStyle; ?>">
                <?//= amp_img_static($logoPortal, $logoPortalWidth, $logoPortalHeight, 'oe24Logo');
                // amp_img_static($logoPortal, 106, 34, 'oe24Logo');
                ?>

                <?
                    tpl('oe24.oe24.device.amp.tpl._content.article.others.staticImage', array(
                        'url' => $logoPortal,
                        'width' => $logoPortalWidth,
                        'height' => $logoPortalHeight,
                        'class' => 'oe24Logo',
                    ));
                ?>
            </div>
        </a>

        <? tpl('oe24.oe24.mobile.article.breadcrumbs',array('channel' => $channel, 'amp' => true)); ?>

        <div class="articleWrapper">

            <div class="pageTop">

                <span class="date">
                    <?= date_format($content->getPublishDate(), 'd.m.Y'); ?>
                </span>

                <h3 class="preTitle">
                    <?= $content->getPreTitle(); ?>
                </h3>

                <h1 class="headline" itemprop="headline">
                    <?= $content->getTitle(); ?>
                </h1>

                <p class="leadText">
                    <?= $content->getLeadText(); ?>
                </p>

            </div>


            <? if ($showContentImage) : ?>
                <div class="articleImage">
                    <?//= amp_img($contentImage, 292, 146);?>
                    <?
                        $spunqTag = array(
                            'attributes' => array(
                                'id' => $contentImage->getId(),
                            ),
                        );
                        tpl('oe24.oe24.device.amp.tpl._content.article.tagging.Image', array(
                            'spunqTag' => $spunqTag,
                            'width' => 292,
                            'height' => 146,
                        ));
                    ?>
                </div>
            <? endif; ?>

            <? if ($showContentVideo) : ?>
                <div class="articleImage">
                    <?//= amp_video($contentVideo->getId()); ?>
                    <?
                        $spunqTag = array(
                            'attributes' => array(
                                'id' => $contentVideo->getId(),
                            ),
                        );
                        tpl('oe24.oe24.device.amp.tpl._content.article.tagging.Video', array(
                            'spunqTag' => $spunqTag,
                        ));
                    ?>
                </div>
            <? endif; ?>

            <? if ($showContentSlideshow) : ?>
                <div class="articleImage">
                    <?//= amp_carousel(null, '', 292, 146, 'responsive', $relatedHeaderImages); ?>
                    <?
                        $imageIds = array_map(function($a) {return $a->getId(); }, $relatedHeaderImages);
                        tpl('oe24.oe24.device.amp.tpl._content.article.tagging.SlideShow', array(
                            'spunqTag' => array(),
                            'width' => 292,
                            'height' => 146,
                            'imageIds' => $imageIds,
                        ));
                    ?>
                </div>
            <? endif; ?>

            <div class="articleSocial clearfix">

                <a href="http://www.facebook.com/sharer.php?m2w&amp;s=100&amp;p[url]=<?= urlencode($canonicalUrl); ?>&amp;p[title]=<?= urlencode($content->getTitle()); ?>" class="fbShare">
                    <?//= amp_img_static(lp('image', 'mobile/social/facebook-share.png'), 90, 33);?>
                    <?
                        tpl('oe24.oe24.device.amp.tpl._content.article.others.staticImage', array(
                            'url' => lp('image', 'mobile/social/facebook-share.png'),
                            'width' => 90,
                            'height' => 33,
                        ));
                    ?>
                </a>

                <a href="whatsapp://send?text=<?= urlencode($canonicalUrl); ?>" data-action="share/whatsapp/share" class="waShare">
                    <?//= amp_img_static(lp('image', 'mobile/social/whats-share.png'), 90, 33);?>
                    <?
                        tpl('oe24.oe24.device.amp.tpl._content.article.others.staticImage', array(
                            'url' => lp('image', 'mobile/social/whats-share.png'),
                            'width' => 90,
                            'height' => 33,
                        ));
                    ?>
                </a>

                <a href="https://twitter.com/intent/tweet?text=@oe24News+<?= urlencode($content->getTitle()); ?>&amp;url=<?= urlencode($canonicalUrl) ?>" class="twShare">
                    <?//= amp_img_static(lp('image', 'mobile/social/twitter-share.png'), 90, 33); ?>
                    <?
                        tpl('oe24.oe24.device.amp.tpl._content.article.others.staticImage', array(
                            'url' => lp('image', 'mobile/social/twitter-share.png'),
                            'width' => 90,
                            'height' => 33,
                        ));
                    ?>
                </a>

            </div>


            <div class="articleText">
                <?= $bodyText; ?>
            </div>


        </div>

        <?
            tpl('oe24.oe24.device.amp.tpl._content.article.others.Ad', array(
                'channel' => $channel,
                'width' => 300,
                'height' => 250,
            ));
        ?>


        <? if ($showRelatedStories) : ?>

            <div class="headlineBlock">Weitere Artikel</div>

            <div class="articleWrapper">

            <? foreach ($relatedStories as $key => $story): ?>

                <div class="relatedStories">
                    <a href="<?= $story['url']; ?>">

                        <div class="relatedImage">
                            <?
                                $spunqTag = array(
                                    'attributes' => array(
                                        'id' => $story['image']->getId(),
                                    ),
                                );
                                tpl('oe24.oe24.device.amp.tpl._content.article.tagging.Image', array(
                                    'spunqTag' => $spunqTag,
                                ));
                            ?>
                        </div>

                        <div class="relatedTextWrapper">
                            <div class="relatedTitle">
                                <div class="preTitle">
                                    <?= $story['preTitle']; ?>
                                </div>
                                <div class="headline">
                                    <?= $story['title']; ?>
                                </div>
                            </div>
                        </div>

                    </a>
                </div>

                <div class="clear"></div>

            <? endforeach; ?>

            </div>

        <? endif; ?>

        <?
            tpl('oe24.oe24.device.amp.tpl._content.article.others.Analytics', array(
                'channel' => $channel,
            ));
        ?>


        <footer>
            <a href="<?= $desktopUrl; ?>">Zur Vollversion wechseln</a> | <a href="http://m.oe24.at/service/Impressum-OE24/1637563">Impressum</a> <br>&copy; <?= date('Y'); ?> oe24 GmbH.
        </footer>


    </div>

</body>
</html>
