<?php
/**
 * @collector noauto
 * @collector footerSplitArea
 */
?>

function receiveSize(e) {
	if (e.origin === 'http://webmisc.oe24.at' || e.origin === 'http://app.oe24.at') { // for security: set this to the domain of the iframe - use e.uri if you need more specificity

		// daten kommen mit INT|ID daher. Bsp: 550|gesund24App
		data = e.data.split('|'); 
		document.getElementById(data[1]).style.height = data[0] + 'px';

	}
}
// window.addEventListener('message', receiveSize, false);
$(window).on('message', function(e) {
	receiveSize(e.originalEvent);
	return false;
});