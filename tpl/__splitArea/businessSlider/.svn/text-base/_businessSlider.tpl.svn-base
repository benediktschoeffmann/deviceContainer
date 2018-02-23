<?php
/**
 * OE2016 Business Slider Unternehmen Ranking
 *
 * @var channel oe24.core.Channel
 * @var box oe24.core.TemplateBox
 * @var slides array<any>
 * @var useCounter boolean
 * @var countColumns integer
 * @var countSlides integer
 */

?>

<div class="flktySlider flktySliderHidden js-flickMain" data-count-columns="<?= $countColumns; ?>" data-count-slides="<?= $countSlides; ?>">

    <? foreach ($slides as $key => $slide): ?>
        
        <? 
        	$href = ($slide['url']) ? 'href="' . $slide['url'] . '"' : '';
        ?>

        <? // $classVisible = ($key < $countColumns) ? 'businessSliderEntryVisible' : ''; ?>
        <a class="businessSliderEntry <?// = $classVisible; ?>" <?= $href; ?>>
            <? if ($useCounter): ?>
                <span class="businessSliderEntryCounter">[<?= $key + 1; ?>]</span>
            <? endif; ?>
            <span class="businessSliderEntryText"><?= $slide['text']; ?></span>
        </a>
    <? endforeach; ?>

</div>
