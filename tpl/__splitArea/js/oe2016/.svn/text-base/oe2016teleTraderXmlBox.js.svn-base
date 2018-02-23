<?php
/**
 * @collector noauto
 */
?>

;(function(containerClass) {

    "use strict";

    // --------------------------------------------------------

    function TeleTraderSlider(container) {

        // var slider = container.querySelector('.flickitySlider');
        var slider = container.querySelector('.teleTraderSlider');

        var countColumns   = parseInt(container.dataset.countColumns, 10);
        var entriesCounter = parseInt(slider.dataset.entriesCounter, 10);
        var groupCells     = parseInt(slider.dataset.groupCells, 10);

        // https://jsperf.com/numbers-and-integers
        // Check if variable is an integer

        countColumns   = (typeof countColumns   === 'number' && (countColumns   % 1) === 0) ? countColumns   : 4;
        entriesCounter = (typeof entriesCounter === 'number' && (entriesCounter % 1) === 0) ? entriesCounter : 0;
        groupCells     = (typeof groupCells     === 'number' && (groupCells     % 1) === 0) ? groupCells     : 1;

        var options = {
            cellAlign: 'left',
            contain: true,
            pageDots: false,
            wrapAround: true

            // Funktioniert nicht so wie gedacht, naemlich dass die ganze Gruppe gescrollt wird.
            // Gescrollt wird immer nur ein Slide
            // groupCells: groupCells
        };

        if (typeof Flickity === 'undefined') {
            return;
        }

        var flkty = new Flickity(slider, options);

        if ('undefined' === typeof flkty || null === flkty) {
            return;
        }

        // ...

        if (entriesCounter <= countColumns) {
            flkty.prevButton.disable();
            flkty.nextButton.disable();
        }
    }

    // --------------------------------------------------------

    var containers = document.querySelectorAll(containerClass);

    for (var i = 0, container; container = containers[i]; ++i) {
        new TeleTraderSlider(container);
    }

})('.teleTraderBox');
