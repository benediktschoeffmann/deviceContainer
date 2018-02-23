<?php
/**
 * HtmlBox Representation
 * @var box          oe24.core.FreeHtmlBox
 * @var category     string
 * @var device       any
 * @nodevmodecomments
 */

$keyValue = "firstBox_$category";
$firstBox = $device->getConfig($keyValue);
if (!$firstBox) {
    $device->setConfig($keyValue, true);
}

$html = $box->getHtml();

$needles = array(
    '<div class="mobileHtmlBox"',
    );

$goodBox = false;
foreach ($needles as $needle) {
    if (strpos($html, $needle) !== false) {
        $goodBox = true;
        break;
    }
}

$olympiaNeedle = 'olympialiveblog';
$olympiaBlog = false;


if (strpos($html, $olympiaNeedle) !== false) {
    $goodBox = true;
    $olympiaBlog = true;
}


if (!$goodBox) {
    return;
}

if ($olympiaBlog) {
    $html = '<a href="http://sport.oe24.at/olympia-2018/liveblog" target="_blank">'.$html.'</a>';
}


$base64 = base64_encode($html);
$returnArray = array(
    'typ'       => 'htmlBox',
    'htmlBox'   => array(
        'content' => $base64,
        'ratio'   => '0.5',
    ),

);

$device->addData($category, $returnArray, 'articles', true);
