<?

function getLexikonTableData($cols, $contentsByTags) {

	if (false == is_array($contentsByTags) || count($contentsByTags) <= 0) {
		return null;
	}

	$arr = array();
	foreach ($contentsByTags as $tagName => $contentsByTag) {

		if (empty($contentsByTag)) {
			continue;
		}

		// $tagName = substr($tagName, -1); // Tags: B, Lexikon-B, etc.
		// (pj) 2014-11-03 statt substring
		$matchFound = preg_match("/.*Lexikon-(.*)/i", $tagName, $tagNameMatch);
		if (false === $matchFound || 0 === $matchFound) {
			continue;
		}
		$tagName = $tagNameMatch[1];
		// (pj) ENDE

		foreach ($contentsByTag as $content) {
			$attr = getContentUrlAttributesArray($content, false, true, true, true);
			$arr[] = array(
				'tag' => $tagName,
				'href' => isset($attr['href']) ? $attr['href'] : '#',
				'title' => isset($attr['title']) ? $attr['title'] : '',
				'caption' => trim($content->getTitle()),
			);
		}
	}

	$sum_rows = count($arr);
	$max_rows = ceil($sum_rows / $cols);

	$table_data = array();
	if (count($arr) > 0) {
		$table_data = array_chunk($arr, ceil($sum_rows / $cols), true);
	}

	return $table_data;
}

?>