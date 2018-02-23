<?php
/**
 * @collector noauto
 * @collector footerSplitArea
 */
?>

/*!
 * Slideshow.js
 */
// function Slideshow() {
// 	this.containerClass;
// 	this.slidePrefix;
// 	this.countSlides;
// 	this.currentSlide;
// 	this.autoplay=false;
// 	this.interval;

// 	this.slidePrev = function() {
// 		//prev Slide
// 		$(this.slidePrefix + this.currentSlide).hide();

// 		if (this.currentSlide == 1) {
// 			this.currentSlide=this.countSlides;
// 		} else {
// 			this.currentSlide--;
// 		}

// 		$(this.slidePrefix + this.currentSlide).show();

// 		if (typeof window['theVoting'] != "undefined") {
// 			window['theVoting'].gotoImage(this.currentSlide);
// 		}
// 	}

// 	this.slideNext = function() {
// 		//next Slide
// 		$(this.slidePrefix + this.currentSlide).hide();

// 		if (this.currentSlide == this.countSlides) {
// 			this.currentSlide=1;
// 		} else {
// 			this.currentSlide++;
// 		}

// 		$(this.slidePrefix + this.currentSlide).show();

// 		if (typeof window['theVoting'] != "undefined") {
// 			window['theVoting'].gotoImage(this.currentSlide);
// 		}
// 	}

// 	this.slideTo = function(picNr) {
// 		//slide to picNr
// 		$(this.slidePrefix + this.currentSlide).hide();
// 		this.currentSlide = picNr;
// 		$(this.slidePrefix + this.currentSlide).show();

// 		if (this.interval && this.interval != null) {
// 			window.clearInterval(this.interval);
// 			this.interval = null;
// 		}

// 		if (typeof window['theVoting'] != "undefined") {
// 			window['theVoting'].gotoImage(this.currentSlide);
// 		}
// 	}

// 	this.gotoImageVoting = function() {
// 		if (typeof window['theVoting'] != "undefined") {
// 			window['theVoting'].gotoImage(this.currentSlide);
// 		}
// 	}
// }

// Slideshow.prototype.setContainerClass = function(value) {
// 	this.containerClass = value;
// 	this.slidePrefix = '.' + this.containerClass + '-slide-';
// }

// Slideshow.prototype.setAutoplay = function(value) {
// 	this.autoplay = value;
// }

// Slideshow.prototype.init = function() {

// 	this.countSlides = $('.' + this.containerClass).children().length;
// 	var that=this;

// 	$('.' + this.containerClass).children().each(function(index) {

// 		$(this).addClass(that.slidePrefix.replace('.','') + (index + 1) );

// 	});

// 	$('.' + this.containerClass).children().not(this.slidePrefix + '1').hide();

// 	this.currentSlide=1;

// 	$('.' + this.containerClass).parent().children('.arrow').addClass(this.containerClass + '-nav');

// 	$('.' + this.containerClass + '-nav').click(function() {

// 		if ($(this).hasClass('arrowLeft')) {

// 			//previouse Slide
// 			that.slidePrev();

// 		} else {

// 			//next Slide
// 			that.slideNext();

// 		}

// 		if (that.autoplay && that.interval != null) {

// 			window.clearInterval(that.interval);
// 			that.interval=null;

// 		}

// 	});

// 	if (this.autoplay) {
// 		this.interval = setInterval(function() { that.slideNext(); }, 4000);
// 	}
// }

// if (typeof slideShows != "undefined") {

//     for (c=0; c<slideShows.length; c++)
//     {
// 		window['slideshow' + slideShows[c]] = new Slideshow();
// 		window['slideshow' + slideShows[c]].setContainerClass('slideshowPics-' + slideShows[c]);
// 		if ($('.article_thumbnails').length == 0 && false) {
// 			window['slideshow' + slideShows[c]].setAutoplay(true);
// 		}
// 		window['slideshow' + slideShows[c]].init();
//     }

// }


;(function($) {

    "use strict";

    $.fn.oe24slideShow = function(options) {

		var moveSlide = function(slides, position) {
			$(slides).removeClass('active');
			$(slides[position]).addClass('active');
			// $(slides).fadeOut(300).removeClass('active');
			// $(slides[position]).addClass('active').fadeIn(300);
			voting(position);
		}

		var moveSlideDescription = function(descriptions, position) {
			$(descriptions).removeClass('active');
			$(descriptions[position]).addClass('active');
		}

		var movePager = function(thumbnails, slideshowThumbnails, pages, position) {
			$(slideshowThumbnails).removeClass('active');
			$(thumbnails[position]).parent().addClass('active');

			var pageIndex = $(thumbnails[position]).parent().index('.slideshowThumbnails');
			$(pages).removeClass('active');
			$(pages[pageIndex]).addClass('active');
		}

		var voting = function(position) {
			if (typeof window['theVoting'] != "undefined") {
				window['theVoting'].gotoImage(position);
			}
		}

		var checkAndShowAd = function(slides, adObject) {
			if (adObject.showAds === false) {
				return true;
			}
			adObject.pictureCounter++;
			if (adObject.pictureCounter === 5) {
				adObject.pictureCounter = 0;
				$(slides).removeClass('active');
				adObject.adDiv.show();
				adObject.slideshowContainer.css({height: '600px', backgroundColor: '#e8e8e8'});
			} else {
				adObject.adDiv.hide();
				adObject.slideshowContainer.css({height: 'auto', backgroundColor: '#ffffff'});
			}
			return (adObject.pictureCounter === 0) ? false : true;
		}

		return this.each(function(i) {

			var that = this;
			var position = $(that).find('.slide.active').index();

			// ein object deswegen, damit ich den Zähler in einer Funktion modifizieren kann
			var adObject = {
				pictureCounter: 1,
				adDiv: $(that).find('.slideAd'),
				slideshowContainer: $(that).find('.slideshowContainer'),
				showAds: options.showAds
			}

			that.slides = $(that).find('.slide');
			// that.active = $(that).find('.slide.active');

			that.descriptions = $(that).find('.slideDescription');
			// that.descriptionActive = $(that).find('.slideDescription.active');

			that.last   = that.slides.length - 1;
			that.arrows = $(that).find('.arrow');

			that.slideshowThumbnails = $(that).find('.slideshowThumbnails');
			that.thumbnails = $(that.slideshowThumbnails).find('a');
			that.pages = $(that).find('.slideshowPages a');

			$(that.arrows).click(function(e){
				e.preventDefault();

				// if (checkAndShowAd(that.slides, adObject)) {

					if ($(this).hasClass('arrowNext')) {
						position = (position + 1 > that.last) ? 0 : position += 1;
					} else {
						position = (position - 1 < 0) ? that.last : position -= 1;
					}

					moveSlide(that.slides, position);
					moveSlideDescription(that.descriptions, position);
					movePager(that.thumbnails, that.slideshowThumbnails, that.pages, position);
				// }

			});

			// Thumbnails Pages
			$(that.pages).click(function(e){
				var pageIndex = $(this).index();
				$(that.pages).removeClass('active');
				$(this).addClass('active');
				$(that.slideshowThumbnails).removeClass('active');
				$(that.slideshowThumbnails[pageIndex]).addClass('active');
				e.preventDefault();
			});

			// Thumbnails
			$(that.thumbnails).click(function(e) {
				e.preventDefault();

				// if (checkAndShowAd(that.slides, adObject)) {

					position = $(that.slideshowThumbnails).find('a').index(this);

					moveSlide(that.slides, position);
					moveSlideDescription(that.descriptions, position);
				// }

			});

			// Voting "init"
			voting(0);

		});
    }

})(jQuery);

// $('.slideshow').oe24slideShow();
