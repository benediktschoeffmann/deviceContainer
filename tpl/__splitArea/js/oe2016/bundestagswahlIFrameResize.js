<?php
/**
 * @collector noauto
 * @collector footerSplitArea
 */
?>

// https://stackoverflow.com/questions/9975810/make-iframe-automatically-adjust-height-according-to-the-contents-without-using
function bundestagswahlResizeIframe(obj) {
    obj.style.height = obj.contentWindow.document.body.scrollHeight + 'px';
}
