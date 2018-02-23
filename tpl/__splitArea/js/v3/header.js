<?php
/**
 * @collector noauto
 * @collector footerSplitArea
 */
?>

var OE24ScrollHandler = {
	scrollTop            : $(window).scrollTop(),

	navTop               : ($('header .nav_top').length) ? $('header .nav_top') : false,
	navPortal            : ($('header .nav_portal').length) ? $('header .nav_portal') : false,
	navMain              : ($('header .nav_main').length) ? $('header .nav_main') : false,

	navPortalTop         : 0,
	navPortalTopStart    : 0,
	navPortalTopFirstInit: 0,

	stickyTimeout        : {},

	init: function() {
		this.navPortalTopFirstInit = this.navTop.innerHeight() + parseInt($('header').css('padding-top'));
		// this.navPortalTopFirstInit = (this.navPortal) ? this.navPortal.offset().top : 0;
		this.navPortalTop          = (this.navPortal) ? this.navPortal.offset().top : 0;
		this.navPortalTopStart     = (this.navPortal) ? this.navPortal.offset().top : 0;
	},

	fixHeaderPosition: function(Superbanner) {
		this.navPortalTop      = this.navPortalTopFirstInit + Superbanner.height();
		this.navPortalTopStart = this.navPortalTopFirstInit + Superbanner.height();
	},

	initSticky: function(adBannerId, stickyClassName) {
		if ('cad_sticky' === stickyClassName && $('.oe2016 .sidebar.article').length > 0) {
			// (pj) 2015-11-24 wenn cad_sticky in oe2016-rebrush und auf artikel-ansicht, dann andere logik
			return;
		}

		if ($('#' + adBannerId).hasClass(stickyClassName)) {
			this.stickyTimeout[adBannerId] = {timeout: null};
			// $('#' + adBannerId).removeClass(stickyClassName);
		}
	},

	fixedHeader: function() {
		var navPortalHeight = (false === this.navPortal) ? 0 : this.navPortal.outerHeight(true);
		var navMainHeight = (false === this.navMain) ? 0 : this.navMain.outerHeight(true);

		var navPositionLeft = $('header').offset().left - $(window).scrollLeft();

		this.scrollTop = $(window).scrollTop();

		if (this.scrollTop >= this.navPortalTop && false !== this.navPortal && false !== this.navMain) {
			if (false !== this.navPortal) this.navPortal.addClass('fixed').css({"left":navPositionLeft});
			if (false !== this.navMain) this.navMain.addClass('fixed').css({"top":navPortalHeight, "left":navPositionLeft});

			$.each(this.stickyTimeout, function(key) {
				if ($('#' + key).hasClass('fixed')) {
					$('#' + key).css({'left': navPositionLeft});
				}
			});

			navMainHeight = (false === this.navMain) ? 0 : this.navMain.outerHeight(true);

			if (false !== this.navTop) this.navTop.css({"margin-bottom":navPortalHeight+navMainHeight});

			this.makeSticky(navPortalHeight, navMainHeight);
		}

		if (this.scrollTop < this.navPortalTopStart && false !== this.navPortal && false !== this.navMain) {
			if (false !== this.navPortal) this.navPortal.removeClass('fixed').css({"left":0});
			if (false !== this.navMain) this.navMain.removeClass('fixed').css({"top":0, "left":0});

			if (false !== this.navTop) this.navTop.css({"margin-bottom":0});

			this.removeSticky();
		}
	},

	makeSticky: function(navPortalHeight, navMainHeight) {
		$.each(this.stickyTimeout, function(item, value) {
			if (value.timeout === false) {
				return;
			}

			var itemID = '#' + item;

			if (typeof value.initOffsetTop === "undefined") {
				OE24ScrollHandler.stickyTimeout[item].initOffsetTop = $(itemID).offset().top;
				OE24ScrollHandler.stickyTimeout[item].initMarginBottom = $(itemID).parent().css('margin-bottom');
			}

			var itemHeight = parseInt($(itemID).height()) + parseInt(value.initMarginBottom);

			var menueScrollPosition = OE24ScrollHandler.scrollTop + navPortalHeight + navMainHeight

			if (menueScrollPosition < value.initOffsetTop) {
				OE24ScrollHandler.removeSticky();
				return;
			}

			$(itemID).parent().css({'margin-bottom': itemHeight});
			$(itemID).addClass('fixed');

			if (value.timeout == null) {
				OE24ScrollHandler.stickyTimeout[item].timeout = window.setTimeout(function(){OE24ScrollHandler.clearTimeout(item)}, 7000);
			}
		});
	},

	clearTimeout: function(item) {
		this.removeSticky();
		window.clearTimeout(OE24ScrollHandler.stickyTimeout[item].timeout);
		OE24ScrollHandler.stickyTimeout[item].timeout = false;
	},

	removeSticky: function() {
		$.each(this.stickyTimeout, function(item, value) {
			var itemID = '#' + item;
			$(itemID).removeClass('fixed');
			$(itemID).parent().css({'margin-bottom': ''});
		});
	}
};

function OE24InitSticky(channelName, adSlotBanner, className) {

	if ($('#wrap').find('.headerContainer').length === 0) {
		return;
	}
	
	// diese Funktion MUSS ausserhalb von document.ready sein fuer IE9 und darunter
	if (typeof channelName == "undefined") {
		channelName = "";
	}

	var adSlotBannerID = '#' + adSlotBanner;
	var classNameClass = '.' + className;

	if (adSlotBanner == "Superbanner") {
		OE24ScrollHandler.fixHeaderPosition($('#Superbanner'));

		// (pj) 2015-11-27 Wenn im #gravityPlayerContent ein Video ausgespielt wird, berechne die Hoehe fuer diese Position neu, damit der StickyHeader passt.
		if ($('#gravityPlayerContent').children().length > 0) {
			if ($('#gravityPlayerContent').length > 0) {
				OE24ScrollHandler.fixHeaderPosition($('#gravityPlayerContent'));
			}
		}
		// (pj) 2015-11-27 end

		// if (channelName == 'frontpage') {
		// 	return;
		// }
	}

	OE24ScrollHandler.initSticky(adSlotBanner, className);
};

$(document).ready(function() {

	if ($('#wrap').find('.headerContainer').length === 0) {
		return;
	}
	
	// temp
	var layout = $('#wrap').hasClass('layout_madonna');
	if (false == layout) {
		OE24ScrollHandler.init();
		// Wenn schon gescrollt wurde und die Seite neu geladen wird ...
		OE24ScrollHandler.fixedHeader();

		$(window).scroll(function(e) {
			OE24ScrollHandler.fixedHeader();
		});

		if (typeof window['setOE24Sticky'] !== 'undefined') {
			window['setOE24Sticky'].forEach(function(entry) {
				OE24InitSticky(entry[0], $(entry[1]).attr('id'), adSlotsSticky[$(entry[1]).attr('id')])
			});
			// OE24InitSticky(window['setOE24Sticky'][0], $(renderSlotElement).attr('id'), adSlotsSticky[$(renderSlotElement).attr('id')]);
		}
	}
});

$(document).ready(function() {

	if ($('#wrap').find('.headerContainer').length === 0) {
		return;
	}

	if (typeof weatherDisplay !== "undefined") {

		var mainWeather         = $('.nav_main_weather');
		var mainWeatherDropdown = $('.nav_main_weather_dropdown');

		var weatherDegree = $('.nav_main_weather .nav_main_weather_degree');
		var weatherCity = $('.nav_main_weather .nav_main_weather_city');
		var weatherIcon = $('.nav_main_weather .icon_weather');

		$('.nav_main_weather a').click(function(e) {
			e.preventDefault();
			mainWeatherDropdown.toggleClass('show');
		});

		// mainWeatherDropdown.mouseenter(function(e) {
		// 	e.stopPropagation();
		// });

		mainWeatherDropdown.children('ul').mouseleave(function(e) {
			mainWeatherDropdown.toggleClass('show');
		});

		weatherDisplay.rotatePlace = function() {

			// weatherDisplay wird in nav_header_main.tpl initialiert

			weatherDisplay.placeIndex = (weatherDisplay.placeIndex + 1 == weatherDisplay.places.length) ? 0 : weatherDisplay.placeIndex + 1;
			place = weatherDisplay.places[weatherDisplay.placeIndex];

			weatherDegree.html(place.temp + '&deg;');
			weatherCity.html(place.name);
			weatherIcon.removeClass().addClass('icon_weather icon-wi' + weatherDisplay.pad(place.icon, 3));

			setTimeout(weatherDisplay.rotatePlace, weatherDisplay.timeout);
		}

		weatherDisplay.pad = function(num, size) {
		    var s = "000" + num;
		    return s.substr(s.length - size);
		}

		setTimeout(weatherDisplay.rotatePlace, weatherDisplay.timeout);
	}
});

$(document).ready(function() {

	if ($('#wrap').find('.headerContainer').length === 0) {
		return;
	}

	var navMainButtons = $('.navMainButtons');
	if (navMainButtons.length > 0){
		$('.nav_main').hover(
			function(e){ navMainButtons.fadeIn(150); },
			function(e){ navMainButtons.fadeOut(150); }
		);
	}
});
