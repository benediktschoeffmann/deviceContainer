<?php
/**
 * @collector noauto
 * @collector footerSplitArea
 */
?>

/**
 * Article Social Scroller JavaScript
 */

$(window).bind("scroll", function(){

	if ($('article .article_social').length > 0) {

		var document_scroll_top = $(document).scrollTop();
		var portal_moving_height = $('.nav_portal').height();
		var main_menu_item_height = $('.nav_main_menue_item').height();
		var social_top = 70;

		var article_box_wrapper_top = $('.article_box_wrapper').offset().top;
		var social_top_diff = social_top - (portal_moving_height + main_menu_item_height);
		var article_box_wrapper_height = $('.article_box_wrapper').height();
		var article_social_height = $('.article_social').height();

		var content_width = $('.content').innerWidth();
		var social_width = $('.article_social').innerWidth();
		var content_left = $('.content').position().left;

		var social_left = content_width - social_width + content_left;

		if ((article_box_wrapper_top + article_box_wrapper_height - portal_moving_height - main_menu_item_height - social_top_diff - article_social_height) < document_scroll_top) {

			$('.article_social').css({
				position: 'absolute',
				left: 'auto',
				right: '0px',
				top: 'auto',
				bottom: '0px'
			});

		} else if ((article_box_wrapper_top - portal_moving_height - main_menu_item_height - social_top_diff) < document_scroll_top) {

				// (ws) 2016-07-14
				// Wenn links vom Artikel eine Werbung ausgespielt wird, stimmt die horizontale Position
				// der Social-Button nicht mehr. Einfache Loesung: Die fixed-Positionierung rausnehmen!
				// $('.article_social').css({
				// 	position: 'fixed',
				// 	left: social_left+'px',
				// 	right: 'auto',
				// 	top: social_top+'px',
				// 	bottom: 'auto'
				// });

		} else {

			$('.article_social').css({
				position: 'absolute',
				left: 'auto',
				right: '0px',
				top: '0px',
				bottom: 'auto'
			});

		}

	}

});
