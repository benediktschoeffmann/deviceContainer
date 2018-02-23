<?php
/**
 * headerNavPortal
 *
 * @var headerNavPortal array<any>
 * @var weatherJson array<any>
 * @var showWeather boolean
 */

?>

<? if (is_array($headerNavPortal)): ?>
<nav class="headerNavPortal">

    <? // <div class="tableRow"> ?>

        <? foreach ($headerNavPortal as $key => $item): ?>
            <a href="<?= $item['href']; ?>"><?= $item['caption']; ?></a>
        <? endforeach; ?>

        <a class="headerNavSearch" href="/search">
            <span class="icon icon_search"></span>
        </a>

        <? if ($showWeather && !empty($weatherJson)): ?>
        <a class="headerNavWeather" href="#!">
            <!-- <span class="icon icon_arrow2_down"></span> -->
            <span class="icon_weather icon-wi<?=sprintf('%03s', $weatherJson['places'][0]['icon'])?>" title="<?=$weatherJson['places'][0]['iconText']?>"></span>
            <span class="headerNavWeatherDegree"><?=sprintf('%2s', $weatherJson['places'][0]['temp'])?>&deg;</span>
            <span class="headerNavWeatherCity"><?=$weatherJson['places'][0]['name']?></span>
        </a>
        <? endif; ?>

    <? // <!-- </div> ?>

</nav>
<? endif; ?>
