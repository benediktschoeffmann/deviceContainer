<?php
/**
 * @collector noauto
 */
?>

// Laufzeit von 05.09.2016 - 05.10.2016, siehe DAILY-600
function Campaign_A1Sitebar_2016_09_05() {
    // var iframe = document.getElementById('ad_frame'); // replace ad_frame
    // var iframe = document.getElementById('Skyscraper1').firstChild.firstChild;
    var iframe = document.getElementById('adv_sitebar_a1'); // replace ad_frame

    (function() {
        var lastTime = 0;
        var vendors = ['ms', 'moz', 'webkit', 'o'];
        for(var x = 0; x < vendors.length && !window.requestAnimationFrame; ++x) {
            window.requestAnimationFrame = window[vendors[x]+'RequestAnimationFrame'];
            window.cancelAnimationFrame = window[vendors[x]+'CancelAnimationFrame']
                                       || window[vendors[x]+'CancelRequestAnimationFrame'];
        }

        if (!window.requestAnimationFrame)
            window.requestAnimationFrame = function(callback, element) {
                var currTime = new Date().getTime();
                var timeToCall = Math.max(0, 16 - (currTime - lastTime));
                var id = window.setTimeout(function() { callback(currTime + timeToCall); },
                  timeToCall);
                lastTime = currTime + timeToCall;
                return id;
            };

        if (!window.cancelAnimationFrame)
            window.cancelAnimationFrame = function(id) {
                clearTimeout(id);
            };
    }());

    var oldData;

    function update() {
        var data = {
            scrollTop: window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop || 0,
            scrollHeight: document.body.scrollHeight,
            windowHeight: window.innerHeight
        };
        if (oldData
            && data.scrollTop === oldData.scrollTop
            && data.scrollHeight === oldData.scrollHeight
            && data.windowHeight === oldData.windowHeight
            ) {

            requestAnimationFrame(update);
            return;
        }

        iframe.contentWindow.postMessage({
            action: 'scrollUpdate',
            data: data
        }, '*');

        oldData = data;
        requestAnimationFrame(update);
    }

    window.addEventListener('message', function onMessage(e) {
        if (e.data.action == 'iframeLoaded') {
            requestAnimationFrame(update);
        }
    });
}