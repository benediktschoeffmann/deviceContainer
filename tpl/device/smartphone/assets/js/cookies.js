<?php
/**
 * @collector noauto
 */
?>

function getCookie(name) {
    var c = document.cookie;
    var start = c.indexOf(" " + name + "=");
    if (start === -1){
        start = c.indexOf(name + "=");
    }
    if (start === -1){
        c = null;
    } else {
        start = c.indexOf("=", start) + 1;
        var end = c.indexOf(";", start);
        if (end === -1){
            end = c.length;
        }
        c = unescape(c.substring(start,end));
    }
    return c;
}

function setCookie(cname,cvalue,exdays) {
    var d = new Date();
    d.setTime(d.getTime()+(exdays*24*60*60*1000));
    var expires = "expires="+d.toGMTString();
    document.cookie = cname + "=" + cvalue + "; " + expires + ";path=/;";
}

// ---------------------------------------------------------------------------------

function getGetParameter (leftSide, rightSide) {

    // console.log(typeof(rightSide));
    if (typeof(rightSide)==='undefined') {
        rightSide = undefined;
    }

    var href = unescape(window.location);

    var i = href.lastIndexOf('?');
    if (i == -1) {
        return null;
    }

    var getParameters = href.substr(i);
        getParameters = getParameters.substring(1).split('&');
    var returnValue = false;
    getParameters.forEach(function(entry) {
        // if (leftSide == 'oe24App') console.log(rightSide + " " + entry.split('=')[1]);
        if (entry.split('=')[0] == leftSide) {
            returnValue = (entry.split('=')[1] == rightSide) || typeof(rightSide) == 'undefined';
        }
    });
    return returnValue;
}

// returns true if GET param is available (independent of value), NULL|false otherwise
function hasGetParameter (param) {

    var href = unescape(window.location);

    var i = href.lastIndexOf('?');
    if (i == -1) {
        return null;
    }

    var getParameters = href.substr(i);
    getParameters = getParameters.substring(1).split('&');
    var returnValue = false;
    getParameters.forEach(function(entry) {
        if (entry.split('=')[0] == param) {
            returnValue = true;
        }
    });

    return returnValue;
}

function isApp() {
    var isBnApp = getGetParameter('app[bnApp]','v1');
    var isIos = getGetParameter('app[ios]');
    var isAndroid = getGetParameter('app[android]');
    var isOe24App = getCookie('oe24App') || hasGetParameter('oe24App');

    if (getCookie('is_ios_app')     ||
        getCookie('is_android_app') ||
        getCookie('isApp')          ||
        isBnApp                     ||
        isOe24App                   ||
        isIos                       ||
        isAndroid) {
        return true;
    }
    return false;
}

function isAppForMobileTeaser() {
    var isBnApp = getGetParameter('app[bnApp]','v1');
    var isIos = getGetParameter('app[ios]');
    var isAndroid = getGetParameter('app[android]');
    var isOe24App = getCookie('oe24App') || hasGetParameter('oe24App');

    if (getCookie('isApp') || isBnApp || isIos || isAndroid || isOe24App) {
        return true;
    }
    return false;
}
