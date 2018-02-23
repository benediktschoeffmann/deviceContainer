<?
/**
 * Output a complete Column
 * 
 * tabSide -> liest entweder standardmäßig die rechte Seite aus oder die linke
 *
 * @var columnName string
 * @var channel oe24.core.Channel
 * @var hide array<any>
 * @var tabSide string
 * @default tabSide right
 * @var object any
 * @default object 0
 */

$column = $channel->getColumnByName($columnName, !State::getInstance()->getIsPreview(), true);
$options = $channel->getOptions();

// if column is story teaser area and no column found, check in teaser area for a column with boxes
// if($columnName == "Story-Teaser Area" && !$column){
//     $column = $channel->getColumnByName("Teaser Area", !State::getInstance()->getIsPreview(), true);
// }

// if($columnName != "OnTop Content" && $options->get("showOnlyTopContent")){
//     return NULL;
// }

if ($columnName == 'Split Area' || $columnName == 'Split-Story-Teaser Area') {

	$boxItems = array();

	$boxes = $column->getBoxes();
	foreach ($boxes as $frontendBox) {

		if ($tabSide === 'top') {

			if ($frontendBox instanceof TabbedBox) {
				break;
			} else {
				$boxItems[] = $frontendBox;
			}

		} else {

			if ($frontendBox instanceof TabbedBox) {

				$tabItems = $frontendBox->getTabbedBoxItems();

				if (count($tabItems) === 2) {
					list($contentArea, $teaserArea) = $tabItems;
					if ($tabSide == 'right') {
						$tabbedBoxes = $teaserArea->getBoxes();
					} else {
						$tabbedBoxes = $contentArea->getBoxes();
					}

					foreach ($tabbedBoxes as $teaserBox) {
						if (!in_array($teaserBox->getTemplate(), $hide)) {
							$boxItems[] = $teaserBox;
						}
					}
				}

			}

		}

	}

	if ($column) {
	    etpl("oe24.frontend._iterateFrontendBoxes", array("boxes" => $boxItems, "channel" => $channel, "column" => $column, "object" => $object));
	}

}

?>
