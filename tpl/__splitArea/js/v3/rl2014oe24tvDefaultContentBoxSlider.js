<?
/**
 * @collector noauto
 * @collector footerSplitArea
 */
?>

$(document).ready(function() {

	function showVideoBox() {

		var counter = $(this).parent().parent().find('.videoCounter');
		var showVids = 2;

		$(this).removeClass('js-invokeOnce');

		if ($(this).hasClass('twoVideos')) {
			showVids = 2;
		} else if ($(this).hasClass('threeVideos')) {
			showVids = 3;
		} else if ($(this).hasClass('fourVideos')) {
			showVids = 4;
		} else if ($(this).hasClass('fiveVideos')) {
			showVids = 5;
		}

		$(this).slick({
			slidesToShow: showVids,
			slidesToScroll: 1,
			draggable: false,
			prevArrow: $(this).find('.leftArrow'),
			nextArrow: $(this).find('.rightArrow'),
			lazyLoad: 'ondemand',
			onBeforeChange: function(slider, pos, nextPos) {
				counter.text((nextPos+1) + ' / ' + slider.slideCount);
			},
			onInit: function() {
				this.$slider.parents('.videoContentBox').css('display', 'block');
			}
		});

		$(this).parent().css('max-height', '');
	};

	$('.videoContentBox:in-viewport .videoContentWrapper.js-invokeOnce').each(showVideoBox);

	$(window).scroll(function() {
		$('.videoContentBox:in-viewport .videoContentWrapper.js-invokeOnce').each(showVideoBox);
	});

});
