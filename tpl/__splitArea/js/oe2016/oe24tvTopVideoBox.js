<?php
/**
 * @collector noauto
 * @collector footerSplitArea
 */
?>

;(function($) {

    function Oe24tvTopVideoBox(element, options) {

        var $playerDiv = $(element).find(options.playerClass);
        var columnName = $(element).data('column-name');

        var playlistObject = {
            'box': element,
            'columnName': columnName,
            'clipsSelector': '.js-topVideoBoxSmallClip'
        }

        // calls Philipps jwPlayer-Skript.
        $playerDiv.jwPlayer(playlistObject);

    }

    $.fn.oe24tvTopVideoBox = function(options) {
            return this.each(function() {
                new Oe24tvTopVideoBox(this, options);
            });
        };

})(jQuery);

// main TopVideoBox
$(document).ready(function () {
    $('.oe24tvTopVideoBox').oe24tvTopVideoBox({
        'playerClass' : '.js-oe24tvTopVideoBoxPlayer'
    });
});


