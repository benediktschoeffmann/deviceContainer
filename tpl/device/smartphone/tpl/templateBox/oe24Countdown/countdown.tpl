<?
/**
 * template box
 * @var channel oe24.core.Channel
 * @var box oe24.core.TemplateBox
 */

// -------------------------------------------

$now = date('m/d/Y H:i:s');
$end = '11/22/2017 21:00:00'; //MM/DD/YYYY HH:II:SS - Format for Internet Explorer

$individualTexts = false;

if ($end <= $now) {
	return;
}

// ----------------------------------------------------

// frühestens am Freitag um 06 Uhr andrucken
// $start = '09/12/2017 00:00:00';
// if ($start > $now) {
// 	return;
// }

// ----------------------------------------------------

$templateOptions = $box->getTemplateOptions();
$url = trim($templateOptions->get('Url'));

$url = (mb_strlen($url)) ? $url : '';
$url = ($url != '' && mb_substr($url, 0, 4) != 'http') ? 'http://' . $url : $url;

$onClick = ($url != '') ? 'window.location.href=\'' . $url . '\'' : '';


// ----------------------------------------------------

// background - img
// $secondsLeft = strtotime($end)-strtotime($now);
// $backgroundImg = (3600 > $secondsLeft) ? 'ms' : '';
// $backgroundImg = (60 > $secondsLeft) ? 's' : $backgroundImg;
// $backgroundImg = (0 >= $secondsLeft) ? 'done' : $backgroundImg;
$backgroundImg = '';

?>

<div id="oe2016oe24Countdown" class="<?= $backgroundImg; ?>" onClick="<?= $onClick; ?>">
	<img src="/images/oe24tv/interview_kurz_d.jpg">
	<? if ($individualTexts): ?>

		<span id="oe2016oe24CountdownHours"></span>
		<span id="oe2016oe24CountdownMinutes"></span>
		<span id="oe2016oe24CountdownSeconds"></span>

	<? else: ?>

		<span id="oe2016oe24CountdownTime"></span>

	<? endif; ?>

</div>

<script>
	;(function() {
		// Set the date we're counting down to
		var countDownDate = new Date('<?= $end; ?>').getTime();

		// Update the count down every 1 second
		var xCountDown = setInterval(function() {

		  // Get todays date and time
		  var now = new Date().getTime();

		  // Find the distance between now an the count down date
		  var distance = countDownDate - now;

		  // Time calculations for days, hours, minutes and seconds
		  var days = Math.floor(distance / (1000 * 60 * 60 * 24));
		  var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
		  var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
		  var seconds = Math.floor((distance % (1000 * 60)) / 1000);

		  <? if ($individualTexts): ?>

		  	// hours
		  	var hoursText = hours.toString();
		  	hoursText = (hoursText == '0') ? '' : hoursText;
		  	hoursText = (hoursText.length == 1) ? '0' + hoursText : hoursText;
		  	if (document.getElementById('oe2016oe24CountdownHours').innerHTML != hoursText) {
		  		document.getElementById('oe2016oe24CountdownHours').innerHTML = hoursText;
		  	}

		  	// minutes
		  	var minutesText = minutes.toString();
		  	if (hoursText == '') {
		  		var minutesText = (minutesText == '0') ? '' : minutesText;
		  		var minutesText = (minutesText.length == 1) ? '0' + minutesText : minutesText;
		  	}
		  	else {
		  		var minutesText = (minutesText.length == 1) ? '0' + minutesText : minutesText;
		  	}
		  	if (document.getElementById('oe2016oe24CountdownMinutes').innerHTML != minutesText) {
		  		document.getElementById('oe2016oe24CountdownMinutes').innerHTML = minutesText;
		  	}

		  	// seconds
		  	var secondsText = seconds.toString();
		  	var secondsText = (secondsText.length == 1) ? '0' + seconds : seconds;
		  	document.getElementById('oe2016oe24CountdownSeconds').innerHTML = secondsText;

			// change classes for bgimage
			var obj = document.getElementById("oe2016oe24Countdown").classList;
			if (0 >= distance) {
				if ( !obj.contains('done') ) {
					obj.add('done');
					obj.remove('s');
				}
			}
			else if (60000 >= distance) {
				if ( !obj.contains('s') ) {
					obj.add('s');
					obj.remove('ms');
				}
			}
			else if (3600000 >= distance) {
				if ( !obj.contains('ms') ) {
					obj.add('ms');
				}
			}


		  <? else: ?>
			  var daysText = (1 == days) ? 'Tag' : 'Tage';
			  var hoursText = (1 == hours) ? 'Stunde' : 'Stunden';
			  var minutesText = (1 == minutes) ? 'Minute' : 'Minuten';
			  var secondsText = (1 == seconds) ? 'Sekunde' : 'Sekunden';

			  // Display the result
			  var timeDisplay = days + ' ' + daysText + ' ' + hours + ' ' + hoursText + ' ' + minutes + ' ' + minutesText + ' ' + seconds + ' ' + secondsText + ' ';
			  if (0 >= days) {
			  	var timeDisplay = hours + ' ' + hoursText + ' ' + minutes + ' ' + minutesText + ' ' + seconds + ' ' + secondsText + ' ';
			  	if (0 >= hours) {
			  		var timeDisplay = minutes + ' ' + minutesText + ' ' + seconds + ' ' + secondsText + ' ';
			  		if (0 >= minutes) {
			  			var timeDisplay = seconds + ' ' + secondsText + ' ';
			  		}
			  	}
			  }
			  document.getElementById('oe2016oe24CountdownTime').innerHTML = 'noch ' + timeDisplay;
			<? endif; ?>

		  // If the count down is finished, do not display anything
		  if (0 >= distance) {
		    clearInterval(xCountDown);
		    document.getElementById('oe2016oe24Countdown').innerHTML = '';
			document.getElementById('oe2016oe24Countdown').style.display = 'none';
		  }
		}, 1000);
	})();
</script>

