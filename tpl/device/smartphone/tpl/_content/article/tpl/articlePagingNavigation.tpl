<?
/**
 * article default
 * topNavigation 1
 * @var article oe24.core.Content
 * @var topNavigation integer
 */

$pages = $article->getTotalBodyPages();

?>

<? if (1 < $pages): ?>
    
	<? if ($topNavigation): ?>
    	<a name="textBegin"></a>
	<? endif; ?>

    <div class="articlePages">
        Seiten: 

		<? for($page = 1; $page <= $pages; $page++) { ?>
			<? $class = (1 == $page) ? 'active ' : ''; ?>
        	<a class="<?= $class; ?>js-oewaLink" onclick="pager.gotoPage(<?= $page; ?>);" href="#textBegin"><?= $page; ?></a>
        <? } ?>
    </div>
    
<? endif; ?>
