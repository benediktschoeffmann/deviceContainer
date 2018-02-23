<?
/**
* Article-Detail Sidebar
*
* @var channel oe24.core.Channel
* @var showAds boolean
* @default showAds 1
*/


/* (bs) DAILY-807 Glomex Einbindung */
$showContentadSky1 = true;

$channelFound = false;
$parentChannels = $channel->getParentChannels(true);
foreach ($parentChannels  as $key => $c) {
    if ($c->getName() == 'news') {
         $glomexId1 = 'teaser-1mcujg57pj4h28hyh';
         $glomexId2 = 'j32yagsl';
         $channelFound = true;
         break;
    }
    if ($c->getName() == 'sport') {
         $glomexId1 = 'teaser-1mcujg51lj4h253b2';
         $glomexId2 = 'j32yagsl';
         $channelFound = true;
         break;
    }
    if ($c->getName() == 'leute' || $c->getName() == 'madonna' || $c->getName() == 'lifestyle') {
         $glomexId1 = 'teaser-1mcujg56jj4h274l9';
         $glomexId2 = 'teaser-1mcujg58gj4h29mpp';
         $channelFound = true;
         break;
    }
    if ($c->getName() == 'auto') {
         $glomexId1 = 'teaser-1mcujg5bsj4h2htpi';
         $glomexId2 = 'j32yagsl';
         $channelFound = true;
         break;
    }
}
if (!$channelFound) {
    $glomexId1 = 'j32yagsl';
    $glomexId2 = 'teaser-1mcujg57pj4h28hyh' ;
}
/* (bs) Glomex End */



$tvTemplate = 'oe24.oe24._templateBoxes.oe24tvSidebarVideoBoxArticle';
$tvBox = false;
$validSidebarBoxes = array(
    'oe24.oe24._htmlBoxes.defaultHtmlBox',
    'oe24.oe24._contentBoxes.oe2016sidebarRadioBox',
    'oe24.oe24._contentBoxes.oe2016marketingTeaser',
    'oe24.oe24._contentBoxes.oe2016sidebarCoverBox',
    'oe24.oe24._contentBoxes.oe2016contentKochenRezeptsuche',
    'oe24.oe24._contentBoxes.oe2016sidebarStoriesMadonna',
    'oe24.oe24._contentBoxes.oe2016sidebarVideoBox',
    'oe24.oe24._contentBoxes.oe2016sidebarMagazinGewinnspiel',
);

$columnName = 'Split-Story-Teaser Area';
$column = $channel->getColumnByName($columnName, !State::getInstance()->getIsPreview(), true);
$boxes = $column->getBoxes();

$sidebarBoxes = array();
foreach ($boxes as $box) {
    $templateOptions = $box->getTemplateOptions();
    $showInArticle = $templateOptions->get('Show-In-Article');
    $showInArticle = ($showInArticle) ? true : false;
    if (false == $showInArticle) {
        continue;
    }

    if ($box->getTemplate() === $tvTemplate) {
        $tvBox = $box;
        $showContentadSky1 = false;
        continue;
    }

    if (in_array($box->getTemplate(), $validSidebarBoxes)) {
        $sidebarBoxes[] = $box;
    }
}

?>

<?
/*
 2017-05-23
 Das Ttemplate 'oe24.oe24.adition.adSlot' soll im Template tpl/_templateBoxes/oe24tvSidebarVideoBoxArticle.tpl im div oe24tvArticleSidebarVideoBox zwischen div.player und div.videoClips ausgespielt werden, wenn die VideoBox ausgespielt wird
*/


?>

<div id="sidebarContainerTopBox">

<?

    if ($tvBox) {
        tpl(
            $tvBox->getTemplate(),
            array(
                'box'     => $tvBox,
                'channel' => $channel,
                'column'  => $column,
            )
        );
    }


    if ($showAds && true == $showContentadSky1) {
        tpl(
            'oe24.oe24.adition.adSlot',
            array(
                'channel' => $channel,
                'id' => 'Contentad_Sky1'
            )
        );
    ?>

    <? // (bs) 2017-05-31 Glomex Einbindung
       // spielt bei aktiviertem AdBlocker auch Werbung aus ?>

        <div id="glomexCad_1" data-glomexid="<?= $glomexId1; ?>" style="width:300px;">
        </div>
    <?
}

?>
<? if ($showAds) : ?>
    <div id="glomexCad_2" data-glomexid="<?= $glomexId2; ?>" style="width:300px;"></div>
<? endif; ?>
<?


foreach ($sidebarBoxes as $sidebarBox) {
    tpl(
        $sidebarBox->getTemplate(),
        array(
            'box'     => $sidebarBox,
            'channel' => $channel,
            'column'  => $column,
        )
    );

}
?>

</div>
