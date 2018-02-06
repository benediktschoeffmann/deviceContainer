<?
/**
 * template box
 * @var channel oe24.core.Channel
 * @var box oe24.core.TemplateBox
 */

$slides = getTvProgramm();

if (!$slides) {
	return;
}

// --------------------------------------------------------------------------------

$countColumns = 1;
$countSlides = count($slides);

$firstSlide = 'first';

$flickityOptions = array(

    'autoplay'        => false,
    'prevNextButtons' => true,
    'pageDots'        => false,
    'cellSelector'    => '.tvProgammSliderEntry',
    // 'groupCells'      => $groupCellsActive,

    // classCounter ist KEINE flickity-Option
    // wird verwendet um die CSS-Klasse des Zaehlerelements zu uebergeben
    'classCounter'    => '.tvSliderCounter',
);

$options = json_encode($flickityOptions);


?>

<? if (0): ?>
<div class="standardHeadline oe24">
    <h2 class="tvHeadlineCaption clearfix">
        <a class="tvHeadlineLeft" href="#!">Das oe24.TV Programm</a>
    </h2>
</div>
<? endif; ?>

<div class="tvProgrammSliderBox">
    
    <div class="flickitySlider flktySliderHidden" data-options='<?= $options; ?>'>

        <? foreach ($slides as $key => $slide): ?>
            
            <a class="tvProgammSliderEntry <?= $firstSlide; ?>" href="#!">
                <? $firstSlide = ''; ?>

                <div class="tvHl headline"><?= $slide['headline']; ?></div>
                <div class="tvMain" id="<?= $key; ?>">
                    <table class="tvTbl" cellspacing="1" width="100%">
                        <tbody>
                            
                            <? foreach ($slide['events'] as $time => $event): ?>

                                <tr class="<?= $event['currentShow']; ?>" id="<?= $event['id']; ?>">
                                    <td width="20%"></td>
                                    <td class="tvTime"><?= $event['time']; ?></td>
                                    <td class="tvShow" title="<?= $event['title']; ?>"><?= $event['title']; ?></td>                                
                                    <td width="20%"></td>
                                </tr>

                            <? endforeach; ?>

                        </tbody>
                    </table>
                </div>

            </a>

        <? endforeach; ?>
		<div class="tvSliderCounter">1/<?= $countSlides; ?></div>
    </div>
	
	

</div>

<script type="text/javascript">
	
	// scroll to current show
    ;(function () {
        window.onload = function (){
            var now = new Date();
            for (var i=0; i<=6; i++) {
                var day = new Date( now.getTime() + (1000 * 60 * 60 * 24 * i) );
                var id2search = 'sl_' + day.toISOString().slice(0,10).replace(/-/g,"");
                var eventid2search = 'currentShow' + day.toISOString().slice(0,10).replace(/-/g,"");

                var curentEvent = document.getElementById(eventid2search);
                if (curentEvent) {
                    var currentSlider = document.getElementById(id2search);
                    if (currentSlider) {
                        var offset = curentEvent.offsetTop;
                        currentSlider.scrollTop = offset;
                    }
                }
            }
        }

    })();

</script>

