<?php
/**
 * @collector noauto
 * @collector footerSplitArea
 */
?>
/*!
 * Horoskop.js
 */
function NaviSlider(){
	this.naviClass = '.horoscopeNavi';
	this.wrapperClass = '.horoscopeNaviWrapper';
	this.leftClass = '.horoscopeNaviLeft';
	this.rightClass = '.horoscopeNaviRight';
	this.width=480;
}

NaviSlider.prototype.init = function()
{
	var that = this;
	$(this.leftClass).click(function(){
		if(! $(that.leftClass).hasClass('noClick') && ! $(that.rightClass).hasClass('noClick')){
			$(that.leftClass).addClass('noClick');
			$(that.rightClass).addClass('noClick');
			if($(that.naviClass).css('left') != '0' && $(that.naviClass).css('left') != '0px'){
				$(that.naviClass).animate({
					left: '+=' + that.width
				}, 500, function() {
					$(that.leftClass).removeClass('noClick');
					$(that.rightClass).removeClass('noClick');
				});
			}else{
				$(that.leftClass).removeClass('noClick');
				$(that.rightClass).removeClass('noClick');
			}
		}
	});
	$(this.rightClass).click(function(){
		if(! $(that.leftClass).hasClass('noClick') && ! $(that.rightClass).hasClass('noClick')){
			$(that.leftClass).addClass('noClick');
			$(that.rightClass).addClass('noClick');
			if($(that.naviClass).css('left') != '-480px'){
				$(that.naviClass).animate({
					left: '-=' + that.width
				}, 500, function() {
					$(that.leftClass).removeClass('noClick');
					$(that.rightClass).removeClass('noClick');
				});
			}else{
				$(that.leftClass).removeClass('noClick');
				$(that.rightClass).removeClass('noClick');
			}
		}
	});

	if($('.activeHoroscopeNaviElement ').length > 0 && $('.activeHoroscopeNaviElement ').offset().left > 445){
		$(that.rightClass).trigger('click');
	}
}

NaviSlider.prototype.debug = function()
{
	// console.log(this);
}

$(document).ready(function(){
	if($('.horoscope').length > 0){
		var horoscope = new NaviSlider();
		horoscope.init();
	}

});
