<?php
/**
 * searchsite
 *
 * @var channel oe24.core.Channel
 * @var params array<any>
 */
$box = new ContentBox();
$box->setChannels(array($channel));

$useVideo = urlencode(request()->getGetValue('video'));
$useSlideshows = urlencode(request()->getGetValue('slideshow'));
$useText = urlencode(request()->getGetValue('text'));
$secondTime = urlencode(request()->getGetValue('second'));

$additionalOe2016Classes = '';
$additionalOe2016CookingClasses = '';
$cooking = false;
if (isset($params['allowedTypes'])) {
	$allowedTypes = $params['allowedTypes'];
	$cooking = true;
	$additionalOe2016Classes = 'oe2016';
	$additionalOe2016CookingClasses = 'wsRecipe recipe2016';
} else {
	$allowedTypes = array();
}

$checked = array(
	'video' => 'checked',
	'slideshow' => 'checked',
	'text' => 'checked'
);
$html = '&second=1';

if ($useVideo) {
	$allowedTypes[] = 'oe24.core.Video';
	$html .= '&video=1';
} else {
	if ($secondTime) {
		$checked['video'] = '';
	}
}

if ($useSlideshows) {
	$allowedTypes[] = 'oe24.core.SlideShow';
	$html .= '&slideshow=1';
} else {
	if ($secondTime) {
		$checked['slideshow'] = '';
	}
}

if ($useText) {
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

$q = urlencode(request()->getGetValue("q"));
$placeholder = 'Bitte geben Sie hier ihre Suche ein...';
if (isset($q) && !empty($q)) {

	$placeholder = urlencode(request()->getGetValue("q"));
	$page = urlencode((int)request()->getGetValue("s"));
	$page = (!$page) ? 1: $page;
	$pages = 1;
	$pager = frontendSearch(urlencode(request()->getGetValue("q")), NULL, $page, NULL, "relevance", 12,$allowedTypes);

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
	$showPages = 5;
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


// tpl('oe24.oe24.__splitArea.tpl.row.row_margin', array('position' => 'top'));

?>
<!-- row start -->
<div class="row <?= $additionalOe2016CookingClasses; ?>">

	<!-- content start -->
	<div class="content <?= $additionalOe2016Classes; ?>">
		<div class="search_box">

			<form class="form_search" name="search" method="GET" action="<?=request()->getUri(true)?>">
				<input type="hidden" name="second" value="1">
				<input class="textfield" type="text" name="q" value="<?=$q?>" placeholder="<?=$placeholder?>"/>
				<? if (!$cooking) : ?>
					<span class="entry">
						<input type="checkbox" name="text" value="1" id="search_text"<?= $checked['text']; ?> >
						<label for="search_text">Artikel</label>
					</span>
					<span class="entry">
						<input type="checkbox" name="slideshow" value="1" id="search_slideshow" <?= $checked['slideshow']; ?>>
						<label for="search_slideshow">Slideshows</label>
					</span>
					<span class="entry">
						<input type="checkbox" name="video" value="1" id="search_video" <?= $checked['video']; ?>>
						<label for="search_video">Videos</label>
					</span>
				<? endif; ?>
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
					  	tpl('oe24.oe24.__splitArea.tpl.content.stories', 
					 		array(
					 			'box' 				=> $box, 
					 			'drop_areas_content' => $contents, 
					 			'col_count' 		=> 3, 
					 			'row_count' 		=> 0, 
					 			'max_stories' 		=> 12
					 		)
					 	); 
					?>
					<div class="clearfix"></div>
					<p class="search_pages_counter">
						<?=$articlePagesCounter;?>
					</p>
					<div class="search_pages">
						<?=$articlePages;?>
					</div>
				<? else: ?>
					<b>Es wurden 0 Ergebnisse gefunden.</b>
				<? endif; ?>
			<? endif; ?>

		</div>
	</div>
	<!-- content end -->

	<!-- sidebar start -->
	<div class="sidebar <?= $additionalOe2016Classes; ?>">
	
	<? if ($cooking): ?>
		<? tpl('oe24.oe24.__splitArea.article.articleDetailSidebar',array('channel' => $channel)); ?>
	<? else: ?>
		<?
			etpl('oe24.oe24.__splitArea._page.standardColumnsSplitArea', array('columnName' => 'Split-Story-Teaser Area', 'channel' => $channel, 'object' => 0, 'hide' => array()));
		?>
	<? endif; ?>
	</div>
	<!-- sidebar end -->

</div>
<!-- row end -->

<?
tpl('oe24.oe24.__splitArea.tpl.row.row_margin', array('position' => 'bottom'));
?>
