<?php
/**
 * @collector noauto
 * @collector footerSplitArea
 */
?>

$(document).ready(function() {

	$('.consoleBottomItems a, .consoleButtonPrev, .consoleButtonNext').on('click', function(e) {
		e.preventDefault();
	});

	$('.consoleTopItems').each(function(){

		console.log('v3');

		var consoleContent = $(this).parents('.consoleContent');
		var syncItems      = consoleContent.find('.consoleBottomItems');
		var prevArrow      = consoleContent.find('.consoleButtonPrev');
		var nextArrow      = consoleContent.find('.consoleButtonNext');
		var autoplay       = consoleContent.data('autoplay');
		var autoplaySpeed  = consoleContent.data('autoplay-speed');

		$(this).slick({
			prevArrow: prevArrow,
			nextArrow: nextArrow,
			autoplay: (1 === autoplay) ? true : false,
			autoplaySpeed: autoplaySpeed,
			draggable: false,
			fade: true,
			lazyLoad: 'ondemand',
			slide: 'a',
			slidesToShow: 1,
			slidesToScroll: 1,
			asNavFor: syncItems
		});
	});

	$('.consoleBottomItems').each(function(){

		var consoleContent = $(this).parents('.consoleContent');
		var syncItems      = consoleContent.find('.consoleTopItems');
		var slidesToShow   = consoleContent.data('slides-to-show');
		var consoleCounter = consoleContent.find('.consoleCounter');

		$(this).slick({
			arrows: false,
			draggable: false,
			slide: 'a',
			slidesToShow: slidesToShow,
			slidesToScroll: 1,
			focusOnSelect: true,
			speed: 200,
			asNavFor: syncItems,
			onInit: function(){
				$(this.$list).on('click', function(e){
					if ($(e.target).is('span')) {
						$(e.target).parents('a').trigger('click');
					}
				});
				var current = $(this.$list).find('.slick-active').get(0);
				$(this.$list).find('.consoleBottomItem').removeClass('current');
				$(current).addClass('current');
			},
			onAfterChange: function(slider, pos){
				var current = $(this.$list).find('.slick-active').get(0);
				$(this.$list).find('.consoleBottomItem').removeClass('current');
				$(current).addClass('current');
				consoleCounter.text((pos+1) + '/' + slider.slideCount);
			}
		});

	});

});
