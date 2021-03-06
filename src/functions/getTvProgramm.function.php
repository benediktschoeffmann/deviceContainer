<?php
/**
 * Daten bereitstellen fuer TV-Programm
 *
 * @return array
 */

function getTvProgramm() {

	$file = 'http://webmisc.oe24.at/tv/oe24tv.xml';
	$xmlString = spunQ_HttpBrowser::sendRequest($file, 5, false)->getBody();

	// --------------------------------------------------------------------------------

	$today = date('Ymd');
	$now = date("His");

	$tomorrow = date('Ymd', mktime(0, 0, 0, date('m'), date('d')+1, date('Y')));
	$lastDay = date('Ymd', mktime(0, 0, 0, date('m'), date('d')+7, date('Y')));

	// --------------------------------------------------------------------------------

	$slides = array();

	$weekDays = array(
	    '0' => 'Sonntag',
	    '1' => 'Montag',
	    '2' => 'Dienstag',
	    '3' => 'Mittwoch',
	    '4' => 'Donnerstag',
	    '5' => 'Freitag',
	    '6' => 'Samstag',
	);

	// --------------------------------------------------------------------------------

	libxml_use_internal_errors(true);
	$xml = simplexml_load_string($xmlString);

	if (!$xml) {
		error('Das Xml des TV-Programms konnte nicht geparsed werden.');
	}

	libxml_use_internal_errors(false);

	if ($xml && $xml !== false) {
		if (is_object($xml)){
			foreach($xml as $event){

			    $time = (string) $event['sendezeit'];
			    $date = (string) $event['datum'];
			    $duration = (string) $event->sendung->dauer;
			    $channel = (string) $event['kanal'];

			    $title = (string) $event->sendung->titel;
			    $text = (string) $event->sendung->programmtext;
			    $position = (integer) $event->sendung->positionsnummer;

			    $useEvent = ('oe24tv' == $channel && $date >= $today && $date < $lastDay) ? true : false;

			    $currentShow = '';

			    if ($useEvent) {
			        // set slide name - 'sl_' is for sorting reasons
			        $slide = 'sl_' . $date;
			        $dateTimestamp = strtotime($date);
			        $weekday = date('w', $dateTimestamp);
			        $dayPrint = date('d.m.', $dateTimestamp);

			        // Slideheadline Fallback
			        if (isset($weekDays[$weekday])) {
			            $headline = $weekDays[$weekday] . ', ' . $dayPrint; // wenn Wochentag angedruckt
			        }
			        else{
			            $headline = $dayPrint; // wenn Datum angedruckt
			        }

		            // aktuelle show ermitteln
		            $showStartTime = strtotime( $date . $time );
		            $durationSeconds = intval(mb_substr($duration, 0, 2)) * 3600 + intval(mb_substr($duration, 2, 2)) * 60 + intval(mb_substr($duration, 4, 2));
		            $showEndTime = date("His", $showStartTime + $durationSeconds);

			        if ($date == $today) {
			        	$currentShow = ($time <= $now && $now < $showEndTime) ? 'currentShow' : '';
			        	// Event-Id - wird aktuell für Positionierung des Scrollbalken verwendet
			        	$event_id = ($time <= $now && $now < $showEndTime) ? 'currentShow' . $date : '';

			            $headline = 'Heute, ' . $dayPrint;
			        }
			        else {
			        	// bei allen anderen Tagen den Startzeitpunkt 10:00 markieren
			        	$time2show = '070100';

			        	// Event-Id - wird aktuell für Positionierung des Scrollbalken verwendet
			        	$event_id = ($time <= $time2show && $time2show < $showEndTime) ? 'currentShow' . $date : '';
			        }

			        // morgen ebenfalls Headline ändern
			        $headline = ($date == $tomorrow) ? 'Morgen, ' . $dayPrint : $headline;

			        // Zeit formatieren
			        $time = mb_substr($time, 0, 2) . ':' . mb_substr($time, 2, 2);

			        // Slide setzen/erweitern
			        if (!isset($slides[$slide])) {

			            $slides[$slide] = array(
			                'headline' => $headline,
			                'events' => array(),
			                'currentSlider' => '',
			            );
			        }

			        // current-show im Slide markieren
			        if ( !empty($currentShow) ){
			            $slides[$slide]['currentSlider'] = 'currentSlider';
			        }

			        $slides[$slide]['events'][$time] = array(
			            'date'        => $date,
			            'time'        => $time,
			            'title'       => $title,
			            'text'        => $text,
			            'currentShow' => $currentShow,
			            'id'          => $event_id,
			        );

			    }

			}
		}
	}

	if (empty($slides)) {
	    return false;
	}

	ksort ($slides);

	return $slides;
}

