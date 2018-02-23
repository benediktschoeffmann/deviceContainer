<?php
/**
 * Video Overlay
 * @var channel oe24.core.Channel
 * @var box oe24.core.ContentBox
 * @var params any
 * @default params 0
 */

// $caption = (is_array($params) && isset($params['caption']) && is_string($params['caption'])) ? $params['caption'] : 'Mit Video';

// class="svgCaptionBox"
// class="svgTriangle"

?>
<div class="videoButtonOverlay">

    <svg width="162" height="57" viewBox="0 0 162 57" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
        <title>
            videoButton
        </title>
        <defs>
            <path d="M25 50c13.807 0 25-11.193 25-25S38.807 0 25 0 0 11.193 0 25s11.193 25 25 25z" id="a"/>
            <filter x="-50%" y="-50%" width="200%" height="200%" filterUnits="objectBoundingBox" id="d">
                <feOffset dy="1" in="SourceAlpha" result="shadowOffsetOuter1"/>
                <feGaussianBlur stdDeviation="1.5" in="shadowOffsetOuter1" result="shadowBlurOuter1"/>
                <feComposite in="shadowBlurOuter1" in2="SourceAlpha" operator="out" result="shadowBlurOuter1"/>
                <feColorMatrix values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.5 0" in="shadowBlurOuter1"/>
            </filter>
            <mask id="e" x="0" y="0" width="50" height="50" fill="#fff">
                <use xlink:href="#a"/>
            </mask>
            <path d="M24.96 46.96c12.15 0 22-9.85 22-22s-9.85-22-22-22-22 9.85-22 22 9.85 22 22 22z" id="b"/>
            <mask id="f" x="0" y="0" width="44" height="44" fill="#fff">
                <use xlink:href="#b"/>
            </mask>
            <path id="c" d="M19.016 12v26L38 25z"/>
            <filter x="-50%" y="-50%" width="200%" height="200%" filterUnits="objectBoundingBox" id="g">
                <feOffset dy="1" in="SourceAlpha" result="shadowOffsetOuter1"/>
                <feGaussianBlur stdDeviation=".5" in="shadowOffsetOuter1" result="shadowBlurOuter1"/>
                <feComposite in="shadowBlurOuter1" in2="SourceAlpha" operator="out" result="shadowBlurOuter1"/>
                <feColorMatrix values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.298488451 0" in="shadowBlurOuter1"/>
            </filter>
            <mask id="h" x="0" y="0" width="18.984" height="26" fill="#fff">
                <use xlink:href="#c"/>
            </mask>
        </defs>
        <g fill="none" fill-rule="evenodd">
            <path class="svgCaptionBox" d="M108.353 13H0v29h107.75a28.07 28.07 0 0 1-3.71-14 28.057 28.057 0 0 1 4.313-15z" fill="#D0113A"/>
            <g transform="translate(108 3)">
                <use fill="#000" filter="url(#d)" xlink:href="#a"/>
                <use stroke-opacity="0" stroke="#FFF" mask="url(#e)" stroke-width="6" fill="#D8D8D8" xlink:href="#a"/>
                <use stroke="#FFF" mask="url(#f)" stroke-width="6" fill="#D8D8D8" xlink:href="#b"/>
                <g>
                    <use fill="#000" filter="url(#g)" xlink:href="#c"/>
                    <use class="svgTriangle defaultChannelBackgroundColor" stroke="#FFF" mask="url(#h)" stroke-width="4" fill="#D0113A" xlink:href="#c"/>
                </g>
            </g>
            <path d="M13.46 34L9.796 23.143h-.07c.098 1.612.147 3.124.147 4.535V34H8V21h2.91l3.508 10.34h.052L18.08 21H21v13h-1.987v-6.43c0-.645.016-1.487.048-2.524.032-1.038.06-1.666.083-1.885h-.07L15.284 34h-1.824zM25 34V21h2v13h-2zm10.087 0h-2.174V22.823H29V21h10v1.823h-3.913V34zM51.86 21H54l-4.42 13h-2.177L43 21h2.124l2.633 8.083c.14.385.285.882.44 1.49.156.607.257 1.06.303 1.355.075-.45.19-.972.345-1.565.156-.593.282-1.03.38-1.316L51.86 21zM56 34V21h2v13h-2zm16-6.624c0 2.145-.563 3.786-1.69 4.92C69.183 33.433 67.56 34 65.44 34H62V21h3.802c1.956 0 3.48.557 4.566 1.672C71.456 23.786 72 25.354 72 27.376zm-2 .077C70 24.483 68.593 23 65.78 23H64v9h1.46c3.027 0 4.54-1.516 4.54-4.547zM82 34h-7V21h7v1.796h-4.977v3.54h4.664v1.778h-4.664v4.08H82V34zm14-6.504c0 2.056-.52 3.653-1.564 4.794C93.394 33.43 91.918 34 90.01 34c-1.934 0-3.42-.566-4.455-1.697C84.518 31.17 84 29.563 84 27.478c0-2.084.52-3.685 1.564-4.802C86.606 21.56 88.094 21 90.026 21c1.904 0 3.375.567 4.415 1.702 1.04 1.134 1.56 2.732 1.56 4.794zm-10-.505c0 1.643.337 2.89 1.012 3.737.674.85 1.673 1.273 2.997 1.273 1.317 0 2.312-.42 2.983-1.26.67-.84 1.007-2.09 1.007-3.75 0-1.635-.333-2.876-.998-3.722-.665-.845-1.656-1.268-2.974-1.268-1.33 0-2.334.423-3.012 1.268C86.34 24.114 86 25.355 86 26.99z" fill="#FFF"/>
        </g>
    </svg>

</div>
