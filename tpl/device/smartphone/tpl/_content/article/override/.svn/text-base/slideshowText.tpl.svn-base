<?
/**
 * override textslideshow
 * @var content oe24.core.Content
 * @default content 0
 */

// Beispiel am Dev-Server
// http://oe24dev.oe24.at/_mobile/madonna/Das-Schlankgeheimnis-der-Franzoesinnen/161548487?smartphone

// --------------------------------------------------

// debug($content);

if ( ! $content) {
    return;
}

// --------------------------------------------------

// Options für Flickity

$autoplay = false;

$options = json_encode(array(
    'autoPlay' => $autoplay,
    'pageDots' => true,
    'prevNextButtons' => false,
    'cellSelector' => '.slide',
));

// --------------------------------------------------

$slides = explode('<spunQ:pagebreak/>', $content->getBodyText());

// --------------------------------------------------

$enableSlider = true;
$classSlider = ($enableSlider) ? 'flickitySlider' : '';
$slides = ($enableSlider) ? $slides : array_slice($slides, 0, 1);

// --------------------------------------------------

?>

<div class="overrideSlideshow overrideTextSlideshow">

    <div class="<?= $classSlider; ?>" data-options='<?= $options; ?>'>

        <? if (1): ?>

            <? foreach ($slides as $key => $slide): ?>

                <div class="slide">
                    <?= $slide; ?>
                </div>

            <? endforeach; ?>

        <? endif; ?>

    </div>

</div>
