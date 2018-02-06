<?
/**
* Article Additional Boxes
*/ 


$device = DeviceContainer::getDevice();
$channel = $device->getConfig('channel');
$column = $channel->getColumnByName('Smartphone Artikel');

if (!$column) {
    return;
}

$validBoxTemplates = array(
    'oe24.oe24._htmlBoxes.defaultHtmlBox',
    'oe24.oe24._contentBoxes.oe2016standardContentSlider',
    'oe24.oe24._contentBoxes.oe2016articleTopGelesen',      // verweist auf SP.ContentSlider
);

$boxes = $column->getBoxes();

$boxes = array_filter($boxes, function($box) use ($validBoxTemplates) {
    return (in_array($box->getTemplate(), $validBoxTemplates));
});

if (!$boxes) {
    return;
}

$contents = $device->processBoxes($boxes);

foreach ($contents as $content) {
    echo $content . "\n";
}
