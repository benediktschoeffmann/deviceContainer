<?
/**
* Article Additional Boxes
*/

$device = DeviceContainer::getDevice();
$channel = $device->getConfig('channel');

// ------------------------------------------------------------------------

$layout = $channel->getOptions(true,false)->get('layoutOverride');

$validLayouts = array(
	'sport',
	'reise',
);

if (!in_array($layout, $validLayouts)) {
	return;
}

// ------------------------------------------------------------------------

$column = $channel->getColumnByName('Split-Story-Teaser Area');

if (!$column) {
    return;
}

// ------------------------------------------------------------------------

$validBoxTemplates = array(
    'oe24.oe24._htmlBoxes.defaultHtmlBox',
    'oe24.oe24._templateBoxes.oe2016joe24ReiseAngebot', // 2017-11-28 (db) Reiseangebote im Artikeldetail joe24
);
$validBoxes = array();

$boxes = $column->getBoxes();

// nur valid content
foreach ($boxes as $box) {
	$template = $box->getTemplate();

	// valid boxes
	if (in_array($template, $validBoxTemplates)) {
		$validBoxes[] = $box;
	}

	// bei tabbed-Boxen auch den Inhalt durgehen
	if ($box instanceof TabbedBox) {
		$tabItems = $box->getTabbedBoxItems();
		if (empty($tabItems)) {
			continue;
		}

		// nur linken Tab berücksichtigen
		if (isset($tabItems[0])) {
			$boxItems = $tabItems[0]->getBoxes();

			foreach ($boxItems as $boxItem) {
				$tabTemplate = $boxItem->getTemplate();
				if (in_array($tabTemplate, $validBoxTemplates)) {
					$validBoxes[] = $boxItem;
				}
			}
		}
	}
}

$boxes = (0 < count($validBoxes)) ? $validBoxes : false;

if (!$boxes) {
    return;
}

// ------------------------------------------------------------------------

$contents = $device->processBoxes($boxes);

foreach ($contents as $content) {
    echo $content . "\n";
}
