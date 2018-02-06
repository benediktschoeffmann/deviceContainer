<?php
/**
 * xlHeadline representation
 * @var portal       oe24.core.Portal
 * @var box          oe24.core.TemplateBox
 * @var articles     any
 * @var category     string
 * @var device       any
 * @var oewaPath     any
 * @nodevmodecomments
 */

$templateOptions = $box->getTemplateOptions();

$headline = $templateOptions->get('Headline');
if (!$headline || $templateOptions->get('Hide-Mobile-Box')) {
    return;
}

$layoutIdentifier = $templateOptions->get('Layout-Identifier');
$layoutIdentifier = ($layoutIdentifier) ? $layoutIdentifier : 'oe24';
$color = $templateOptions->get('BgColorLeft');
$color = ($color) ? $color : $device->getColorFromLayoutIdentifier($layoutIdentifier);

$headlineArray = array(
    'typ'       => 'headline',
    'headline'  => array(
        'title' => $device->sanitize($headline),
        'color' => $color,
        ),
    );

$device->addData($category, $headlineArray, 'articles', true);
