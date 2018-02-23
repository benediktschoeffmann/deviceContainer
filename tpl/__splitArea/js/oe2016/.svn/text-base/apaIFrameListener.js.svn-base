<?php
/**
 * @collector noauto
 * @collector footerSplitArea
 */
?>

window.addEventListener('message', function (event) {
    if (event.origin != 'http://file.oe24.at') {
    // if (event.origin != 'http://oe24dev.webmisc.oe24.at') {
        // console.log('Message did not come from trusted origin, exiting. ');
        return;
    }
    var values = event.data.split(';');
    var elem = document.getElementById(values[0]);
    var height = values[1];
    height = (parseInt(height) >= 50) ? height : '300';
    elem.style.height = height + 'px';
 });
