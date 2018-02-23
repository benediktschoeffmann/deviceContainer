<?php
/**
 * @collector noauto
 * @collector footerSplitArea
 */
?>

$(document).ready(function() {

    function CookiesOverlay(element, opts) {

        this.element = element;
        this.opts = opts;

        if (true === this.checkCookie()) {
            return;
        }

        this.init();
    }

    CookiesOverlay.prototype.init = function() {

        var self = this;

        if ($(this.element).hasClass('layout_oe24_mobile')) {
            if (getCookie('appStickyCorrection')) {
                $(this.element).css('bottom', '94px');
            } else {
                $(this.element).css('bottom', '50px');
            }
        }

        $(this.element).addClass('cookiesOverlayEnabled');
        $(this.opts.closeButton).on('click', function(e) {
            e.preventDefault();
            self.setCookie();
        });
    }

    CookiesOverlay.prototype.setCookie = function() {

        var d = new Date();

        d.setTime(d.getTime() + (this.opts.expires * 24*60*60*1000));
        document.cookie = this.opts.name + "=" + this.opts.value + ";expires=" + d.toUTCString() + ";path=/; ";
        this.checkCookie();
    }

    CookiesOverlay.prototype.checkCookie = function() {

        // IE8 kennt Array.prototype.indexOf() nicht!
        // pos = document.cookie.split(';').indexOf(cookie);
        var pos = -1;
        var arr = document.cookie.split(';')

        for (var n = 0; n < arr.length; n++) {
            if (arr[n].trim() === this.opts.name + "=" + this.opts.value) {
                pos = n;
                break;
            }
        }

        if (pos >= 0) {
            $(this.element).removeClass('cookiesOverlayEnabled');
            return true;
        }

        return false;
    }

    $.fn.cookiesOverlay = function(opts) {
        return this.each(function() {
            new CookiesOverlay(this, opts);
        });
    };

    $('.cookiesOverlay').cookiesOverlay({
        'name':  'cookiesOverlay',
        'value': 'cookiesOverlayAccepted',
        'expires': 365 * 2,
        'closeButton': $('.cookiesOverlayClose')[0]
    });

});
