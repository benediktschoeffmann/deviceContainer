<?php
/**
 * @collector noauto
 */
?>

;(function($) {

    "use strict";

    function ConsoleSlider(element, opts) {

        var consoleSlider  = $(element),
            stories        = consoleSlider.find('.consoleStories'),
            navigation     = consoleSlider.find('.consoleNavigation'),
            navigationItem = consoleSlider.find('.consoleNavigationItem'),
            counter        = consoleSlider.find('.consoleStoryCounter'),

            prevArrow      = consoleSlider.find('.buttonPrev'),
            nextArrow      = consoleSlider.find('.buttonNext'),

            autoplay       = consoleSlider.data('autoplay'),
            autoplay       = (1 == autoplay) ? true: false,
            autoplaySpeed  = consoleSlider.data('autoplayspeed'),

            slidesToShow   = consoleSlider.data('slidestoshow'),
            slidesToScroll = consoleSlider.data('slidestoscroll');


        // --------------------------------------------------------

        stories.slick({

            arrows: false,
            draggable: false,
            fade: true,
            lazyLoad: 'ondemand',

            slide: 'a',
            slidesToShow: 1,
            slidesToScroll: 1,

            onInit: function() {
                var storyText = consoleSlider.find('.consoleStoryText');
                storyText.css({ 'opacity':'1' });
            },

            onBeforeChange: function(slider, pos, nextPos) {
                counter.text((nextPos+1) + '/' + slider.slideCount);
            }

        });

        // --------------------------------------------------------

        navigation.slick({

            asNavFor: stories,

            autoplay: autoplay,
            autoplaySpeed: autoplaySpeed,

            draggable: false,
            focusOnSelect: true,
            lazyLoad: 'ondemand',
            pauseOnHover: true,

            prevArrow: prevArrow,
            nextArrow: nextArrow,

            slide: 'a',
            slidesToShow: slidesToShow,
            slidesToScroll: slidesToScroll,

            onInit: function() {
                prevArrow.on('click', function(e) {
                    navigation.slickPause();
                });
                nextArrow.on('click', function(e) {
                    navigation.slickPause();
                });
            }

        });

        // In onInit funktioniert preventDefault() nicht fuer die geklonten Items
        navigationItem.on('click', function(e) {
            var index = $(this).index();
            stories.slickGoTo(index);
            e.preventDefault();
            navigation.slickPause();
        });

        $('.consoleNavigation .slick-cloned').on('click', function(e) {
            e.preventDefault();
            navigation.slickPause();
        });

    }

    $.fn.consoleSlider = function(opts) {
        return this.each(function() {
            new ConsoleSlider(this, opts);
        });
    };

})(jQuery);

$(document).ready(function() {

    // if ($('#wrap').hasClass('layout_tv')) {
    //     return;
    // }

    // Slick
    // $('.oe2016 .console').not('.flickity').consoleSlider();

    // Flickity
    $('.flickity.console').flickitySetup();
});
