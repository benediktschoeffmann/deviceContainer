<?php

/*
 * Gibt die Anzahl der angeklickten Seitenumbrüche in den TextSections zurück
 *
 * @author pj
 *
 * @param oe24.core.Text $article
 *	der Artikel
 *
 * @retval $countPages
 * 	Anzahl an angeklickten Seitenumbrüchen
*/

function getTextSectionPages ($article) {

	$countPages = 0;

	foreach ($article->getTextSections() as $textSection) {
		if ($textSection->getPageBreak()) {
			++$countPages;
		}
	}

	return $countPages;
}

?>