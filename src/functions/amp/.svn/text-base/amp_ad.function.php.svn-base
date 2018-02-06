<?php
function amp_ad($width, $height) {
	$frontpage = Channel::getChannelByChannelString(Portal::getPortalByName('oe24', false), 'frontpage');
	$adSlots = json_decode($frontpage->getOptions(true)->get('AditionAdSlots'));
	$showAd = false;

	foreach ($adSlots as $key => $adSlot) {
		if ($adSlot->banner == 'Mobile Amp' && $adSlot->artikel == true) {
			$showAd = true;
			$adWpId = $adSlot->id;
			break;
		}
	}

	if (!$showAd) {
		return '';
	}

	// dummy for now.
	$adVersion = '1';
	$adFarm = 'ad1';

	echo "<div class=\"headlineBlockAd\">Anzeige</div>";

	// Nicht aendern, Code muss genau so geschrieben werden !!!
	$adTag =
"<amp-ad width=$width height=$height class=\"ampAdCentered\"
    type=\"adition\"
    data-version=\"$adVersion\"
    data-farm=\"$adFarm\"
    data-wp_id=\"$adWpId\">
 </amp-ad>";

	return trim($adTag);
}
