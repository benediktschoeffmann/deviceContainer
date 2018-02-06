<?

/**
 * @param $type spunQ_Type
 * @param $conditions array, where key is memberName
 * @param $properties array, where value is memberName
 * @param $asArray return array or object
 */

function getSpunqData($type, $conditions = array(), $properties = NULL, $asArray = false) {
	if (empty($conditions)) {
		throw new spunQ_Exception("Error Processing Request");		
	}
	$selectQuery = new spunq_SelectQuery();
	// $selectQuery->setProperties(array(
	// 	'id',
	// 	'name',
	// 	'columns._value.id',
	// 	'columns._value.boxes._value.id',
	// 	'columns._value.boxes._value.name',
	// 	'columns._value.boxes._value.template',
	// ));
	if (is_array($properties)) {
		$selectQuery->setProperties($properties);
	}
	$selectQuery->setType($type);
	foreach ($conditions as $member => $value) {
		$selectQuery->addCondition($member . ' = {' . $member . '}');
	}
	// $selectQuery->addCondition('name = {channelName}');
	// $selectQuery->addCondition('parent.name = {parentName}');
	// $selectQuery->addCondition('columns._value.name = {columnName}');
	if ($asArray) {
		$selectQuery->setReturnType(spunq_SelectQuery::RETURN_ARRAY);
	}

	return $selectQuery->execute($conditions);
	// return $selectQuery->execute(array(
	// 	'channelName' => 'frontpage',
	// 	'parentName' => 'area51',
	// 	'columnName' => 'Split Area',
	// ));
}

function getContentFromBox($box, $type, $properties = array('id'), $asArray = false) {
	
	$content = getSpunqData(
		'oe24.core.ContentBox',
		array(
			'id' => $box->getId(),
		),
		array(
			'dropAreas._value.contents._value.id',
		),
		true
	);

	$itemIds = array_map(function($item) { return $item['dropAreas._value.contents._value.id']; }, $content);

	resolveContentCollection($itemIds);

	$contents = array();
	foreach ($itemIds as $key => $id) {
		$content = getSpunqData(
			$type,
			array(
				'id' => $id,
			),
			$properties,
			$asArray
		);

		if ('oe24.core.Video' === $type && empty($content)) {
			$content = getSpunqData(
				'oe24.core.Text',
				array(
					'id' => $id,
					'customType.name' => 'VideoA1',
				),
				$properties,
				$asArray
			);
		}

		if (!empty($content)) {
			$contents[] = $content[0];
		}
	}

	return $contents;
}

function resolveContentCollection(&$itemIds) {
	foreach ($itemIds as $key => $id) {
		$contents = getSpunqData(
			'oe24.core.ContentCollection',
			array(
				'id' => $id,
			),
			array(
				'id',
				'items._value.id',
			),
			true
		);

		$contentIds = array_map(function($item) { return $item['items._value.id']; }, $contents);

		resolveContentCollection($contentIds);
		if (!empty($contentIds)) {
			array_splice($itemIds, $key, 1, $contentIds);
		}
	}
}
