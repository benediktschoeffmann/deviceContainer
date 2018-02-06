<?
/**
 * template box
 * @var channel oe24.core.Channel
 * @var box oe24.core.TemplateBox
 */

$templateOptions = $box->getTemplateOptions();

// -------------------------------------------

$module = trim($templateOptions->get('modul'));
$module = ($module) ? $module : 'Ergebnisse';

$apaView = trim($templateOptions->get('apaView'));
$apaView = ($apaView) ? $apaView : '';

$headline = trim($templateOptions->get('Headline'));
$headline = ($headline) ? $headline : '';

// -------------------------------------------

$distanceTop = $templateOptions->get('Abstand-Oben');
$distanceTop = ($distanceTop) ? true : false;

$distanceBottom = $templateOptions->get('Abstand-Unten');
$distanceBottom = ($distanceBottom) ? true : false;

$classDistanceTop = ($distanceTop) ? 'distanceTop' : '';
$classDistanceBottom = ($distanceBottom) ? 'distanceBottom' : '';
$classDistance = trim($classDistanceTop.' '.$classDistanceBottom);

// -------------------------------------------

$dataView = '';

switch ($module) {
    case 'Kalender':
        $dataView = 'widget:calendar';
        break;

    case 'Ergebnisse':
        $dataView = 'widget:result';
        break;

    case 'Teams':
        $dataView = 'widget:teamoverview';
        break;

    case 'Tabellen':
        $dataView = 'widget:standing';
        break;
}

$dataView = (mb_strlen($apaView)) ? $apaView : $dataView;


$id = 'apaWintergames' . $module . $apaView;
$id = str_replace('=', '', $id);
$id = str_replace(':', '', $id);
$id = str_replace('.', '', $id);
$id = str_replace('-', '', $id);
$id = str_replace('_', '', $id);

?>

<div class="olympia2018 <?= $classDistance; ?>">
    <? if ($headline): ?>
        <h2 class="headline"><?= $headline; ?></h2>
    <? endif; ?>
    <div class="apaOuterFrame" data-view="<?= $dataView; ?>" data-package="wintergames" id="<?= $id; ?>"></div>
</div>
