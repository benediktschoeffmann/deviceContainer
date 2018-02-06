<?php
/**
 * @collector noauto
 */
?>

// (ws) 2015-08

function fishtankUpdate() {
    var viewportHeight = $(window).height();
    $('.fishtank, .fishtankContainer, .fishtankAd').css({
        'height': viewportHeight
    });
}

$(document).ready(function() {

    $(window).on('resize orientationchange', function(e) {
        fishtankUpdate();
    });

    $('.fishtankClose').on('click touchstart', function(e) {
        e.preventDefault();
        var fishtank = $(this).parents('.fishtank');
        var elements = fishtank.add(fishtank.prev('.fishtankCaption'));
        elements.css({
            'display': 'none'
        });
    });

    fishtankUpdate();
});
