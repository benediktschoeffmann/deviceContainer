<?php
/**
 * @collector noauto
 * @collector footerSplitArea
 */
?>

;(function($, win, doc, undefined) {

	"use strict";

	function WeatherTicker(element, opts) {

		this.element = $(element);

		this.defaults = {
			interval: 2000
		};

		this.opts = $.extend(this.defaults, opts);
		this.init();
	}

	WeatherTicker.prototype.init = function() {

		var self = this;

		this.intervalID = null;

		this.elementTop = 0;
		this.elementHeight = this.element.height();
		this.movement = this.element.children().height();

		this.element.on('mouseenter', function(e){
			self.stop();
		});

		this.element.on('mouseleave', function(e){
			self.start();
		});

		this.start();
	};

	WeatherTicker.prototype.start = function() {

		var self = this;

		self.stop();
		self.intervalID = setInterval(function() {
			self.elementTop -= self.movement;
			if (self.elementTop <= (self.elementHeight * (-1))) {
				self.elementTop = 0;
			}
			self.element.css("top", self.elementTop + 'px');
		}, self.defaults.interval);
	}

	WeatherTicker.prototype.stop = function() {
		clearInterval(this.intervalID);
	}

	$.fn.weatherTicker = function(opts) {
		return this.each(function() {
			new WeatherTicker(this, opts);
		});
	};

})(jQuery, window, document);

$('.row .breakingNewsWeather .weatherTicker ul').weatherTicker({
	interval: 1600
});
