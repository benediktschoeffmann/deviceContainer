<?php
/**
 * OE2016 Business Slider Template
 *
 * @var channel oe24.core.Channel
 * @var box oe24.core.TemplateBox
 * @var useCounter boolean
 * @var countColumns integer
 * @default useCounter 0
 */

// -------------------------------------------SpunQ_File::get()

$useCounter = (true === $useCounter || false === $useCounter || 0 === $useCounter) ? $useCounter : false;

// -------------------------------------------

// Daten der einzelnen Slides

$slides = array();
$slideTemplate = array();

$file = "http://file.oe24.at/redaktion/BusinessLive-TVQuoten.txt";
$csv = spunQ_HttpBrowser::sendRequest($file, 5, false)->getBody();
$quoten = explode(chr(10), $csv);

$bFoundContent = false;

foreach ($quoten as $key => $quote) {
    $data = explode(";", $quote);
    
    if ($bFoundContent) {
        // bei quellenangabe stoppen
        if (false !== mb_strpos(mb_strtolower($data[1]), 'evogenius reporting')) {
            break;
        }
        
        // mehrere Headline-Zeilen in Importfile
        if ("sender" != mb_strtolower($data[0])) {
            if (isset($data[2])) {
                $sChannel = $data[0];
                $iPosition = $data[2];
                $sTitle = $data[7];
                $dReach = $data[8];

                $displayShow = (3 >= $iPosition && mb_strlen($sTitle) && mb_strlen($dReach)) ? true : false;
                if ($displayShow) {
                    $slideTemplate[$sChannel][$iPosition] = $data;
                }
            }
        }
    }
    else {
        if (isset($data[0])) {
            // Headline-Zeile gefunden, erst ab hier beginnt unser Content
            if ("sender" == mb_strtolower($data[0])) {
                $bFoundContent = true;
            }
        }
    }
}

foreach($slideTemplate as $tvStation => $shows) {
    
    ksort($shows);
    
    $text = '';
    foreach ($shows as $position => $show) {

        $text .= templateAsString(
                    'oe24.oe24.__splitArea.businessSlider.tvQuotenShow', 
                    array(
                        'showname' => $show[7],
                        'drw'      => $show[8], 
                    )
                );
    }

    $text = templateAsString(
                'oe24.oe24.__splitArea.businessSlider.tvQuotenSlide', 
                array(
                    'tvStation'    => $tvStation,
                    'slideContent' => $text, 
                )
            );

    $slides[] = array(
        'text' => $text,
        'url'  => '',
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
