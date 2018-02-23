<?
/**
 * @collector noauto
 * @collector footerSplitArea
 */
?>

$(document).ready(function () {

	;(function($) {
		var useCaptcha = $('.slideshowVoting').data('usecaptcha');

		if (useCaptcha) {
			SlideShowVotingCaptchaExpired();
		}

		var type = $('.slideshowVoting').data('type');

		if (type == 4) {
			var $leftArrow = $('.slideshowVoting .leftArrow');
			var $rightArrow = $('.slideshowVoting .rightArrow');

			$('.slideshowItemsContainer').slick({
				slidesToShow: 1,
				slidesToScroll: 1,
				draggable: false,
				lazyLoad: 'progressive',
				prevArrow: $leftArrow,
				nextArrow: $rightArrow,
				onInit: function() {

				}
			});
		}

		$('.jsSlideshowVoting').on('click', function(event) {
			event.preventDefault();
			var max = $('.slideshowItemsContainer').data('max');
			var classVoting = $(this).attr('class').split(' ')[1];
			$('.' + classVoting).removeClass('selected');
			$(this).parent().siblings().find('a').removeClass('selected');
			$(this).addClass('selected');
			if ($('.slideshowVoting .selected').length == max) {
				// get the instance on the modal dialogue
				var inst = $('[data-remodal-id=modal]').remodal();
				// open window
				inst.open();
			}
		});

		$(document).on('confirmation', '.remodal', function () {
			var arr = new Array();
			var id = $('.slideshowItemsContainer').data('id');
			var selectedList = $('.slideshowItemsContainer .selected');
			$.each(selectedList, function(index) {
				arr.push($(this).parent().parent().data('id') + ';' + $(this).attr('class').split(' ')[1]);
			});

			var type = $('.slideshowVoting').data('type');
			if (type == 4) {
				var pictureId = $('.slideshowItemsContainer').find('.slick-active').data('id');
				arr.push(pictureId + ';jsOption1');
			}

			var domain = $('.slideshowItemsContainer').data('domain');
			var voterData = new Array();
			var name = $('#slideShowVotingName').val();
			var tel = $('#slideShowVotingPhone').val();
			var mail = $('#slideShowVotingEmail').val();
			//var url = 'http://' + domain + '.oe24.at/_slideShowVoting/' + id + '/' + arr.join('|');
			var url = 'http://' + domain + '/_slideShowVoting/' + id + '/' + arr.join('|');
			if (name !== 'Name' && tel !== 'Telefonnummer' && mail !== 'E-Mail') {
                    url += '/' + name + '|' + tel + '|' + mail;
            }

			var posting = $.get(url);
			posting.done(function(data) {
				// console.log('>'+data+'<');
				if ('' !== data) {
					var json = $.parseJSON(data);
					for (var i in json) {
						var span = $(".slideshowItemsContainer").find("[data-id='" + i + "'] .jsPoints").text(json[i]);
					}
				}
			});

			$('.jsSlideshowVoting').removeClass('selected');

			$('.jsSlideshowVoting').unbind('click');



			// $('.voteButton').unbind('click');

			var showGame = $('.slideshowItemsContainer').data('game');
			if (1 == showGame) {
				window.location = $('.slideshowItemsContainer').data('url');
			} else {
				document.location.hash = 'hitlistAnchor';
			}

			$('.votingResult').css('display', 'block');
		});

		$(document).on('cancellation', '.remodal', function () {
			var selectedList = $('.slideshowItemsContainer .selected');
			selectedList.removeClass('selected');
			document.location.hash = 'hitlistAnchor';
		});

		$('.showResultButton').on('click', function (event) {
			event.preventDefault();
			$('.votingResult').css('display', 'block');
		});

		$('.voteButton').on('click', function (e) {
			e.preventDefault();
			var type = $('.slideshowVoting').data('type');
			var arr = Array();
			if (type == 4) {
				var pictureId = $('.slideshowItemsContainer').find('.slick-active').data('id');
				arr.push(pictureId + ';jsOption1');
			}
			var domain = $('.slideshowItemsContainer').data('domain');
			var id = $('.slideshowItemsContainer').data('id');
			var url = 'http://' + domain + '.oe24.at/_slideShowVoting/' + id + '/' + arr.join('|');
			var posting = $.get(url);
			posting.done(function(data) {
			});
			var showGame = $('.slideshowItemsContainer').data('game');
			$('.voteButton').prop('disabled', true);
			$('.voteButton').addClass('disabled');

			if (1 == showGame) {
				window.location = $('.slideshowItemsContainer').data('url');
			} else {
				document.location.hash = 'hitlistAnchor';
			}




		});



	})(jQuery);


});
function SlideShowVotingCaptchaSuccess(response) {
	$('.remodal-confirm').prop('disabled', false);
	$('.voteButton').prop('disabled', false);
}

function SlideShowVotingCaptchaExpired() {
	$('.remodal-confirm').prop('disabled', true);
	$('.voteButton').prop('disabled', true);
}
