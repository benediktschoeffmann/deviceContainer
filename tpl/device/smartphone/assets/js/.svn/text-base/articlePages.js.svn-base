<?php
/**
 * @collector noauto
 */
?>

/*!
 * Article Pages
 */

function showTextPages(){
	this.box = $('.articleBox');
	this.gotoPage = function(page) {
		this.box.find('.articlePageText').hide();
		this.box.find('.articlePageText:eq('+(page-1)+')').show();
		$('.articleBox .articlePages').each(function(){
			$(this).find('a').removeClass('active');
			$(this).find('a:eq('+(page-1)+')').addClass('active');
		});
	}
}

if ($('.articleBox .articlePages').length > 0) {
	var pager = new showTextPages();
}
