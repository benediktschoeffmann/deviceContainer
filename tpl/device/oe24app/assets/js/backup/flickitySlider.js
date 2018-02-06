<?php
/**
 * @collector noauto
 */
?>

(function () {

    function FlickitySlider(slider, sliderClass) {

        var that = this;

        that.slider = slider;
        that.sliderClass = sliderClass;

        that.firstSwipeDone = false;
        that.iconSwipe = slider.querySelector('.iconSwipe');

        that.options = {

            cellAlign: 'left',
            cellSelector: '.story',
            contain: true,
            imagesLoaded: true,
            lazyLoad: 1,

            pageDots: false,
            prevNextButtons: true,
            wrapAround: true
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

        flkty.on('select', function() {

            var cellNumber = flkty.selectedIndex + 1;

            // Zaehler, falls vorhanden, aktualisieren
            if (null !== that.counter) {
                that.counter.textContent = cellNumber + '/' + flkty.slides.length;
            }

            // Den Swipe-Arrow nur einmal zeigen
            if (null !== that.iconSwipe && false == that.firstSwipeDone && cellNumber > 1) {
                that.iconSwipe.style.display = 'none';
                that.firstSwipeDone = true;
            }
        });
    }

    var sliderClass = '.flickitySlider';
    var sliders = document.querySelectorAll(sliderClass);

    for (var i = 0, slider; slider = sliders[i]; ++i) {
        new FlickitySlider(slider, sliderClass);
    }

})();

