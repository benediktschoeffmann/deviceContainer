<?
/**
 * Output a complete Column
 *
 * @var columnName string
 * @var channel oe24.core.Channel
 * @var object any
 * @default object 0
 */
$column = $channel->getColumnByName($columnName, !State::getInstance()->getIsPreview(), true);
$options = $channel->getOptions();

// if column is story teaser area and no column found, check in teaser area for a column with boxes
if($columnName == "Story-Teaser Area" && !$column){
    $column = $channel->getColumnByName("Teaser Area", !State::getInstance()->getIsPreview(), true);
}

if($columnName != "OnTop Content" && $options->get("showOnlyTopContent")){
    return NULL;
}

if($column){
    $boxes = $column->getBoxes();
    etpl("oe24.frontend._iterateFrontendBoxes", array("boxes" => $boxes, "channel" => $channel, "column" => $column, "object" => $object));
}
?>
