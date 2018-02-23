<?php
/**
 * @collector noauto
 * @collector footerSplitArea
 */
?>

;(function($, win, doc, undefined) {

	"use strict";

	function PageSlider(element, opts) {

		var el = $(element),
			autoplay = (1 == el.data('autoplay')) ? true : false,
			autoplaySpeed = el.data('autoplay-speed'),
			prevArrow  = el.parents('.pageSliderBox').find('.prevSlide'),
			nextArrow  = el.parents('.pageSliderBox').find('.nextSlide');

		el.slick({
			arrows: true,
			prevArrow: prevArrow,
			nextArrow: nextArrow,
			autoplay: autoplay,
			autoplaySpeed: autoplaySpeed,
			draggable: false,
			// focusOnSelect: true,
			focusOnSelect: false, // (ws) 141120
			lazyLoad: 'ondemand',
			pauseOnHover: true,
			slidesToShow: 2,
			slidesToScroll: 1,
			slide: 'a',
			speed: 250,
			onInit: function(){
				prevArrow.on('click', function(e){
					el.slickPause();
				});
				nextArrow.on('click', function(e){
					el.slickPause();
				});
				el.find('.pageSliderItem').css({"display":"block"});
			}
		});
	}

	$.fn.pageSlider = function(opts) {
		return this.each(function() {
			new PageSlider(this, opts);
		});
	};

})(jQuery, window, document);

$('.row .pageSlider').pageSlider();
