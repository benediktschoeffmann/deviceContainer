<?php
/**
 * @collector noauto
 * @collector footerSplitArea
 */
?>

(function() {
    "use strict";

    function _getEpaperDate(inTargetUrl) {
        var epaperDate = new Date();
        epaperDate = new Date(epaperDate.getTime() - (1000 * 60 * 60 * 5));
        var epaperMonth = epaperDate.getMonth() + 1;
        var epaperDay = epaperDate.getDate();
        if (epaperMonth < 10) {
            epaperMonth = '0' + epaperMonth;
        }
        if (epaperDay < 10) {
            epaperDay = '0' + epaperDay;
        }
        if (inTargetUrl && (navigator.userAgent.match(/Android/i) || navigator.userAgent.match(/iPhone/i))) {
            return 'http://tageszeitung.oe24.at/ipadoe_neu/#';
        } else {
            return 'https://www.epaper-oesterreich.at/shelf.act?filter=CITYW';
        }
    }
    $(document).ready(function() {
        var currentDate = new Date();
        var currentWeekday = currentDate.getDay();
        var currentDay = currentDate.getDate();
        var currentMonth = currentDate.getMonth();

        var weekdays = new Array('So','Mo','Di','Mi','Do','Fr','Sa');
        var months = new Array('Jänner','Februar','März','April','Mail','Juni','Juli','August','September','Oktober','November','Dezember');

/*        if (navigator.userAgent.match(/Android/i) || navigator.userAgent.match(/iPhone/i)) {
            $('#latestCoverUrl').attr('href', _getEpaperDate(true) + '/_pdf/epaper.pdf');
            $('#latestCoverTextUrl').attr('href', _getEpaperDate(true) + '/_pdf/epaper.pdf');
        } else {*/
            $('#latestCoverUrl').attr('href', 'https://www.epaper-oesterreich.at/shelf.act?filter=CITYW');
            $('#latestCoverTextUrl').attr('href', 'https://www.epaper-oesterreich.at/shelf.act?filter=CITYW');
        //}
        $('#latestCoverUrl').attr('target', '_blank');
        $('#latestCoverTextUrl').attr('target', '_blank');
        $('#latestCoverImage').attr('src', 'http://file.oe24.at/tz-cover/epaper_320x437.jpg');
        $('.latestCover .weekday').text(weekdays[currentWeekday]);
        $('.latestCover .day').text(currentDay);
        $('.latestCover .month').text(months[currentMonth]);
    });
})();
