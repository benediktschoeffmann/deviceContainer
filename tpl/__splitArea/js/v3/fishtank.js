<?php
/**
 * @collector noauto
 * @collector footerSplitArea
 */
?>

function startFishtankParallax(channelName, adSlotBanner, className) {

	// $('.fishtank').css('position', 'relative').css('left', '0px');
	// $('.fishtank .ad').css('height', '855px').css('background-image', 'url(/images/000000516131.png)');

	if ($('.fishtank').length === 0) {
		return;
	}

	var navPortal = $('.nav_portal').height();
	var fishtankHeight = $('.fishtank').height();
	var startScrollingDelay = (fishtankHeight / 2);
	var fishtankTop = $('.fishtank').offset().top + startScrollingDelay;
	var fishtankImgHeight = $('.fishtank .ad').height();
	var fishtankOverflow = fishtankImgHeight - fishtankHeight;
	var startScroll = fishtankTop - $(window).height();

	$(window).scroll(function() {

		var navMain = $('.nav_main').height();
		var scrollView = $(window).height() - navPortal - navMain; // + $('.fishtank').height();
		var scrollTop = $(window).scrollTop();

		if (scrollTop > startScroll && (scrollTop + navPortal + navMain) < (fishtankTop - startScrollingDelay)) {
			var diff = (scrollTop - startScroll) / (scrollView - startScrollingDelay);
			var translateNew = (fishtankOverflow * diff);
			$('.fishtank .ad').css('transform', 'translateY(-' + translateNew + 'px)');
		}
		if (scrollTop < startScroll) {
			$('.fishtank .ad').css('transform', 'translateY(0px)');
		}
		if ((scrollTop + navPortal + navMain) > (fishtankTop - startScrollingDelay)) {
			$('.fishtank .ad').css('transform', 'translateY(-' + fishtankOverflow + 'px)');
		}

	});

}

if (typeof window['setFishtankParallax'] !== 'undefined') {
	window['setFishtankParallax'].forEach(function(entry) {
		startFishtankParallax(entry[0], $(entry[1]).attr('id'), adSlotsSticky[$(entry[1]).attr('id')])
	});
}

