<?php
/**
 * @collector noauto
 */
?>
function Slideshow(){
	this.containerClass;
	this.slidePrefix;
	this.countSlides;
	this.currentSlide;
	this.autoplay=false;
	this.interval;

	this.isFirstSlide = function(pic){
		if(pic==1){
			return true;
		}else{
			return false;
		}
	}
	this.isLastSlide = function(pic){
		if(pic==this.countSlides){
			return true;
		}else{
			return false;
		}
	}
	this.slideNext = function(){
		//next Slide
		$(this.slidePrefix + this.currentSlide).hide();
		if(this.isLastSlide(this.currentSlide)){
			this.currentSlide=1;
		}else{
			this.currentSlide++;
		}
		$(this.slidePrefix + this.currentSlide).show();
	}
}
Slideshow.prototype.setContainerClass = function(value){
	this.containerClass = value;
	this.slidePrefix = '.' + this.containerClass + '-slide-';
}
Slideshow.prototype.setAutoplay = function(value){
	this.autoplay = value;
}
Slideshow.prototype.init = function()
{
	this.countSlides = $('.' + this.containerClass).children().length;
	var that=this;
	$('.' + this.containerClass).children().each(function(index) {
		$(this).addClass(that.slidePrefix.replace('.','') + (index+1));
	});
	$('.' + this.containerClass).children().not(this.slidePrefix + '1').hide();
	if($('.' + this.containerClass).parent().children('.slideshowOverlay').children().length > 1){
		$('.' + this.containerClass).parent().children('.slideshowOverlay').children().each(function(index) {
			$(this).addClass(that.slidePrefix.replace('.','') + (index+1));
		});
		$('.' + this.containerClass).parent().children('.slideshowOverlay').children().not(this.slidePrefix + '1').hide();
	}
	this.currentSlide=1;
	$('.' + this.containerClass).parent().children('.arrow').addClass(this.containerClass + '-nav');
	$('.' + this.containerClass + '-nav').click(function(){
		if($(this).hasClass('left')){
			//previouse Slide
			$(that.slidePrefix + that.currentSlide).hide();
			if(that.isFirstSlide(that.currentSlide)){
				that.currentSlide=that.countSlides;
			}else{
				that.currentSlide--;
			}
			$(that.slidePrefix + that.currentSlide).show();
		}else{
			//next Slide
			$(that.slidePrefix + that.currentSlide).hide();
			if(that.isLastSlide(that.currentSlide)){
				that.currentSlide=1;
			}else{
				that.currentSlide++;
			}
			$(that.slidePrefix + that.currentSlide).show();
		}
		if(that.autoplay && that.interval != null){
			window.clearInterval(that.interval);
			that.interval=null;
		}
	});
	if(this.autoplay)
		this.interval=setInterval(function(){that.slideNext();},4000);
}
