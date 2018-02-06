<?php
/**
 * headerNavPortal
 *
 * @var headerComponent any
 * @var navigationComponent any
 */

$showWeather = $headerComponent->hasWeatherInformation();
if ($showWeather) {
    $weatherJson = $headerComponent->getWeatherJSON();
}

$portalNavigation = $navigationComponent->getNavigationItems('top');

if (!is_array($portalNavigation)) {
    return;
}
?>
<nav class="headerNavPortal">

    <? foreach ($portalNavigation as $key => $item): ?>
        <a href="<?=$item['href'];?>">
            <?=$item['caption'];?>
        </a>
    <? endforeach; ?>

    <a class="headerNavSearch" href="/search">
        <span class="icon icon_search"></span>
    </a>

    <? if ($showWeather && !empty($weatherJson)): ?>
        <a class="headerNavWeather" href="#!">
            <span class="icon_weather icon-wi<?=sprintf('%03s', $weatherJson['places'][0]['icon'])?>" title="<?=$weatherJson['places'][0]['iconText'];?>"></span>
            <span class="headerNavWeatherDegree">
                <?=sprintf('%2s', $weatherJson['places'][0]['temp'])?>&deg;
            </span>
            <span class="headerNavWeatherCity">
                <?=$weatherJson['places'][0]['name']?>
            </span>
        </a>
    <? endif; ?>

</nav>

