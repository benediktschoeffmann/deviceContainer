<?php
/**
 * @collector noauto
 */
?>

$(document).ready(function() {

    ;(function($) {

        var overlay = $('.newStoriesOverlay');

        if (typeof overlay === 'undefined') {
            return;
        }

        function startTimeOut() {
            var timeOutTime = 1000 * 60 * 10; // 10 Minuten
            // var timeOutTime = 10000; // 10 Sekunden
            var timeoutId = setTimeout(function() {
                overlay.addClass('activeOverlay');
            }, timeOutTime);
        }

        // $('.newStoriesOverlay').on('click', function(e) {
        //     e.preventDefault();
        //     overlay.removeClass('activeOverlay');
        //     startTimeOut();
        // });

        $('.newStoriesOverlay .newStoriesButtonCancel, .newStoriesOverlay .newStoriesButtonClose').on('click', function(e) {
            e.preventDefault();
            overlay.removeClass('activeOverlay');
            startTimeOut();
        });

        $('.newStoriesOverlay .newStoriesButtonLoad').on('click', function(e) {
            e.preventDefault();
            overlay.removeClass('activeOverlay');
            window.location.href = $(this).attr('href');
        });

         // $('.OUTBRAIN a').on('click', function(e) {
         //    e.preventDefault();
         //    overlay.removeClass('activeOverlay');
         //    window.location.href = $(this).attr('href');
         // });

        startTimeOut();

    })(jQuery);

});
