<?
/**
 * standard channel
 * @var device any
 */

if (!$device instanceof Smartphone) {
    return;
}

$contents = $device->getChannelContents();

foreach ($contents as $content) {
    echo $content."\n";
}
