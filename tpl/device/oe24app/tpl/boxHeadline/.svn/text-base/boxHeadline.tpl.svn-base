<?php
/**
 * Box Headline
 * @var device       any
 * @var category     string
 * @var box          oe24.core.FrontendBox
 * @var useLayoutIdentifier boolean
 * @default useLayoutIdentifier 1
 * @var color       string
 * @default color -1
 * @var headline string
 * @default headline -1
 * @nodevmodecomments
 */

$templateOptions = $box->getTemplateOptions();

if ($headline == '-1') {
    $headline = $templateOptions->get('Headline');
    if (!$headline) {
        $headline = $templateOptions->get('headline');
        if (!$headline) {
            return;
        }
    }
}

// if useLayoutIdentifier is false, use parameter color
$layoutIdentifier = null;
if ($useLayoutIdentifier) {
    $layoutIdentifier = $templateOptions->get('Layout-Identifier');
    $layoutIdentifier = ($layoutIdentifier) ? $layoutIdentifier : $templateOptions->get('layout-Identifier');
    $layoutIdentifier = ($layoutIdentifier) ? $layoutIdentifier : null;

}

$color = ($layoutIdentifier) ?
            $device->getColorFromLayoutIdentifier($layoutIdentifier) :
            $device->getColorFromCategory($category);

$headlineArray = array(
    'typ'       => 'headline',
    'headline'  => array(
        'title' => $device->sanitize($headline),
        'color' => $color,
        ),
    );

$device->addData($category, $headlineArray, 'articles', true);
