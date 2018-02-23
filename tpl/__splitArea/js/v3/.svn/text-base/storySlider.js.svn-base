<?php
/**
 * @collector noauto
 * @collector footerSplitArea
 */
?>

$(document).ready(function() {

	$('.storySlider').each(function(){

		var prevArrow     = $(this).siblings('.storySliderPrev');
		var nextArrow     = $(this).siblings('.storySliderNext');
		var autoplay      = $(this).data('autoplay');
		var autoplaySpeed = $(this).data('autoplay-speed');
		var slidesToShow  = $(this).data('slides-to-show');

		$(this).slick({
			prevArrow: prevArrow,
			nextArrow: nextArrow,
			infinite: true,
			lazyLoad: 'ondemand',
			slidesToShow: slidesToShow,
			autoplay: (1 === autoplay) ? true : false,
			autoplaySpeed: autoplaySpeed,
			onInit: function(){
				var that = this;
				$(this.$prevArrow, this.$prevArrow).on('click', function(e){
					that.$slider.slickPause();
				});
			}
		});
	});

});
