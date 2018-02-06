<?
/**
 * template box
 * @var channel oe24.core.Channel
 * @var box oe24.core.TemplateBox
 */

$templateOptions = $box->getTemplateOptions();

// -------------------------------------------

$headline = trim($templateOptions->get('Headline'));
$headline = ($headline) ? $headline : '';

// -------------------------------------------

$useCounter = $templateOptions->get('Mit-Zaehler');
$useCounter = ($useCounter) ? true : false;

// -------------------------------------------

$distanceTop = $templateOptions->get('Abstand-Oben');
$distanceTop = ($distanceTop) ? true : false;

$distanceBottom = $templateOptions->get('Abstand-Unten');
$distanceBottom = ($distanceBottom) ? true : false;

// -------------------------------------------

$classDistanceTop = ($distanceTop) ? 'distanceTop' : '';
$classDistanceBottom = ($distanceBottom) ? 'distanceBottom' : '';
$classDistance = $classDistanceTop.' '.$classDistanceBottom;

// -------------------------------------------

$sliderType = $templateOptions->get('Slider-Type');

switch ($sliderType) {

    // case 'Unternehmen Ranking':
    //     $template = 'oe24.oe24.__splitArea.businessSlider.unternehmenRanking';
    //     $classSlider = 'bsUnternehmenRanking';
    //     break;

    // case 'Forbes 100 Ranking':
    //     $template = 'oe24.oe24.__splitArea.businessSlider.forbes100Ranking';
    //     $classSlider = 'bsForbes100Ranking';
    //     break;

    case 'TV-Quoten':
        $template = 'oe24.oe24.device.smartphone.tpl.templateBox.businessSlider.tvQuoten';
    	// $template = 'oe24.oe24.__splitArea.businessSlider.tvQuoten';
        $classSlider = 'bsTvQuotes';
        break;

    // case 'Gewinner/Verlierer':
    //     $template = 'oe24.oe24.__splitArea.businessSlider.gewinnerVerlierer';
    //     $classSlider = 'bsWinnerLoser';
    //     break;

    // case 'Maerkte Live':
    //     $template = 'oe24.oe24.__splitArea.businessSlider.maerkteLive';
    //     $classSlider = 'bsMarketLive';
    //     break;

    default:
        return;
}

// -------------------------------------------

$sliderContent = templateAsString($template, array(
    'channel'      => $channel,
    'box'          => $box,
    'useCounter'   => $useCounter,
    'countColumns' => 1,
));
// debug($sliderContent);
if (null == $sliderContent) {
    return;
}

// -------------------------------------------

$layoutIdentifier = 'business';

// -------------------------------------------

$flickityOptions = array(

    'autoplay'        => false,
    'prevNextButtons' => true,
    'pageDots'        => false,
    // 'groupCells'      => $groupCellsActive,

    // classCounter ist KEINE flickity-Option
    // wird verwendet um die CSS-Klasse des Zaehlerelements zu uebergeben
    'classCounter'    => '.storiesCounter',
);

$options = json_encode($flickityOptions);

?>
<div class="businessSliderBox <?= $layoutIdentifier; ?> <?= $classSlider; ?> <?= $classDistance; ?> ">

<? if (1): ?>
    <? if ($headline): ?>
        <div class="businessSliderBoxHeader">
            <span class="businessSliderBoxHeaderCaption defaultChannelBackgroundColor">
                <span class="businessSliderBoxTitle headline"><?= $headline; ?></span>
            </span>
        </div>
    <? endif; ?>
<? endif; ?>

<? if (1): ?>
    <div class="businessSliderBoxSlider flickitySlider" data-options='<?= $options; ?>'>
        <?= $sliderContent; ?>
        <? if (1): ?><div class="storiesCounter">&nbsp;</div><? endif; ?>
    </div>
<? endif; ?>

<? if (0): ?><?= $sliderContent; ?><? endif; ?>

</div>

