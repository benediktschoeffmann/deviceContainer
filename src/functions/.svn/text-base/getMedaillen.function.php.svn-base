<?php

/*
 * Bereitet die Daten fuer die Tabelle "Medaillen-Spiegel" auf
 * (Content, Teaser & Mobile)
 *
 * @author ws
 *
 * @param string $xmlURL
 *	URL von der die XML-Datei geholt wird, die die Daten des medaillen-Spiegels enthaelt
 * @param integer $limit
 *	Anzahle der Eintraege, die gezeigt werden sollen
 * @param string $flag_images_dir
 * Verzeichnis, das die Grafiken fuer die Laenderflaggen enthaelt
 *
 * @retval $medaillen
 * 	Array mit den Datensätzen
*/

function getMedaillen($xmlURL, $limit, $flag_images_dir) {

	$flag_images_url = str_replace($_SERVER['DOCUMENT_ROOT'], '/', $flag_images_dir);

	$xml = xmlCache::getXMLData($xmlURL, 60);
	$nations = $xml->xpath("/c/team");
	// debug($nations);

	if (empty($nations)) {
		return array();
	}

	$showAustria = true;
	$onTop = false; // Wofuer wird $onTop gebraucht?

	$i = 0;
	$last_position = 0;
	$medaillen = array();

	foreach ($nations as $nation) {

		if ($i >= $limit) {
			break;
		}

		if ($i == $limit - 1 && $showAustria) {
			$nation = $xml->xpath("/c/team[@w='at']");
			if ($nation && isset($nation[0])) {
				$nation = $nation[0];
			} else {
				$nation = new SimpleXMLElement('<team />');
				$nation->addAttribute('p', '-');
				$nation->addAttribute('w', 'at');
				$nation->addAttribute('l', 'Österreich');
				$nation->addAttribute('g', '0');
				$nation->addAttribute('s', '0');
				$nation->addAttribute('b', '0');
				$nation->addAttribute('alpha3', 'AUT');
			}
		}

		$attributes = $nation->attributes();

		$position = (int) $attributes->p;
		$position = ($position == 0) ? "-" : $position . '.';

		if ($position === $last_position) {
			$position = '';
		} else {
			$last_position = $position;
		}

		$shortcut = (string) $attributes->w;
		$name = (string) $attributes->l; // == "Russische Föderation" ? "Russland" : (string) $attributes->l;

		$gold = (int) $attributes->g;
		$gold = ($gold == 0) ? '-' : $gold;

		$silver = (int) $attributes->s;
		$silver = ($silver == 0) ? '-' : $silver;

		$bronze = (int) $attributes->b;
		$bronze = ($bronze == 0) ? '-' : $bronze;

		$total = $gold + $silver + $bronze;
		$total = ($total == 0) ? '-' : $total;

		if ($shortcut == 'at') {
			$showAustria = false;
		}

		$flag = (is_readable($flag_images_dir.'/'.$shortcut.'.gif')) ? $flag_images_url.'/'.$shortcut.'.gif' : '';

		$medaillen[] = array(
			'position' => $position,
			'name' => $name,
			'gold' => $gold,
			'silver' => $silver,
			'bronze' => $bronze,
			'total' => $total,
			'flag' => $flag,
			'class' => ('at' == $shortcut) ? 'class="at"' : '',
		);

		$i++;
	}

	return $medaillen;
}

