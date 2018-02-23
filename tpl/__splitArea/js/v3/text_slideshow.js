<?php
/**
 * @collector noauto
 * @collector footerSplitArea
 */
?>

;(function($) {

    "use strict";

    $.fn.oe24textSlideShow = function() {

        var gotoPage = function(box, position, pages){
            var textPosition = $(box).find(".textSlideshowHeadline .textSlideshowPosition");

            // if(navigator.userAgent.toLowerCase().indexOf('chrome') > -1){
            //     window.getSelection().setBaseAndExtent(textPosition,0,textPosition,1);
            // }

            var currentItem = $(box).find(".textSlideshowContentArea .tSsEntry");
            currentItem.removeClass("visible").addClass("hidden");

            var nextItem = $(box).find(".textSlideshowContentArea .tSsEntry:eq("+position+")");
            nextItem.removeClass("hidden").addClass("visible");

            $(box).find(".textSlideshowHeadline .textSlideshowPosition").html((position+1)+"/"+pages);
        }

        return this.each(function(i) {

            var that = this;
            var position = $(that).find('.tSsEntry.visible').index();

            var pages = $(that).find('.textSlideshowContentArea .tSsEntry').length;
            that.last = pages - 1;

            that.arrows = $(that).find('.arrow');

            $(that.arrows).click(function(e){
                e.preventDefault();

                if ($(this).hasClass('tSsRightBtn')) {
                    position = (position + 1 > that.last) ? 0 : position += 1;
                } else {
                    position = (position - 1 < 0) ? that.last : position -= 1;
                }

                gotoPage(that, position, pages);

            });

        });
    }
})(jQuery);

$('.textSlideshow').oe24textSlideShow();
