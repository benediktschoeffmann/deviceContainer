<?
/**
 * Article NewsTicker
 * @var article oe24.core.Content
 */

// Beispiele am Dev-Server
// http://oe24dev.oe24.at/_mobile/test/ws/smartphone/SmartPhone-Ticker-Test/161569097?smartphone

if ( ! $article) {
    return;
}

$device = DeviceContainer::getDevice();

$contents = $device->getArticleContents($article);

$classVideo = (true == $contents['isVideoStory']) ? 'videoStory' : '';

$jwplayerTplName = '_shared.1_0.jwplayer.jwplayerSetupProxy';

// -------------------------------------------------------------------

$textSectionPages = 0;
$textSectionPages = getTextSectionPages($article);
$pages = $article->getTotalBodyPages() + $textSectionPages;

$textSections = $article->getTextSections();

?>

<div class="articleBox articleDefault articleNewsticker">

    <div class="story">

        <? if ($contents['video']): ?>

            <div class="storyVideo">
                <? tpl($jwplayerTplName, array('video' => $contents['video'], 'events' => array())); ?>
            </div>

        <? else: ?>

            <div class="storyImage <?= $classVideo; ?>">
                <?
                tpl('oe24.oe24.device.smartphone.tpl._content.image.articleImages', array(
                    'relatedImages' => $contents['relatedImages'],
                ));
                ?>
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

        <div class="storyAd">
            <? tpl('oe24.oe24.device.smartphone.tpl._adition.adition', array(
                    'channel' => $device->getConfig('channel'),
                    'object'  => $article,
                    'banner'  => 'MobileArtikelBottom',
            )); ?>
        </div>


        <div class="newsTickerWrapper">
            <!-- <div class="buttonWrapper"> -->
                <div class="reloadButton defaultChannelBackgroundColor" onclick="window.location.reload();">
                    Liveticker aktualisieren
                </div>
            <!-- </div> -->
            <?
            foreach ($textSections as $section) {
                tpl('oe24.oe24.device.smartphone.tpl._content.article.tpl.articleTextSection', array('section' => $section));
            }
            ?>
        </div>

        <div class="storyOutbrain">
            <? //MH 20170407 MB_11 ist nicht garantiefähige Version der Outbrain-Einbindung
            tpl('oe24.oe24.device.smartphone.assets.vendor.outbrain.articleOutbrain', array('widgetString' => 'MB_11')); ?>
        </div>

        <div class="storyComments">
            <? tpl('oe24.oe24.device.smartphone.tpl._content.article.tpl.articleComments'); ?>
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
