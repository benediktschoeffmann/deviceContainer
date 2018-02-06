<?php
/**
 * WeatherBox representation
 * @var portal       oe24.core.Portal
 * @var box          oe24.core.TemplateBox
 * @var articles     any
 * @var category     string
 * @var device       any
 * @var oewaPath     any
 * @nodevmodecomments
 */

$keyValue = "firstBox_$category";
$firstBox = $device->getConfig($keyValue);
if (!$firstBox) {
    $device->setConfig($keyValue, true);
}

$link = 'http://www.oe24.at'.l('oe24.oe24.oe24app.getWeatherBox', array('boxId' => $box->getId()));

$weather = array(
    'typ' => 'weatherBox',
    'weatherBox'  => array(
        'url' => $link,
    ),
);

$device->addData($category, $weather, 'articles', true);
