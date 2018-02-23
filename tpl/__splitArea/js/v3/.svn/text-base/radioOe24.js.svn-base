<?php
/**
 * @collector noauto
 * @collector footerSplitArea
 */
?>

;(function($) {

	"use strict";

	$.fn.oe24radioPlayer = function() {

		var refreshTime = 30000;
		var url = '/_getPlaylist/wien/playlist.json';
		var coverCity = 'wien';
		var fileUrl = 'http://server8775.streamplus.de:80/;';
		var popupLink = '';
		var autoPopup = false;

		var autoplay = true;

		var loadPlaylist = function() {
			$.getJSON(url, function(data) {
				var trackNow = data.tracks[0];
				var trackNext = data.tracks[1];

				$('#nowCover').attr('src', '/_getCover/' + coverCity + '/'+trackNow.track_id+'/cover.jpg');
				$('#nowInterpret').text(trackNow.artist);
				$('#nowTitel').text(trackNow.title);

				$('#nextInterpret').text(trackNext.artist);
				$('#nextTitel').text(trackNext.title);
			});
		}

		return this.each(function(i) {
			
			if ($('.radioOe24Playlist').find('.playlistBody.popup').length > 0) {
				autoplay = false;
			}

			if (typeof jwplayer !== 'undefined') {

		        var player = jwplayer("radioStream").setup({
		            'flashplayer': "/misc/swf/jwplayer.flash.swf",
		            'file': fileUrl,
		            'type': 'mp3',
		            'autostart': autoplay,
		            'primary': "flash",
		            'width': 0,
		            'height': 0
		        });
		        player.setVolume(100);

			}

			if ($('.radioOe24Playlist').find('.playlistBody.popup').length > 0) {
				popupLink = $('.radioOe24Playlist #popupLink').val();
				autoPopup = $('.radioOe24Playlist #autoPopup').val();
			} else {
				$('#btnPlayPause').click(function() {
					if ($(this).hasClass('pause')) {
						player.play();
						$(this).addClass('play').removeClass('pause');
					} else {
						player.stop();
						$(this).addClass('pause').removeClass('play');
					}
				});

				$('.radioOe24Playlist .playlistLinks a').click(function(e) {
					parent.window.open($(this).attr('href'));
					e.preventDefault();
				});
			}
			
			$('.radioOe24Playlist .playlistBody.popup').click(function() {
				window.open(popupLink,'oe24playerwin','width=360,height=480');
			});

			if (autoPopup) {
				$('.radioOe24Playlist .playlistBody.popup').trigger('click');
			}

			loadPlaylist();
			window.setInterval(function() {loadPlaylist();}, refreshTime);
		});
	}


})(jQuery);

$('.radioOe24Playlist').oe24radioPlayer();