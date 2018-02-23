<?php
/**
 * @collector noauto
 */
?>

;(function(containerClass, sliderClass) {

    "use strict";

    // --------------------------------------------------------

    function Slider(container, sliderClass) {

        var slider = container.querySelector(sliderClass);

        if (typeof slider === 'undefined' || null === slider) {
            // Box wird nicht gezeigt
            return;
        }

        // -------------------------------------------

        // var countColumns = parseInt(slider.dataset.countColumns, 10);
        // var countSlides = parseInt(slider.dataset.countSlides, 10);
        // // https://jsperf.com/numbers-and-integers
        // // Check if variable is an integer
        // countColumns = (typeof countColumns === 'number' && (countColumns % 1) === 0) ? countColumns : 4;
        // countSlides = (typeof countSlides === 'number' && (countSlides % 1) === 0) ? countSlides : 0;

        var countSlides = ('countSlides' in slider.dataset) ? slider.dataset.countSlides : 0;
        var countColumns = ('countColumns' in slider.dataset) ? slider.dataset.countColumns : 4;

        countSlides = isNaN(countSlides) ? 0 : countSlides;
        countColumns = isNaN(countColumns) ? 4 : countColumns;

        countSlides = parseInt(countSlides, 10);
        countColumns = parseInt(countColumns, 10);

        // -------------------------------------------

        // Flickity Init

        var options = {
            cellAlign: 'left',
            contain: true,
            imagesLoaded: true,
            pageDots: false,
            wrapAround: true
        };

        if (typeof Flickity === 'undefined') {
            return;
        }

        var flkty = new Flickity(slider, options);

        if (typeof flkty === 'undefined' || null === flkty) {
            return;
        }

        // -------------------------------------------

        if (countSlides <= countColumns) {
            if (typeof flkty.prevButton !== 'undefined') {
                flkty.prevButton.disable();
            }
            if (typeof flkty.nextButton !== 'undefined') {
                flkty.nextButton.disable();
            }
        }

        // -------------------------------------------

        container.className += ' slider-enabled';
    }

    // --------------------------------------------------------

    var containers = document.querySelectorAll(containerClass);

    for (var i = 0, container; container = containers[i]; ++i) {
        new Slider(container, sliderClass);
    }

})('.businessSliderBox', '.flktySlider');
