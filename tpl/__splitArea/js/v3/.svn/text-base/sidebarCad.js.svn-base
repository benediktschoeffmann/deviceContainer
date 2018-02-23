<?php
/**
 * @collector noauto
 * @collector footerSplitArea
 */
?>

var SidebarCad = function() {

    if (!$('#wrap').hasClass('a2016') || !$('.a2016 .content.article').length > 0 || !$('.a2016 .sidebar.article').length > 0) {
        return;
    }

    // this.cad1 = $('#Contentad1');
    // this.cad1 = $('#Contentad_Sky1');
    this.cad1 = $('#sidebarContainerTopBox');
    this.cad2 = $('#Contentad2');

    this.cad1Content = null;
    this.cad2Content = null;

    this.timeout = {
        key: 0,
        counter: 0,
        interval: 100,
        limit: 10000
    };

    this.header    = $('.headerContainer header');
    this.navPortal = $('.headerContainer .nav_portal');
    this.navMain   = $('.headerContainer .nav_main');

    if ($('#wrap').hasClass('oe2016')) {
        this.header    = $('.headerBox .headerNav');
        this.navPortal = $('.headerBox .headerNavPortal');
        this.navMain   = $('.headerBox .headerNavContainer');
    }

    this.sidebarContainer = $('.a2016 .sidebar.article .sidebarContainer');

    // Hoehe von navPortal und navMain, wenn beide NICHT 'fixed' sind
    this.cad1Top = 100;
    this.sidebarContainerPaddingBottom = parseInt($('.a2016 .sidebar.article .sidebarContainer').css('padding-bottom'));

    // (ws) 2015-12-04
    // Die Hoehe des sidebarContainers wird jetzt in articleObserver.js ermittelt
    // this.article = $('.a2016 .content.article');
    // this.initSidebar();

    this.initCad();
}

SidebarCad.prototype.initCad = function() {

    var self = this;

    self.cad1.css({'display':'block'});
    self.cad2.css({'display':'block'});

    self.cad2.css({
        'position': 'absolute',
        'bottom': this.sidebarContainerPaddingBottom + 'px'
    });

    function pollCad() {

        var temp;

        temp = self.cad1.find('iframe');
        if (temp.length > 0) {
            self.cad1Content = temp;
        }

        temp = self.cad2.find('iframe');
        if (temp.length > 0) {
            self.cad2Content = temp;
        }

        if ((self.cad1Content !== null && self.cad2Content !== null) || (self.timeout.counter > self.timeout.limit)) {
            clearTimeout(self.timeout.key);
            self.handleWindowScrollEvent();
        } else {
            self.timeout.counter += self.timeout.interval;
            self.timeout.key = setTimeout(pollCad, self.timeout.interval);
        }
    }

    pollCad();

    $(window).on('scroll', function(e) {
        self.handleWindowScrollEvent();
    });
}

SidebarCad.prototype.handleWindowScrollEvent = function() {

    if (this.navMain.hasClass('fixed') || this.navMain.hasClass('stickyHeader')) {

        var sidebarContainerPositionBottom = this.sidebarContainer.position().top + this.sidebarContainer.outerHeight();
        var cad1Bottom = this.cad1Top + this.cad1.outerHeight();
        var cad2Height = (this.cad2.length > 0) ? this.cad2.outerHeight() : 0;
        var gravityHeight = ($('.gravityContainer').length > 0) ? $('.gravityContainer').outerHeight(true) : 0;
        var scrollTop = $(window).scrollTop() - gravityHeight;

        cad2Height = (cad2Height > 0) ? cad2Height + 10 : 0;

        if (sidebarContainerPositionBottom - cad1Bottom - cad2Height - this.sidebarContainerPaddingBottom > scrollTop) {

            this.cad1.css({
                'position': 'fixed',
                'top': this.cad1Top + 'px',
                'bottom': 'auto',
                'left': this.navMain.position().left
            });
            // 2018-02-14 (db) fullpage-ads positioning
            $('.fullpageAds #sidebarContainerTopBox, .fullpageAds #Contentad2').css({
                'left': '50%',
                'margin-left': '-480px'
            });
        } else {
            this.cad1.css({
                'position': 'absolute',
                'top': 'auto',
                'bottom': (cad2Height + this.sidebarContainerPaddingBottom) + 'px',
                'left': 'auto'
            });
            // 2018-02-14 (db) fullpage-ads positioning
            $('.fullpageAds #sidebarContainerTopBox, .fullpageAds #Contentad2').css({
                'left': 'auto',
                'margin-left': '0'
            });
        }

    } else {
        this.cad1.css({
            'position': 'static'
        });
        // 2018-02-14 (db) fullpage-ads positioning
        $('.fullpageAds #sidebarContainerTopBox, .fullpageAds #Contentad2').css({
            'left': 'auto',
            'margin-left': '0'
        });
    }
}

$(document).ready(function() {
    new SidebarCad();
});
