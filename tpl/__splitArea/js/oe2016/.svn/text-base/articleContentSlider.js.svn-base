<?php
/**
 * @collector noauto
 */
?>

;(function() {

    function FlickitySlider(slider, sliderClass) {
        var that = this;

        that.slider = slider;
        that.sliderClass = sliderClass;

        that.imagePosition = 0;

        that.options = {

            cellAlign: 'left',
            cellSelector: '.story',
            contain: true,
            imagesLoaded: true,
            lazyLoad: 1,

            pageDots: false,
            prevNextButtons: true,
            wrapAround: true,

            // custom property
            classCounter: null
        };

        options = slider.dataset.options;

        if ('undefined' !== typeof options) {
            options = JSON.parse(options);
            for (var key in options) {
                that.options[key] = options[key];
            }
        }
        
        var flkty = ('undefined' !== typeof Flickity) ? new Flickity(that.slider, that.options) : null;
        if ('undefined' === typeof flkty || null === flkty) {
            return;
        }
        
        // -------------------------------

        // Falls ein Zaehler gewuenscht ist, ist er hier implementiert.
        // Das Counter-Element muss innerhalb von .flickitySlider liegen

        that.counter = slider.querySelector(that.options.classCounter);

        flkty.on('cellSelect', function() {

            // http://flickity.metafizzy.co/events.html#select
            // This event was previously cellSelect in Flickity v1. cellSelect will continue to work in Flickity v2.

            var cellNumber = flkty.selectedIndex + 1;

            // Zaehler, falls vorhanden, aktualisieren
            if (null !== that.counter) {
                // text nur einmal setzen
                if (that.imagePosition != flkty.selectedIndex) {
                    that.counter.textContent = cellNumber + '/' + flkty.cells.length;
                }
            }

            // voting - got to image
            if (typeof window['theVoting'] != "undefined") {
                // sicher gehen, dass gotoImage nur einmal ausgeführt wird
                if (that.imagePosition != flkty.selectedIndex) {
                    window['theVoting'].gotoImage(flkty.selectedIndex);
                }
            }    

            that.imagePosition = flkty.selectedIndex;
        });

        // add oewa-Link to slide-buttons
        var buttons = document.getElementsByClassName('flickity-prev-next-button');
        
        var buttonsLength = buttons.length;
        for (j = 0; j < buttonsLength; j++) {
            buttons[j].classList.add('js-oewaLink');
        }

        // voting
        if (typeof window['theVoting'] != "undefined") {
            window['theVoting'].gotoImage(0);
        } else {
            window['initVoting'] = true;
        }

    }
    
    var sliderClass = '.flickitySlider';
    var sliders = document.querySelectorAll(sliderClass);
    for (var i = 0, slider; slider = sliders[i]; i++) {
        new FlickitySlider(slider, sliderClass);
    }

})();

