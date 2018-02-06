<?
/**
 * content box
 * @var channel oe24.core.Channel
 * @var box oe24.core.ContentBox
 */

// --------------------------------------------------

$device = DeviceContainer::getDevice();

// --------------------------------------------------

$templateOptions = $box->getTemplateOptions();

// ------------------------------------------

$hideMobileBox = $templateOptions->get('Hide-Mobile-Box');
if ($hideMobileBox) {
    return;
}

// ------------------------------------------

$layoutPortrait = $templateOptions->get('Layout-Portrait');
$layoutPortrait = ($layoutPortrait) ? true : false;

$withChannelTopStories = $templateOptions->get('Channel-Top-Stories');
$withChannelTopStories = ($withChannelTopStories) ? true : false;

$withTopStories = $templateOptions->get('With-Top-Stories');
$withTopStories = ($withTopStories) ? true : false;

$showStoryTime = $templateOptions->get('Show-Story-Time');
$showStoryTime = ($showStoryTime) ? true : false;

$overlay = $templateOptions->get('Overlay');
$overlay = ($overlay) ? $overlay : '';

// ------------------------------------------

$showHeadline = $templateOptions->get('Show-Headline');
$showHeadline = ($showHeadline) ? true : false;

// ------------------------------------------

$bigHeadline = trim($templateOptions->get('Big-Headline'));
$smallHeadline = trim($templateOptions->get('Small-Headline'));

// ------------------------------------------

$externerLink = trim($templateOptions->get('Externer-Link'));
$disableHeadLink = $templateOptions->get('Disable-Head-Link');

$headlineLink = (empty($externerLink)) ? '#!' : $externerLink;
$headlineLink = (true == $disableHeadLink) ? '#!' : $headlineLink;

$onClick = ('#!' === $headlineLink) ? 'onclick="return false;"' : '';

// ------------------------------------------

// Spaltenanzahl der ersten Zeile. Beim Layout Portrait mit drei Stories gelten diese drei Stories als "erste Zeile"
$firstRowColumns = $templateOptions->get('First-Row-Columns');
$firstRowColumns = ($firstRowColumns && ctype_digit($firstRowColumns)) ? (int) $firstRowColumns : 3;
// Im "layoutPortrait" werden nur 3 Stories gezeigt
$firstRowColumns = (true === $layoutPortrait) ? 2 : $firstRowColumns;

// Spaltenanzahl der Folgezeilen
$nextRowsColumns = $templateOptions->get('Next-Rows-Columns');
$nextRowsColumns = ($nextRowsColumns && ctype_digit($nextRowsColumns)) ? (int) $nextRowsColumns : 3;
// Im "layoutPortrait" werden nur 3 Stories gezeigt
$nextRowsColumns = (true === $layoutPortrait) ? 1 : $nextRowsColumns;

// Anzahl der gewuenschten Folgezeilen
$nextRowsCounter = $templateOptions->get('Next-Rows-Counter');
// (db) 2017-07-19 Template 'OE2016 Standard ContentBox Fullwide' hat keine Option 'Next-Rows-Counter', stattdessen Option 'Rows' verwenden -> ohne dem wird nur eine Row angedruckt
$nextRowsCounter =  (!$templateOptions->get('Next-Rows-Counter') && $templateOptions->get('Rows')) ?  $templateOptions->get('Rows') : $nextRowsCounter;

$nextRowsCounter = (null !== $nextRowsCounter && ctype_digit($nextRowsCounter)) ? (int) $nextRowsCounter : 0;

// ------------------------------------------

// (db) 2017-03-10 wenn contentBox nicht in einer Tab liegt, wird Layout von vorheriger TabbedBox genomme
// besser via neue Funktion "isBoxInTabbox" abfragen und Layout via Tabbox oder Channel bekommen
// $tabbedBoxLayoutIdentifier = $device->getConfig('tabbedBoxLayoutIdentifier');
$tabbedBoxLayoutIdentifier = null;
$oBoxOrChannel = isBoxInTabbox($channel, $box, 'Split Area 2016');
if($oBoxOrChannel){
    if($oBoxOrChannel instanceof TabbedBox){
        // Layout aus TabbedBox
        $tabbedBoxOptions = $oBoxOrChannel->getTemplateOptions();
        $tabbedBoxLayoutIdentifier = $tabbedBoxOptions->get("layout-Identifier");
        if(null == $tabbedBoxLayoutIdentifier) {
            $tabbedBoxLayoutIdentifier = $tabbedBoxOptions->get("Layout-Identifier");
        }
    }
    else{
        // layout aus Channel
        $channelOptions = $oBoxOrChannel->getOptions(true);
        $tabbedBoxLayoutIdentifier = $channelOptions->get("layoutOverride");
    }
}


$boxLayoutIdentifier = $templateOptions->get('Layout-Identifier');
// (db) 2017-03-10 unterschiedliche schreibweisen berücksichtigen
if(null == $boxLayoutIdentifier){
    $boxLayoutIdentifier = $templateOptions->get('layout-Identifier');
}

// $layoutIdentifier = ($tabbedBoxLayoutIdentifier) ? $tabbedBoxLayoutIdentifier : 'oe24';
$layoutIdentifier = $tabbedBoxLayoutIdentifier;
if (null == $layoutIdentifier) {
    $layoutIdentifier = $boxLayoutIdentifier;
}
if (null == $layoutIdentifier) {
    $layoutIdentifier = 'oe24';
}

// ------------------------------------------

// Home Channel Top Stories

$homeChannelTopStories = array();

if ($withTopStories) {
    $myHomeChannel = $box->getHomeChannel();
    $homeChannelTopStories = (NULL === $myHomeChannel) ? array() : $myHomeChannel->getTopContents(true, true);
}

// ------------------------------------------

// Drop Area Content Stories

$contentStories = $box->getContentOfAllDropAreas(true);

// Sortieren der Content Stories nach dem "Angezeigtes Datum"

if ($showStoryTime) {
    @usort($contentStories, function($a, $b) {
        $aTimestamp = strtotime((string)$a->getFrontendDate());
        $bTimestamp = strtotime((string)$b->getFrontendDate());
        if ($aTimestamp == $bTimestamp) {
            return 0;
        }
        return ($aTimestamp < $bTimestamp) ? +1 : -1;
    });
}

// ------------------------------------------

// Stories werden doppelt gezeigt, wenn sie sowohl in den Home Channel Top Stories gesetzt sind,
// als auch in der Drop Area der Box, weil sie z.B. aus einer Collection kommen, oder "haendisch" gesetzt wurden.
// Deshalb werden die "gemergten" Stories noch einmal gefiltert, also doppelte Stories ausgeschieden.

$temp = array();

foreach ($homeChannelTopStories as $key => $story) {
    if (!($story instanceof TextualContent)) {
        continue;
    }
    $id = $story->getId();
    $temp[$id] = $story;
}

// schon vorhandene Stories werden jetzt "ueberschrieben"
foreach ($contentStories as $key => $story) {
    if (!($story instanceof TextualContent)) {
        continue;
    }
    $id = $story->getId();
    $temp[$id] = $story;
}

// ------------------------------------------

// Zusammenfassen aller gefundenen Stories. Zugleich die Array-Keys auf nummerisch 0 bis n setzen
$stories = array_values($temp);
if (count($stories) <= 0) {
    return;
}

// ------------------------------------------

// Anzahl der Stories, die gezeigt werden sollen
$maxStories = $firstRowColumns + ($nextRowsColumns * $nextRowsCounter);

$parentChannel = $channel->getParent();

// (db) - 2017-06-09 - wenn parent-channel 'tv', dann maximal 10 andrucken - in News würden sonst nur 3 angedruckt
$maxStories = ('tv' == $parentChannel->getName()) ? 10 : $maxStories;

// (db) - 2017-02-20 - Mobile auf der Startseite nicht mehr als 3 Stories anzeigen
if($parentChannel instanceof Portal){
    $maxStories = ($maxStories>3) ? 3 : $maxStories;
}
// (db) - 2017-02-20 - end
$stories = array_slice($stories, 0, $maxStories);
?>


<? if ($showHeadline): ?>

    <? if ($bigHeadline): ?>

        <div class="headlineBox <?= $layoutIdentifier; ?>">
            <h2 class="headline defaultChannelBackgroundColor">
                <a href="<?= $headlineLink; ?>" <?= $onClick; ?> >
                    <?= $bigHeadline; ?>
                </a>
            </h2>
        </div>

    <? endif; ?>


    <? if ($smallHeadline): ?>

        <div class="headlineBox <?= $layoutIdentifier; ?>">
            <h2 class="headline defaultChannelBackgroundColor">
                <a href="<?= $headlineLink; ?>" <?= $onClick; ?> >
                    <?= $smallHeadline; ?>
                </a>
            </h2>
        </div>

    <? endif; ?>

<? endif; ?>


<?
// ------------------------------------------

tpl('oe24.oe24.device.smartphone.tpl.contentBox.contentBoxStories', array(
    'channel'          => $channel,
    'box'              => $box,
    'stories'          => $stories,
    'showStoryTime'    => $showStoryTime,
    'overlay'          => $overlay,
    'layoutIdentifier' => $layoutIdentifier,
));

// ------------------------------------------

?>
