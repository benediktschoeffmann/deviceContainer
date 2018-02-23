<?php
/**
 * @collector noauto
 */
?>

 /** @collector footerSplitArea*/
$(document).ready(function() {

	var scroll_console = null;

	$('.wm2014TopBox .wmConsoleContainer .arrow').click(function (e) {

		e.preventDefault();

		if (scroll_console != null) {
			window.clearInterval(scroll_console);
			scroll_console = null;
		}

		scrollConsole($(this).hasClass('arrowLeft'));
                oe24Tracking.loadOewa();
                oe24Tracking.googleAnalyticsRefreshTracking();

	});

	function scrollConsole(hasClassArrowLeft) {

		var images = $('.wm2014TopBox .wmConsoleContainer .consoleImgLink');
		var imgLength = images.length;
		var imgIndex = $('.wm2014TopBox .wmConsoleContainer .consoleImgLink:visible').index();

		images.hide();

		if (hasClassArrowLeft) {
			imgIndex = (imgIndex-1 < 0) ? imgLength-1 : imgIndex-1;
		} else {
			imgIndex = (imgIndex+1 >= imgLength) ? 0 : imgIndex+1;
		}

		$(images[imgIndex]).show();

		$('.wm2014TopBox .wmConsoleContainer .consoleOverlay').html((imgIndex+1) + ' / ' + imgLength);

	}

	$('.wm2014TopBox .klappBar').click(function (e) {

		e.preventDefault();

		$(this).prev().toggle();

		var klappIcons = $(this).find('.klappIcon');

		if (klappIcons.hasClass('icon_arrow4_up')) {
			klappIcons.removeClass('icon_arrow4_up').addClass('icon_arrow4_down');
			$(this).find('.klappText').html('Aufklappen');
		} else {
			klappIcons.removeClass('icon_arrow4_down').addClass('icon_arrow4_up');
			$(this).find('.klappText').html('Zuklappen');
		}

	});

	$('.wm2014TopBox .wmVideosContainer .arrow').click(function (e) {

		e.preventDefault();

		var images = $('.wm2014TopBox .wmVideosContainer .wmVideo');
		var imgLength = images.length;
		var imgIndex = $('.wm2014TopBox .wmVideosContainer .wmVideo:visible').index();
		var imgIndexLength = $('.wm2014TopBox .wmVideosContainer .wmVideo:visible').length;

		images.hide();

		if ($(this).hasClass('arrowLeft')) {
			imgIndex = (imgIndex-1 < 0) ? imgLength-imgIndexLength : imgIndex-1;
		} else {
			imgIndex = (imgIndex+imgIndexLength+1 > imgLength) ? 0 : imgIndex+1;
		}

		for (var j=0; j<imgIndexLength; ++imgIndex, ++j) {
			$(images[imgIndex]).show();
		}

		oe24Tracking.loadOewa();
		oe24Tracking.googleAnalyticsRefreshTracking();
	});

	scroll_console = window.setInterval(function() {scrollConsole(false); }, 5000);

});
