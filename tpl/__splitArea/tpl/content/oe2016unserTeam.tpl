<?php

/**
 * OE2016 Sport Tabbox Nationalteam
 *
 * @var channel oe24.core.Channel
 * @var column oe24.core.ChannelColumn
 * @var box oe24.core.TabbedBox
 * @var params array<any>
 */

// src/functions/getNationalTeam.function.php
//MH 20170202 DAILY-665 Ski-WM
$teamType = isset($params['teamType']) ? $params['teamType'] : 'nationalteam';
//MH END

$nationalTeam = getNationalTeam($teamType);



$eventTrackingPrev = eventTracking(array('action' => 'leftClick',  'box' => $box, 'channel' => $channel, 'column' => $column, 'callTemplate' => __FILE__));
$eventTrackingNext = eventTracking(array('action' => 'rightClick', 'box' => $box, 'channel' => $channel, 'column' => $column, 'callTemplate' => __FILE__));

$defaultUrl = '#!';

$slidesToShow = 11;
$slidesToScroll = 1;

// ------------------------------------------------------
// 2016-06-07

$cssClassBox = isset($params['cssClassBox']) ? $params['cssClassBox'] : '';

// 2016-06-07 end
// ------------------------------------------------------

?>

<div class="teamBox <?= $cssClassBox; ?>" data-slidestoshow="<?= $slidesToShow; ?>" data-slidestoscroll="<?= $slidesToScroll; ?>">

    <div class="teamBoxBackground">
        <div class="teamBoxSliderContainer">

            <div class="teamBoxSlider clearfix">

                <? foreach ($nationalTeam as $key => $item): ?>

                    <? $url = (false == isset($item['url']) || empty($item['url'])) ? $defaultUrl : $item['url']; ?>

                    <a class="teamBoxItem" href="<?= $url; ?>">

                        <div class="teamBoxImage">
                            <span class="<?= $item['cssClass']; ?>"></span>
                            <? if ( $teamType == 'nationalteam' ) : ?>
                                <span class="defaultChannelColor teamBoxPlayerNumber"><?=$item['nr']; ?></span>
                            <? endif; ?>
                        </div>

                        <span class="defaultChannelColor teamBoxFirstName"><?=$item['firstname']; ?></span>
                        <span class="defaultChannelColor teamBoxLastName"><?=$item['lastname']; ?></span>

                    </a>

                <? endforeach; ?>

            </div>

        </div>
    </div>

    <span class="prevArrow unselectable js-oewaLink" onclick="<?= $eventTrackingPrev; ?>">‹</span>
    <span class="nextArrow unselectable js-oewaLink" onclick="<?= $eventTrackingPrev; ?>">›</span>

</div>
