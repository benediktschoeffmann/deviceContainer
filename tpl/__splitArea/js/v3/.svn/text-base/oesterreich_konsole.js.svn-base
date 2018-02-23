<?php
/**
 * @collector noauto
 * @collector footerSplitArea
 */
?>

;(function($) {

	var oeAtKonsoleTeaser = {

		init: function(oeAtKonsoleTeaserHelper) {

			this.interval = null;
			this.delay = oeAtKonsoleTeaserHelper.delay;

			this.items = $('#oesterreich_konsole .oeat_item');
			this.currentIndex = $('#oesterreich_konsole .oeat_item.active').index();

			$('#oesterreich_konsole').hover(
				function() {
					oeAtKonsoleTeaser.stop();
				},
				function() {
					oeAtKonsoleTeaser.next();
					if (oeAtKonsoleTeaser.delay){
						oeAtKonsoleTeaser.interval = window.setInterval(function() {
							oeAtKonsoleTeaser.play();
						}, oeAtKonsoleTeaser.delay);
					}
				}
			);

			$('#oesterreich_konsole .oeat_prev, #oesterreich_konsole .oeat_next').on('click', function(e){
				var className = $(this).attr('class');
				e.preventDefault();
				if ('oeat_prev' == className) {
					oeAtKonsoleTeaser.prev();
				} else {
					oeAtKonsoleTeaser.next();
				}
			});

			if (this.delay){
				this.interval = window.setInterval(function() {
					oeAtKonsoleTeaser.play();
				}, this.delay);
			}
		},

		prev: function() {
			this.currentIndex = (this.currentIndex - 1 >= 0) ? this.currentIndex - 1 : this.items.length - 1;
			// $(this.items).removeClass('active');
			// $(this.items[this.currentIndex]).addClass('active');
			$(this.items).hide();
			$(this.items[this.currentIndex]).fadeIn();
			this.stop();
		},

		next: function() {
			this.currentIndex = (this.currentIndex + 1 <= this.items.length - 1) ? this.currentIndex + 1 : 0;
			// $(this.items).removeClass('active');
			// $(this.items[this.currentIndex]).addClass('active');
			$(this.items).hide();
			$(this.items[this.currentIndex]).fadeIn();
			this.stop();
		},

		play: function(){
			this.currentIndex = (this.currentIndex + 1 <= this.items.length - 1) ? this.currentIndex + 1 : 0;
			// $(this.items).removeClass('active');
			// $(this.items[this.currentIndex]).addClass('active');
			$(this.items).hide();
			$(this.items[this.currentIndex]).fadeIn();
		},

		stop: function() {
			window.clearInterval(this.interval);
		}

	}


	// ----------------------------------------

	$(document).ready(function() {
		if ($('#oesterreich_konsole').length && typeof oeAtKonsoleTeaserHelper !== "undefined") {
			oeAtKonsoleTeaser.init(oeAtKonsoleTeaserHelper);
		}
		// if (typeof oeAtKonsoleTeaser != "undefined") {
		// 	oeAtKonsoleTeaser.init();
		// }
	});

})(jQuery);
