<?php
/**
 * @collector noauto
 */
?>

function setDesktopCookie(domain) {
    if (typeof(domain) === 'undefined') {
        domain = 'oe24.at';
    }
    var cookieString = 'desktop=' + domain + ';domain=' + domain + ';path=/;expires=' + new Date((new Date()).getTime() + 5 * 24 * 60 * 60 * 1000).toGMTString();
    document.cookie = cookieString;
}

if (typeof window.addEventListener === 'function') {
    var elem   = document.querySelector('.js-desktopVersion');
    var domain = elem.dataset.domain;
    elem.addEventListener('click', function(event) {
        // event.preventDefault();
        setDesktopCookie(domain);
    }, false);
} else if (typeof window.attachEvent === 'function'){
    var elem   = document.querySelector('.js-desktopVersion');
    var domain = elem.getAttribute(domain);
    elem.attachEvent('onclick', function(event) {
        setDesktopCookie(domain);
    });
}

// Utilities.docReady(

var oe24App = function() {
    var oewaAppPath = oewaPath;
    // (db) 20170222 - nur abschneiden wenn auch wirklich "/" vorkommt
    if(oewaPath.lastIndexOf('/') > 0){
        oewaAppPath = oewaPath.substr(0, oewaPath.lastIndexOf('/'));
    }
    var currentUrl = encodeURIComponent(document.URL);

    if (isApp()) {
        // trigger native functions for ios and android.
        // breaking news app does it in the container, so no
        // special action required
        var cookieValue = getCookie('isApp');
        var oe24AppValue = getGetParameter('oe24App');


        // (bs) we decided to do this not with cookies for the oe24app.
        // the oe24app always sends a _get- Tupel, with key oe24App and either ios
        // or android value.
        if (false !== oe24AppValue) {
            cookieValue = oe24AppValue;
        }


        if (cookieValue == 'ios') {
            window.location.href ="oe24app://trackCp?p=" + oewaAppPath;
        } else if (cookieValue == 'android') {
            NativeAppInterface.trackCp(oewaAppPath);
        }



        return;
    }

    if(typeof tracking === 'function') {
        tracking();
    }
}
// });

functionQueue.add(oe24App);
