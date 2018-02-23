<?php
/**
 * @collector noauto
 * @collector footerSplitArea
 */
?>

/**
 * oe24Subnavigation für Relaunch 2014
 * @author Philipp Jarnig
 *
 * Klettert die Listelemente durch und zeigt die richtige Subliste an, welche ausgewählt wurde.
 */

/*!
 * oe24Subnavigation für Relaunch 2014
 * @author Philipp Jarnig
 *
 * Klettert die Listelemente durch und zeigt die richtige Subliste an, welche ausgewählt wurde.
 */
var oe24SubnavfetchData = oe24SubnavfetchData || [[]];
var oe24SubnavfetchDataUrl = oe24SubnavfetchDataUrl || [""];
function oe24Subnav(aNode, sidebarClicked) {
	if (typeof aNode == "undefined") {
		return;
	}

	var url = null;
	fetchData = function(loadSidebar, aNode, subnavContainer) {
		showData("load", subnavContainer);
		url = aNode.data('jsonurl');
		if(!url || url == null){
			url == "";
		}
		if(url != ''){
			url = url + loadSidebar;
		}
		var idx = jQuery.inArray(url,oe24SubnavfetchDataUrl);
		if(idx>=0){
			subnavContainer.data(url + loadSidebar, oe24SubnavfetchData[idx]);
			showData(oe24SubnavfetchData[idx], subnavContainer);
			return;
		}
		$.ajax ({
			url: url +'?jsonCallbackSubNav',
			jsonp : false,
			cache: true,
			jsonpCallback: 'jsonCallbackSubNav',
			cache: 'true',
			dataType : 'jsonp'
		}).done (function (msg) {

			oe24SubnavfetchData.push(msg);
			// oe24SubnavfetchDataUrl.push(url); // alte buggy version
			oe24SubnavfetchDataUrl.push(msg.jsonUrl);
			subnavContainer.data(url + loadSidebar, msg);

			showData(msg, subnavContainer);

		});
	}

	showData = function(content, subnavContainer) {
		subNavContent = subnavContainer.find('.subnav_content').children();

		aTop1 = subNavContent.nextAll().eq(0);
		aTop2 = subNavContent.nextAll().eq(1);

		divMore = subNavContent.nextAll().eq(2).children();

		aMore1 = divMore;
		aMore2 = divMore.nextAll().eq(0);
		aMore3 = divMore.nextAll().eq(1);
		if(typeof content[0] == "undefined"){
			subNavContent.parent().hide();
			subNavContent.parent().parent().css('height',40);
		} else {
			subNavContent.parent().show();
			subNavContent.parent().parent().css('height',260);
		}
		for (m=0; m<5; ++m) {

			var aClass = m < 2 ? 'aTop' + (m+1) : 'aMore' + (m-1);
			if (content == "load" ||typeof content[m] == "undefined") {

				window[aClass].attr('href', '#').addClass('empty');
				window[aClass].children().first().attr('src', '/images/empty.gif');
				window[aClass].children().next().html('');
			} else {

				window[aClass].attr('href', content[m].href).removeClass('empty');
				window[aClass].children().first().attr('src', content[m].image);
				window[aClass].children().next().html(content[m].caption);

			}

		}

	}

	var noStory = "Zur Zeit ist keine aktuelle Meldung eingelangt.";

	if (!sidebarClicked) {
		// var subnavItem = $(aNode.parentNode);
		var subnavContentId = "#" + $(aNode.parentNode).attr('id') + "_content";
		var subnavContainer = $(aNode.parentNode.parentNode.parentNode);

		subnavContainer.data('lastSubnavClicked', subnavContentId);

		// Timestamp überprüfen, wenn Element vorhanden und wenn nicht aktuell, daten nachladen.
		// if (subnavContainer.find(subnavContentId).length > 0) {
			// var itemTimestamp = subnavItem.attr('timestamp');

			// var url = aNode.data('jsonurl');

			// // Timestamp abholen für aktuelle Liste
			// $.ajax ({
			// 	url: url + "timeStamp",
			// cache: false,
			// 	dataType: 'json'
			// }).done (function (msg) {

				// wenn neue Zeit jünger als alte zeit, dann Daten neu laden, sonst das div anzeigen
				// if (msg.timestamp <= itemTimestamp) {

				// 	showData( subnavContainer.data(aNode.data('jsonurl') + 'newest'), subnavContainer );

				// } else {

					// subnavItem.attr('timestamp', msg.timestamp);

					// if (typeof subnavContainer.data(aNode.data('jsonurl') + 'newest') != "undefined") {

					// 	showData( subnavContainer.data(aNode.data('jsonurl') + 'newest'), subnavContainer );

					// } else {

					// 	fetchData('newest', aNode, subnavContainer);

					// }

				// }
			// })

		// 	return;
		// }

		// Inhalte nachladen, die benötigt werden anhand subnavItem.attr('id')
		if (typeof subnavContainer.data($(aNode).data('jsonurl') + 'newest') != "undefined") {

			showData( subnavContainer.data($(aNode).data('jsonurl') + 'newest'), subnavContainer );

		} else {

			fetchData('newest', $(aNode), subnavContainer);

		}

		return;

	} else {

		// var subnavItem = $(aNode.parentNode.parentNode);
		var subnavContainer = $(aNode.parentNode.parentNode.parentNode);
		var subnavContentId = subnavContainer.data('lastSubnavClicked');

		if (typeof subnavContentId == "undefined") {
			subnavContentId = "#subnav_1_content";
		}

		var sidebar = $(aNode).attr('class').substr(8, 1) == "1" ? 'newest' : 'top';

		var aNode = subnavContainer.find(subnavContentId.substr(0, 9)).children()[0];

		if (typeof aNode == "undefined" || $(aNode).data('jsonurl') == "") {
			return;
		}

		if (typeof subnavContainer.data($(aNode).data('jsonurl') + sidebar) != "undefined") {

			showData( subnavContainer.data($(aNode).data('jsonurl') + sidebar), subnavContainer );

		} else {

			fetchData(sidebar, $(aNode), subnavContainer);

		}


	}
}

$(function() {
	"use strict";
	var delay=200, setTimeoutConst;
    $('.nav_main_items .subnav_container .subnav_menu li').on('mouseover', 'a', function() {
		var subnav_container_menu = this;
		setTimeoutConst = setTimeout(function(){
			$(subnav_container_menu.parentNode.parentNode).children().removeClass('active'); // allen li-Nodes die Klasse 'active' löschen.
			$(subnav_container_menu.parentNode).addClass('active'); // über dem a-Node wird das li-Node mit der Klasse 'active' befüllt.

			$(subnav_container_menu.parentNode.parentNode).next().find('.sidebar a').removeClass('active');
			$(subnav_container_menu.parentNode.parentNode).next().find('.sidebar a:first').addClass('active');

			oe24Subnav(subnav_container_menu, false);
		}, delay);

    }).on('mouseout', 'a', function() { clearTimeout(setTimeoutConst );});

    $('.nav_main_items .subnav_container').on('mouseover', '.sidebar a', function() {
		var subnav_container_sidebar = this;
		setTimeoutConst = setTimeout(function(){
			$(subnav_container_sidebar.parentNode).children().removeClass('active'); // a-Nodes die Klasse 'active' löschen.
			$(subnav_container_sidebar).addClass('active'); // a-Node mit Klasse 'active' befüllen.
			oe24Subnav(subnav_container_sidebar, true);
		}, delay);
    }).on('mouseout', '.sidebar a', function() { clearTimeout(setTimeoutConst );});

    $('.nav_main_items .subnav_container').each(function() {

        //oe24Subnav($(this).find('.subnav_menu li a')[0], false);

    });

    $('.nav_main_items').on('mouseover', '>li>a', function() {
		var subnav_container_item = this;
		setTimeoutConst = setTimeout(function(){
			$(subnav_container_item).next().find('.subnav_menu li').removeClass('active'); // allen li-Nodes die Klasse 'active' löschen.
			$(subnav_container_item).next().find('.subnav_menu li:first').addClass('active'); // über dem a-Node wird das li-Node mit der Klasse 'active' befüllt.

			$(subnav_container_item).next().find('.sidebar a').removeClass('active');
			$(subnav_container_item).next().find('.sidebar a:first').addClass('active');

			if (typeof $(subnav_container_item).next().find('.subnav_menu li a')[0] != "undefined") {
				oe24Subnav($(subnav_container_item).next().find('.subnav_menu li a')[0], false);
			}
		}, delay);
    }).on('mouseout', '>li>a', function() { clearTimeout(setTimeoutConst );});
});
