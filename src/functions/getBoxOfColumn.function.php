<?php

/**
 *
 *	Searches for a Box with a specified Template in a Column of a Channel.
 *
 *	@param channelName string
 *	@param templateString string
 *	@param columnName string
 *  @param portalName string
 *
 *  @return the first box with the template or null
*/

function getBoxOfColumn($channelName, $templateString, $columnName = 'Split-Story-Teaser Area', $portalName = 'oe24', $multiple = false) {
	$portal = Portal::getPortalByName($portalName, FALSE);
	if (!$portal) {
		return NULL;
	}
	$channel = Channel::getChannelByChannelString($portal, $channelName);
	if (!$channel) {
		return NULL;
	}
	$column = $channel->getColumnByName($columnName);
	if (!$column) {
		return NULL;
	}

	$goodBoxes = array();
	$boxes = $column->getBoxes();

	foreach ($boxes as $key => $box) {
		if ($box instanceof TabbedBox) {
			$tabItems = $box->getTabbedBoxItems();
			foreach ($tabItems as $key => $tabItem) {
				foreach ($tabItem->getBoxes() as $key => $box) {
					$boxTemplate = $box->getTemplate();
					if ($templateString == $boxTemplate) {
						if (!$multiple) {
							return $box;
						} else {
							$goodBoxes[] = $box;
						}
					}
				}
			}
		}
		else {
			$boxTemplate = $box->getTemplate();
			if ($templateString == $boxTemplate) {
				if (!$multiple) {
					return $box;
				} else {
					$goodBoxes[] = $box;
				}
			}
		}
	} // end outer foreach

	// if we didn't find the box, return null
	if (($multiple && empty($goodBoxes)) || !$multiple) {
		return NULL;
	} else {
		return $goodBoxes;
	}
}
