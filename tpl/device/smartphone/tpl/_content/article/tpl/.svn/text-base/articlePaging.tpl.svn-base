<?
/**
 * article default
 * @var article oe24.core.Content
 */

// ------------------------------------------------------------------------------------

$pages = $article->getTotalBodyPages();

$pageBodyText = $article->getPagedBodyText(true, true, 'smartphone');

?>

<? /*Seitennavigation*/ ?>
<? tpl('oe24.oe24.device.smartphone.tpl._content.article.tpl.articlePagingNavigation', array('article' => $article, 'topNavigation' => 1) ); ?>

<? foreach ($pageBodyText as $key => $bodyText) { ?>

	<? $displayClass = (0 == $key) ? '' : ' passive'; ?>
	<div class="articlePageText<?= $displayClass; ?>"><?= $bodyText; ?></div>

<? } ?>

<? /*Seitennavigation*/ ?>
<? tpl('oe24.oe24.device.smartphone.tpl._content.article.tpl.articlePagingNavigation', array('article' => $article, 'topNavigation' => 0) ); ?>
