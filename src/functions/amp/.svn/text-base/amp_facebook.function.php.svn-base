<?php
function amp_facebook($href, $layout = 'responsive', $width = '400', $height = '200') {
    if ('' === $href) {
        return '';
    }

    if ('' !== $layout) {
        $layout = 'layout="' . $layout .'"';
    }

    if ('' !== $width) {
        $width = 'width="' . $width .'"';
    }

    if ('' !== $height) {
        $height = 'height="' . $height .'"';
    }

    $buffer = array();

    // $buffer[] = '<div class="facebook">';
    $buffer[] = "<amp-facebook $width $height $layout";
    $buffer[] = 'data-href="' . $href . '">';
    $buffer[] = '</amp-facebook>';
    // $buffer[] = '</div>';

    $tag = implode('', $buffer);
    return $tag;
}