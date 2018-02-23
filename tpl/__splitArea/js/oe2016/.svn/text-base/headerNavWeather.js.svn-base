<?php
/**
 * @collector noauto
 */
?>

;(function($) {

    // Object "weatherDropdown" wird in "headerNavWeatherDropdown.[php|tpl]" initialisiert

    if (typeof weatherDropdown === "undefined") {
        return;
    }

    var headerNavWeatherDropdown = $('.headerNavWeatherDropdown');

    $('.headerNavWeather').click(function(e) {
        e.preventDefault();
        headerNavWeatherDropdown.toggleClass('show');
    });

    // Falls das Staedte-DropDown beim MouseEnter-Event gezeigt werden soll ...
    // $('.headerNavWeather').mouseenter(function(e) {
    //     headerNavWeatherDropdown.toggleClass('show');
    // });

    headerNavWeatherDropdown.mouseleave(function(e) {
        headerNavWeatherDropdown.toggleClass('show');
    });

    weatherDropdown.rotatePlace = function() {

        var weatherIcon   = $('.headerNavWeather .icon_weather');
        var weatherDegree = $('.headerNavWeather .headerNavWeatherDegree');
        var weatherCity   = $('.headerNavWeather .headerNavWeatherCity');

        weatherDropdown.placeIndex = (weatherDropdown.placeIndex + 1 == weatherDropdown.places.length) ? 0 : weatherDropdown.placeIndex + 1;
        place = weatherDropdown.places[weatherDropdown.placeIndex];

        weatherIcon.removeClass().addClass('icon_weather icon-wi' + weatherDropdown.pad(place.icon, 3));
        weatherDegree.html(place.temp + '&deg;');
        weatherCity.html(place.name);

        setTimeout(weatherDropdown.rotatePlace, weatherDropdown.timeout);
    }

    weatherDropdown.pad = function(num, size) {
        var s = "000" + num;
        return s.substr(s.length - size);
    }

    setTimeout(weatherDropdown.rotatePlace, weatherDropdown.timeout);

})(jQuery);
