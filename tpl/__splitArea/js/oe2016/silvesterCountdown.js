<?php
/**
 * @collector noauto
 */
?>

// Verwendet das jQuery-Plugin "The Final Countdown"
// http://hilios.github.io/jQuery.countdown/

;(function() {

    "use strict";

    function SilvesterCountdown(el) {

        var silvesterCountdown = $(el);
        var silvesterCounter = silvesterCountdown.find('.silvesterCounter');
        var finalDate = $(el).data('finaldate');
        var html = '';

        // Pruefen, ob das jQuery-Plugin "The Final Countdown" geladen ist
        if (typeof silvesterCounter.countdown !== 'function') {
            return;
        }

        // Container zeigen
        silvesterCountdown.css('display', 'block');

        // Event-Handler des Plugins
        silvesterCounter.countdown(finalDate)
            .on('update.countdown', function(event) {
                html = event.strftime('<span class="silvesterDigits">%I</span><span class="silvesterDigits">%M</span><span class="silvesterDigits">%S</span>');
                $(this).html(html);
            })
            .on('finish.countdown', function(event) {
                silvesterCountdown.addClass('finished');
            });

    }

    $.fn.silvesterCountdown = function() {
        return this.each(function() {
            new SilvesterCountdown(this);
        });
    };

    $('.silvesterCountdown').silvesterCountdown();

})();
