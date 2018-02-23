<?php
/**
 * @collector noauto
 */
?>

;(function($) {

    function StickyHeader(el) {

        this.el = $(el);

        this.headerNav = this.el.find('.headerNav');
        this.headerNavLogo = this.el.find('.headerNavLogo');
        this.headerNavMain = this.el.find('.headerNavMain');
        this.headerNavPortal = this.el.find('.headerNavPortal');
        this.headerNavContainer = this.el.find('.headerNavContainer');

        this.headerNavPortalOuterHeight = this.headerNavPortal.outerHeight();

        this.init();
    }

    StickyHeader.prototype.init = function() {
        var self = this;
        self.scrollHandler();
        $(window).on('scroll', function(e) {
            self.scrollHandler();
        });
    };

    StickyHeader.prototype.scrollHandler = function() {

        var self = this,
            marginBottom = 0,
            offset = $(self.headerNav).offset(),
            scrollTop = $(window).scrollTop();
            scrollLeft = offset.left - $(window).scrollLeft();

        function update(positionLeft, marginBottom) {
            // (db) 2017-12-14 set 'left' only if 'wrap'-div is not centered
            if ($('.headerNavContainer').hasClass('headerNavCenterSticky')) {
                self.headerNavContainer.css('left','');
            }
            else {
                self.headerNavContainer.css({
                    'left': positionLeft + 'px'
                });

            }
            self.headerNavPortal.css({
                'margin-bottom': marginBottom + 'px'
            });
        }

        function adIsSticky(scrollLeft) {
            if (typeof globalVars.stickyObjects === 'undefined') {
                return;
            }

            $.each(globalVars.stickyObjects, function(key, werbePosition) {

                var $werbePositionObject = $(werbePosition.objectQuery);
                if ($werbePositionObject.length == 0) {
                    return;
                }

                if (false == werbePosition.timeout) {
                    return;
                }

                if (null == werbePosition.timeout) {
                    werbePosition.timeout = window.setTimeout(function() {
                        werbePosition.timeout = false;
                        $werbePositionObject.removeClass('stickyHeader');
                        updateWerbung(werbePosition, 0, 0);
                        delete globalVars.stickyObjects[key];
                    }, 7000);
                }

                $werbePositionObject.addClass('stickyHeader');
                marginBottom = $werbePositionObject.outerHeight();
                updateWerbung(werbePosition, scrollLeft, marginBottom);
            });
        }

        function adIsNotSticky(scrollLeft) {
            if (typeof globalVars.stickyObjects === 'undefined') {
                return;
            }

            $.each(globalVars.stickyObjects, function(key, werbePosition) {

                var $werbePositionObject = $(werbePosition.objectQuery);
                if ($werbePositionObject.length == 0) {
                    return;
                }

                $werbePositionObject.removeClass('stickyHeader');
                updateWerbung(werbePosition, 0, 0);
            });
        }

        function updateWerbung(werbePosition, positionLeft, marginBottom) {
            var $werbePositionObject = $(werbePosition.objectQuery);
            if ($werbePositionObject.length == 0) {
                return;
            }
            // werbePosition bekommt Position left um an der richtigen Position zu bleiben
            $werbePositionObject.css({
                'left': positionLeft + 'px'
            });
            // Container bekommt margin-bottom, damit Seite nicht huepft
            $werbePositionObject.parent().css({
                'margin-bottom': marginBottom + 'px'
            });
        }

        if (scrollTop > offset.top + this.headerNavPortalOuterHeight) {
            this.headerNavContainer.addClass('stickyHeader');
            marginBottom = self.headerNavLogo.outerHeight() + self.headerNavMain.outerHeight();
            update(scrollLeft, marginBottom);
            adIsSticky(scrollLeft);
        } else {
            this.headerNavContainer.removeClass('stickyHeader');
            update(0, 0);
            adIsNotSticky(scrollLeft);
        }
    };

    $.fn.stickyHeader = function() {
        return this.each(function() {
            globalVars.stickyHeader = new StickyHeader(this);
        });
    };

})(jQuery);

$('.headerBox').stickyHeader();
