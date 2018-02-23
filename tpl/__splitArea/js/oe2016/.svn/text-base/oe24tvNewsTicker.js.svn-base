<?php
/**
 * @collector noauto
 */
?>

;(function ($) {

    "use strict";

    function Infinite(el, options) {

        this.el = $(el);

        this.defaults = {

            // Ueber diese Variable kann die Scroll-Geschwindigkeit gesteuert werden (ca. pixel/seconds)
            // Hoeher Wert -> schneller und umgekehrt
            // speed: 300,
            speed: 200,

            animationName: 'infiniteRun',
            animationTimingFunction: 'linear',
            animationIterationCount: 'infinite',

            // animationIterationCount: '0',
            // animationDuration: '45s',

            animationDelay: '0s'
        };

        var meta = this.el.data('infinite-options');
        this.options = $.extend(this.defaults, options, meta);

        this.init();
    }

    Infinite.prototype.init = function() {

        var elementWidth = this.el.outerWidth(true);
        var infiniteItemWidth = 0;
        var infiniteWrapperWidth = 0;

        var infiniteWrapper;
        var infiniteItems;

        // -------------

        this.el.wrapInner('<div class="infiniteWrapper"></div>');

        infiniteWrapper = this.el.children();
        infiniteItems = infiniteWrapper.children();

        // -------------

        // Zwecks Test
        // this.stylesItem(infiniteWrapper);

        // -------------

        infiniteItems.each(function() {

            // Wichtig! Ohne der nachfolgenden Zeile wird als Elementbreite die "sichtbare" Breite
            // des Elements, spricht die Breite des Containers zurueckgeliefert
            $(this).css('white-space', 'nowrap');

            $(this).addClass('infiniteItem');
            infiniteItemWidth = $(this).outerWidth(true);
            infiniteWrapperWidth += infiniteItemWidth;
        });

        // -------------

        infiniteItems.clone(true, true).appendTo(infiniteWrapper);

        // -------------

        this.stylesWrapper(infiniteWrapper, infiniteWrapperWidth, elementWidth);
        this.eventsWrapper(infiniteWrapper);
        this.keyframe(infiniteWrapperWidth);

        // -------------

    }

    Infinite.prototype.stylesWrapper = function(infiniteWrapper, infiniteWrapperWidth, elementWidth) {

        var currentWidth = infiniteWrapperWidth + elementWidth + (infiniteWrapperWidth - elementWidth) + 1,
            animationDuration = parseInt(currentWidth / this.options.speed, 10) + 's';

        // console.log(currentWidth, animationDuration);

        infiniteWrapper.css(
            {
                'width': currentWidth,

                'transform': 'translate3d(0, 0, 0)',

                // 'animation': 'infiniteRun 10s linear infinite',

                'animation-name': this.options.animationName,
                // 'animation-duration': this.options.animationDuration,
                'animation-duration': animationDuration,
                'animation-timing-function': this.options.animationTimingFunction,
                'animation-iteration-count': this.options.animationIterationCount,

                'animation-delay': this.options.animationDelay
            }
        );
    }

    Infinite.prototype.eventsWrapper = function(infiniteWrapper) {

        infiniteWrapper.hover(
            function() {
                $(this).css(
                    'animation-play-state', 'paused',
                    'cursor', 'pointer'
                );
            },
            function() {
                $(this).css(
                    'animation-play-state', 'running',
                    'cursor', 'normal'
                );
            }
        );
    }

    Infinite.prototype.keyframe = function(infiniteWrapperWidth) {

        // http://stackoverflow.com/questions/5105530/programmatically-changing-webkit-transformation-values-in-animation-rules
        // https://developer.mozilla.org/en-US/docs/Web/API/CSSStyleSheet/insertRule

        var style = document.head.appendChild(document.createElement("style"));
        var rule = 'infiniteRun { 100%  { transform: translateX(-' + infiniteWrapperWidth + 'px); } }';

        if (CSSRule.KEYFRAMES_RULE) { // W3C
            style.sheet.insertRule("@keyframes" + ' ' + rule, 0);
        } else if (CSSRule.WEBKIT_KEYFRAMES_RULE) { // WebKit
            style.sheet.insertRule("@-webkit-keyframes" + ' ' + rule, 0);
        } else {
            console.log("Can't insert keyframes rule");
        }
    }

    Infinite.prototype.stylesItem = function(infiniteWrapper) {

        var firstItem = infiniteWrapper.children(':first').addClass('infiniteFirstItem');
        var lastItem  = infiniteWrapper.children(':last').addClass('infiniteLastItem');

        firstItem.css('background-color', '#f00');
        lastItem.css('background-color', '#00f');
    }

    $.fn.infinite = function(options) {
        return this.each(function() {
            new Infinite(this, options);
        });
    };

})(jQuery);


$(document).ready(function() {
    $('.infiniteScroller').infinite();
});

