<?php
/**
 * @collector noauto
 * @collector footerSplitArea
 */
?>

/**
 * Tickerbox JavaScript
 */

/*!
 * Tickerbox JavaScript
 */

;(function ( $ ) {

	var rotate = true;
	var nextButton = 'next';
	var prevButton = 'prev';
	var container = 'content_container';
	var content = 'content';

	$.fn.oe24Tickerbox = function(shouldRotate, nextBtn, prevBtn, containerDiv, contentDiv) {

		if (typeof nextBtn !== "undefined") {
			nextButton = nextBtn;
		}
		if (typeof prevBtn !== "undefined") {
			prevButton = prevBtn;
		}
		if (typeof shouldRotate !== "undefined") {
			rotate = shouldRotate;
		}
		if (typeof containerDiv !== "undefined") {
			container = containerDiv;
		}
		if (typeof contentDiv !== "undefined") {
			content = contentDiv;
		}


		this.each(function() {
			
			var imagesPerPage = 3;
			if ($(this).find('.ticker_bilder').length > 0) {
				imagesPerPage = 4;
			}

			var boxItems = $(this).find('.' + content).length;
			var itemPos = 0;
			var endItem = boxItems-imagesPerPage;
			var that = this;

			if (rotate) {
				for (i=0; i<(imagesPerPage-1); i++) {
					$(this).find('.' + container).append($(this).find('.' + content).eq(i).clone());
				}
				// $(this).find('.' + container).append($(this).find('.' + content).eq(1).clone());
				var endItem = boxItems-1;
			}

			$(this).find('.' + nextButton).click(function() {

				if (itemPos <= endItem) {
					$(that).find('.' + content).eq(itemPos).css({'display': 'none'});
					itemPos++;
				}

				if (rotate && itemPos > endItem) {
					$(that).find('.' + content).css({'display': 'initial'});
					itemPos = 0;
				}

				return false;
			});

			$(this).find('.' + prevButton).click(function() {

				if (itemPos >= 0) {
					itemPos--;
					$(that).find('.' + content).eq(itemPos).css({'display': 'initial'});
				}

				if (rotate && itemPos < 0) {
					$(that).find('.' + content + ':lt(' + endItem + ')').css({'display': 'none'});
					itemPos = endItem;
				}

				return false;
			});

		});

		return this;

	};

}(jQuery));

$('.ticker_box').oe24Tickerbox(true, 'ticker_arrow_right', 'ticker_arrow_left', 'ticker_middle', 'ticker_content');