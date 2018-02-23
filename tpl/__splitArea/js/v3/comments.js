<?php
/**
 * @collector noauto
 * @collector footerSplitArea
 */
?>

;(function($) {

	"use strict";

	$.fn.Kommentare = function(options) {

		var commentId = $(this).find('#setCommentForm :input[name="commentRef"]').val();

		
		if (typeof commentId === 'undefined' ) {
			return;
		}

		var addLeadingZeros = function(num) {
			return (num >= 0 && num < 10) ? "0" + num : "" + num;
		}

		var getCommentDateTime = function(timestamp) {
			var date = new Date(timestamp*1000);
			var tag = addLeadingZeros(date.getDate());
			var monat = addLeadingZeros(date.getMonth()+1);
			var jahr = date.getFullYear();
			var std = addLeadingZeros(date.getHours());
			var min = addLeadingZeros(date.getMinutes());
			return tag + "." + monat + "." + jahr + " " + std + ":" + min;
		}

		var getCommentDiv = function(comment, answerId, isPetition) {
			var username = ('' === comment['firstname'] || '' === comment['lastname']) ? comment['username'] : comment['firstname'] + ' ' + comment['lastname'] + ' (' + comment['username'] + ')';
			if (isPetition && username.substr(-7) == ' (GAST)') {
				username = username.substr(0, username.length-7);
			}
			var commentId = (answerId !== null) ? answerId : comment['id'];
			var commentName = $('<span></span>').addClass('name').text(username);
			var commentTrenner = $('<div></div>').addClass('trenner').text('>>');
			var commentDatum = $('<span></span>').addClass('datum').text(getCommentDateTime(comment['date']));
			var commentAnswer = $('<a></a>').addClass('answerComment').addClass('right').data('answerId', commentId).text('Antworten');
			var commentClearfix = $('<div></div>').addClass('clearfix');
			var commentText = $('<p></p>').text(comment['text']);

			var commentDivContainer = $('<div></div>').addClass('comment_div').append(commentName, [commentTrenner, commentDatum, commentAnswer, commentClearfix, commentText]);
			var commentDivAfter = $('<div></div>').addClass('comment_div_after');

			var commentDiv = $('<div></div>').addClass('comment').append(commentDivContainer, [commentDivAfter]);

			if (answerId !== null) {
				commentDiv.addClass('antwort');
			}

			return commentDiv;
		}

		var showComments = function(commentSection) {
			var comments = $('#commentsContainer').data('comments');
			comments.reverse();

			var isPetition = $(commentSection).hasClass('no_borders');

			if (comments.length > 0) {
				$('#commentsContainer').html('');
			}

			for (var c=0; c<comments.length; ++c) {

				var commentDiv = getCommentDiv(comments[c], null, isPetition);
				$('#commentsContainer').append(commentDiv);

				if (comments[c]['answers'] != null) {
					for (var a=0; a<comments[c]['answers'].length; ++a) {
						var commentAnswerDiv = getCommentDiv(comments[c]['answers'][a], comments[c]['id'], isPetition);
						$('#commentsContainer').append(commentAnswerDiv);
					}
				}

			}

		}

		var loadComments = function(commentSection) {

			$.ajax({
				url: '/user/json/getcomments/' + commentId,
				dataType: 'json',
				// cache: false,
				success: (function(response) {
					console.log('comments success');
					if (response !== null) {
						$('#commentsContainer').data('comments', response);
						$('#commentText').text('Posten Sie ('+response.length+')');
						$('#commentCounter span').text('('+response.length+')');
						showComments(commentSection);
					}
					// (ws) 2015-11-25 OE2016-24
					$('#commentsContainer').addClass('js-commentsDone');
					// (ws) 2015-11-25 OE2016-24 //
				})
			});

		}

		return this.each(function(i) {

			var commentSection = this;

			loadComments(commentSection);

			// Wenn user auf Antworten klickt
			$(this).on('click', '.comment .answerComment', function() {
				$('#setCommentForm').find(':input[name="commentAnswerRef"]').val($(this).data('answerId'));
				$('.commentsHeaderText').text('Posten Sie Ihre Antwort');
				$('#setCommentForm textarea').attr('placeholder', 'Schreiben Sie hier Ihre Antwort');
			});

			// Wenn user ins Kommentarfeld was reinschreibt
			$(this).find('#setCommentForm textarea').bind('keyup', function() {
				if ($(this).val().length > 0) {
					$('#setCommentForm :input[name="setComment"]').val('1');
					$('#setCommentForm .button').removeAttr('disabled');
				} else {
					$('#setCommentForm :input[name="setComment"]').val('0');
					$('#setCommentForm .button').attr('disabled', 'disabled');
				}
			});

			// Form-Submit
			$(this).find('form').bind('submit', function() {

				var that = this;
				var data = $(this).serialize();

				$(commentSection).find('#commentMsg').text('');

				$(commentSection).find('#' + $(this).attr('id') + ' button[type="submit"]').attr('disabled', 'disabled');
				$(commentSection).find('#' + $(this).attr('id') + ' input[type="submit"]').attr('disabled', 'disabled');

				$.post('/user/json', data, function(response) {

					$(commentSection).find('#' + $(that).attr('id') + ' button[type="submit"]').removeAttr('disabled');
					$(commentSection).find('#' + $(that).attr('id') + ' input[type="submit"]').removeAttr('disabled');

					if ($(that).attr('id') == 'logoutForm') {
						if (response.error === null) {
							$(commentSection).find('#loginForm').css('display', 'inline');
							$(commentSection).find('#commentGuestUsername').css('display', 'inline');
							$(commentSection).find('#loginUsername').css('display', 'none');
							$(commentSection).find('#logoutForm').css('display', 'none');
							$(commentSection).find('#noFirstAndLastname').css('display', 'none');
							if ($(commentSection).find('#commentGuestUsername').length == 0) {
								$(commentSection).find('#setCommentForm').css('display', 'none');
							} else {
								$(commentSection).find('#setCommentForm').css('display', 'inline');
							}
							$('#loginForm :input[name="username"]').focus();
						}
					}

					if ($(that).attr('id') == 'loginForm') {
						if (response.error === null) {

							$(commentSection).find('#loginUsername').text('Hallo '+response.username);
							$(commentSection).find('#logoutForm').css('display', 'inline');
							$(commentSection).find('#loginUsername').css('display', 'inline');
							$(commentSection).find('#setCommentForm').css('display', 'inline');
							$(commentSection).find('#loginForm').css('display', 'none');
							$(commentSection).find('#commentGuestUsername').css('display', 'none');
							if ($(commentSection).find('#commentGuestUsername').length == 0) {
								$(commentSection).find('#setCommentForm')[0].reset();
								$(commentSection).find('#setCommentForm textarea').val('');
								$(commentSection).find('#setCommentForm :input[name="setComment"]').val('0');
								$(commentSection).find('#setCommentForm :input[name="commentAnswerRef"]').val('0');
								$(commentSection).find('#setCommentForm textarea').attr('placeholder', 'Schreiben Sie hier Ihren Kommentar');
								$(commentSection).find('.commentsHeaderText').text('Posten Sie Ihre Meinung');
								$(commentSection).find('#setCommentForm :input[type="submit"]').attr('disabled', 'disabled');
							}
							$(commentSection).find('#setCommentForm textarea').focus();

							if (response.firstName === null || response.lastName === null) {
								window.location.href = '/user?noFirstLastName&redirect=' + window.location.href;
								$(commentSection).find('#noFirstAndLastname').css('display', 'inline');
								$(commentSection).find('#setCommentForm').css('display', 'none');
							}

						}

					}

					if (response.success !== null) {
						$(commentSection).find('#commentMsg').removeClass('error').addClass('success').html(response.success);
					} else if (response.error !== null) {
						$(commentSection).find('#commentMsg').removeClass('success').addClass('error').html(response.error);
					}

					if (response.error === null) {
						$(that)[0].reset();
						if ($(that).attr('id') == 'setCommentForm') {
							// loadComments();
						}
					}

				},'json').fail(function() {

					if ($(that).attr('id') == "loginForm") {
						$(commentSection).find('#commentMsg').removeClass('success').addClass('error').html('Ein Fehler ist aufgetreten.');
					}

					$(commentSection).find('#' + $(that).attr('id') + ' button[type="submit"]').removeAttr('disabled');
					$(commentSection).find('#' + $(that).attr('id') + ' input[type="submit"]').removeAttr('disabled');

				});

				return false;
			});
		});

	}

})(jQuery);

$('section.comments').Kommentare();
