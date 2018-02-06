<?
/**
 * wahl charts
 *
 * @var channel oe24.core.Channel
 * @var box oe24.core.TemplateBox
 */

// ------------------------------------------------------

// Commit DAILY-890
// ----------------
// public/images/charts
// src/functions/collectorOe2016/collectHeadCss.function.php
// src/functions/collectorOe2016/collectBottomJs.function.php
// src/functions/hex2rgba.function.php
// tpl/_templateBoxes/oe2016wahlCharts.tpl
// tpl/__splitArea/css/oe2016/oe2016wahlCharts.css
// tpl/__splitArea/js/oe2016/oe2016wahlCharts.js
// tpl/device/smartphone/tpl/_urlsHead.php
// tpl/device/smartphone/tpl/_urlsBottom.php
// tpl/device/smartphone/tpl/templateBox/wahlCharts/wahlCharts.tpl
// tpl/device/smartphone/tpl/templateBox/wahlCharts/wahlCharts.css

// Links
// -----
// http://www.chartjs.org/docs/latest/
// https://stackoverflow.com/questions/tagged/chart.js
// http://mekshq.com/how-to-convert-hexadecimal-color-code-to-rgb-or-rgba-using-php/
// http://tobiasahlin.com/blog/chartjs-charts-to-get-you-started/
// https://github.com/emn178/Chart.PieceLabel.js

// ------------------------------------------------------

// $device = DeviceContainer::getDevice();

// ------------------------------------------------------

// Template Optionen Start

$templateOptions = $box->getTemplateOptions();

$chartCaption    = $templateOptions->get('Diagramm-Titel');
$barChartCaption = $templateOptions->get('Bar-Diagramm-Titel');
$pieChartCaption = $templateOptions->get('Kreis-Diagramm-Titel');
$chartSource     = $templateOptions->get('Daten-Quelle');

$parteien = $templateOptions->get('Kandidaten');
$colors = $templateOptions->get('Farben');

$valuesNew = $templateOptions->get('Neue-Werte');
$valuesOld = $templateOptions->get('Alte-Werte');

// Zwecks Test
// Wenn keine alten Werte eingegeben wurden, wird der
// Bar-Chart-Type auf jeden Fall auf 'bar' ungestellt
// $valuesOld = '';

$mandate = $templateOptions->get('Mandate');

$barDiagramType = $templateOptions->get('Bar-Diagramm-Type');

$barChartUrl = $templateOptions->get('Bar-Diagramm-URL');
$pieChartUrl = $templateOptions->get('Kreis-Diagramm-URL');

// * @templateOption Ohne-Bar-Diagramm checkbox
// $withoutBarChart = $templateOptions->get('Ohne-Bar-Diagramm');
// $showBarChart = !$withoutBarChart;

$withoutPieChart = $templateOptions->get('Ohne-Kreis-Diagramm');

$distanceTop = $templateOptions->get('Abstand-oben');
$distanceBottom = $templateOptions->get('Abstand-unten');

// -------------------------------------------

$classDistanceTop = ($distanceTop) ? 'distanceTop' : '';
$classDistanceBottom = ($distanceBottom) ? 'distanceBottom' : '';

// Template Optionen Ende

// ------------------------------------------------------

// TODO: Ueberpruefen, ob die relevanten Textfelder ausgefuellt sind
// -> Parteien, Farben, Neue Werte, Mandate

$parteien  = explode(';', trim($parteien,  ' ;'));
$colors    = explode(';', trim($colors,    ' ;'));
$valuesNew = explode(';', trim($valuesNew, ' ;'));
$valuesOld = explode(';', trim($valuesOld, ' ;'));
$mandate   = explode(';', trim($mandate,   ' ;'));

// ------------------------------------------------------

// Ueberpruefen, ob die Anzahl der Eingabedaten fuer ALLE notwendigen Angaben uebereinstimmt

$referenceCount = count($parteien);

$countColors    = count($colors);
$countValuesNew = count($valuesNew);
$countValuesOld = count($valuesOld);
$countMandate   = count($mandate);

// ------------------------------------------------------

$chartTypeBar = ('Nur Neue Werte' == $barDiagramType) ? 'bar' : 'barGroup';
$chartTypePie = 'pie';

// Ist der Eingabe-String leer, liefert explode(';', {string})
// ein Array mit einem Eintrag -> array(0 => '').

if (empty($valuesOld) || ($countValuesOld == 1 && empty($valuesOld[0]))) {
    $chartTypeBar = 'bar';
}

// ------------------------------------------------------

try {

    if ($referenceCount == 1 && empty($parteien[0])) {
        $message = 'Offenbar wurden keine Kandidaten angegeben.';
        throw new Exception($message);
    }

    if ($countColors != $referenceCount) {
        $message = 'Anzahl der Parteifarben stimmt nicht mit der Anzahl der Parteien ueberein.';
        throw new Exception($message);
    }

    if ($countValuesNew != $referenceCount) {
        $message = 'Anzahl der neuen Stimmen stimmt nicht mit der Anzahl der Parteien ueberein.';
        throw new Exception($message);
    }

    if ($countMandate != $referenceCount) {
        $message = 'Anzahl der Mandate stimmt nicht mit der Anzahl der Parteien ueberein.';
        throw new Exception($message);
    }

    // Wenn die "alten" Werte nicht eingegeben wurden ist der Bar-Chart-Type 'bar'
    // und die Ueberpruefung der Anzahl der Eintraege entfaellt.

    // debug('barGroup'.' == '.$chartTypeBar.' && '.$countValuesOld.' != '.$referenceCount);

    if ('barGroup' == $chartTypeBar && $countValuesOld != $referenceCount) {
        $message = 'Anzahl der alten Stimmen stimmt nicht mit der Anzahl der Parteien ueberein.';
        throw new Exception($message);
    }

} catch (Exception $e) {

    // do something with the error

    error($e->getMessage());
    return;
}

// ------------------------------------------------------

$parteien = array_map(function($item) {
    return trim($item);
}, $parteien);

$colors = array_map(function($item) {
    return '#'.trim($item, ' #');
}, $colors);

$valuesNew = array_map(function($item) {
    $temp = str_replace(',', '.', trim($item));
    return floatval($temp);
}, $valuesNew);

$valuesOld = array_map(function($item) {
    $temp = str_replace(',', '.', trim($item));
    return floatval($temp);
}, $valuesOld);

$mandate = array_map(function($item) {
    return intval(trim($item));
}, $mandate);

// ------------------------------------------------------

// echo var_export($parteien, true)."\n";
// echo var_export($colors, true)."\n";
// echo var_export($valuesNew, true)."\n";
// echo var_export($valuesOld, true)."\n";
// echo var_export($mandate, true)."\n";

// exit;

// ------------------------------------------------------

$colorsNew = array_map(function($color) {
    return hex2rgba($color, 1.0);
}, $colors);

$colorsOld = array_map(function($color) {
    return hex2rgba($color, 0.15);
}, $colors);

// ------------------------------------------------------
// ------------------------------------------------------

// Stimmverteilung fuer Bar-Chart

$stimmVerteilung = array(
    'parteien' => $parteien,
    'colors'   => ('barGroup' == $chartTypeBar) ? array($colorsOld, $colorsNew) : array($colorsNew),
    'data'     => ('barGroup' == $chartTypeBar) ? array($valuesOld, $valuesNew) : array($valuesNew),
);

// echo $chartTypeBar."\n";
// echo var_export($stimmVerteilung, true)."\n";
// exit;

// ------------------------------------------------------
// ------------------------------------------------------

// Mandatsverteilung fuer Pie-Chart. Parteien mit "0" Mandaten herausfiltern.
// In ALLEN Arrays muessen die korrespontierenden Eintraege geloescht werden.

$indexListWithZero = array();

foreach ($mandate as $key => $value) {
    if ($value <= 0) {
        $indexListWithZero[] = $key;
    }
}

$mandateParteien = array();
$mandateColors   = array();
$mandateData     = array();

if (defined('ARRAY_FILTER_USE_KEY')) {

    $mandateParteien = array_filter($parteien, function($key) use ($indexListWithZero) {
        return (in_array($key, $indexListWithZero)) ? false : true;
    }, ARRAY_FILTER_USE_KEY);
    $mandateParteien = array_slice($mandateParteien, 0);

    $mandateColors = array_filter($colors, function($key) use ($indexListWithZero) {
        return (in_array($key, $indexListWithZero)) ? false : true;
    }, ARRAY_FILTER_USE_KEY);
    $mandateColors = array_slice($mandateColors, 0);

    $mandateData = array_filter($mandate, function($key) use ($indexListWithZero) {
        return (in_array($key, $indexListWithZero)) ? false : true;
    }, ARRAY_FILTER_USE_KEY);
    $mandateData = array_slice($mandateData, 0);

} else {

    $mandateParteien = array_filter($parteien, function($value) use ($indexListWithZero, $parteien) {
        $key = array_search($value, $parteien);
        return (in_array($key, $indexListWithZero)) ? false : true;
    });
    $mandateParteien = array_slice($mandateParteien, 0);

    $mandateColors = array_filter($colors, function($value) use ($indexListWithZero, $colors) {
        $key = array_search($value, $colors);
        return (in_array($key, $indexListWithZero)) ? false : true;
    });
    $mandateColors = array_slice($mandateColors, 0);

    $mandateData = array_filter($mandate, function($value) use ($indexListWithZero, $mandate) {
        $key = array_search($value, $mandate);
        return (in_array($key, $indexListWithZero)) ? false : true;
    });
    $mandateData = array_slice($mandateData, 0);

}

$mandatsVerteilung = array(
    'parteien' => $mandateParteien,
    'colors'   => array($mandateColors),
    'data'     => array($mandateData),
);

// echo var_export($mandateParteien, true)."\n";
// echo var_export($mandateColors, true)."\n";
// echo var_export($mandateData, true)."\n";

// ------------------------------------------------------
// ------------------------------------------------------

// echo var_export($stimmVerteilung, true)."\n";
// echo var_export($mandatsVerteilung, true)."\n";
// exit;

// ------------------------------------------------------

$jsonOption = (defined('JSON_PRETTY_PRINT')) ? JSON_PRETTY_PRINT : null;

$barChartData = json_encode($stimmVerteilung, $jsonOption);
$pieChartData = json_encode($mandatsVerteilung, $jsonOption);

// echo var_export($barChartData, true)."\n";
// echo var_export($pieChartData, true)."\n";

// ------------------------------------------------------

$showPieChart = !$withoutPieChart;
$classShowPieChart = ($showPieChart) ? 'showPieChart' : '';

// ------------------------------------------------------

// Links fuer mobil ausschalten

// $barChartUrl = (empty($barChartUrl)) ? '#!' : $barChartUrl;
// $pieChartUrl = (empty($pieChartUrl)) ? '#!' : $pieChartUrl;

// $barChartUrl = '#!';
// $pieChartUrl = '#!';

// $barChartOnClick = ('#!' == $barChartUrl) ? 'return false;' : '';
// $pieChartOnClick = ('#!' == $pieChartUrl) ? 'return false;' : '';

// ------------------------------------------------------

$defaultFontSize = '11';

?>
<div class="chartContainer <?= $classShowPieChart; ?> <?= $classDistanceTop; ?> <?= $classDistanceBottom; ?>">


    <div class="chartHeader">
        <h2 class="chartCaption"><?= $chartCaption; ?></h2>
    </div>


    <div class="chartContent">


        <!-- Bar Chart -->


        <? if (1):?>
            <span class="chartCell barChart chartCellCaption">
                <span><?= $barChartCaption; ?></span>
            </span>
        <? endif; ?>


        <? if (1):?>
            <span class="chartCell barChart barChartData">
                <canvas class="chart barChart"
                    data-chart-type="<?= $chartTypeBar; ?>"
                    data-default-font-size="<?= $defaultFontSize; ?>"
                    data-chart-data='<?= $barChartData; ?>'>
                </canvas>
            </span>
        <? endif; ?>


        <? if (1): ?>
            <span class="chartCell barChart">
                <div class="legendContainer">
                    <div class="legendBox">
                        <? foreach ($stimmVerteilung['parteien'] as $key => $value): ?>

                            <?

                            // Die "eigenartige" Indizierung der Werte folgt aus
                            // der Aufbereitung der Datenstrukturen fuer Chart.js

                            // Die Daten stehen je nach verwendetem ChartBar-Type
                            // an der Stelle [0] ('bar' == $chartTypeBar) bzw.
                            // an der Stelle [1] ('barGroup' == $chartTypeBar)

                            $useIndex = 0;

                            if ('barGroup' == $chartTypeBar) {

                                $useIndex = 1;

                                $difference = $stimmVerteilung['data'][1][$key] - $stimmVerteilung['data'][0][$key];

                                $difference = ($difference > 0) ? '+'.$difference : $difference;
                                $diffColor = ($difference < 0) ? '#c00' : ((0 == $difference) ? '#000' : '#090');

                                // Anzeige der Fliesskommazahlen mit "," Zeichen
                                $legendDifference = str_replace('.', ',', $difference);
                            }

                            $legendValue = str_replace('.', ',', $stimmVerteilung['data'][$useIndex][$key]) . '%';

                            ?>

                            <div class="legend">
                                <span class="value"><?= $legendValue; ?></span>
                                <span class="divider" style="background-color:<?= $stimmVerteilung['colors'][$useIndex][$key]; ?>">&nbsp;</span>
                                <? if ('barGroup' == $chartTypeBar): ?>
                                    <span class="value" style="color:<?//= $diffColor; ?>"><?= $legendDifference; ?></span>
                                <? endif; ?>
                            </div>

                        <? endforeach; ?>
                    </div>
                </div>
            </span>
        <? endif; ?>


        <!-- Pie Chart -->


        <? if ($showPieChart): ?>


            <? if (1):?>
                <span class="chartCell pieChart chartCellCaption">
                    <span><?= $pieChartCaption; ?></span>
                </span>
            <? endif; ?>


            <? if (1):?>
                <span class="chartCell pieChart pieChartData">
                    <canvas class="chart pieChart"
                        data-chart-type="<?= $chartTypePie; ?>"
                        data-default-font-size="<?= $defaultFontSize; ?>"
                        data-chart-data='<?= $pieChartData; ?>'>
                    </canvas>
                </span>
            <? endif; ?>


            <? if (1):?>
                <span class="chartCell pieChart">
                    <div class="legendContainer">
                        <div class="legendBox">
                            <? foreach ($mandatsVerteilung['parteien'] as $key => $value): ?>
                                <div class="legend">
                                    <span class="value"><?= $value; ?></span>
                                    <span class="divider" style="background-color:<?= $mandatsVerteilung['colors'][0][$key]; ?>">&nbsp;</span>
                                    <span class="value"><?= $mandatsVerteilung['data'][0][$key]; ?></span>
                                </div>
                            <? endforeach; ?>
                        </div>
                    </div>
                </span>
            <? endif; ?>


        <? endif; ?>


    </div>

    <? if (1): ?>
    <div class="chartFooter">
        <p class="chartSource"><?= $chartSource; ?></p>
    </div>
    <? endif; ?>

</div>


<script src="/images/charts/Chart.min.js"></script>

