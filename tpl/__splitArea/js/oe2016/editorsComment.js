<?php
/**
 * @collector noauto
 */
?>

;(function($) {

    "use strict";

    function EditorsComment(element, opts) {

        var editorsComment    = $(element),
            editorsCommentRow = editorsComment.find('.editorsCommentRow'),
            editorsCommentCol = editorsComment.find('.editorsCommentCol'),
            prevArrow         = editorsComment.find('.prevArrow'),
            nextArrow         = editorsComment.find('.nextArrow'),
            slidesToShow      = editorsComment.data('slidestoshow'),
            maxHeight         = 0,
            outerHeight       = 0;

        // ----------------------------------------------

        //  Gleiche Hoehe fuer alle Slides
        //  ------------------------------
        //  Die Hoehe der Box wird per CSS auf height:0px und overflow:hidden gesetzt
        //  Die Hoehe fuer die Slides wird berechnet und gesetzt
        //  Die Hoehe der Box ist die Hoehe der Slides + Padding oben und unten

        editorsCommentCol.each(function(index) {
            outerHeight = $(this).outerHeight();
            maxHeight = (maxHeight < outerHeight) ? outerHeight : maxHeight;
        });

        editorsCommentCol.css({ 'height': maxHeight });
        editorsComment.css({ 'height': maxHeight + 20 + 'px' });

        // ----------------------------------------------

        editorsCommentRow.slick({

            prevArrow: prevArrow,
            nextArrow: nextArrow,

            infinite: true,

            slide: 'a',
            slidesToShow: slidesToShow,
            slidesToScroll: 1

        });
    }

    $.fn.editorsComment = function(opts) {
        return this.each(function() {
            new EditorsComment(this, opts);
        });
    };

})(jQuery);

$(document).ready(function() {
    $('.editorsComment').editorsComment();
});
