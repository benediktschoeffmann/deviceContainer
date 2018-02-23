<?php
/**
 * @collector noauto
 * @collector footerIE7_SplitArea
 */
?>

/* To avoid CSS expressions while still supporting IE 7 and IE 6, use this script */
/* The script tag referring to this file must be placed before the ending body tag. */

/* Use conditional comments in order to target IE 7 and older:
	<!--[if lt IE 8]><!-->
	<script src="ie7/ie7.js"></script>
	<!--<![endif]-->
*/

(function() {
	function addIcon(el, entity) {
		var html = el.innerHTML;
		el.innerHTML = '<span style="font-family: \'oe24weather\'">' + entity + '</span>' + html;
	}
	var icons = {
		'icon-wi120': '&#xe601;',
		'icon-wi119': '&#xe602;',
		'icon-wi118': '&#xe603;',
		'icon-wi117': '&#xe604;',
		'icon-wi116': '&#xe605;',
		'icon-wi115': '&#xe606;',
		'icon-wi114': '&#xe607;',
		'icon-wi113': '&#xe608;',
		'icon-wi112': '&#xe609;',
		'icon-wi111': '&#xe60a;',
		'icon-wi110': '&#xe60b;',
		'icon-wi109': '&#xe60c;',
		'icon-wi108': '&#xe60d;',
		'icon-wi107': '&#xe60e;',
		'icon-wi106': '&#xe60f;',
		'icon-wi105': '&#xe610;',
		'icon-wi104': '&#xe611;',
		'icon-wi103': '&#xe612;',
		'icon-wi102': '&#xe613;',
		'icon-wi101': '&#xe614;',
		'icon-wi100': '&#xe615;',
		'icon-wi099': '&#xe616;',
		'icon-wi098': '&#xe617;',
		'icon-wi097': '&#xe618;',
		'icon-wi096': '&#xe619;',
		'icon-wi095': '&#xe61a;',
		'icon-wi094': '&#xe61b;',
		'icon-wi093': '&#xe61c;',
		'icon-wi092': '&#xe61d;',
		'icon-wi091': '&#xe61e;',
		'icon-wi090': '&#xe61f;',
		'icon-wi089': '&#xe620;',
		'icon-wi088': '&#xe621;',
		'icon-wi087': '&#xe622;',
		'icon-wi086': '&#xe623;',
		'icon-wi085': '&#xe624;',
		'icon-wi084': '&#xe625;',
		'icon-wi083': '&#xe626;',
		'icon-wi082': '&#xe627;',
		'icon-wi081': '&#xe628;',
		'icon-wi080': '&#xe629;',
		'icon-wi079': '&#xe62a;',
		'icon-wi078': '&#xe62b;',
		'icon-wi077': '&#xe62c;',
		'icon-wi076': '&#xe62d;',
		'icon-wi075': '&#xe62e;',
		'icon-wi074': '&#xe62f;',
		'icon-wi073': '&#xe630;',
		'icon-wi072': '&#xe631;',
		'icon-wi071': '&#xe632;',
		'icon-wi070': '&#xe633;',
		'icon-wi069': '&#xe634;',
		'icon-wi068': '&#xe635;',
		'icon-wi067': '&#xe636;',
		'icon-wi066': '&#xe637;',
		'icon-wi065': '&#xe638;',
		'icon-wi064': '&#xe639;',
		'icon-wi063': '&#xe63a;',
		'icon-wi062': '&#xe63b;',
		'icon-wi061': '&#xe63c;',
		'icon-wi060': '&#xe63d;',
		'icon-wi059': '&#xe63e;',
		'icon-wi058': '&#xe63f;',
		'icon-wi057': '&#xe640;',
		'icon-wi056': '&#xe641;',
		'icon-wi055': '&#xe642;',
		'icon-wi054': '&#xe643;',
		'icon-wi053': '&#xe644;',
		'icon-wi052': '&#xe645;',
		'icon-wi051': '&#xe646;',
		'icon-wi050': '&#xe647;',
		'icon-wi049': '&#xe648;',
		'icon-wi048': '&#xe649;',
		'icon-wi047': '&#xe64a;',
		'icon-wi046': '&#xe64b;',
		'icon-wi045': '&#xe64c;',
		'icon-wi044': '&#xe64d;',
		'icon-wi043': '&#xe64e;',
		'icon-wi042': '&#xe64f;',
		'icon-wi041': '&#xe650;',
		'icon-wi040': '&#xe651;',
		'icon-wi039': '&#xe652;',
		'icon-wi038': '&#xe653;',
		'icon-wi037': '&#xe654;',
		'icon-wi036': '&#xe655;',
		'icon-wi035': '&#xe656;',
		'icon-wi034': '&#xe657;',
		'icon-wi033': '&#xe658;',
		'icon-wi032': '&#xe659;',
		'icon-wi031': '&#xe65a;',
		'icon-wi030': '&#xe65b;',
		'icon-wi029': '&#xe65c;',
		'icon-wi028': '&#xe65d;',
		'icon-wi027': '&#xe65e;',
		'icon-wi026': '&#xe65f;',
		'icon-wi025': '&#xe660;',
		'icon-wi024': '&#xe661;',
		'icon-wi023': '&#xe662;',
		'icon-wi022': '&#xe663;',
		'icon-wi021': '&#xe664;',
		'icon-wi020': '&#xe665;',
		'icon-wi019': '&#xe666;',
		'icon-wi018': '&#xe667;',
		'icon-wi017': '&#xe668;',
		'icon-wi016': '&#xe669;',
		'icon-wi015': '&#xe66a;',
		'icon-wi014': '&#xe66b;',
		'icon-wi013': '&#xe66c;',
		'icon-wi012': '&#xe66d;',
		'icon-wi011': '&#xe66e;',
		'icon-wi010': '&#xe66f;',
		'icon-wi009': '&#xe670;',
		'icon-wi008': '&#xe671;',
		'icon-wi007': '&#xe672;',
		'icon-wi006': '&#xe673;',
		'icon-wi005': '&#xe674;',
		'icon-wi004': '&#xe675;',
		'icon-wi003': '&#xe676;',
		'icon-wi002': '&#xe677;',
		'icon-wi001': '&#xe678;',
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
