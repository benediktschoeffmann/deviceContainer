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

// bottom video-layer
$(document).ready(function () {
    $('.oe24tvTopVideoLayer').oe24tvTopVideoBox({
        'playerClass' : '.js-oe24tvTopVideoBoxPlayer'
    });

    // start layer
    setTimeout(function(){ $('.oe24tvTopVideoLayer').removeClass('tvLayerEnd').addClass('tvLayerStart'); }, 1000);

    // close layer
    $('.oe24tvTopVideoLayer .videoLayerClose').click(function(e) {
      $('.oe24tvTopVideoLayer').removeClass('tvLayerStart').addClass('tvLayerEnd');
    });
    // open layer
    $('.oe24tvTopVideoLayer .videoLayerUp').click(function(e) {
      $('.oe24tvTopVideoLayer').removeClass('tvLayerEnd').addClass('tvLayerStart');
    });
});

