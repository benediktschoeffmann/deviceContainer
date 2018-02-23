<?php
/**
 * Paging Site
 * 
 * @var pages integer
 * @var page integer
 */

$articlePagesCounter = 'Seite ' . $page . ' von ' . $pages;

$articlePages = '';
$showPages = 5;
$startPage = ($page-$showPages < 1) ? 1 : $page-$showPages;
$endPage = ($page+$showPages > $pages) ? $pages : $page+$showPages;

if ($page > 1) {
	$articlePages .= '<a class="" onclick="" href="?q=&s=1">«</a>';
	$articlePages .= '<a class="" onclick="" href="?q=&s=' . ($page-1) . '">‹</a>';
}

for ($p=$startPage; $p<=$endPage; ++$p) {
	$class = ($p == $page) ? 'active' : '';
	$articlePages .= '<a class="' . $class . '" onclick="" href="?q=&s=' . $p . '">' . $p . '</a>';
}

if ($page < $pages) {
	$articlePages .= '<a class="" onclick="" href="?q=&s=' . ($page+1) . '">›</a>';
	$articlePages .= '<a class="" onclick="" href="?q=&s=' . $pages . '">»</a>';
}

?>
<div class="pager_box">
	<p class="search_pages_counter">
		<?=$articlePagesCounter;?>
	</p>
	<div class="search_pages">
		<?=$articlePages;?>
	</div>
</div>
