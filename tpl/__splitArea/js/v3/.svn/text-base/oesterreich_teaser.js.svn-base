<?
/**
 * @collector noauto
 * @collector footerSplitArea
 */
?>

$(document).ready(function () {

	;(function($) {
		var flagList = $('.oesterreichTeaserBox .country_header a');
		var divList = $('.oesterreichTeaserBox .countryTeasers div');
		var buttonBox = $('#districtBoxButtons ul');
		var ajaxLoader = $('.ajaxLoader');

		flagList.on('click', handleClicks);

		function handleClicks(event) {
			event.preventDefault();

			$(flagList).each(function() {
				$(this).removeClass('highlight');
			});
			$(this).addClass('highlight');

			$('#districtBoxButtons').fadeOut(150);

			var url = $(this).data('link');

			ajaxLoader.show();

			var posting = $.get(url);

			posting.done(function (data) {
				var responseList = jQuery.parseJSON(data);

				if (!('tags' in responseList)) {
					$(responseList).each(function (index, entry) {
						updateStories(index, entry);
					});
				}

				else {
					if (typeof responseList['tags'] != undefined) {
						// updateDistrictList($(responseList['tags'])[0]);
					}
					if (typeof responseList['stories'] != undefined) {
						$(responseList['stories']).each(function(index, element) {
							updateStories(index, element);
						});
					}
				}

				var buttonBoxLinks = $('#districtBoxButtons ul li a');

				buttonBoxLinks.on('click', handleClicks);

				ajaxLoader.hide();
			});

		}

		function updateDistrictList(list) {
			buttonBox.empty();

			$.each(list, function (index, element) {
				buttonBox.append('<li><a class="ajaxLink" href="" data-link="'+index+'"> '+element+' </a></li>');
			});
		}

		function updateStories(index, entry) {
			var teaser = $('.buzzTeaserStory.a' + index);
			teaser.find('a').attr('href', entry.href);
			teaser.find('img').attr('src', entry.imageUrl);
			teaser.find('.buzzTeaserPreTitle').text(entry.preTitle);
			teaser.find('.buzzTeaserTitle').text(entry.title);
		}

		$('#districtSelector').on('click', function () {
			// $('#districtBoxButtons').fadeToggle(150);
		});

	})(jQuery);

	;(function($) {
		$('.oesterreichTeaserContainer .w').trigger('click');
	})(jQuery);

});
