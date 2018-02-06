<?php
/**
 * Function is Box in Tab Box
 *
 * @param channel oe24.core.Channel the Channel to test
 * @param box oe24.core.FrontendBox the Box to search for
 * @param column string in which Column to search
 * @return null if box is not in ChannelColumn
           the channel if box is not in Tab Box
           the tabbed Box if box is in Tab Box
           false if an error occurred
 */
function isBoxInTabbox($channel, $frontendBox, $column = 'Split Area 2016') {
    $channelColumn = $channel->getColumnByName($column);
    if (!$channelColumn) {
        return false;
    }
    $boxes = $channelColumn->getBoxes();

    foreach ($boxes as $key => $box) {
        if ($box instanceof TabbedBox) {
            $tabbedBoxItems = $box->getTabbedBoxItems();
            if (!$tabbedBoxItems) return false;
            foreach ($tabbedBoxItems as $key => $item) {
                $itemBoxes = $item->getBoxes();
                foreach ($itemBoxes as $key => $itemBox) {
                    if ($itemBox && $itemBox->getId() === $frontendBox->getId()) {
                        return $box; // tabbed Box
                    }
                }
            }
        }
        if ($box->getId() === $frontendBox->getId()) {
            return $channel;
        }
    }

    return null;
}
