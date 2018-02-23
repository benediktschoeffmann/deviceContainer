<?php
/**
 * @collector noauto
 */
?>
;(function ($, window, undefined) {
  'use strict';

  var $doc = $(document),
      Modernizr = window.Modernizr;

  $(document).ready(function() {
	
  });

  if (Modernizr.touch && !window.location.hash) {
    $(window).load(function () {
      setTimeout(function () {
        window.scrollTo(0, 1);
      }, 0);
    });
  }

	$('div.slideshow .overlay').each(function(i, element) {
		$(element).height(eval($('.slideshow .annotation').height() + 17).toString() + 'px');
	});

	if(typeof sliderInits === 'object') {
		for(var i = 0; i < sliderInits.length; i++)
			sliderInits[i].init();
	}
    
    if(typeof readyCallbacks === 'object'){
        for(var i = 0; i < readyCallbacks.length; i++){
            if(typeof readyCallbacks[i] === 'function'){
                readyCallbacks[i]($);
            }
        }
    }
	  
})(jQuery, this);
