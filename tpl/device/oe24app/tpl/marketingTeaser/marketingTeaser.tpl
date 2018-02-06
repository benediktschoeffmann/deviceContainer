<?php
/**
 * MarketingTeaser as Html Box
 * @var box          oe24.core.ContentBox
 * @var articles     array<oe24.core.TextualContent>
 * @var category     string
 * @var device       any
 * @nodevmodecomments
 */

$keyValue = "firstBox_$category";
$firstBox = $device->getConfig($keyValue);
if (!$firstBox) {
    $device->setConfig($keyValue, true);
}

$articlesPerCategory = $device->getConfig('articlesPerCategory');
if ($category != 'frontpage' && $articlesPerCategory >= 19) {
    break;
}
$device->setConfig('articlesPerCategory', ($articlesPerCategory+1));

$article = reset($articles);

$image = $article->getFirstRelatedImage(true, $box);
if (!$image) {
    return;
}

//$imageSrc = $image->getFileUrl('XL-Konsole');
$imageSrc = $image->getFileUrl('Oe24AppXL-Konsole');
$url = $article->getUrl(true, $box);
$file = $image->getOriginalFile();
$path = $file->getPath();

$imageInfo = getimagesize($path);

// $ratio = number_format(($imageInfo[1] / $imageInfo[0]), 3);
$ratio = (($imageInfo[1]) / $imageInfo[0]);

$html = array();
// $html[] = '<div style="width: 100%">';
$html[] = '<html><head></head><body style="margin: 0; padding:0; width:100%;">';
$html[] = '<a href="'.$url.'" target="_self" style="display: block; width:100%; margin: 0; padding: 0;">';
$html[] = '<img style="display:block; width:100%;margin:0;padding:0;" src="'.$imageSrc.'">';
$html[] = '</a>';
$html[] = '</body></html>';

// $html[] = '</div>';

$htmlText = implode("", $html);
$base64Html = $device->encodeBodyText($htmlText);

$returnArray = array(
    'typ'   => 'htmlBox',
    'htmlBox' => array(
        'content' => $base64Html,
        'ratio' => $ratio,
    ),
);

$device->addData($category, $returnArray, 'articles', true);
