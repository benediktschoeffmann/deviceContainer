<?
function _iterateFrontendBoxes($boxes, $channel, $column, $params = array()) {

	$column = $channel->getColumnByName($column);

	foreach ($boxes as $box) {
		try {
			etpl($box->getTemplate(), array(
					'box'		=>	$box,
					'channel'	=>	$channel,
					'column'	=> 	$column,
					'params'	=>  $params,
				));
		} catch (spunQ_Exception $e) {
		 	error($e);
		}
	}
}
