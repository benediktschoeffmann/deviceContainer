<?php
/**
 * @collector noauto
 */
?>
// JQuery Plugin to handle OesterreichTabbedBox clicks.
// Plugin documentation as follows:
// http://debuggable.com/posts/how-to-write-jquery-plugins:4f72ab2e-7310-4a74-817a-0a04cbdd56cb

;(function($, doc, win) {

    "use strict";

    function OesterreichTabbedBox(el, opts) {


        this.el  = $(el);
        this.opts = opts;

        this.tabbedBoxNav = this.el.find('.tabbedBoxNav');
        this.currentActive = this.tabbedBoxNav.find('.active');
        this.ajaxLoader = this.el.find('.ajaxLoader');
        this.init();
    }

    OesterreichTabbedBox.prototype.init = function() {

        var self = this;

        function handleClick(event) {
            var url = $(this).data('link');
            var posting = $.post(url);

            event.preventDefault();
            self.ajaxLoader.show();

            self.currentActive.removeClass('active');
            $(this).addClass('active');
            self.currentActive = $(this);

            posting.done(function (data) {
                var result = jQuery.parseJSON(data);
                $(result).each(function (index) {
                    $('#oesterreichTabbedBox .js-oesterreichBoxAjaxTarget'+index+' .articleLink').attr('href', this.url);
                    $('#oesterreichTabbedBox .js-oesterreichBoxAjaxTarget'+index+' .image').attr('src', this.imageUrl);
                    $('#oesterreichTabbedBox .js-oesterreichBoxAjaxTarget'+index+' .story_pretitle').text(this.preTitle);
                    $('#oesterreichTabbedBox .js-oesterreichBoxAjaxTarget'+index+' .story_pagetitle').text(this.title);
                    $('#oesterreichTabbedBox .js-oesterreichBoxAjaxTarget'+index+' .story_leadtext').text(this.leadText);
                });
                self.ajaxLoader.hide();
            });
        }

        self.el.find('.js-countryLink').on('click', handleClick);
    };

    $.fn.oeTabbedBox = function(opts) {
        return this.each(function() {
            new OesterreichTabbedBox(this, opts);
        });
    };

})(jQuery, document, window);

$('#oesterreichTabbedBox').oeTabbedBox({
    // optionA: 'a',
    // optionB: 'b'
});
// $('#oesterreichTabbedBox .active').click();

