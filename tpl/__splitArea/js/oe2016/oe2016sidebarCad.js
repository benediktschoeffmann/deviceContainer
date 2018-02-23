<?php
/**
 * @collector noauto
 * @collector footerSplitArea
 */

 // $mode = 'js';
 $mode = 'jquery';

?>

<? if ($mode == 'js'): ?>

    var oe2016SidebarCadFixed = false;
    var oe2016SidebarCadLoaded = {
        duration: 500,
        maxTries: 10,
        tried: 0
    };

    var oe2016SidebarCad = function() {
        var wrap = document.getElementById('wrap');

        var oe2016 = wrap.classList.contains('oe2016') ? true : false;
        var article = ( wrap.classList.contains('a2016') || wrap.classList.contains('story') ) ? true : false;

        if (!oe2016 || (oe2016 && article) ) {
            return;
        }

        // -----------------------------------------------

        this.cad1 = document.getElementById('Contentad1');

        var sticky = (this.cad1.classList.contains('cad_sticky2017')) ? true : false;

        if (!sticky) {
            // this.cad1.classList.add('cad_sticky2017');
            return;
        }

        // only if element exists
        if (typeof this.cad1 != 'undefined') {
            this.cad1OriginalTop = this.cad1.offsetTop;

            this.cad1Fixed = false;
            this.fixedDuration = 2500;
            this.cadTimer = null;

            this.timeout = {
                key: 0,
                counter: 0,
                interval: 100,
                limit: 10000
            };

            this.header = document.querySelector('.headerBox .headerNav');

            this.navPortal = document.querySelector('.headerBox .headerNavPortal');

            this.navMain = document.querySelector('.headerBox .headerNavContainer');

            // Hoehe von navPortal und navMain, wenn beide NICHT 'fixed' sind
            this.navHeight = 100;

            // for display-reasons - do not display margin for subdiv, while position is fixed
            this.cad1_subdiv = document.querySelector('#Contentad1.cad_sticky2017 div');

            this.initCad();
        }
        else {
            // try again, in case ad hasn't been loaded yet
            oe2016SidebarCadLoaded.tried++;
            if (oe2016SidebarCadLoaded.tried < oe2016SidebarCadLoaded.maxTries) {
                setTimeout(function(){
                    new oe2016SidebarCad();
                }, oe2016SidebarCadLoaded.duration);
            }
        }
    }

    oe2016SidebarCad.prototype.initCad = function() {

        var self = this;

        self.cad1.style.display = 'block';

        function pollCad() {
            var temp;

            temp = document.querySelector('#Contentad1.cad_sticky2017 iframe');
            self.cad1Content = null;
            if (typeof temp != 'undefined'){
                self.cad1Content = temp;
            }

            if ((self.cad1Content !== null) || (self.timeout.counter > self.timeout.limit)) {
                clearTimeout(self.timeout.key);
                self.handleWindowScrollEvent();
            }
            else {
                // no content loaded/has been found, try again in "interval" milliseconds until "limit" has been reached
                self.timeout.counter += self.timeout.interval;
                self.timeout.key = setTimeout(pollCad, self.timeout.interval);
            }
        }

        pollCad();

        window.onscroll = function () {
            self.handleWindowScrollEvent();
        };
    }



    oe2016SidebarCad.prototype.handleWindowScrollEvent = function() {
        if (!oe2016SidebarCadFixed) {

            if (this.navMain.classList.contains('fixed') || this.navMain.classList.contains('stickyHeader')) {

                var cad1top = this.cad1OriginalTop - this.navHeight;

                var gravity = document.getElementsByClassName('gravityContainer');
                var gravityHeight = (typeof gravity[0] != 'undefined') ? gravity[0].offsetHeight : 0;

                var supportPageOffset = window.pageXOffset !== undefined;
                var isCSS1Compat = ((document.compatMode || "") === "CSS1Compat");
                var scrollTop = supportPageOffset ? window.pageYOffset : isCSS1Compat ? document.documentElement.scrollTop : document.body.scrollTop;
                scrollTop -= gravityHeight;

                if (cad1top < scrollTop) {
                    this.cad1.style.position = 'fixed';
                    this.cad1.style.top = this.navHeight + 'px';
                    this.cad1.style.bottom = 'auto';
                    this.cad1.style.left = 'auto';
                    this.cad1.style.zIndex = '9999';

                    this.cad1_subdiv.style.marginBottom = '0';

                    if (!this.cadTimer) {
                        this.cadTimer = setTimeout(function(){
                            var ad = document.querySelector('#Contentad1.cad_sticky2017');
                            ad.style.position = 'static';
                            ad.style.top = 'auto';
                            ad.style.bottom = 'auto';
                            ad.style.left = 'auto';
                            ad.style.zIndex = '1';

                            var adDiv = document.querySelector('#Contentad1.cad_sticky2017 div');
                            adDiv.style.marginBottom = '20px';

                            oe2016SidebarCadFixed = true;

                        }, this.fixedDuration);


                    }
                }
                else {
                    this.cad1.style.position = 'static';
                    this.cad1.style.top = 'auto';
                    this.cad1.style.bottom = 'auto';
                    this.cad1.style.left = 'auto';
                    this.cad1.style.zIndex = '1';

                    this.cad1_subdiv.style.marginBottom = '20px';
                }

            }
            else {
                this.cad1.style.position = 'static';

                this.cad1_subdiv.style.marginBottom = '20px';
            }
        }

    }

    window.onload = function () {
        new oe2016SidebarCad();
    };


<? else: ?>


    var oe2016SidebarCadFixed = false;
    var oe2016SidebarCadLoaded = {
        duration: 500,
        maxTries: 10,
        tried: 0
    };

    var oe2016SidebarCad = function() {

        var oe2016 = $('#wrap').hasClass('oe2016') ? true : false;
        var article = ($('#wrap').hasClass('a2016') || $('.a2016 .content.article').length > 0 || $('.a2016 .sidebar.article').length > 0) ? true : false;

        if (!oe2016 || (oe2016 && article) ) {
            return;
        }

        // this.cad1 = $('#Contentad1');
        // this.cad1.addClass('cad_sticky2017');
        this.cad1 = $('#Contentad1.cad_sticky2017');

        // only if element exists
        if (this.cad1.length>0) {
            this.cad1OriginalTop = document.getElementById("Contentad1").offsetTop;

            this.cad1Fixed = false;
            this.fixedDuration = 2500;
            this.cadTimer = null;

            this.timeout = {
                key: 0,
                counter: 0,
                interval: 100,
                limit: 10000
            };

            this.header    = $('.headerBox .headerNav');
            this.navPortal = $('.headerBox .headerNavPortal');
            this.navMain   = $('.headerBox .headerNavContainer');


            // Hoehe von navPortal und navMain, wenn beide NICHT 'fixed' sind
            this.navHeight = 100;
            // this.sidebarContainerPaddingBottom = parseInt($('.a2016 .sidebar.article .sidebarContainer').css('padding-bottom'));

            // for display-reasons - do not display margin for subdiv, while position is fixed
            this.cad1_subdiv = $('#Contentad1.cad_sticky2017 div');

            this.initCad();
        }
        else {
            // try again, in case ad hasn't been loaded yet
            oe2016SidebarCadLoaded.tried++;
            if (oe2016SidebarCadLoaded.tried < oe2016SidebarCadLoaded.maxTries) {
                setTimeout(function(){
                    new oe2016SidebarCad();
                }, oe2016SidebarCadLoaded.duration);
            }
        }
    }

    oe2016SidebarCad.prototype.initCad = function() {

        var self = this;

        self.cad1.css({'display':'block'});
        function pollCad() {

            var temp;

            temp = self.cad1.find('iframe');
            self.cad1Content = null;
            if (temp.length > 0) {
                self.cad1Content = temp;
            }
            if ((self.cad1Content !== null) || (self.timeout.counter > self.timeout.limit)) {
                clearTimeout(self.timeout.key);
                self.handleWindowScrollEvent();
            }
            else {
                // no content loaded/has been found, try again in "interval" milliseconds until "limit" has been reached
                self.timeout.counter += self.timeout.interval;
                self.timeout.key = setTimeout(pollCad, self.timeout.interval);
            }
        }

        pollCad();



        $(window).on('scroll', function(e) {
            self.handleWindowScrollEvent();
        });
    }



    oe2016SidebarCad.prototype.handleWindowScrollEvent = function() {
        if (!oe2016SidebarCadFixed) {

            // handle margin for first div

            if (this.navMain.hasClass('fixed') || this.navMain.hasClass('stickyHeader')) {
                var cad1top = this.cad1OriginalTop - this.navHeight;
                var gravityHeight = ($('.gravityContainer').length > 0) ? $('.gravityContainer').outerHeight(true) : 0;
                var scrollTop = $(window).scrollTop() - gravityHeight;

                if (cad1top < scrollTop) {
                    // element "über" Fenster - position fixed
                    this.cad1.css({
                        'position': 'fixed',
                        'top': this.navHeight + 'px',
                        'bottom': 'auto',
                        'left': 'auto',
                        'z-index': '9999',
                    });

                    this.cad1_subdiv.css({
                        'margin-bottom': '0'
                    });

                    if (!this.cadTimer) {
                        this.cadTimer = setTimeout(function(){
                            $('#Contentad1.cad_sticky2017').css({
                                'position': 'static',
                                'top': 'auto',
                                'bottom': 'auto',
                                'left': 'auto',
                                'z-index': '1',
                            });

                            $('#Contentad1.cad_sticky2017 div').css({
                                'margin-bottom': '20px'
                            });

                            oe2016SidebarCadFixed = true;

                        }, this.fixedDuration);


                    }
                }
                else {
                    // element im Fenster oder darunter -> alles normal
                    this.cad1.css({
                        'position': 'static',
                        'top': 'auto',
                        'bottom': 'auto',
                        'left': 'auto',
                        'z-index': '1',
                    });

                    this.cad1_subdiv.css({
                        'margin-bottom': '20px'
                    });
                }

            }
            else {
                this.cad1.css({
                    'position': 'static'
                });
                this.cad1_subdiv.css({
                    'margin-bottom': '20px'
                });
            }
        }

    }

    window.onload = function () {
        new oe2016SidebarCad();
    };

<? endif; ?>

