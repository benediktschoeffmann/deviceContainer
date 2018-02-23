<?php
/**
 * @collector noauto
 */
?>

;(function($, jwplayer) {
    "use strict";

    function RadioPlayer(el) {

        // jQuery Objects
        this.$el = $(el);
        // this.$headerLogoButton = this.$el.find('.js-radioPlayerLogoButton');
        this.$coverButton = this.$el.find('.js-radioPlayerCoverWrapper');
        this.$iconPlayPause = this.$el.find('.iconPlayPause');
        this.$radioStream = this.$el.find('.js-radioStream');

        this.$interpretNow = this.$el.find('.radioPlayerNowInterpret');
        this.$titleNow = this.$el.find('.radioPlayerNowTitle');
        this.$interpretNext = this.$el.find('.radioPlayerNextInterpret');
        this.$titleNext = this.$el.find('.radioPlayerNextTitle');

        this.$coverImage = this.$el.find('.radioPlayerCoverImage');

        // Variables
        this.radioStreamId = this.$radioStream.attr('id');
        this.player = false;
        this.playlistInterval = 30000;
        this.playlistIntervalId = false;

        // Data-Variables
        this.isPopup = this.$el.data('is-popup');
        this.radioStation = this.$el.data('radio-station');

        // Initialising
        this.init();
        this.addEventListeners();

    }

    RadioPlayer.prototype.initJWPlayer = function() {

        var autoplay = true;

        if (false == this.isPopup) {
            autoplay = false;
            return;
        }

        if (typeof this.streamUrl === 'undefined') {
            return;
        }

        if (typeof jwplayer === 'undefined') {
            return;
        }

        this.player = jwplayer(this.radioStreamId).setup({
            'flashplayer': '/v7.2.2/jwplayer.flash.swf',
            'file': this.streamUrl,
            'type': 'mp3',
            'autostart': autoplay,
            // 'primary': "flash",
            'width': 0,
            'height': 0
        });
        this.player.setVolume(100);

    }

    RadioPlayer.prototype.init = function() {

        var self = this;

        switch (this.radioStation) {
            case 'wien':
                this.playlistUrl = '/_getPlaylist/wien/playlist.json';
                this.streamUrl = 'http://server8775.streamplus.de:80/;';
                break;
            case 'salzburg':
                this.playlistUrl = '/_getPlaylist/salzburg/playlist.json';
                this.streamUrl = 'http://server8773.streamplus.de:80/;';
                break;
            case 'tirol':
                this.playlistUrl = '/_getPlaylist/tirol/playlist.json';
                this.streamUrl = 'http://server19943.streamplus.de:80/;';
                break;
            default:
                break;
        }

        this.playlistIntervalId = window.setInterval(function() {
            self.updatePlaylist();
        }, this.playlistInterval);

        this.initJWPlayer();
    }

    RadioPlayer.prototype.addEventListeners = function() {

        var self = this;

        // this.$headerLogoButton.on('click', function(e) {
        //     e.preventDefault();

        //     if (false == self.isPopup) {
        //         // self.openPopup($(this).attr('href'));
        //         return;
        //     }

        //     self.togglePlayPause();
        // });

        this.$coverButton.on('click', function(e) {
            e.preventDefault();

            if (false == self.isPopup) {
                self.openPopup($(this).attr('href'));
                return;
            }

            self.togglePlayPause();
        });

    }

    RadioPlayer.prototype.openPopup = function(href) {

        var boxHeight = this.$el.outerHeight() + 10;
        window.open(href, 'oe24playerwin', 'width=330,height=' + boxHeight);

    }

    RadioPlayer.prototype.togglePlayPause = function() {

        if (false === this.player) {
            return;
        }

        var playerState = (this.$iconPlayPause.hasClass('icon_play')) ? 'playing' : 'paused';

        this.$iconPlayPause.removeClass('icon_play');
        this.$iconPlayPause.removeClass('icon_pause');

        this.player.play(); // toggle between pause and play

        if ('playing' === playerState) {
            this.$iconPlayPause.addClass('icon_pause');
        } else {
            this.$iconPlayPause.addClass('icon_play');
        }

    }

    // Load new/next Title and Cover
    RadioPlayer.prototype.updatePlaylist = function() {

        var self = this;

        if (typeof this.playlistUrl === 'undefined') {
            window.clearInterval(this.playlistIntervalId);
            return;
        }

        $.getJSON(this.playlistUrl, function(data) {

            var trackNow = data.tracks[0];
            var trackNext = data.tracks[1];

            self.$interpretNow.text(trackNow.artist);
            self.$titleNow.text(trackNow.title);
            self.$interpretNext.text(trackNext.artist);
            self.$titleNext.text(trackNext.title);

            $.ajax({
                'url': '/_checkCover/' + self.radioStation + '/' + trackNow.track_id + '/cover.jpg'
            }).done(function(data) {
                self.$coverImage.attr('src', data);
            });

        });

    }

    $.fn.radioPlayer = function() {
        return this.each(function() {
            new RadioPlayer(this);
        });
    }

})(jQuery, jwplayer);

$(document).ready(function() {
    $('.radioPlayer').radioPlayer();
});
