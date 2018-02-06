<?php
/**
 * searchsite
 *
 * @var channel oe24.core.Channel
 * @var params array<any>
 */


$box = new ContentBox();
$box->setChannels(array($channel));

$useVideo = request()->getGetValue('video');
$useSlideshows = request()->getGetValue('slideshow');
$useText = request()->getGetValue('text');
$secondTime = request()->getGetValue('second');

// --------------------------------------------------------------

$cooking = false;
if (isset($params['allowedTypes'])) {
	$allowedTypes = $params['allowedTypes'];
	$cooking = true;
} else {
	$allowedTypes = array();
}

$checked = array(
		'video' => 'checked',
		'slideshow' => 'checked',
		'text' => 'checked'
	);
$html = '&second=1';

if (isset($useVideo)) {
	$allowedTypes[] = 'oe24.core.Video';
	$html .= '&video=1';
} else {
	if ($secondTime) {
		$checked['video'] = '';
	}
}

if (isset($useSlideshows)) {
	$allowedTypes[] = 'oe24.core.SlideShow';
	$html .= '&slideshow=1';
} else {
	if ($secondTime) {
		$checked['slideshow'] = '';
	}
}

if (isset($useText)) {
	$allowedTypes[] = 'oe24.core.Text';
	$html .= '&text=1';
} else {
	if ($secondTime) {
		$checked['text'] = '';
	}
}

// if(isset($params['allowedTypes']) && is_array($params['allowedTypes'])){
//     $allowedTypes = $params['allowedTypes'];
// }

// --------------------------------------------------------------

$q = request()->getGetValue("q");
$placeholder = 'Bitte geben Sie hier ihre Suche ein...';
if (isset($q) && !empty($q)) {

	$placeholder = request()->getGetValue("q");
	$page = (int)request()->getGetValue("s");
	$page = (!$page) ? 1: $page;
	$pages = 1;
	$pager = frontendSearch(request()->getGetValue("q"), NULL, $page, NULL, "relevance", 12,$allowedTypes);

	$contents_temp = array();
	
	if ($pager) {
	    $contents_temp = $pager->getPageContents();
	    $resultCount = $pager->getAmountObjects();
	    $pages = $pager->getAmountPages();
	}

	$contents = array();
	foreach ($contents_temp as $key => $content) {
		if ($content instanceof Image) {
			continue;
		}
		if ($content->getUrl()) {
			$contents[] = $content;
		}
	}

	$articlePagesCounter = 'Seite ' . $page . ' von ' . $pages;
	$articlePages = '';
	$showPages = 2;
	$startPage = ($page-$showPages < 1) ? 1 : $page-$showPages;
	$endPage = ($page+$showPages > $pages) ? $pages : $page+$showPages;

	if ($page > 1) {
		$articlePages .= '<a class="" onclick="" href="?q=' . $q . '&s=1' . $html . '">«</a>';
		$articlePages .= '<a class="" onclick="" href="?q=' . $q . '&s=' . ($page-1) . $html .'">‹</a>';
	}

	for ($p=$startPage; $p<=$endPage; ++$p) {
		$class = ($p == $page) ? 'active' : '';
		$articlePages .= '<a class="' . $class . '" onclick="" href="?q=' . $q . '&s=' . $p . $html . '">' . $p . '</a>';
	}

	if ($page < $pages) {
		$articlePages .= '<a class="" onclick="" href="?q=' . $q . '&s=' . ($page+1) . $html . '">›</a>';
		$articlePages .= '<a class="" onclick="" href="?q=' . $q . '&s=' . $pages . $html . '">»</a>';
	}

}

// --------------------------------------------------------------

// tpl('oe24.oe24.__splitArea.tpl.row.row_margin', array('position' => 'top'));

?>
<!-- row start -->
<div class="row">

	<!-- content start -->
	<div class="content">
		<div class="search_box">

			<form class="form_search" name="search" method="GET" action="<?=request()->getUri(true)?>">
				<input type="hidden" name="second" value="1">
				<input class="textfield" type="text" name="q" value="<?=$q?>" placeholder="<?=$placeholder?>"/>

				<input class="button" type="submit" value="Suche starten"/>
			</form>

			<div class="clearfix"></div>

			<? if (isset($pager) && $pager): ?>
				<? if (isset($resultCount) && $resultCount): ?>
					<p class="search_pages_counter">
						<?=$articlePagesCounter;?>
					</p>
					<div class="search_pages">
						<?=$articlePages;?>
					</div>

					<? 
					  // 	tpl('oe24.oe24.__splitArea.tpl.content.stories', 
					 	// 	array(
					 	// 		'box' 				=> $box, 
					 	// 		'drop_areas_content' => $contents, 
					 	// 		'col_count' 		=> 3, 
					 	// 		'row_count' 		=> 0, 
					 	// 		'max_stories' 		=> 12
					 	// 	)
					 	// ); 
					?>

					<?
					    tpl('oe24.oe24.device.smartphone.tpl.contentBox.contentBoxStories', array(
					        'channel'          => $channel,
					        'box'              => $box,
					        'stories'          => $contents, // $stories,
					        'showStoryTime'    => false, // $showStoryTime,
					        'overlay'          => '', // $overlay,
					        'layoutIdentifier' => 'cooking24', // $layoutIdentifier,
					    ));
					?>

					<?
		                // tpl('oe24.oe24.device.smartphone.tpl.contentBox.contentBoxStory', array(
		                //     'story' => $story,
		                // ));
	                ?>

					<div class="clearfix"></div>
					<p class="search_pages_counter">
						<?=$articlePagesCounter;?>
					</p>
					<div class="search_pages">
						<?=$articlePages;?>
					</div>
				<? else: ?>
					<div class="search_result">
						<b>Es wurden 0 Ergebnisse gefunden.</b>
					</div>
				<? endif; ?>
			<? endif; ?>

		</div>
	</div>
	<!-- content end -->

	<!-- sidebar start -->
	<div class="sidebar">
	<?
		etpl('oe24.oe24.__splitArea._page.standardColumnsSplitArea', array('columnName' => 'Split-Story-Teaser Area', 'channel' => $channel, 'object' => 0, 'hide' => array()));
	?>
	</div>
	<!-- sidebar end -->

</div>
<!-- row end -->

<?
tpl('oe24.oe24.__splitArea.tpl.row.row_margin', array('position' => 'bottom'));
?>
