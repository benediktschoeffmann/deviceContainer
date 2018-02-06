<?php

/*
 * Bereitet die TextSections als Array auf
 *
 * @author pj
 *
 * @param oe24.core.TextSections<array> $textSections
 *	der Artikel
 *
 * @retval $tmpArr
 * 	Array mit den Datensätzen
*/

function getTextSectionAsArray ($textSections, $overrideLayout='gesund24') {

	$firstTicker = true;
	$tickerPage = 0;
	
	$tickerPages = array();

	$tickerEntrys = array();

	foreach ($textSections as $tickerKey => $tickerSection) {

		if (true === $tickerSection->getPageBreak()) {

			$tickerPages[$tickerPage]['entrys'] = $tickerEntrys;

			$tickerEntrys = array();
			$firstTicker = true;

			if (0 < $tickerKey) {
				++$tickerPage;
			}

			$tickerPages[$tickerPage]['pageBreak'] = true;
		}

		$bodyText = $tickerSection->getBodyText();

		$bodyText = '<p>' . str_replace("\n", "</p>\n<p>", $bodyText) . '</p>';

		// spunQ_Tags
		if (preg_match_all('/<[^<]*spunQ([:_])([A-Za-z]*)[^>]*>/', $bodyText, $match)) {

			foreach ($match[0] as $key => $value) {
				$spunqTag = $match[2][$key];

				$spunqId = 0;
				$spunqType = 'oe24.core.' . $spunqTag;
				$spunqLinkText = '';
				
				if ('_' === $match[1][$key]) {
					$hrefPos = strpos($value, 'href');
					$hrefPos = strpos($value, '"', $hrefPos)+1;
					$hrefEndPos = strpos($value, '"', $hrefPos)-$hrefPos;
					$spunqId = substr($value, $hrefPos, $hrefEndPos);

					$spunqLinkTextPos = strpos($bodyText, $value) + strlen($value);
					$spunqEndLinkTextPos = strpos($bodyText, '</a>', $spunqLinkTextPos);
					$spunqLinkText = substr($bodyText, $spunqLinkTextPos, $spunqEndLinkTextPos - $spunqLinkTextPos);

					$tplAlias = 'oe24.oe24.overrides.' . $overrideLayout . '._htmltagging.objectlink';
				} else {
					$idPos = strpos($value, 'id');
					$idPos = strpos($value, '"', $idPos)+1;
					$idEndPos = strpos($value, '"', $idPos)-$idPos;
					$spunqId = substr($value, $idPos, $idEndPos);

					$tplAlias = 'oe24.oe24.overrides.' . $overrideLayout . '._htmltagging.' . $spunqTag;
				}

				if (0 === $spunqId) {
					continue;
				}

				if (!spunQ_Module::aliasToTplFile($tplAlias, false)) {
					$tplAlias = str_replace('.overrides.' . $overrideLayout, '', $tplAlias);
				}

				if (spunQ_Module::aliasToTplFile($tplAlias, false)) {
					$templateHtml = templateAsString($tplAlias, array('id' => $spunqId, 'type' => $spunqType, 'linkText' => $spunqLinkText));
					if ('_' === $match[1][$key]) {
						$bodyText = str_replace($value . $spunqLinkText . '</a>', $templateHtml, $bodyText);
					} else {
						$bodyText = str_replace($value, $templateHtml, $bodyText);
					}
				}

			}

			$relatedContentHtml = array();
			$relatedContents = $tickerSection->extractRelatedContent('oe24.core.Content');
			foreach ($relatedContents as $key => $relatedContent) {

				$spunqType = 'oe24.core.' . get_class($relatedContent);

				$tplAlias = 'oe24.oe24.overrides.' . $overrideLayout . '._htmltagging.';
				if (($relatedContent instanceof Text && $relatedContent->getVideoOptions()) || $relatedContent instanceof Video) {
					$tplAlias = $tplAlias . 'Video';
				} else if ($relatedContent instanceof SlideShow) {
					$tplAlias = $tplAlias . 'SlideShow';
				} else if ($relatedContent instanceof Text) {
					$tplAlias = $tplAlias . 'Text';
				} else if ($relatedContent instanceof Image) {
					$tplAlias = $tplAlias . 'Image';
				}

				if (!spunQ_Module::aliasToTplFile($tplAlias, false)) {
					$tplAlias = str_replace('.overrides.' . $overrideLayout, '', $tplAlias);
				}

				if (spunQ_Module::aliasToTplFile($tplAlias, false)) {
					$templateHtml = templateAsString($tplAlias, array('id' => $relatedContent->getId(), 'type' => $spunqType));
					$bodyText .= '<p>' . $templateHtml . '</p>';
				}
			}

		}

		$shortDate = formatDateUsingIntlLangKey('time.short', $tickerSection->getFrontendDate());
		$title = $tickerSection->getTitle();
		if (!empty($title)) {
			$shortDate = $title;
		}

		$tmpArr = array(
			'title' => $title,
			'shortDate' => $shortDate,
			// 'pageBreak' => $tickerSection->getPageBreak(),
			'leadText' => $tickerSection->getLeadText(),
			'bodyText' => $bodyText,
			'class' => $firstTicker ? 'first_ticker' : '',
		);

		$tickerOptions = ($tickerSection->getTemplate() === 'sportticker') ? $tickerSection->getOptions() : array();
		foreach ($tickerOptions as $key => $value) {
			$tmpArr = array_merge($tmpArr, array($key => $value));
		}

		$tickerEntrys[] = $tmpArr;
		$firstTicker = false;
	}

	$tickerPages[$tickerPage]['entrys'] = $tickerEntrys;

	return $tickerPages;
}

?>