<?php
/**
 * @collector noauto
 */
?>

;(function($) {

    function HeaderSubNav(el, settings) {

        this.headerNavContainer = $(el);

        // this.defaults = {
        //     ajaxDelay: 200
        // }
        // this.settings = $.extend(this.defaults, settings);

        // Ajax-Request
        this.jqXHR = false;

        // urlPart: Neueste Stories abrufen
        this.urlPartLatest = 'oe2016/newest';

        // urlPart: Top-Stories abrufen
        this.urlPartTopStories = 'oe2016/top';

        this.headerNavMainItems = this.headerNavContainer.find('.headerNavMainItem').not('.facebook');
        this.headerNavMainSubNav = this.headerNavContainer.find('.headerNavMainSubNav');
        this.subNavMenu = this.headerNavContainer.find('.headerNavMainSubNav .subNavMenu');

        this.init();
    }

    HeaderSubNav.prototype.init = function() {

        var self = this;

        // Click-Events der Sidebar-Buttons werden derzeit nicht weiter verarbeitet

        $('.headerNavMainSubNav .subNavSidebar1, .headerNavMainSubNav .subNavSidebar2').on('click', function(e) {
            e.preventDefault();
        });

        // Hover-Events

        this.headerNavMainItems.find('> a').on('mouseenter', function() {

            var currentLink = $(this).parents('.headerNavMainItem').find('.subNavMenu a:first');
            if (currentLink.length <= 0) {
                return;
            }

            var url = currentLink.data('jsonurl');

            url = ('' === url) ? '' : url + self.urlPartLatest;
            self.readStories(currentLink, url);
        });

        this.subNavMenu.find('li > a').on('mouseenter', function() {

            var currentLink = $(this);
            var url = currentLink.data('jsonurl');

            url = ('' === url) ? '' : url + self.urlPartLatest;
            self.readStories(currentLink, url);
        });
    }

    HeaderSubNav.prototype.readStories = function(currentLink, url) {

        var self = this, stories = [];

        if ('' === url) {
            self.writeStories(currentLink, []);
            return;
        }

        if (currentLink.data('jsonData')) {
            stories = currentLink.data('jsonData').stories;
            self.writeStories(currentLink, stories);
        } else {
            this.fetchJsonData(currentLink, url);
        }
    }

    HeaderSubNav.prototype.writeStories = function(currentLink, stories) {

        var subNavContainer = currentLink.parents('.subNavContainer'), selector;

        $('.subNavContainer').removeClass('noStories');
        if (0 == stories.length) {
            $('.subNavContainer').addClass('noStories');
            return;
        }

        $.each(stories, function(index, value) {

            selector = '.subNavStory' + (index + 1);

            subNavContainer.find(selector).attr('href', '#!');
            subNavContainer.find(selector + ' img').attr('src', '/images/empty.gif');
            subNavContainer.find(selector + ' span').html('');

            subNavContainer.find(selector).attr('href', stories[index].href);
            subNavContainer.find(selector + ' img').attr('src', stories[index].image);
            subNavContainer.find(selector + ' span').html(stories[index].caption);
        });
    }

    HeaderSubNav.prototype.fetchJsonData = function(currentLink, url) {

        var self = this;

        // Aktuellen Ajax-Request abbrechen
        if (self.jqXHR) {
            self.jqXHR.abort();
            self.jqXHR = false;
        }

        this.jqXHR = $.ajax({

            cache: true,
            jsonp : false,
            dataType : 'jsonp',
            url: url + '?jsonCallbackSubNav',
            jsonpCallback: 'jsonCallbackSubNav',

            success: function(data, status, jqXHR) {
                self.writeStories(currentLink, data.stories);
                currentLink.data('jsonData', { jsonUrl:data.jsonUrl, stories:data.stories });
            },

            error: function(jqXHR, status, errorThrown) {
                var data = {};
                data.stories = [];
                self.writeStories(currentLink, data.stories);
                currentLink.removeData('jsonData');
            }

        });
    }

    $.fn.headerSubNav = function(settings) {
        return this.each(function() {
            globalVars.headerSubNav = new HeaderSubNav(this, settings);
        });
    };

})(jQuery);

$(document).ready(function() {

    if (typeof globalVars.headerSubNav === 'undefined') {
        $('.headerNavContainer').headerSubNav({
            // ajaxDelay: 300
        });
    }

});
