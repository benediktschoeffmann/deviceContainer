<?php
/**
 * @collector noauto
 */

/*

Mail Donnerstag, 16. Februar 2017 um 16:15

Wenn URL mit GET Parameter:

m.oe24.at/?app[ios]=v1
document.cookie = 'isApp=ios;domain=oe24.at;path=/;';

Wenn Cookie:

document.cookie = 'is_ios_app=true;domain=oe24.at;path=/;';
document.cookie = 'is_android_app=true;domain=oe24.at;path=/;';

wird die jeweilige ÖWA App Logik ausgeführt!

LG, Georg

Zwecks Test

PHP
$appOs = isset($_GET['app']['ios']) ? 'ios' : 'android';
$appOs = isset($_GET['app']['bnApp']) ? 'bnApp' : $appOs;

JavaScript
var cookieTTL = (new Date()).getTime() + 365 * 24 * 60 * 60 * 1000;
document.cookie = 'isApp=<?= $appOs ?>;domain=oe24.at;path=/;expires=' + new Date(cookieTTL).toGMTString();
console.log(document.cookie);

Zwecks Test Ende

*/

?>

;(function() {

    var cookieIsApp = getCookie('isApp');
    var cookieIsIosApp = getCookie('is_ios_app');
    var cookieIsAndroidApp = getCookie('is_android_app');

    var navigationMain = document.querySelector('.smartphone .navigationMain');
    var teaser = document.querySelector('.smartphone .oe24tvTeaser');
    var footer = document.querySelector('.wrapper .footer');

    // console.log(cookieIsApp, cookieIsIosApp, cookieIsAndroidApp);
    // console.log(navigationMain, teaser, footer);

    if (!cookieIsApp && !cookieIsIosApp && !cookieIsAndroidApp) {
        if (null !== teaser && null !== navigationMain) { navigationMain.style.paddingBottom = '150px'; }
        if (null !== teaser && null !== footer) { footer.style.padding = '3px 5% 150px'; }
        if (null !== teaser) { teaser.style.display = 'block'; }
    } else {
        if (null !== teaser) { teaser.style.display = 'none'; }
    }

})();
