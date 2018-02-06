;(function() {

    "use strict";

    // (ws) 2016-02-08 Cookies-Overlay rausnehmen
    // (ws) 2018-02-02 Cookies-Overlay zeigen, falls noch nicht "weggeklickt"

    var cookiesOverlay = document.querySelector('.cookiesOverlay');

    if (!cookiesOverlay) {
        return;
    }

    var cookieOptions = {
        name: 'mobileCookieOverlay',
        value: 'mobileCookieOverlayAccepted',
        expires: 365 * 2,
        className: 'visible'
    }

    var cookiesOverlayClose = cookiesOverlay.querySelector('.cookiesOverlayClose');

    cookiesOverlayClose.addEventListener('click', function(event) {
        event.preventDefault();
        setCookie(cookieOptions.name, cookieOptions.value, cookieOptions.expires);
        cookiesOverlay.classList.remove(cookieOptions.className);
    });

    function checkCookie() {

        var cookie = getCookie(cookieOptions.name);

        if (cookieOptions.value == cookie) {
            cookiesOverlay.classList.remove(cookieOptions.className);
        } else {
            cookiesOverlay.classList.add(cookieOptions.className);
        }
    }

    checkCookie();

})();
