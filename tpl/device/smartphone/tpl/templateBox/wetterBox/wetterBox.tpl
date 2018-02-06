<?php
/**
 * Österreich-Wetter - Smartphone-Variante
 *
 * @var channel oe24.core.Channel
 * @var box oe24.core.TemplateBox
 */


$imageToday = 'http://file.wetter.at/mowis/mobil2014/aut_t0.jpg';
// $imageTomorrow = 'http://file.wetter.at/mowis/mobil2014/aut_t24.jpg';

// -------------------------------------------

$tsCurrent = time();
$shortNames = array();

$weekDaysShort = array('So', 'Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa');

$nextDays1 = array();
$nextDays2 = array();
$firstDay1 = "";
$lastDay1 = "";
$firstLink1 = "";
$firstDay2 = "";
$lastDay2 = "";
$firstLink2 = "";

for ($n = 2; $n <= 7; $n++) {
    $ts = mktime(0, 0, 0, date('n'), date('j') + $n, date('Y'));

    $sWeekday = $weekDaysShort[date('w', $ts)];
    $sLink = 'http://file.wetter.at/mowis/mobil2014/aut_d'.$n.'.jpg';
    // debug(date('Y-m-d', $ts).' -> '.$weekDaysShort[date('w', $ts)]);
    if(count($nextDays1)<3){
        $nextDays1[$sWeekday] = $sLink;

        $firstDay1 = ($firstDay1 == "") ? $sWeekday : $firstDay1;
        $firstLink1 = ($firstLink1 == "") ? $sLink : $firstLink1;

        $lastDay1 = $sWeekday;
    }
    else{
        $nextDays2[$sWeekday] = $sLink;

        $firstDay2 = ($firstDay2 == "") ? $sWeekday : $firstDay2;
        $firstLink2 = ($firstLink2 == "") ? $sLink : $firstLink2;

        $lastDay2 = $sWeekday;
    }
}

$weekText1 = "$firstDay1 - $lastDay1";
$weekText2 = "$firstDay2 - $lastDay2";


$headerItems = array(
    'Heute' => 'http://file.wetter.at/mowis/mobil2014/aut_t0.jpg',
    'Morgen' => 'http://file.wetter.at/mowis/mobil2014/aut_d1_vorm.jpg',
    $weekText1 => $firstLink1,
    $weekText2 => $firstLink2,
);


$imageTitle = "";
// $headerItems = array_merge($headerItems, $nextDays);

?>

<div class="weatherBox">

    <div class="weatherHeader">

        <? if (0): ?>
        <div class="weatherNav" id="weatherNav-<?= $uniqid; ?>">
            <? foreach($periodStrings as $key => $tage): ?>
                <? $classNavLink = ('current' == $key) ? 'active' : ''; ?>
                <a class="weatherNavItem <?=$classNavLink?> js-oewaLink" href="#!" onclick="<?= $onclick; ?>" data-type="<?= $key; ?>">
                    <?= $tage['name']; ?>
                </a>
            <? endforeach; ?>
        </div>
        <? endif; ?>

        <? if (1): ?>
        <div class="weatherNav">
            <? $iCount=0; foreach ($headerItems as $day => $imageUrl): ?>
                <?
                $iCount++;
                $classActive = ('Heute' == $day) ? 'active' : '';
                $classWide   = ('Heute' == $day || 'Morgen' == $day) ? 'wide' : '';
                $classLink   = $classActive.' '.$classWide;
                ?>
                <a class="weatherNavItem <?= $classLink; ?> js-oewaLink" href="#!" onclick="weatherMap.display(<?= $iCount; ?>); return false;" id="weatherNav<?= $iCount; ?>" rel="nofollow">
                    <?= $day; ?>
                </a>
            <? endforeach; ?>
        </div>
        <? endif; ?>
    </div>

    <div class="weatherMap">
        <img id="mapWeather" class="mapToday" src="<?= $imageToday; ?>" alt="<?= $imageTitle; ?>"/>
    </div>

    <div class="weatherMapNavigation">
        <a id="weatherMapPrevious" class="isHidden" href="#!" onclick="weatherMap.getPrevious();return false;" rel="nofollow"> 
            <div class="weatherMapNav">&laquo; Zurück</div>
        </a>
        <a id="weatherMapNext" href="#!" onclick="weatherMap.getNext();return false;" rel="nofollow"> 
            <div class="weatherMapNav">Weiter &raquo;</div>
        </a>
    </div>
    <div class="weatherBottom">
        <a class="weatherAtLink" href="http://m.wetter.at" target="_blank">
            Das ganze Wetter auf wetter.at &raquo;
        </a>
    </div>

</div>
