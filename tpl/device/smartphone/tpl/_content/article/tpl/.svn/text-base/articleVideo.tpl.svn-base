<?
/**
 * article video
 * @var article oe24.core.Content
 */

// Beispiele am Dev:
// http://oe24dev.oe24.at/_mobile/test/ws/oe24tv/Gegen-Putins-Truppen-waeren-wir-machtlos/161551016?smartphone
// http://oe24dev.oe24.at/_mobile/test/ws/oe24tv/Das-Wetter-morgen/161550633?smartphone
// http://oe24dev.oe24.at/_mobile/import/Wettkampf-25-Meter-steil-nach-oben/161551960?smartphone

if ( ! $article) {
    return;
}

$device = DeviceContainer::getDevice();

$contents = $device->getArticleContents($article);

// $tplName = '_shared.1_0.jwplayer.7_6_1.jwplayerSetup';
$jwplayerTplName = '_shared.1_0.jwplayer.jwplayerSetupProxy';

$showPreTitle = !empty($contents['preTitle']);
$showLeadText = !empty($contents['leadText']);
$showBodyText = !empty($contents['bodyText']);

?>
<div class="articleBox articleVideo">

    <div class="story">

        <? tpl($jwplayerTplName, array('video' => $article, 'events' => array(), )); ?>

        <div class="storyText">
            <div class="storyTextTop clearfix">
                <? if ($showPreTitle) : ?>
                    <strong class="storyPreTitle defaultChannelColor"><?= $contents['preTitle']; ?></strong>
                <? endif; ?>
                <span class="storyDateTime"><?= $contents['dateTime']; ?></span>
            </div>
            <h1 class="storyTitle"><?= $contents['title']; ?></h1>
        </div>

        <? /* (db) 2017-06-28 bei mobilen Videoartikeln Leadtext nicht andrucken */ ?>
        <? if ($showLeadText && 0) : ?>
            <div class="storyText">
                <p class="storyLeadText"><?= $contents['leadText']; ?></p>
            </div>
        <? endif;?>

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

        <? if ($showBodyText) : ?>
            <div class="storyBodyText">
                <?= $contents['bodyText']; ?>
            </div>
        <? endif; ?>

        <? /* (db) 2017-06-28 bei mobilen Videoartikeln Kommentarfunktion nicht andrucken, wird in Desktopversion auch nicht verwendet */ ?>
        <? if (0): ?>
            <div class="storyComments">
                <? tpl('oe24.oe24.device.smartphone.tpl._content.article.tpl.articleComments'); ?>
            </div>
        <? endif; ?>

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
            <? tpl('oe24.oe24.device.smartphone.tpl._content.article.tpl.articleChannelTopStories');
            ?>
        </div>

    </div>



</div>

