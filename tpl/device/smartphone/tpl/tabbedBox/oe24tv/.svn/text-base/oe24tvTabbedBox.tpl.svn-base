<?
/**
 * Smartphone oe24tv Tabbed Box
 *
 * @var channel oe24.core.Channel
 * @var box oe24.core.TabbedBox
 */

// --------------------------------------------------

$smartphone = Smartphone::getInstance();

// --------------------------------------------------

$templateOptions = $box->getTemplateOptions();

// ------------------------------------------

$hideMobileBox = $templateOptions->get('Hide-Mobile-Box');
if ($hideMobileBox) {
    return;
}

// ------------------------------------------

$showHeadlineLeft = $templateOptions->get('Show-Headline-Left');
$showHeadlineLeft = ($showHeadlineLeft) ? true : false;

$showHeadlineRight = $templateOptions->get('Show-Headline-Left');
$showHeadlineRight = ($showHeadlineRight) ? true : false;

// ------------------------------------------

$headlineLeft = $templateOptions->get('Headline-Left');
if (null === $headlineLeft || $headlineLeft == '') {
    $headlineLeft = $channel->getPageTitle();
}

$headlineRight = $templateOptions->get('Headline-Left');
if (null === $headlineRight || $headlineRight == '') {
    $headlineRight = '';
}

// ------------------------------------------

$layoutIdentifier = $templateOptions->get('Layout-Identifier');
if (!$layoutIdentifier) {
    $layoutIdentifier = 'oe24';
}

// Die Boxen in der TabbedBox sollen den Layout-Identifier abrufen koennen
$smartphone->setConfig('tabbedBoxLayoutIdentifier', $layoutIdentifier);

// ------------------------------------------

$homeChannel = $box->getHomeChannel();
$homeChannelUrl = (null === $homeChannel) ? '#!' : $homeChannel->getUrl();

$externerLink = trim($templateOptions->get('externer-Link'));
$homeChannelUrl = (empty($externerLink)) ? $homeChannelUrl : $externerLink;

$mainHeadlineUrl = trim($templateOptions->get('Headline-Left-Url'));
$homeChannelUrl = (empty($mainHeadlineUrl)) ? $homeChannelUrl : $mainHeadlineUrl;


// (ws) 2016-05-30 Target im Link einfuegen, wenn gewuenscht
$homeChannelTarget = (empty($externerLink)) ? '' : 'target="_blank"';
// (ws) 2016-05-30 end

$disableHeadLink = $templateOptions->get('disable-Head-Link');
$homeChannelUrl = (true == $disableHeadLink) ? '#!' : $homeChannelUrl;

$onClick = ('#!' === $homeChannelUrl) ? 'onclick="return false;"' : '';

// ------------------------------------------

$contents = array();

$tabbedBoxItems = $box->getTabbedBoxItems();

foreach ($tabbedBoxItems as $key => $tabbedBoxItem) {

    $boxes = $tabbedBoxItem->getBoxes();

    // Boxen in verschachtelten TabbedBoxen ignorieren
    foreach ($boxes as $key => $box) {
        if ($box instanceof TabbedBox) {
            unset($boxes[$key]);
        }
    }

    // Index im Array neu erstellen
    $boxes = array_values($boxes);

    // Content der einzelnen Boxen holen
    $contentsOfBoxes = $smartphone->processBoxes($boxes);

    // und eintragen
    $contents[] = implode("\n", $contentsOfBoxes);
}

?>

<div class="tabbedBox">

    <? if (true == $showHeadlineLeft): ?>

    <div class="headlineBox <?= $layoutIdentifier; ?>">
        <h2 class="headline defaultChannelBackgroundColor">
            <a href="<?= $homeChannelUrl; ?>" <?= $onClick; ?> ><?= $headlineLeft; ?></a>
        </h2>
    </div>

    <? endif; ?>

    <?
    foreach ($contents as $content) {
        echo $content."\n";
    }
    ?>

</div>
