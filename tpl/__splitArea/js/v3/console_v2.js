<?php
/**
 * @collector noauto
 * @collector footerSplitArea
 */
?>

;(function($, win, doc, undefined) {

	"use strict";

	function ConsoleOe24(element, opts) {

		console.log('v3/console_v2');

		var stories    = $(element).children('.consoleStories'),
			counter    = $(element).children('.consoleCounter'),

			navigation = $(element).find('.consoleNavigation'),
			prevArrow  = $(element).find('.slickPrev'),
			nextArrow  = $(element).find('.slickNext'),

			storyItems = stories.children('.consoleStoriesItem'),
			interval   = navigation.data('interval');

		stories.slick({
			// asNavFor: navigation,
			arrows: false,
			draggable: false,
			fade: true,
			lazyLoad: 'ondemand',
			slidesToShow: 1,
			slidesToScroll: 1,
			slide: 'a',
			onInit: function(){
				navigation.css({"display":"block", "width":"100%"});
				storyItems.css({"display":"block"});
			},
			onBeforeChange: function(slider, pos, nextPos) {
				counter.text((nextPos+1) + '/' + slider.slideCount);
			}
		});

		navigation.slick({
			asNavFor: stories,
			arrows: true,
			prevArrow: prevArrow,
			nextArrow: nextArrow,
			// autoplay: false,
			autoplay: true,
			autoplaySpeed: interval,
			draggable: false,
			focusOnSelect: true,
			lazyLoad: 'ondemand',
			pauseOnHover: true,
			slidesToShow: 4,
			slidesToScroll: 1,
			slide: 'a',
			speed: 250,
			onInit: function(){
				prevArrow.on('click', function(e){
					navigation.slickPause();
				});
				nextArrow.on('click', function(e){
					navigation.slickPause();
				});

			}
		});

		// In onInit funktioniert preventDefault() nicht fuer die geklonten Items
		$(element).find('.consoleNavigationItem').on('click', function(e){
			e.preventDefault();
			navigation.slickPause();
		});
	}

	$.fn.consoleOe24 = function(opts) {
		return this.each(function() {
			new ConsoleOe24(this, opts);
		});
	};

})(jQuery, window, document);

// (ws) 2016-03-07
if (false === $('#wrap').hasClass('oe2016') || $('#wrap').hasClass('layout_tv')) {
	// $('.console').consoleOe24();
	$('.console').not('.flickity').consoleOe24();
}
// (ws) 2016-03-07 end

// $(document).ready(function() {
// 	setTimeout(function () {
// 		$('.console .captionContainer').fadeIn("fast");
// 	}, 2000);
// });

