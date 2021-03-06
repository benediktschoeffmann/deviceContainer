<?
/**
 * article default
 * @var article oe24.core.Content
 */

// Beispiele am Dev-Server
// http://oe24dev.oe24.at/_mobile/madonna/Das-Schlankgeheimnis-der-Franzoesinnen/161548487?smartphone (Originalartikel)
// http://oe24dev.oe24.at/_mobile/madonna/Das-Geheimnis-der-schlanken-Franzoesinnen/161552703?smartphone
// http://oe24dev.oe24.at/_mobile/test/ws/smartphone/Das-Geheimnis-der-schlanken-Franzoesinnen/161552703?smartphone

if ( ! $article) {
    return;
}

$device = DeviceContainer::getDevice();

$contents = $device->getArticleContents($article);

$classVideo = (true == $contents['isVideoStory']) ? 'videoStory' : '';

$jwplayerTplName = '_shared.1_0.jwplayer.jwplayerSetupProxy';

// -----------------------------------------------------------

// (db) 2017-05-26 Seiten im Artikeldetail
$pages = $article->getTotalBodyPages();

// -----------------------------------------------------------

?>

<div class="articleBox articleDefault">

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
            <? if (1 < $pages): ?>
                <? tpl('oe24.oe24.device.smartphone.tpl._content.article.tpl.articlePaging', array('article' => $article) ); ?>
            <? else: ?>
                <?= $contents['bodyText']; ?>
            <? endif; ?>
        </div>

        <?
            // (db) 2017-10-17 - Nationalratswahl-Ergebnis 2017 bei Nationalratswahlartikeln
            tpl('oe24.oe24.device.smartphone.tpl._content.article.tpl.nationalratswahl2017Widget',
                array(
                    'channel' => $device->getConfig('channel'),
                )
            );
        ?>

        <div class="storyBottom">
            <? tpl('oe24.oe24.device.smartphone.tpl._content.article.tpl.articleSportAdditionalBoxes'); ?>
        </div>

        <div class="storyBottom">
            <?
            // MH 20170407 MB_1 ist garantiefähige Version der Outbrain-Einbindung
            // (bs) 2017-11-03
            // Der richtige WidgetString wird nun im Template selbst vergeben!
            tpl('oe24.oe24.device.smartphone.assets.vendor.outbrain.articleOutbrain', array('widgetString' => 'MB_11'));
            ?>
        </div>

        <div class="storyComments">
            <? tpl('oe24.oe24.device.smartphone.tpl._content.article.tpl.articleComments'); ?>
        </div>

        <div class="storyBottom storyAd">
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


    </div>  <!-- end of story -->

</div>
