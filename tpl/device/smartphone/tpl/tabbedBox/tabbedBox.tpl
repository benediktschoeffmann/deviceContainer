<?
/**
 * Smartphone Tabbed Box
 *
 * @var channel oe24.core.Channel
 * @var box oe24.core.TabbedBox
 */

$device = DeviceContainer::getDevice();

// --------------------------------------------------

$boxTemplateString = $box->getTemplate();

// --------------------------------------------------

$templateOptions = $box->getTemplateOptions();

// ------------------------------------------

$hideMobileBox = $templateOptions->get('Hide-Mobile-Box');
if ($hideMobileBox) {
    return;
}

// ------------------------------------------

$showHeadline = $templateOptions->get('show-Headline');
$showHeadline = ($showHeadline) ? true : false;

if (false == $showHeadline) {
    // In der Sport-Tabbedbox heisst die Template-Option "Show-Headline" (grosses "S")
    $showHeadline = $templateOptions->get('Show-Headline');
    $showHeadline = ($showHeadline) ? true : false;
}

// ------------------------------------------

$headline = $templateOptions->get('headline');
if (null === $headline || $headline == '') {
    // ditto ... In der Sport-Tabbedbox heisst die Template-Option "Headline" (grosses "H")
    $headline = $templateOptions->get('Headline');

    // (db) 20170221 - im template "OE2016 Tabbed-Box Sport24" sind die Headlines: "Big-Headline" und "Small-Headline"
    if (null === $headline || $headline == '') {
        $headline = $templateOptions->get('Small-Headline');
    }
    if (null === $headline || $headline == '') {
        $headline = $templateOptions->get('Big-Headline');
    }
    // (db) 20170221 - end
}
if (null === $headline || $headline == '') {
    $headline = $channel->getPageTitle();
}

// ------------------------------------------

// (db) 2017-03-10 bisher war überprüfung ob sportTabbedBox oder nicht, wenn Template-Option "Headline" (grosse "H") vorhanden ist - ist nicht überall so - Fallback wurde dadurch auf 'sport' gesetzt, obwohl 'layout-identifier' bereist korrekten Wert gebracht hatte
$layoutIdentifier = $templateOptions->get('layout-Identifier');
if(null == $layoutIdentifier){
    $layoutIdentifier = $templateOptions->get('Layout-Identifier');
}
if (null == $layoutIdentifier) {
    $layoutIdentifier = 'oe24';
}

// if (true == $sportTabbedBox) {
//     $sportLayoutIdentifier = $templateOptions->get('Layout-Identifier');
//     $layoutIdentifier = ($sportLayoutIdentifier) ? $sportLayoutIdentifier : 'sport';
// }
// (db) 2017-03-10 end

// Die Boxen in der TabbedBox sollen den Layout-Identifier abrufen koennen
$device->setConfig('tabbedBoxLayoutIdentifier', $layoutIdentifier);

// ------------------------------------------

$homeChannel = $box->getHomeChannel();
$homeChannelUrl = (null === $homeChannel) ? '#!' : $homeChannel->getUrl();

$externerLink = trim($templateOptions->get('externer-Link'));
$homeChannelUrl = (empty($externerLink)) ? $homeChannelUrl : $externerLink;

// (ws) 2016-05-30 Target im Link einfuegen, wenn gewuenscht
$homeChannelTarget = (empty($externerLink)) ? '' : 'target="_blank"';
// (ws) 2016-05-30 end

$disableHeadLink = $templateOptions->get('disable-Head-Link');
$homeChannelUrl = (true == $disableHeadLink) ? '#!' : $homeChannelUrl;

$onClick = ('#!' === $homeChannelUrl) ? 'onclick="return false;"' : '';

// ------------------------------------------

$contents = array();

$tabbedBoxItems = $box->getTabbedBoxItems();

// ------------------

// Wenn auch die Sidebar-Boxen gezeigt werden sollen, dann die nachfolgende Zeile auskommentieren
$tabbedBoxItems = isset($tabbedBoxItems[0]) ? array_slice($tabbedBoxItems, 0, 1) : array();

// ------------------

foreach ($tabbedBoxItems as $key => $tabbedBoxItem) {

    $boxes = $tabbedBoxItem->getBoxes();

    $keysToDelete = array();

    $temp = array();
    // Boxen in verschachtelten TabbedBoxen ignorieren
    foreach ($boxes as $key => $box) {
        if ($box instanceof TabbedBox) {
            continue;
        }
        $temp[] = $box;
    }

    $boxes = $temp;

    // Index im Array neu erstellen
    $boxes = array_values($boxes);

    // Content der einzelnen Boxen holen
    $contentsOfBoxes = $device->processBoxes($boxes);

    // und eintragen
    $contents[] = implode("\n", $contentsOfBoxes);
}

// ------------------------------------------

// Spezielle Anpassungen fuer die Madonna-TabbedBox ermoeglichen
$madonnaTabbedBox = ('oe24.oe24._tabbedBoxes.oe2016madonnaTabbedBox' == $boxTemplateString) ? true : false;
$layoutIdentifier = ($madonnaTabbedBox) ? 'madonna' : $layoutIdentifier;

// ------------------------------------------

$headlineLogos = array(
    'joe24-logo' => lp('image', 'oe2016/logo-joe24.png'),
);

$headlineLogo = (array_key_exists($layoutIdentifier, $headlineLogos)) ? $headlineLogos[$layoutIdentifier] : '';

?>

<div class="tabbedBox <?= $layoutIdentifier; ?>">

    <? if (true == $showHeadline): ?>

    <div class="headlineBox layout_<?= $layoutIdentifier; ?>">
        <h2 class="headline defaultChannelBackgroundColor">
            <a href="<?= $homeChannelUrl; ?>" <?= $onClick; ?> >
                <?= $headline; ?>
                <? if (!empty($headlineLogo)): ?>
                    <img class="headlineLogo" src="<?= $headlineLogo; ?>" alt="">
                <? endif; ?>
            </a>
        </h2>
    </div>

    <? endif; ?>

    <?
    if ($madonnaTabbedBox) {
        tpl('oe24.oe24.device.smartphone.tpl.templateBox.horoskop.horoskopSigns', array('channel' => $channel));
    }
    ?>

    <?
    foreach ($contents as $content) {
        echo $content."\n";
    }
    ?>

</div>
