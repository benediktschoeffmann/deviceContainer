<?php
/**
 * @collector noauto
 * @collector footerSplitArea
 */
?>

$(document).ready(function() {

	$('.weatherNavi a:not(.weatherAtLink)').click(function(e) {

		var weatherBox = $(this).parents('.weatherBox');
		var dataType = $(this).data('type');

		e.preventDefault();

		weatherBox.find('.weatherNavi a').removeClass('active');
		$(this).addClass('active');

		weatherBox.find('.weatherMap .location').each(function() {
			$(this).find('.wetterIcon img').attr('src', 'http://www.wetter.at/wetter_public/images/icons/clouds/60x60/icon_' + $(this).find('.wetterIcon').data(dataType) + '.png');
			$(this).find('.wetterTemperature').html($(this).find('.wetterTemperature').data(dataType) + '&deg;');
		});

		weatherBox.find('.weatherText p').html(weatherBox.find('.weatherText p').data(dataType));
	});

});
