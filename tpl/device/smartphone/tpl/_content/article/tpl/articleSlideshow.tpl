<?
/**
 * article slideshow
 * @var article oe24.core.Content
 */

// Beispiele am Dev:
// http://oe24dev.oe24.at/_mobile/import/slideshow/Papst-Besuch-in-Kuba/161433325?smartphone

if ( ! $article) {
    return;
}

$device = DeviceContainer::getDevice();
$contents = $device->getArticleContents($article);

?>
<div class="articleBox articleSlideshow">

    <div class="story">

        <div class="storyImage">
            <? tpl('oe24.oe24.device.smartphone.tpl._content.article.override.slideshowImages', array('content' => $article)); ?>
        </div>

        <? tpl('oe24.oe24.device.smartphone.tpl._content.article.tpl.articleSlideshowVoting', array('article' => $article)); ?>

        <? if (0): ?>
        <div class="storyText">
            <strong class="storyPreTitle"><?= $contents['preTitle']; ?></strong>
            <h3 class="storyTitle defaultChannelColor"><?= $contents['title']; ?></h3>
        </div>
        <? endif; ?>

        <div class="storyText">
            <div class="storyTextTop clearfix">
                <strong class="storyPreTitle defaultChannelColor"><?= $contents['preTitle']; ?></strong>
                <span class="storyDateTime"><?= $contents['dateTime']; ?></span>
            </div>
            <h1 class="storyTitle"><?= $contents['title']; ?></h1>
        </div>

        <div class="storyText">
            <p class="storyLeadText"><?= $contents['leadText']; ?></p>
        </div>

        <? if (1): ?>
            <div class="storyAd">
                <? tpl('oe24.oe24.device.smartphone.tpl._adition.adition', array(
                        'channel' => $device->getConfig('channel'),
                        'object'  => $article,
                        'banner'  => 'MobileArtikelTop',
                )); ?>
            </div>
        <? endif; ?>

        <div class="storySocialMedia">
            <? tpl('oe24.oe24.device.smartphone.tpl._content.article.tpl.articleSocialMedia'); ?>
        </div>

        <div class="storyBodyText">
            <?= $contents['bodyText']; ?>
        </div>

        <div class="storyOutbrain">
            <? //MH 20170407 MB_11 ist nicht garantiefähige Version der Outbrain-Einbindung
            tpl('oe24.oe24.device.smartphone.assets.vendor.outbrain.articleOutbrain', array('widgetString' => 'MB_11')); ?>
        </div>

        <div class="storyComments">
                <? tpl('oe24.oe24.device.smartphone.tpl._content.article.tpl.articleComments'); ?>
        </div>

        <div class="storyAd">
            <? tpl('oe24.oe24.device.smartphone.tpl._adition.adition', array(
                    'channel' => $device->getConfig('channel'),
                    'object'  => $article,
                    'banner'  => 'MobileArtikelBottom',
            )); ?>
        </div>

        <div class="storyBottom storyAdditionalBoxes">
            <? tpl('oe24.oe24.device.smartphone.tpl._content.article.tpl.articleAdditionalBoxes'); ?>
        </div>

        <div class="storyBottom storyRelatedArticles">
            <? tpl('oe24.oe24.device.smartphone.tpl._content.article.tpl.articleRelatedArticles'); ?>
        </div>

        <div class="storyBottom storyChannelTopStories">
            <? tpl('oe24.oe24.device.smartphone.tpl._content.article.tpl.articleChannelTopStories'); ?>
        </div>

        <? // bs 2017-07-10 DAILY-811 ?>
        <? // <div class="storyBottom storyAditionBox"> ?>
            <? // tpl('oe24.oe24.device.smartphone.tpl._adition.storyAditionBox'); ?>
        <? // </div> ?>
    </div>



</div>
