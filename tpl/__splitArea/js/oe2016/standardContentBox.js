<?php
/**
 * @collector noauto
 */
?>

;(function($) {

    "use strict";

    function StandardContentBox(element, opts) {

        var box = $(element),
            columnLeft  = box.find('.columnLeft'),
            columnRight = box.find('.columnRight'),
            heightLeft  = columnLeft.outerHeight(true),
            heightRight = columnRight.outerHeight(true);

        if (heightLeft < heightRight) {
            columnLeft.find('a').css({ 'height': (heightRight - 20) + 'px' });
        }
    }

    $.fn.standardContentBox = function(opts) {
        return this.each(function() {
            new StandardContentBox(this, opts);
        });
    };

})(jQuery);

$(document).ready(function() {
    $('.standardContentBox.portrait').standardContentBox();
});
