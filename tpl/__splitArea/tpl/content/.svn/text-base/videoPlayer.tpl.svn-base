<?php
/**
* template to show the video player for telekom/a1
*
* @var content any
* @var area string
* @var overrideAutostart any
* @default overrideAutostart -1
* @var forceAutostart any
* @default forceAutostart 0
* @var forceWideScreen any
* @default forceWideScreen 0
* @var showRelatedVideos any
* @default showRelatedVideos 0
* @var maxRelatedVideos integer
* @default maxRelatedVideos 3
* @var startMuted boolean
* @default startMuted 0
* @var defaultTypeText string
* @default defaultTypeText Video zum Thema
* @var hideInlineHeadline boolean
* @default hideInlineHeadline 0
* @var params any
* @default params 0
*/

if (!$content instanceof Video) {

    if (!$content instanceof Text) {
        return;
    }
    if (!$content->getVideoOptions()) {
        return;
    }

}

switch ($area) {
    case 'StoryInline':
        $additionalVideoClass = '';
        break;
    default:
        $additionalVideoClass = ' noHeadline';
        break;
}

$videoTitle = $content->getTitle();

?>
<div class="video_player<?=$additionalVideoClass;?>">

    <? if (!$hideInlineHeadline): ?>
        <div class="oe2016InlineHeadline">
            <span class="type"><?= $defaultTypeText; ?></span>
            <span class="title"><?=$videoTitle;?></span>
        </div>
    <? endif; ?>

    <?
        // $tplName = '_shared.1_0.jwplayer.7_6_1.jwplayerSetup';
        $tplName = '_shared.1_0.jwplayer.jwplayerSetupProxy';

        tpl($tplName, array(
            'video' => $content,
            'events' => array(),
            'autostart' => $forceAutostart,
            'setMuted' => $startMuted,
            // 'maxRelatedVideos' => 6,
            // 'showThreeVideoInRow' => true,
            'params' => $params,
        ));
    ?>
</div>
