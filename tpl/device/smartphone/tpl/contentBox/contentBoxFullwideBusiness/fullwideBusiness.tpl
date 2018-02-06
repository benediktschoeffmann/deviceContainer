<?
/**
 * contentBox Fullwide Business
 *
 * @var channel oe24.core.Channel
 * @var box oe24.core.ContentBox
 */

$device = DeviceContainer::getDevice();

$layoutIdentifier = 'layout_business';
$showStoryTime = false;
$overlay = '';

// TEMPLATEOPTIONS---------------------------

$templateOptions = $box->getTemplateOptions();
$showHeadline = $templateOptions->get('Show-Headline');
$showHeadline = ($showHeadline) ? true : false;

$tradeHeadline = $templateOptions->get('Gewerbe-Headline');
$tradeHeadline = (!$tradeHeadline) ? '&nbsp;' : $tradeHeadline;

$provinceIdentifier = $templateOptions->get('Bundesland');
$provinceIdentifier = (null === $provinceIdentifier) ? 'Wien' : $provinceIdentifier;

$provinceHeadline = $provinceIdentifier;

$columnsCounter = $templateOptions->get('Spalten-Links');
$columnsCounter = (!$columnsCounter) ? 3 : $columnsCounter;

$showLeadtext = $templateOptions->get('Hide-Leadtext');
$showLeadtext = ($showLeadtext) ? false : true;

$colorSchemaLeft = $templateOptions->get('Farbe-Links');
$colorSchemaLeft = (!$colorSchemaLeft) ? '01' : $colorSchemaLeft;
$colorSchemaLeft = 'colorSchema'.$colorSchemaLeft;

$colorSchemaRight = $templateOptions->get('Farbe-Rechts');
$colorSchemaRight = (!$colorSchemaRight) ? '01' : $colorSchemaRight;
$colorSchemaRight = 'colorSchema'.$colorSchemaRight;

$urlLeft = $templateOptions->get('Url-Left');
$urlLeft = ($urlLeft) ? $urlLeft : '#!';

$urlRight = $templateOptions->get('Url-Right');
$urlRight = ($urlRight) ? $urlRight : '#!';

// GET STORIES-------------------------------

$stories = $box->getContentOfAllDropAreas(true);
if (count($stories) < ($columnsCounter + 1)) {
    return;
}

// sidebar auch berücksichtigen.
$stories = array_slice($stories, 0, $columnsCounter + 1);

// PROVINCE INFO -----------------------------

// $tradeUrl = '#!';
// $provinceUrl = '#!';

$tradeUrl = $urlLeft;
$provinceUrl = $urlRight;

$onClickLeft = ('#!' === $urlLeft) ? 'onclick="return false;"' : '';
$onClickRight = ('#!' === $urlRight) ? 'onclick="return false;"' : '';

switch ($provinceIdentifier) {
    case 'Burgenland' :
        $provinceHeadline = 'Burgenland';
        $provinceClass = 'provinceBurgenland';
        break;
    case 'Kaernten' :
        $provinceHeadline = 'Kärnten';
        $provinceClass = 'provinceKaernten';
        break;
    case 'Niederoesterreich' :
        $provinceHeadline = 'Niederösterreich';
        $provinceClass = 'provinceNiederoesterreich';
        break;
    case 'Oberoesterreich' :
        $provinceHeadline = 'Oberösterreich';
        $provinceClass = 'provinceOberoesterreich';
        break;
    case 'Salzburg' :
        $provinceHeadline = 'Salzburg';
        $provinceClass = 'provinceSalzburg';
        break;
    case 'Steiermark' :
        $provinceHeadline = 'Steiermark';
        $provinceClass = 'provinceSteiermark';
        break;
    case 'Tirol' :
        $provinceHeadline = 'Tirol';
        $provinceClass = 'provinceTirol';
        break;
    case 'Vorarlberg' :
        $provinceHeadline = 'Vorarlberg';
        $provinceClass = 'provinceVorarlberg';
        break;
    case 'Wien' :
        $provinceHeadline = 'Wien';
        $provinceClass = 'provinceWien';
        break;
    default :
        break;
}

// ------------------------------------------------------------

$storiesLeft = array();
$storiesRight = array();

foreach ($stories as $key => $story) {

    // zur entsprechenden Story-Position hinzufügen
    if ($key < $columnsCounter) {
        $storiesLeft[] = $story;
    }
    else {
        $storiesRight[] = $story;
    }
}

?>

<? if (count($storiesLeft)): ?>
    <div class="<?= $colorSchemaLeft; ?>">
        <? if ($showHeadline): ?>
            <div class="headlineBox">
                <h2 class="headline defaultChannelBackgroundColor">
                    <a class="clearfix" href="<?= $tradeUrl; ?>" <?= $onClickLeft; ?> >
                        <?= $tradeHeadline; ?>
                    </a>
                </h2>
            </div>
        <? endif; ?>

        <? if(1): ?>
        <?
        tpl('oe24.oe24.device.smartphone.tpl.contentBox.contentBoxStories', array(
            'channel'          => $channel,
            'box'              => $box,
            'stories'          => $storiesLeft,
            'showStoryTime'    => $showStoryTime,
            'overlay'          => $overlay,
            'layoutIdentifier' => $layoutIdentifier,
        ));
        ?>
        <? endif; ?>
    </div>
<? endif; ?>

<? if (count($storiesRight)): ?>
    <div class="<?= $colorSchemaRight; ?>">
        <? if ($showHeadline): ?>
            <div class="headlineBox">
                <h2 class="headline defaultChannelBackgroundColor">

                    <? if (0): ?>
                    <div class="crest">
                        <div class="crestImage"></div>
                    </div>
                    <? endif; ?>

                    <? if (!empty($provinceClass)): ?>
                        <span class="crestImage <?= $provinceClass; ?>"></span>
                    <? endif; ?>

                    <a class="" href="<?= $provinceUrl; ?>" <?= $onClickRight; ?> >
                        <?= $provinceHeadline; ?>
                    </a>

                </h2>
            </div>
        <? endif; ?>

        <? if(1): ?>
        <?
        tpl('oe24.oe24.device.smartphone.tpl.contentBox.contentBoxStories', array(
            'channel'          => $channel,
            'box'              => $box,
            'stories'          => $storiesRight,
            'showStoryTime'    => $showStoryTime,
            'overlay'          => $overlay,
            'layoutIdentifier' => $layoutIdentifier,
        ));
        ?>
        <? endif; ?>
    </div>
<? endif; ?>
