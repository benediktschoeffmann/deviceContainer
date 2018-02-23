<?
/**
 * @collector noauto
 * @collector footerSplitArea
 */
?>

$(document).ready(function() {
	function slideTopGelesenArticles() {
		$(this).slick({
			slidesToShow: 3,
			slidesToScroll: 1,
			draggable: false,
			prevArrow: $('.oe2016 .articleTopRead .leftArrow'),
			nextArrow: $('.oe2016 .articleTopRead .rightArrow'),
			lazyLoad: 'ondemand',
/*			onBeforeChange: function(slider, pos, nextPos) {
				counter.text((nextPos+1) + ' / ' + slider.slideCount);
			},
			onInit: function() {
				this.$slider.parents('.videoContentBox').css('display', 'block');
			}*/
		});
	}

	$('.oe2016 .articleTopRead .js-slickSlideMe').each(slideTopGelesenArticles);
});
