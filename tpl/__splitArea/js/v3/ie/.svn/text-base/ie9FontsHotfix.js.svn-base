<?php
/**
 * @collector noauto
 * @collector footerIE8SplitArea
 */
?>

;
(function(){
	$(document).ready(function(){
		$('.ie7_anon').each(function() { // wird von der ie9.js generiert für die :after und :before elemente
			var inhalt = $(this).html();
			if (inhalt.substring(0,2) == '\\e') {
				$(this).html('&#x' + inhalt.substring(1) + ';');
			}
		});
	});
})();