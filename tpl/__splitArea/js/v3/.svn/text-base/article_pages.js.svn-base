<?php
/**
 * @collector noauto
 * @collector footerSplitArea
 */
?>

/**
 * Article Pages
 */

/*!
 * Article Pages
 */

function showTextPages(){
	this.box = $('#wrap article .article_body');
	this.gotoPage = function(page) {
		this.box.find('.article_page_body').hide();
		this.box.find('.article_page_body:eq('+(page-1)+')').show();
		$('#wrap article .article_pages').each(function(){
			$(this).find('a').removeClass('active');
			$(this).find('a:eq('+(page-1)+')').addClass('active');
		});
	}
}

if ($('#wrap article .article_pages').length > 0) {
	var pager = new showTextPages();
}

$('.article_box .overlay_box .arrowContainer .arrow').click(function(e) {

	// console.log('OLD', this);

	e.preventDefault();

	/*
	var images = $('.article_box .overlay_box img');
	var imgLength = images.length;
	var imgIndex = $('.article_box .overlay_box img:visible').index();
	*/
	var images = $(this).parent().parent().children("img");
	var imgLength = images.length;
	var imgIndex = $(this).parent().parent().children("img:visible").index();

	// (ws)
	var copyright = $('.article_box .article_box_top_copyright');
	// (ws) end

	images.hide();

	if ($(this).hasClass('arrowLeft')) {
		imgIndex = (imgIndex-1 >= 0) ? imgIndex-1 : imgLength-1 ;
	} else {
		imgIndex = (imgIndex+1 >= imgLength) ? 0 : imgIndex+1;
	}

	$(images[imgIndex]).show();

	// (ws)
	$(copyright).removeClass('active');
	$(copyright[imgIndex]).addClass('active');
	// (ws) end

	oe24Tracking.loadOewa();
	oe24Tracking.googleAnalyticsRefreshTracking();
});
