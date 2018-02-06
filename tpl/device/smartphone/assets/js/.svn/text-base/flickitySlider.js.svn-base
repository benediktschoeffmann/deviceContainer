<?php
/**
 * @collector noauto
 */
?>

;(function () {
    function FlickitySlider(slider, sliderClass) {
        var that = this;

        that.slider = slider;
        that.sliderClass = sliderClass;

        that.imagePosition = 0;

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

        // Berechnen, wo die Buttons bezogen auf den Image-Container zu positionieren sind

        if (typeof that.options.customOptions !== 'undefined' && typeof that.options.customOptions.repositionArrows !== 'undefined') {
            var box = Utilities.getClosest(that.slider, '.overrideImageSlideshow');
            var imageContainer = box.querySelector('.slideImageContainer');
            var buttons = box.querySelectorAll('.flickity-prev-next-button');
            var top = 0;
            if (typeof imageContainer !== 'undefined' && typeof buttons[0] !== 'undefined' && typeof buttons[1] !== 'undefined' ) {
                top = (imageContainer.offsetHeight / 2) + 'px';
                for (var i = buttons.length - 1; i >= 0; i--) {
                    buttons[i].style.top = top;
                }
            }
        }

        // -------------------------------

        // Falls ein Zaehler gewuenscht ist, ist er hier implementiert.
        // Das Counter-Element muss innerhalb von .flickitySlider liegen

        that.counter = slider.querySelector(that.options.classCounter);

        // set Startposition
        setFlickityPosition(flkty, that, true);

        flkty.on('cellSelect', function() {

            setFlickityPosition(flkty, that, false);
        });

        // -------------------------------

        // option 'dragThreshold' funktioniert nur, wenn extra-package 'flickity-as-nav-for' installiert ist
        // spezial script stattdessen
        flkty.hasDragStarted = function( moveVector ) {
          // dragging startet erst, wenn mindestens x Pixel nach rechts oder links bewegt wurde
          return !this.isTouchScrolling && Math.abs( moveVector.x ) > 20;
        };

        // -------------------------------

        if (typeof flkty.prevButton !== 'undefined' && typeof flkty.prevButton.element !== 'undefined') {
            flkty.prevButton.element.className += ' js-oewaLink';
        }

        if (typeof flkty.nextButton !== 'undefined' && typeof flkty.nextButton.element !== 'undefined') {
            flkty.nextButton.element.className += ' js-oewaLink';
        }

        // -------------------------------

        // voting
        if (typeof window['theVoting'] != "undefined") {
            window['theVoting'].gotoImage(0);
        } else {
            window['initVoting'] = true;
        }

    }

    function setFlickityPosition (flkty, that, forceSetPosition) {

        var cellNumber = flkty.selectedIndex + 1;
        
        // Zaehler, falls vorhanden, aktualisieren
        if (null !== that.counter) {
            // text nur einmal setzen
            if (that.imagePosition != flkty.selectedIndex || forceSetPosition) {
                that.counter.textContent = cellNumber + '/' + flkty.slides.length;
            }
        }

        // Den Swipe-Arrow nur einmal zeigen
        if (null !== that.iconSwipe && false == that.firstSwipeDone && cellNumber > 1) {
            that.iconSwipe.style.display = 'none';
            that.firstSwipeDone = true;
        }

        // voting - go to image
        if (typeof window['theVoting'] != "undefined") {
            // sicher gehen, dass gotoImage nur einmal ausgeführt wird
            if (that.imagePosition != flkty.selectedIndex) {
                window['theVoting'].gotoImage(flkty.selectedIndex);
            }
        }

        that.imagePosition = flkty.selectedIndex;

    }

    var sliderClass = '.flickitySlider';
    var sliders = document.querySelectorAll(sliderClass);

    for (var i = 0, slider; slider = sliders[i]; ++i) {
        new FlickitySlider(slider, sliderClass);
    }

})();
