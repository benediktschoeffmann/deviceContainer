<?php
/**
 * @collector noauto
 */
?>

;(function($, win, doc, undefined){

	"use strict";

	function BoerseTicker(element, opts) {

		this.element = $(element);

		this.defaults = {
			interval: 60,
			movement: 1 // Pixel
		};

		this.opts = $.extend(this.defaults, opts);
		this.init();
	}

	BoerseTicker.prototype.init = function() {

		var self = this;

		this.intervalID = null;

		this.elementLeft = 0;
		this.elementWidth = this.element.width();
		this.element.append(this.element.html());

		this.element.on('mouseenter', function(e){
			self.stop();
		});

		this.element.on('mouseleave', function(e){
			self.start();
		});

		this.start();
	};

	BoerseTicker.prototype.start = function() {

		var self = this;

		self.stop();
		self.intervalID = setInterval(function() {
			self.elementLeft -= self.defaults.movement;
			// self.element.css("left", self.elementLeft + 'px');
			self.element.css('transform', 'translate3d(' + self.elementLeft + 'px, 0, 0)');
			if (self.elementLeft < (self.elementWidth * (-1))) {
				self.elementLeft = 0;
			}
		}, self.defaults.interval);
	}

	BoerseTicker.prototype.stop = function() {
		clearInterval(this.intervalID);
	}

	$.fn.boerseTicker = function(opts) {
		return this.each(function() {
			new BoerseTicker(this, opts);
		});
	};

})(jQuery, window, document);

$('.boerseTickerBox .atxEntryContent').boerseTicker({
	interval: 20
});


