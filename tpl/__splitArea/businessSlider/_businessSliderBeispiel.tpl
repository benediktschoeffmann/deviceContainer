<?php
/**
 * OE2016 Business Slider Beispiel
 *
 * @var channel oe24.core.Channel
 * @var box oe24.core.TemplateBox
 * @var useCounter boolean
 * @var countColumns integer
 * @default useCounter 0
 */

// -------------------------------------------

$useCounter = (true === $useCounter || false === $useCounter || 0 === $useCounter) ? $useCounter : false;

// -------------------------------------------

// Daten der einzelnen Slides, wo auch immer die herkommen
// Die Slides muessen per CSS noch gestyled werden.

$slides = array();

for ($i = 0; $i < 16; $i++) {
    $slides[] = array(
        'text' => 'Bill Gates',
        'unternehmen' => 'Software / Microsoft',
        'url'  => 'http://www.oe24.at',
        // ...
    );
}

// -------------------------------------------

$countSlides = count($slides);

if ($countSlides <= 0) {
    return null;
}

// -------------------------------------------

tpl('oe24.oe24.__splitArea.businessSlider._businessSlider', array(
    'channel'      => $channel,
    'box'          => $box,
    'slides'       => $slides,
    'useCounter'   => $useCounter,
    'countColumns' => $countColumns,
    'countSlides'  => $countSlides,
));
