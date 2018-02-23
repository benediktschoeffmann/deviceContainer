<?php
/**
 * @collector noauto
 * @collector footerSplitArea
 */
?>

$(document).ready(function() {
	var country = $('.country_header a');
	var countryBox = $('.country_body .country');
	var rowCaption = $('.country_body').parents('.content').siblings('.row_caption').find('h2');
	var countryname = '';
	country.hover(function() {
		var countryIndex = $(this).index();
		$(country).removeClass('active');
		$(country[countryIndex]).addClass('active');
		$(countryBox).removeClass('active');
		$(countryBox[countryIndex]).addClass('active');
		countryname = $(this).children('span').attr('data-countryname');
		//$(rowCaption).children('#country_countryname').remove();
		//$(rowCaption).append('<span id="country_countryname"> '+countryname+'</span>');
	}, function() {
		/*  ;  */
	});
});
