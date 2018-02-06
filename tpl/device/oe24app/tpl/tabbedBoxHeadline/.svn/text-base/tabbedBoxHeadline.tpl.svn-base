<?php
/**
 * Tabbed Box Headline
 * @var device       Oe24App
 * @var category     string
 * @var box          oe24.core.TabbedBox
 * @nodevmodecomments
 */

// check if it is the first tabbedbox in this category
$keyValue = "firstBox_$category";

$firstBox = $device->getConfig($keyValue);
if (!$firstBox) {
    $device->setConfig($keyValue, true);
    return;
}

$options = $box->getTemplateOptions();
$showHeadline = ($options->get('Show-Headline') ||
                 $options->get('show-Headline'));

if (!$showHeadline) {
    return;
}

$headline = $options->get('Headline');
$headline = ($headline) ? $headline : $options->get('headline');

if ($box->getTemplate() === 'oe24.oe24._tabbedBoxes.oe2016tabbedBoxSport24' ||
    $box->getTemplate() === 'oe24.oe24._tabbedBoxes.oe2016tabbedBoxStars24') {
    $headline = $options->get('Small-Headline');
    if (!$headline) {
        $headline = $options->get('Big-Headline');
    }
}

if (!$headline || empty($headline)) {
    return;
}



$layoutIdentifier = $options->get('layout-Identifier');
$layoutIdentifier = ($layoutIdentifier) ? $layoutIdentifier : $options->get('Layout-Identifier');
$layoutIdentifier = ($layoutIdentifier) ? $layoutIdentifier : 'oe24';
$color = $device->getColorFromLayoutIdentifier($layoutIdentifier);

$headlineArray = array(
    'typ'       => 'headline',
    'headline'  => array(
        'title' => $device->sanitize($headline),
        'color' => $color,
        ),
    );

$device->addData($category, $headlineArray, 'articles', true);

