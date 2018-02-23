<?php
/**
 * @collector noauto
 */
?>

$(document).ready(function() {

    // Verwendet das jQuery-Plugin "The Final Countdown"
    // http://hilios.github.io/jQuery.countdown/

    $('.countdownBox').each(function() {

        var countdownBox = $(this),
            countdownLiftOff = countdownBox.data('lift-off'),
            showSeconds = parseInt(countdownBox.data('show-seconds'), 10),
            counter = countdownBox.find('.countdownCounter');

        // zwecks schnellem Test
        // countdownLiftOff = '2016/09/26 07:00:00';
        // countdownLiftOff = '2016/09/22 10:34:00';

        var formatAll = [
            '<span class="countdownCell">%D</span>',
            '<span class="countdownCell">%H</span>',
            '<span class="countdownCell">%M</span>',
            '<span class="countdownCell">%S</span>'
        ];

        var format = (1 === showSeconds) ? formatAll.join('') : formatAll.splice(0,3).join('');

        counter.countdown(countdownLiftOff)
            .on('update.countdown', function(event) {
                if (countdownBox.is(':hidden')) {
                    countdownBox.addClass('countdownRunning');
                }
                countdownHtml = event.strftime(format);
                $(this).html(countdownHtml);
            })
            .on('finish.countdown', function(event) {
                countdownBox.addClass('countdownFinished');
            });
    });

});

