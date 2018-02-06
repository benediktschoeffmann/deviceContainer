<?php
/**
 * @collector noauto
 */
?>

var weatherMap = {

	slider : 1,
	position : new Array(),

	elements : new Array(),

	init : function(){
		// heute
		weatherMap.elements[1] = new Array();
		for(i = 0; i <= 23; i++){
			weatherMap.elements[1][i] = 'http://file.wetter.at/mowis/mobil2014/aut_t' + i + '.jpg';
		}

		weatherMap.position[1] = 0;

		// morgen
		weatherMap.elements[2] = new Array();
		weatherMap.elements[2][0] = 'http://file.wetter.at/mowis/mobil2014/aut_d1_vorm.jpg';
		weatherMap.elements[2][1] = 'http://file.wetter.at/mowis/mobil2014/aut_d1_nachm.jpg';
		weatherMap.elements[2][2] = 'http://file.wetter.at/mowis/mobil2014/aut_d1_abend.jpg';

		weatherMap.position[2] = 0;

		// woche 1
		weatherMap.elements[3] = new Array();
		weatherMap.elements[3][0] = 'http://file.wetter.at/mowis/mobil2014/aut_d2.jpg';
		weatherMap.elements[3][1] = 'http://file.wetter.at/mowis/mobil2014/aut_d3.jpg';
		weatherMap.elements[3][2] = 'http://file.wetter.at/mowis/mobil2014/aut_d4.jpg';

		weatherMap.position[3] = 0;

		// woche 2
		weatherMap.elements[4] = new Array();
		weatherMap.elements[4][0] = 'http://file.wetter.at/mowis/mobil2014/aut_d5.jpg';
		weatherMap.elements[4][1] = 'http://file.wetter.at/mowis/mobil2014/aut_d6.jpg';
		weatherMap.elements[4][2] = 'http://file.wetter.at/mowis/mobil2014/aut_d7.jpg';

		weatherMap.position[4] = 0;
	},

	display : function(id){
		if(0 == weatherMap.position.length){
			weatherMap.init();
		}
		weatherMap.slider = id;

		var slider = weatherMap.slider;
		var position = weatherMap.position[slider];
		var sSrc = weatherMap.elements[slider][position];

		// image laden
		var mapWeather = document.getElementById('mapWeather');
		mapWeather.src = sSrc;
		
		// navigation anpassen
		var weatherNavItemActive = document.getElementById('weatherNav' + id);
		var weatherNavItems = document.getElementsByClassName('weatherNavItem');

		var weatherNavLength = weatherNavItems.length;
		for (var i = 0; i < weatherNavLength; i++){
			weatherNavItems[i].classList.remove('active');
		}
		weatherNavItemActive.classList.add('active');

		// subnavigation setzen, je nach aktueller Position im ausgewählten Slider Weiter-/Zurückbutton anzeigen
		var weatherMapPrevious = document.getElementById('weatherMapPrevious');
		var weatherMapNext = document.getElementById('weatherMapNext');
		if(position <= 0){
			// erste Bild - nur weiter möglich
			weatherMapPrevious.classList.add('isHidden');
			weatherMapNext.classList.remove('isHidden');
		}
		else if(position + 1 >= weatherMap.elements[slider].length){
			// letztes Bild - nur zurück möglich
			weatherMapPrevious.classList.remove('isHidden');
			weatherMapNext.classList.add('isHidden');
		}
		else{
			weatherMapPrevious.classList.remove('isHidden');
			weatherMapNext.classList.remove('isHidden');
		}

	},

	getNext : function(){
		if(0 == weatherMap.position.length){
			weatherMap.init();
		}

		var slider = weatherMap.slider;
		var next = weatherMap.position[slider] + 1;
		var sSrc = weatherMap.elements[slider][next];
		
		// neue position und src setzen
		var mapWeather = document.getElementById('mapWeather');
		mapWeather.src = sSrc;
		weatherMap.position[slider] = next;

		var weatherMapPrevious = document.getElementById('weatherMapPrevious');
		var weatherMapNext = document.getElementById('weatherMapNext');
		
		weatherMapPrevious.classList.remove('isHidden');
		// kein nächstes Bild möglich - Button deaktivieren
		if((next+1) >= weatherMap.elements[slider].length){
			weatherMapNext.classList.add('isHidden');
		}
	},

	getPrevious : function(){
		if(0 == weatherMap.position.length){
			weatherMap.init();
		}

		var slider = weatherMap.slider;
		var previous = weatherMap.position[slider] - 1;
		var sSrc = weatherMap.elements[slider][previous];
		
		// neue position und src setzen
		var mapWeather = document.getElementById('mapWeather');
		mapWeather.src = sSrc;
		weatherMap.position[slider] = previous;

		var weatherMapPrevious = document.getElementById('weatherMapPrevious');
		var weatherMapNext = document.getElementById('weatherMapNext');
		
		weatherMapNext.classList.remove('isHidden');
		// kein vorheriges Bild möglich - Button deaktivieren
		if((previous) <= 0){
			weatherMapPrevious.classList.add('isHidden');
		}
	}	
}

