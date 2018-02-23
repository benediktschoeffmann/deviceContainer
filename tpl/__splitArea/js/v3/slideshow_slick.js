<?php
/**
 * @collector noauto
 * @collector footerSplitArea
 */
?>

$(document).ready(function() {
	$('.imageSlideShowWrapper').each(function() {

		var _ = this;

		var imagesPerPage = $(this).data('images-per-page');

		var $bigSlider = $(this).find('.imageSlideShow');
		var $bigSliderCounter = $(this).find('.bigSliderCounter');
		var $bigSliderPrev = $(this).find('.arrowPrev');
		var $bigSliderNext = $(this).find('.arrowNext');

		var $thumbSlider = $(this).find('.imageSlideShowThumbs');

		$bigSlider.slick({
			slidesToShow: 1,
			slidesToScroll: 1,
			draggable: false,
			lazyLoad: 'progressive',
			prevArrow: $bigSliderPrev,
			nextArrow: $bigSliderNext,
			onInit: function() {
				$bigSlider.find('.slide.hide').removeClass('hide');

				if (typeof window['theVoting'] != "undefined") {
					window['theVoting'].gotoImage(0);
				} else {
					window['initVoting'] = true;
				}
			},
			onBeforeChange: function(slider, pos, nextPos) {
				var nextItem = (nextPos+1);
				if ($thumbSlider.length > 0) {
					var thumbnailIndex = Math.floor(nextPos / imagesPerPage);
					$thumbSlider.slickGoTo(thumbnailIndex * imagesPerPage);
				}
				$bigSliderCounter.text(nextItem + ' / ' + slider.slideCount);

				if (typeof window['theVoting'] != "undefined") {
					window['theVoting'].gotoImage(nextPos);
				}
			}
		});

		if ($thumbSlider.length > 0) {
			$thumbSlider.slick({
				infinite: false,
				draggable: false,
				arrows: false,
				slidesToShow: imagesPerPage,
				slidesToScroll: imagesPerPage,
				lazyLoad: 'progressive',
				onBeforeChange: function(slider, pos, nextPos) {
					var pageIndex = Math.floor(nextPos/imagesPerPage);
					$(_).find('.slideshowPages .active').removeClass('active');
					$(_).find('.slideshowPages a:eq(' + pageIndex + ')').addClass('active');
				}
			})

			$thumbSlider.find('.slideThumb').on('click', function() {
				$bigSlider.slickGoTo($(this).index());
			});

			$(this).find('.slideshowPages a').on('click', function(e) {
				e.preventDefault();
				$(this).parent().find('.active').removeClass('active');
				$(this).addClass('active');
				$bigSlider.slickGoTo($(this).index() * imagesPerPage);
				$thumbSlider.slickGoTo($(this).index() * imagesPerPage);
			});
		}

	});
});
