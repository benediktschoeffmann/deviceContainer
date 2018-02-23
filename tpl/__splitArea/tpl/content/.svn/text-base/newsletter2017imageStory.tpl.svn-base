<?php
/**
 * Newsletter 2017 Image Story
 *
 * @var box oe24.core.ContentBox
 * @var channel oe24.core.Channel
 * @var image oe24.core.Image
 * @var url string
 */

if (!$image) {
    return;
}

$emptyImage = linktoPublic('image', 'newsletter/2017/emptyBigStoryTransparent.png');

$imageSrc = $image->getFileUrl();
if (!$imageSrc) {
    $imageSrc = $emptyImage;
}

// ----------------------------------------------

$stylesContentImage = array(
    'display:block',
    'width:100%;',
    'background-color:#f8f8f8',
);

?>
<div>
    <a href="<?= $url; ?>" target="_blank">
        <img src="<?= $imageSrc; ?>" alt="" style="<?= implode(';', $stylesContentImage); ?>">
    </a>
</div>
