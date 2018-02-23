<?
/**
 * template box
 * @var channel oe24.core.Channel
 * @var box oe24.core.TemplateBox
 */

$templateOptions = $box->getTemplateOptions();

// -------------------------------------------

$module = trim($templateOptions->get('Modul'));
$module = ($module) ? $module : 'Ergebnisse';

$apaView = trim($templateOptions->get('apaView'));
$apaView = ($apaView) ? $apaView : '';

$position = trim($templateOptions->get('Position'));
$position = ($position) ? $position : 'sidebar';

$headline = trim($templateOptions->get('Headline'));
$headline = ($headline) ? $headline : '';

$url = trim($templateOptions->get('Url'));
$url = ($url) ? $url : '';
$url = (mb_strlen($url) && 'http' != mb_substr($url, 0, 4)) ? 'http://' . $url : $url;

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
$additionalAttributes='';

switch ($module) {
    case 'Kalender':
        $dataView = 'widget:calendar';
        break;

    case 'Ergebnisse':
        $dataView = 'widget:result';

        // Speziallfall Ergebnisliste
        //apaview=topic:to547-widget:resultlist-event:8403132-round:73369-season:23999
        if (isset($_GET['apaview'])) {
            $dataView = $_GET['apaview'];
        }
        break;

    case 'Teamoverview':
        $dataView = 'widget:teamoverview';
        break;

    // Team Österreich
    case 'Team':
        $dataView = 'widget:team-team:158';
        break;

    case 'Tabelle-Klein':
        $additionalAttributes = 'data-standing-size="3" data-standing-hasnav="false"';
    case 'Tabellen':
        $dataView = 'widget:standing';

        break;
}

$dataView = (mb_strlen($apaView)) ? $apaView : $dataView;

// ---------------------------------------------

$onClick = (mb_strlen($url)) ? 'onClick="window.location.href = \'' . $url . '\';" style="cursor: pointer;"' : '';

// ---------------------------------------------

$id = 'apaWintergames' . $module . $position . $apaView;
$id = str_replace('=', '', $id);
$id = str_replace(':', '', $id);
$id = str_replace('.', '', $id);
$id = str_replace('-', '', $id);
$id = str_replace('_', '', $id);
$id = str_replace(' ', '', $id);

?>

<div class="olympia2018 <?= $classDistance; ?>" <?= $onClick; ?>>
    <? if ($headline): ?>
        <h2 class="headline"><?= $headline; ?></h2>
    <? endif; ?>
    <div class="apaOuterFrame" data-view="<?= $dataView; ?>" data-package="wintergames" <?= $additionalAttributes; ?> id="<?= $id; ?>"></div>
</div>
