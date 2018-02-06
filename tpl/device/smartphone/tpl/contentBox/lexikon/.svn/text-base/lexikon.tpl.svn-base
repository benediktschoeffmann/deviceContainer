<?

/**
 * @var layout string
 * @var headerText any
 * @var lexikonAuswahl any
 *
 * @default headerText 0
 * @default lexikonAuswahl Lexikon
 */

if ('0' == $headerText || null == $headerText) {
	$headerText = '';
}

$contentsByTags = array();
$layoutContentLevel = ContentLevel::getLevelByName(ucfirst($layout)); // Gesund24, Cooking24, ...
foreach ($layoutContentLevel->getMappedLevels() as $mappedLevel) {
	if ($lexikonAuswahl == $mappedLevel->getName()) {
		$contentLevel = $mappedLevel;
		if($contentLevel){
			$contentTags = $contentLevel->getMappedTags();
			foreach($contentTags as $contentTag){
				$contentsByTags[$contentTag->getName()] = $contentTag->getTagRefContent();
			}
		}
	}
}

if (count($contentsByTags) === 0) {
	return;
}

// -------------------------------

$cols = 1;
// $cols = 3;
// $cols = 4;

// Breite der Tabellenspalten
$col_width = floor(100 / $cols);

// -------------------------------

$table_data = getLexikonTableData($cols, $contentsByTags);

$old_col = 0;
$old_cat = '';

?>
<div class="lexikon_leadtext">
	<p><?= $headerText; ?></p>
</div>
<table class="lexikon">
	<colgroup>
	<?for ($n = 0; $n < $cols; $n++):?>
		<col width="<?=$col_width?>">
	<?endfor?>
	</colgroup>
	<tr style="vertical-align:top">
	<?foreach ($table_data as $k1 => $cols):?>
		<td>
			<ul class="lexikon_list">
			<?foreach ($cols as $k2 => $item):?>

				<?

				// Angezeigt wird die Kategorie zu Beginn und wenn sie wechselt.
				// In der ersten Zeile einer neuen Spalte soll allerdings ebenfalls
				// die Kategorie gezeigt werden, auch wenn sie die gleiche ist, wie
				// in der letzten Zeile der vorherigen Spalte

				$cat = $item['tag'];

				if (($cat !== $old_cat) || ($k1 > 0 && $k1 !== $old_col)) {
					$old_col = $k1;
					$old_cat = $cat;
					$class_item = 'lexikon_kategorie_start';
				} else {
					$cat = '&nbsp;';
					$class_item = '';
				}

				?>

				<li class="lexikon_item <?=$class_item?>">
					<span class="lexikon_kategorie"><?=$cat?></span>
					<a class="lexikon_link" href="<?=$item['href']?>" title="<?=$item['title']?>"><?=$item['caption']?></a>
				</li>
			<?endforeach?>
			</ul>
		</td>
	<?endforeach?>
	</tr>
</table>
