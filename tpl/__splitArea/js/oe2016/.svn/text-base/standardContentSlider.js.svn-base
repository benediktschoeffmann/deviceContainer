<?php
/**
 * @collector noauto
 */
?>

;(function($) {

    "use strict";

    function StandardContentSlider(element, opts) {

        this.contentSlider    = $(element);
        this.countSlides      = this.contentSlider.data('count-slides');
        this.storiesPerRow    = this.contentSlider.data('stories-per-row');
        this.sliderRows       = this.contentSlider.data('slider-rows');
        this.contentSliderBox = this.contentSlider.parents('.contentSliderBox');

        this.contentSliderBoxCounter = this.contentSliderBox.find('.contentSliderBoxCounter');
        // ??? this.countSlides = (this.contentSliderBoxCounter.length > 0) ? this.contentSliderBoxCounter.data('count-slides') : 0;

        // Die Button sollen dargestellt werden, auch wenn die Anzahl der Slides gleich
        // der Stories per Row ist, wenn also gar nicht "geslidet" werden soll
        // this.prevNextButtonsEnabled = (this.countSlides > this.storiesPerRow) ? true : false;
        this.prevNextButtonsEnabled = true; // (this.countSlides > this.storiesPerRow) ? true : false;
        this.slideMe = (this.countSlides > this.storiesPerRow) ? true : false;

        this.defaults = {
            useFlickity: true
        }
        this.opts = $.extend(this.defaults, opts);

        this.init();
    }

    StandardContentSlider.prototype.init = function() {

        var that = this, slideBoxes, firstImage, firstImageHeight = 0, storyTextHeight = 0, marginTop = 0, marginBottom = 0;

        // http://codepen.io/desandro/pen/KVwVqa/
        // trigger redraw for transition
        that.contentSlider[0].offsetHeight;


        var aTag = $(that.contentSlider).find('.slide a');
        if (aTag.length > 0) {
            marginTop = parseInt($(that.contentSlider).find('.slide a').css('margin-top').replace(/px/, ''));
            marginBottom = parseInt($(that.contentSlider).find('.slide a').css('margin-bottom').replace(/px/, ''));
        }

        for (var i = that.sliderRows; i > 0; i--) {
            slideBoxes = that.contentSlider.find('.slideBox' + i);
            firstImage = $(slideBoxes).find('img').get(0);

            firstImageHeight = $(firstImage).outerHeight(true);

            if (firstImageHeight > 0) {
                // console.log('No OnLoad');
                that.setSlideBoxesHeight(slideBoxes, marginTop, marginBottom, firstImageHeight);
                that.initFlickity();
            } else {
                $(firstImage).on('load', function() {
                    // console.log('In OnLoad');
                    firstImageHeight = $(firstImage).outerHeight(true);
                    that.setSlideBoxesHeight(slideBoxes, marginTop, marginBottom, firstImageHeight);
                    that.initFlickity();
                });
            }
        }
    }

    StandardContentSlider.prototype.setSlideBoxesHeight = function(slideBoxes, marginTop, marginBottom, firstImageHeight) {

        var that = this, storyTextHeight, slideBoxesHeight;

        storyTextHeight = that.getStoryTextHeight(slideBoxes, firstImageHeight);
        slideBoxesHeight = marginTop + firstImageHeight + storyTextHeight + marginBottom;

        slideBoxes.height(slideBoxesHeight);
        // console.log(marginTop, marginBottom, firstImageHeight, storyTextHeight, slideBoxesHeight);
    }

    StandardContentSlider.prototype.getStoryTextHeight = function(slideBoxes, firstImageHeight) {

        var storyText, storyTextHeight = 0, outerHeight = 0;

        for (var j = slideBoxes.length - 1; j >= 0; j--) {
            storyText = $(slideBoxes[j]).find('.storyText');
            outerHeight = parseInt($(storyText).outerHeight(true));
            storyTextHeight = (outerHeight > storyTextHeight) ? outerHeight : storyTextHeight;
        }

        return storyTextHeight;
    }

    StandardContentSlider.prototype.initFlickity = function() {

        var that = this;

        if (false === that.opts.useFlickity) {
            return;
        }

        that.contentSlider.flickity({
            prevNextButtons: this.prevNextButtonsEnabled,
            lazyLoad: that.storiesPerRow - 1,
            pageDots: false,
            freeScroll: false,
            wrapAround: true,
            cellAlign: 'left',
            draggable: true,
            imagesLoaded: true,
            cellSelector: '.js-flickSlideItem'
        });

        var flkty = that.contentSlider.data('flickity');

        if (that.contentSliderBoxCounter.length > 0) {
            flkty.on('cellSelect', function(e) {
                that.contentSliderBoxCounter.html((flkty.selectedIndex + 1) + ' / ' + that.countSlides);
            });
        }

        if (false === that.slideMe) {
            $(flkty.prevButton.element).attr('disabled', 'disabled');
            $(flkty.nextButton.element).attr('disabled', 'disabled');
        }

        // (ws) 2016-07-12 speziell fuer oe24TV
        that.contentSlider.parents('.tabbedBoxTvContent').siblings('.tabbedBoxTvSidebar').addClass('active');
        // (ws) 2016-07-12 //

    }

    $.fn.standardContentSlider = function(opts) {
        return this.each(function() {
            new StandardContentSlider(this, opts);
        });
    };

})(jQuery);

$(document).ready(function() {
    $('.contentSlider').standardContentSlider({
        'useFlickity': true
    });

    $('.contentSlider.js-flickMain').find('button').addClass('js-oewaLink');
});
