<?php

function amp_youtube($id, $layout = 'responsive', $width='480', $height='270') {
    $buffer = array();
    $buffer[] = '<amp-youtube data-videoid="';
    $buffer[] = $id . '" layout="'.$layout.'"';
    $buffer[] = 'width="'.$width.'" ';
    $buffer[] = 'height="'.$height.'"></amp-youtube>';

    $youtubeTag = implode('', $buffer);
    return $youtubeTag;
}
