<?php
/**
 * @collector noauto
 */
?>

;(function(containerClass) {

    // "use strict";

    // --------------------------------------------------------

    var oe24adsLoadAfterPage = {

        allowedAds : new Array(
            'adition_MobileMiddle',
            'adition_MobileBottom',
            'adition_MobileCPCSlot1',
            'adition_MobileCPCSlot2',
            'adition_MobileCPCSlot3',
        ),
        ads : new Array(),
        adsVisible : new Array(),

        handleAd: function(container) {
            var containerId = container.id;

            var loadIt = false;

            // ------------------------------------

            // during testing only on channel-pages
            // var channel = oe24adsLoadAfterPage.isChannel();

            // if (channel == false) {
            //     loadIt = true;
            // }

            // ------------------------------------

            if (oe24adsLoadAfterPage.allowedAds.indexOf(containerId) == -1 ){
                // doesn't matter where it is, load it right from the get go
                loadIt = true;
            }

            oe24adsLoadAfterPage.ads[containerId] = containerId;
            oe24adsLoadAfterPage.adsVisible[containerId] = false;

            if (oe24adsLoadAfterPage.isVisible(containerId)) {
                loadIt = true;
            }

            if (loadIt) {
                oe24adsLoadAfterPage.displayAd(containerId);
            }
        },

        channel : null,
        isChannel: function() {
            if (oe24adsLoadAfterPage.channel == null) {
                oe24adsLoadAfterPage.channel = true;

                // during testing only on channel-pages
                var wrap = document.getElementById('pageBodyTop');
                if (wrap.classList.contains('articleBody')) {
                    oe24adsLoadAfterPage.channel = false;
                }
            }

            return oe24adsLoadAfterPage.channel;
        },

        isVisible: function(id) {
            var offsetTop = document.getElementById(id).offsetTop;

            var doc = document.documentElement;
            var scrollTop = (window.pageYOffset || doc.scrollTop)  - (doc.clientTop || 0);


            var windowHeight = window.innerHeight;

            // contentad in visible area +/- additional pixel
            var additionalPixel = 100;
            if ( offsetTop >= (scrollTop - additionalPixel) && offsetTop <= (scrollTop + windowHeight + additionalPixel) ) {
                return true;
            }
            return false;
        },

        displayId : '',

        displayAd: function(id) {

            if (oe24adsLoadAfterPage.adsVisible[id] == false) {

                

                // get id of the ad
                var adObject = document.getElementById(id);

                var adId = adObject.getAttribute('adid');
                // console.log('id: ',id,' visible - ',adId);

                var script2Load = '<script src=http://ad1.adfarm1.adition.com/js?wp_id=' + adId + '></script>';
                postscribe('#'+id, script2Load);

                // adObject.innerHTML = script2Load;



                // var oScript = document.createElement('script');
                // oScript.setAttribute('type', 'text/javascript');
                // adObject.appendChild(oScript);
                // oScript.setAttribute('src', 'http://ad1.adfarm1.adition.com/js?wp_id=' + adId);

                // var oScript = document.createElement('iframe');
                // oScript.setAttribute('src', 'http://ad1.adfarm1.adition.com/js?wp_id=' + adId);
                // adObject.appendChild(oScript);
                


                
                
                // <script type="text/javascript" src="http://ad1.adfarm1.adition.com/js?wp_id= adSlotId; "></script>

                oe24adsLoadAfterPage.adsVisible[id] = true;


                // oe24adsLoadAfterPage.displayId = id; // helper to remember which ad we are handling right now
                // adition = adition || {};
                // adition.srq = adition.srq || [];

                // adition.srq.push(function(api) {
                //     api.renderSlot(oe24adsLoadAfterPage.displayId);
                //     oe24adsLoadAfterPage.adsVisible[oe24adsLoadAfterPage.displayId] = true;
                // });

            }
        },

        controlAd: function() {
            for (var i = 0; i < oe24adsLoadAfterPage.allowedAds.length; i++) {
                var id = oe24adsLoadAfterPage.allowedAds[i];
                if (typeof oe24adsLoadAfterPage.adsVisible[id] != 'undefined') {
                    if (oe24adsLoadAfterPage.adsVisible[id] == false) {
                        if (oe24adsLoadAfterPage.isVisible(id)) {
                            oe24adsLoadAfterPage.displayAd(id);
                        }
                    }
                }
            }
        }

    };

    // --------------------------------------------------------
    // if this is a channel where advertisments are disabled,
    // the global variable "adition" does not exist - hence the return.
    // console.log('adition: ',typeof adition);
    // if (typeof adition === 'undefined') {
    //     return;
    // }

    var containers = document.querySelectorAll(containerClass);

    for (var i = 0, container; container = containers[i]; ++i) {
        oe24adsLoadAfterPage.handleAd(container);
    }

    window.onscroll = function () {
        oe24adsLoadAfterPage.controlAd();
    };


})('.adSlotAdition');

