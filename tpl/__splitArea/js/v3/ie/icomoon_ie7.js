<?php
/**
 * @collector noauto
 * @collector footerIE7_SplitArea
 */
?>

/* To avoid CSS expressions while still supporting IE 7 and IE 6, use this script */
/* The script tag referencing this file must be placed before the ending body tag. */

/* Use conditional comments in order to target IE 7 and older:
	<!--[if lt IE 8]><!-->
	<script src="ie7/ie7.js"></script>
	<!--<![endif]-->
*/

(function() {
	function addIcon(el, entity) {
		var html = el.innerHTML;
		el.innerHTML = '<span style="font-family: \'icomoon\'">' + entity + '</span>' + html;
	}
	var icons = {
		'icon-instagram': '&#xe631;',
		'icon-pinterest': '&#xe632;',
		'icon-camera': '&#xe630;',
		'icon-location': '&#xe61f;',
		'icon-location2': '&#xe620;',
		'icon-star': '&#xe621;',
		'icon-star2': '&#xe622;',
		'icon-cycle': '&#xe625;',
		'icon-cw': '&#xe626;',
		'icon-ccw': '&#xe627;',
		'icon-layout': '&#xe623;',
		'icon-play': '&#xe628;',
		'icon-pause': '&#xe629;',
		'icon-record': '&#xe62a;',
		'icon-stop': '&#xe62b;',
		'icon-next': '&#xe62c;',
		'icon-previous': '&#xe62d;',
		'icon-first': '&#xe62e;',
		'icon-last': '&#xe62f;',
		'icon-dot': '&#xe624;',
		'icon-comment': '&#xe600;',
		'icon-printer': '&#xe601;',
		'icon-mail': '&#xe602;',
		'icon-house': '&#xe603;',
		'icon-search': '&#xe604;',
		'icon-facebook': '&#xe605;',
		'icon-twitter': '&#xe606;',
		'icon-googleplus': '&#xe607;',
		'icon-list1': '&#xe618;',
		'icon-list2': '&#xe619;',
		'icon-clock': '&#xe61a;',
		'icon-user': '&#xe61b;',
		'icon-users': '&#xe61c;',
		'icon-arrow1-left': '&#xe60c;',
		'icon-arrow1-down': '&#xe60d;',
		'icon-arrow1-up': '&#xe60e;',
		'icon-arrow1-right': '&#xe60f;',
		'icon-arrow2-left': '&#xe614;',
		'icon-arrow2-down': '&#xe615;',
		'icon-arrow2-up': '&#xe616;',
		'icon-arrow2-right': '&#xe617;',
		'icon-arrow3-left': '&#xe610;',
		'icon-arrow3-down': '&#xe611;',
		'icon-arrow3-up': '&#xe612;',
		'icon-arrow3-right': '&#xe613;',
		'icon-arrow4-left': '&#xe608;',
		'icon-arrow4-down': '&#xe609;',
		'icon-arrow4-up': '&#xe60a;',
		'icon-arrow4-right': '&#xe60b;',
		'icon-export': '&#xe61d;',
		'icon-sharable': '&#xe61e;',
		'icon-caret-down': '&#xf0d7;',
		'icon-caret-up': '&#xf0d8;',
		'icon-caret-left': '&#xf0d9;',
		'icon-caret-right': '&#xf0da;',
		'0': 0
		},
		els = document.getElementsByTagName('*'),
		i, c, el;
	for (i = 0; ; i += 1) {
		el = els[i];
		if(!el) {
			break;
		}
		c = el.className;
		c = c.match(/icon-[^\s'"]+/);
		if (c && icons[c[0]]) {
			addIcon(el, icons[c[0]]);
		}
	}
}());
