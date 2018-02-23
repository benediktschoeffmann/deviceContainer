<?php
/**
 * Video Layer mit Top-Videos
 * @var channel oe24.core.Channel
 * @var layout string
 * @var oe2016layouts array<string>
 * @var object any
 * @default object 0
 */

$isArticle = ($object && $object instanceof TextualContent);

// blacklists ... channels in der form: 'frontpage/businesslive/'
$dontShowInChannels = array();
$dontShowInLayouts = array('madonna','tv');

$maxClips = 1;

// ----------------------------------------------------------------



$channelPath = "";
$aParents = $channel->getParentChannels(true);
$portal = $channel->getPortal();
foreach ($aParents as $parentChannel) {
    if ($parentChannel->getId() == $portal->getId()){
        continue;
    }

    $channelPath .= $parentChannel->getName() . "/";
}


$displayVideoLayer = (in_array($layout, $dontShowInLayouts)) ? false : true;
$displayVideoLayer = (in_array($channelPath,$dontShowInChannels)) ? false : $displayVideoLayer;
// sicherheitscheck auf oe2016-layouts
$displayVideoLayer = (!isOe2016Layout($layout, $isArticle)) ? false : $displayVideoLayer;

if (!$displayVideoLayer) {
    return;
}

// ----------------------------------------------------------------

// topVideo Contentbox in Entwicklung: 161635156 - produktiv: 322677829
$videoBoxId = (spunQ::inMode(spunQ::MODE_DEVELOPMENT)) ? '161635156' : '322677829';
$box = db()->getById($videoBoxId, 'oe24.core.FrontendBox', false);

if (!$box){
    return;
}

// ----------------------------------------------------------------

$templateOptions = $box->getTemplateOptions();

// ----------------------------------------------------------------

$autostart = $templateOptions->get('autoPlayFirstVideo') ? true : false;

// $textPortalLeft = trim($templateOptions->get('Text-Portal-Left'));
$textPortalLeft = "Jetzt Live auf";

$volume = trim($templateOptions->get('Volume'));
if (!$volume || '' == $volume) {
    $volume = 100;
}

$setMuted = $templateOptions->get('Video-Stumm-Starten') ? true : false;

// ----------------------------------------------------------------

$clips = $box->getContentOfAllDropAreas();
$clips = array_slice($clips, 0, $maxClips);
if (count($clips) < $maxClips) {
    return;
}

// ----------------------------------------------------------------

$clipInfos = array();
$otherVideos = array();
$emptyImg = lp('image', 'empty_2x1.png');
foreach ($clips as $key => $clip) {

    $img = $clip->getFirstRelatedImage();
    if ($img) {
        // $imgSrc = $img->getFileUrl('100x100Crop');
        $imgSrc = $img->getFileUrl('292x146Crop');
        $imgPoster = $img->getFileUrl('620x388');
    } else {
        $imgSrc = $emptyImg;
        $imgPoster = $emptyImg;
    }
    $title = $clip->getTitle();
    $length = ($clip->getVideoLength()) ? $clip->getVideoLength() : '';

    $published = date_format($clip->getPublishDate(), 'd.m.Y H:i');

    $videoId = $clip->getId();

    $videoSrcArray = getVideoSources($clip);

    $isLiveStream = ($clip->getIsLivestream()) ? '1' : '0';

    $url = $clip->getUrl();

    $clipInfos[] = array(
        'id'         => $videoId,
        'imgSrc'     => $imgSrc,
        'poster'     => $imgPoster,
        'title'      => $title,
        'length'     => $length,
        'videoSrc'   => json_encode($videoSrcArray),
        'video'      => $clip,
        'livestream' => $isLiveStream,
        'url'        => $url,
        'published'  => $published,
        );

    if ($key > 0) {
        $otherVideos[] = $clip;
    }
}

// -----------------------------------------------

// $logoPortal  = '/images/oe2016/logo-oe24TV_v2.svg';
$logoPortal  = '/images/oe2016/logo-oe24TV_v3.svg';
$navMainLink = 'http://www.oe24.at/video';

// -----------------------------------------------

$tplName = '_shared.1_0.jwplayer.jwplayerSetupProxy';

?>

<div class="oe24tvTopVideoLayer tvLayerEnd clearfix">

    <? if (0): ?>
        <a class="topVideoBoxHeadline" href="<?= $navMainLink; ?>">

            <div class="oe24tvTopVideoLayerNavContainer">

                <div class="oe24tvTopVideoLayerInnerDiv">
                    <div class="oe24tvTopVideoLayerInnerTable">
                        <div class="navContainerLeft"><?= $textPortalLeft; ?></div>
                        <div class="navContainerRight"><img class="logoPortal" src="<?= $logoPortal; ?>" alt=""></div>
                    </div>
                </div>

            </div>

        </a>
    <? endif; ?>

    <div class="videoLayerClose">&#10005;</div>

    <div class="videoLayerUp">&#x25B2;</div>

    <? if (1): ?>
        <a class="topVideoBoxHeadline" href="<?= $navMainLink; ?>">

            <div class="oe24tvTopVideoLayerNavContainer">

                <div class="oe24tvTopVideoLayerInnerDiv">
                    <div class="oe24tvTopVideoLayerInnerTable headlineContainer">
                        <div class="headlineImg"><img class="logoPortal" src="<?= $logoPortal; ?>" alt=""></div>
                        <div class="headlineTxt">im Live-Stream: Alle News Live</div>
                    </div>
                </div>

            </div>

        </a>
    <? endif; ?>

    <? if (1): ?>
        <div class="oe24tvDescription">
            <a class="oe24tvHeadline" href="<?= $navMainLink; ?>">

                <div class="oe24tvDescriptionTxt oe24tvLayerTable">
                    <div class="oe24tvDescriptionImg"><img class="logoPortal" src="<?= $logoPortal; ?>" alt=""></div>
                    <div class="oe24tvTxtLittle">im</div>
                </div>
                <div class="oe24tvDescriptionTxt">Live-Stream:</div>
                <div class="oe24tvDescriptionTxt">alle News Live</div>

            </a>
        </div>

        <div class="bigClipArea">
            <?
                tpl($tplName, array(
                        'video' => $clips[0],
                        'events' => array(),
                        'autostart' => $autostart,
                        'jsClass' => 'js-oe24tvTopVideoBoxPlayer',
                        'setMuted' => $setMuted,
                        'params'   => array(
                            'volume' => $volume
                            ),
                        // 'otherVideos' => $otherVideos,
                    ));
            ?>
        </div>

    <? endif; ?>

    <? if (0): ?>
        <div class="bigClipArea">
            <?
                tpl($tplName, array(
                        'video' => $clips[0],
                        'events' => array(),
                        'autostart' => $autostart,
                        'jsClass' => 'js-oe24tvTopVideoBoxPlayer',
                        'setMuted' => $setMuted,
                        'params'   => array(
                            'volume' => $volume
                            ),
                        // 'otherVideos' => $otherVideos,
                    ));
            ?>
        </div>

        <div class="smallClipArea">

            <? foreach ($clipInfos as $key => $clip) : ?>
                <a class="smallClip clearfix js-topVideoBoxSmallClip <?= ($key == 0) ? 'active' : ''; ?>" href="#!" data-videosrc='<?= $clip['videoSrc']; ?>' data-videoposter="<?= $clip['poster'];?>" data-livestream="<?= $clip['livestream']; ?>" data-title="<?= $clip['title']; ?>" data-length="<?= $clip['length']; ?>" data-url="<?= $clip['url']; ?>" data-published="<?= $clip['published']; ?>" data-id="<?= $clip['id']; ?>">
                    <div class="clipImageContainer video_container video_container_bottom_left">
                        <img class="smallClipImage" src="<?= $clip['imgSrc']; ?>" alt="">
                    </div>
                    <div class="smallClipText">
                        <span class="smallClipTitle"><?= $clip['title']; ?></span>
                    </div>
                </a>
            <? endforeach; ?>

        </div>
    <? endif; ?>

</div>


