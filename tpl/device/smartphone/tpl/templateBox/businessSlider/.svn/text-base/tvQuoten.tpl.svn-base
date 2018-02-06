<?
/**
 * template box
 * @var channel oe24.core.Channel
 * @var box oe24.core.TemplateBox
 */

// -------------------------------------------

// Daten der einzelnen Slides

$slides = array();
$slideTemplate = array();

$file = "http://file.oe24.at/redaktion/BusinessLive-TVQuoten.txt";
$csv = spunQ_HttpBrowser::sendRequest($file, 5, false)->getBody();
$quoten = explode(chr(10), $csv);

$bFoundContent = false;

foreach ($quoten as $key => $quote) {
    $data = explode(";", $quote);
    
    if ($bFoundContent) {
        // bei quellenangabe stoppen
        if (false !== mb_strpos(mb_strtolower($data[1]), 'evogenius reporting')) {
            break;
        }
        
        // mehrere Headline-Zeilen in Importfile
        if ("sender" != mb_strtolower($data[0])) {
            if (isset($data[2])) {
                $sChannel = $data[0];
                $iPosition = $data[2];
                // $sTitle = $data[7];
                // $dReach = $data[8];

                if (3 >= $iPosition) {
                    $slideTemplate[$sChannel][$iPosition] = $data;
                }
            }
        }
    }
    else {
        if (isset($data[0])) {
            // Headline-Zeile gefunden, erst ab hier beginnt unser Content
            if ("sender" == mb_strtolower($data[0])) {
                $bFoundContent = true;
            }
        }
    }
}

foreach($slideTemplate as $tvStation => $shows) {
    
    ksort($shows);
    
    $tvShows = array();

    foreach ($shows as $position => $show) {

        $tvShows[$position] = array(
        	'name' => $show[7],
        	'drw' => round($show[8],1),
        );

    }

    if (count($tvShows)) {
	    $slides[] = array(
	        'station' => $tvStation,
	        'shows' => $tvShows,
	    );
	}
}

// -------------------------------------------

$countSlides = count($slides);

if ($countSlides <= 0) {
    return null;
}

// -------------------------------------------

?>

<? foreach ($slides as $key => $slide): ?>
	
	<a class="story">
		<div class="tvHl"><?= $slide['station']; ?></div>
        <div class="tvMain">
            <table class="tvTbl" cellspacing="1" width="100%">
                <tbody>
                    <tr>
                        <th class="tvShow">Sendung</th>
                        <th class="tvDrw" title="Durchschnittsreichweite in Tausend">DRW</th>
                    </tr>
                    
					<? foreach ($slide['shows'] as $position => $show): ?>
	                    <tr>
		                    <td class="tvShow" title="<?= $show['name']; ?>"><?= $show['name']; ?></td>
		                    <td class="tvDrw"><?= $show['drw']; ?></td>
	                	</tr>
					<? endforeach; ?>

                </tbody>
            </table>
        </div>
	</a>

<? endforeach; ?>

