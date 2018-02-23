<?
/**
* Story Site
*
* @var channel oe24.core.Channel
* @var params array<any>
* @var object oe24.core.Content
* @var layout string
*/

// -------------------------------------------

$article = $object;
$articleOptions = $article->getOptions(true, true);
$articleId = $article->getId();

// $parentChannels = $channel->getParentChannels();

// -------------------------------------------

// Breadcrumbs

// $icon_house = '&xe603;';

// $breadcrumbs = array();
// foreach ($parentChannels as $parentChannel) {

//  $caption = trim($parentChannel->getPageTitle());
//  $caption = ('' == $caption) ? $icon_house : $caption;
//  $url = $parentChannel->getUrl();

//  $breadcrumbs[] = array('caption' => $caption, 'url' => $url);
// }
// $caption = trim($channel->getPageTitle());
// $url = $channel->getUrl();
// $breadcrumbs[] = array('caption' => $caption, 'url' => $url);

// -------------------------------------------

// Body
$articleHeadline = $article->getTitle();
$articleTeaser = $article->getLeadText(true);

// -------------------------------------------
//Autor anzeigen MH
$author = ($articleOptions->getByKey("showAuthor") && $article->getFrontendAuthor()) ? $article->getFrontendAuthor() : NULL;

// Kommentare anzeigen
$showComments = $articleOptions->getByKey("allowPosting");
if ($showComments === null) {
    $showComments = true;
}

// Hide Social Buttons
$hideSocialButtons = $articleOptions->getByKey("hideSocialButtons");
if ($hideSocialButtons === null) {
    $hideSocialButtons = true;
}

// Print Button anzeigen
$showPrintButton = $articleOptions->getByKey("print");
if ($showPrintButton === null) {
    $showPrintButton = true;
}

// Mail Button anzeigen
$showMailButton = $articleOptions->getByKey("mailto");
if ($showMailButton === null) {
    $showMailButton = true;
}

//Prüfen ob entgeltlicher Content
$showPaidContentMarker = $article->getOptions(true, true)->get('EntgeltlicherContent');
if ($showPaidContentMarker == null) {
        $showPaidContentMarker = false;
}
// -------------------------------------------

// $playerDiv = ptpl('oe24.oe24.__splitArea.tpl.content.videoPlayer', array(
//     'content' => $article,
//     'area' => 'Split-Story-Teaser Area',
//     'forceAutostart' => true,
//     'forceWideScreen' => true,
//     'showRelatedVideos' => true,
//     'maxRelatedVideos' => 4,
//     'hideInlineHeadline' => true,
// ));

// $tplName = '_shared.1_0.jwplayer.7_6_1.jwplayerSetup';
$tplName = '_shared.1_0.jwplayer.jwplayerSetupProxy';

$playerDiv = ptpl($tplName, array(
    'video' => $article,
    'events' => array(),
    'autostart' => true,
    'maxRelatedVideos' => 4,
));

// -------------------------------------------
// Copyright aus 'Quelle' holen.
$copyright = trim($article->getFrontendSource()->getName());
$copyright = trim($copyright, '.');

// -------------------------------------------
// DAILY-914 Datum andrucken.
$frontendDate = $article->getFrontendDate();
setlocale(LC_TIME, 'de_DE');
$prettyFrontendDate = strftime('%e. %B %G, %H:%M', $frontendDate->getTimestamp());


$leadText = trim($article->getLeadText(true));
$showLeadText = !empty($leadText);

?>
<!-- row start -->
<div class="row">
    <div class="oe24tvArticle oe24tvVideo">
        <? $playerDiv->display(); ?>
    </div>
</div>

<div class="row">
    <div class="oe24tvArticle oe24tvCaption">
        <h3 class="videoPreTitle">
            <span><?= $article->getPreTitle(); ?></span>
            <? if (!empty($copyright)): ?>
                <span class="videoCopyright">&copy; <?= $copyright; ?></span>
            <? endif; ?>
        </h3>
        <h2 class="videoTitle"><?= $article->getTitle(); ?></h2>
        <? if ($showLeadText) : ?>
            <p class="videoLeadText">
                <?= $article->getLeadText(); ?>
            </p>
        <? endif; ?>
        <p class="videoDate">
            <?= $prettyFrontendDate; ?>
        </p>
        <? if ($showPaidContentMarker) : ?>
            <div class="row paidContent">entgeltliche Einschaltung</div>
        <? endif; ?>
        <? if (!$hideSocialButtons) : ?>
            <div class="addThisButtons addthis_sharing_toolbox"></div>
        <? endif; ?>
    </div>
</div>
<!-- row end -->

<?
tpl('oe24.oe24.__splitArea._page.standardColumns', array(
    'columnName' => 'Split-Story-Teaser Area',
    'channel' => $channel,
    'object' => $article,
));
