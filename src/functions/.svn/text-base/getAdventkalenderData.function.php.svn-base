<?php
/**
 * Daten bereitstellen fuer den Adventkalender
 *
 * @param oe24.core.FrontendBox $box
 * @return array
 */

function getAdventkalenderData($box) {

	$templateOptions = $box->getTemplateOptions();

	$firstDate = trim($templateOptions->get('Erster-Tag'));
	$lastDate = trim($templateOptions->get('Letzter-Tag'));

	if (!preg_match('/^\d\d\d\d-\d\d-\d\d$/', $firstDate) || !preg_match('/^\d\d\d\d-\d\d-\d\d$/', $lastDate)) {
		return null;
	}

	$tsFirst = strtotime($firstDate.' 00:00:00');
	$tsLast = strtotime($lastDate.' 23:59:59');

	if (false == $tsFirst || false == $tsLast) {
		return null;
	}

	$tsCurrent = time();

	// zum Testen ANFANG ----------------------------

	// (ws) 2014-11-14
	// Den auskommentierten Programmcode lass ich hier,
	// damit er u.U. weiter verwendet werden kann und nicht erst
	// aus einer "alten" Version herausgesucht werden muss.

	// $tsCurrent = strtotime('2014-11-23 23:59:59');
	// $tsCurrent = strtotime('2014-11-24 00:00:00');
	// $tsCurrent = strtotime('2014-11-30 23:59:59');
	// $tsCurrent = strtotime('2014-12-01 00:00:00');
	// $tsCurrent = strtotime('2014-12-02 00:00:00');
	// $tsCurrent = strtotime('2014-12-22 23:59:59');
	// $tsCurrent = strtotime('2014-12-23 23:59:59');
	// $tsCurrent = strtotime('2014-12-23 07:26:03');
	// $tsCurrent = strtotime('2014-12-24 23:59:59');
	// $tsCurrent = strtotime('2014-12-25 23:59:59');
	// $tsCurrent = strtotime('2015-01-15 23:59:59');
	// $tsCurrent = strtotime('2015-01-16 00:00:00');

	// $tsCurrent = strtotime('2016-12-01 23:59:59');
	// $tsCurrent = strtotime('2016-12-03 23:59:59');
	// $tsCurrent = strtotime('2016-12-10 23:59:59');
	// $tsCurrent = strtotime('2016-12-22 23:59:59');
	// $tsCurrent = strtotime('2016-12-24 23:59:59');
	// $tsCurrent = strtotime('2017-01-16 00:00:00');

	// $readTestDate = false;
	// $channel = $box->getHomeChannel();
	//
	// if (null !== $channel) {
	//
	// 	$url = $channel->getPortal()->getUrl();
	// 	$oe24dev = (($pos = strpos('oe24dev.oe24.at', $url)) >= 0) ? true : false;
	//
	// 	// Am Development-Server ist der Adventkalender im Channel fontpage -> advent -> adventkalender,
	// 	// am Produktions-Server vorlaeufig im Channel fontpage -> test -> adventkalender
	// 	$searchPath = ($oe24dev) ? 'fontpage/advent/adventkalender' : 'frontpage/test/adventkalender';
	//
	// 	$parentChannels = $channel->getParentChannels(true);
	// 	$temp = array();
	// 	foreach ($parentChannels as $c) {
	// 		$temp[] = trim($c->getName());
	// 	}
	// 	$channelPath = implode('/', $temp);
	//
	// 	$pos = strpos($searchPath, $channelPath);
	// 	if ($pos >= 0) {
	// 		$readTestDate = true;
	// 	}
	//
	// 	if ($readTestDate && isset($_GET['d'])) {
	// 		$temp = strtotime($_GET['d']);
	// 		if (false !== $temp) {
	// 			$tsCurrent = $temp;
	// 		}
	// 	}
	// }

	$readTestDate = false;
	if (isset($_GET['d'])) {
		$temp = strtotime($_GET['d']);
		if (false !== $temp) {
			$tsCurrent = $temp;
		}
	}

	// zum Testen ENDE ------------------------------

	$maxDays = 24;
	$year = date('Y', $tsFirst);

	$tsDecemberFirstDay = strtotime($year.'-12-01 00:00:00');
	$tsDecemberLastDay  = strtotime($year.'-12-24 23:59:59');

	$dayOfYearFirstDay = date('z', $tsFirst);
	$dayOfYearCurrentDay = date('z', $tsCurrent);
	$dayOfYearFirstDecember = date('z', $tsDecemberFirstDay);

	$currentIndex = ($dayOfYearCurrentDay - $dayOfYearFirstDecember);
	$currentIndex = ($currentIndex > ($maxDays - 1) || $tsCurrent >= $tsDecemberLastDay) ? $maxDays - 1 : $currentIndex;

	// ----------------------------------------------

	$imageFormat = '200x200';

	$contentStories = $box->getContentOfAllDropAreas(true, true);
	$contentStories = array_slice($contentStories, 0, $maxDays);

	$storiesCounter = 0;
	$stories = array();
	foreach ($contentStories as $key => $content) {

		$attr = getContentUrlAttributesArray($content, $box, true, true, true);

		$href = (isset($attr['href']) && is_string($attr['href'])) ? $attr['href'] : '#';
		$title = (isset($attr['title']) && is_string($attr['title'])) ? $attr['title'] : '';
		$target = (isset($attr['target']) && is_string($attr['target']) && '' != $attr['target']) ? 'target="'.$attr['target'].'"' : '';

		$image = $content->getFirstRelatedImage(true, $box);
		$src = (null !== $image) ? $image->getFileUrl($imageFormat) : 'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7';

		$classHidden = ($currentIndex !== false && $currentIndex >= $key) ? '' : 'hidden';

		$overrideTitle = $content->getTitle(true, $box);
		$overrideTitle = ($overrideTitle) ? $overrideTitle : '';

		$temp = array(
			'href' => $href,
			'title' => $title,
			'target' => ('' != $target) ? 'target="'.$target.'"' : '',
			'src' => $src,
			'hidden' => $classHidden,

			// (ws) 2016-11-22
			'overrideTitle' => $overrideTitle,
			// (ws) 2016-11-22 end
		);

		$stories[] = $temp;
		$storiesCounter++;
	}

	// Falls noch zu wenige Stories vorhanden sind, trotzdem das Array auffuellen und kennzeichnen
	for ($n = $storiesCounter; $n < $maxDays; $n++) {
		$classHidden = ($currentIndex !== false && $currentIndex >= $n) ? '' : 'hidden';
		$temp = array(
			'href' => '#',
			'title' => '',
			'target' => '',
			'src' => lp('image', 'rl2014/adventkalender/missing.jpg'),
			'hidden' => $classHidden,

			// (ws) 2016-11-22
			'overrideTitle' => '',
			// (ws) 2016-11-22 end
		);
		$stories[] = $temp;
	}

	return array(
		'tsFirst' => $tsFirst,
		'tsLast' => $tsLast,
		'tsCurrent' => $tsCurrent,
		'currentIndex' => $currentIndex,
		'stories' => $stories,
	);
}
