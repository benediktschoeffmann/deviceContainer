<?php
/**
 * @collector noauto
 */
?>

;(function($) {

    "use strict";

    function TeamBox(element, opts) {

        var teamBox = $(element),
            slider         = teamBox.find('.teamBoxSlider'),
            prevArrow      = teamBox.find('.prevArrow'),
            nextArrow      = teamBox.find('.nextArrow'),
            slidesToShow   = teamBox.data('slidestoshow'),
            slidesToScroll = teamBox.data('slidestoscroll');

        slider.slick({

            prevArrow: prevArrow,
            nextArrow: nextArrow,

            infinite: true,
            // autoplay: true,

            slide: 'a',
            slidesToShow: slidesToShow,
            slidesToScroll: slidesToScroll,

            onInit: function() {
                teamBox.css({
                    'height':'auto'
                });
            }

        });
    }

    $.fn.teamBox = function(opts) {
        return this.each(function() {
            new TeamBox(this, opts);
        });
    };

})(jQuery);

$(document).ready(function() {
    $('.teamBox').teamBox();
});
