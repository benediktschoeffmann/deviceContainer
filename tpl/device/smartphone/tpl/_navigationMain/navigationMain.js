<?php
/**
 * @collector noauto
 */
?>



;(function() {

    function toggleNavigationMain() {

        var body  = document.querySelector('body');
        var buttons = document.querySelectorAll('.headerNavButton a');
        var navigationMainItems = document.querySelectorAll('.navigationMainItem');

        var classBody = body.className;
        var classActive = 'navigationMainActive';

        for (var i = buttons.length - 1; i >= 0; i--) {
            buttons[i].addEventListener('click', function(e) {
                e.preventDefault();
                body.className = (Utilities.hasClass(body, classActive)) ? classBody : classBody + ' ' + classActive;
            });
        }


        var src = $('.navigationMainItem .js-ePaperCover').attr('src');

        if (src == '') {
            $('.navigationMainItem .js-ePaperCover').attr("src", "http://file.oe24.at/tz-cover/epaper_320x437.jpg");
        }

        // for (var i = navigationMainItems.length - 1; i >= 0; i--) {
        //     navigationMainItems[i].addEventListener('click', function(e) {
        //         e.preventDefault();
        //     });
        // }

        // navigation: click before js has been loaded
        if (typeof oe24_navHeaderStartLoadCheckStarted !== 'undefined') {
            if (true == oe24_navHeaderStartLoadCheckStarted) {
                // timeout benötigt - flickity kann sonst Breiten nicht korrekt berechnen
                setTimeout(function() {
                    var body  = document.querySelector('body');
                    var classActive = 'navigationMainActive';
                    body.className = (Utilities.hasClass(body, classActive)) ? classBody : classBody + ' ' + classActive;
                }, 600);

            }
            oe24_navHeaderStartLoadCheckStarted = false;
        }
    }

    toggleNavigationMain();

})();
