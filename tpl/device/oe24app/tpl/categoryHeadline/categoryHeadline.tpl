<?php
/**
 * Category Headline
 * @var device       any
 * @var category     string
 * @var channelColor string
 * @nodevmodecomments
 */

$headline = (strtoupper($category) === 'FRONTPAGE') ? 'STARTSEITE' : strtoupper($category);

if (!$channelColor || '' == $channelColor) {
    $channelColor = '#d0113a';
}

if (substr($channelColor, 0, 1) != '#') {
    $channelColor = '#' . $channelColor;
}
$headlineArray = array(
    'typ'       => 'headline',
    'headline'  => array(
        'title' => $device->sanitize($headline),
        'color' => $channelColor,
        ),
    );

$device->addData($category, $headlineArray, 'articles', true);
