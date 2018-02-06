<?php
/**
 * @collector noauto
 */
?>

;(function($) {

    function Oe24tvTopVideoBox(element, options) {
        var $playerDiv = $(element).find(options.playerClass);
        
        var playlistObject = {
            'box': element,
            'columnName': 'Mobile Column',
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

$(document).ready(function () {
    $('.oe24tvTopVideoBox').oe24tvTopVideoBox({
        'playerClass' : '.js-oe24tvTopVideoBoxPlayer'
    });
});

