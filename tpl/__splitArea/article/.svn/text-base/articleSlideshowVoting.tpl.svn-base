<?
/**
* Article SlideshowVoting
*
* @var channel oe24.core.Channel
* @var params array<any>
* @var object oe24.core.SlideShowVoting
* @var layout string
*/

$options = $object->getOptions(true, true);
// if(isOverride("madonna", $channel)){

// }

// (bs) 2015-11-18 OE2016-24
$additionalCommentClass = '';
$showStickySocial = true;
if ('oe24' === $layout) {
	$showStickySocial = false;
	$additionalCommentClass = ' no_borders oe2016';
}

$article = $object;
$articleId = $article->getId();
$parentChannels = $channel->getParentChannels();

// Breadcrumbs
$icon_house = '&xe603;';

$breadcrumbs = array();
foreach ($parentChannels as $parentChannel) {

	$caption = trim($parentChannel->getPageTitle());
	$caption = ('' == $caption) ? $icon_house : $caption;
	$url = $parentChannel->getUrl();

	$breadcrumbs[] = array('caption' => $caption, 'url' => $url);
}
$caption = trim($channel->getPageTitle());
$url = $channel->getUrl();
$breadcrumbs[] = array('caption' => $caption, 'url' => $url);

// -------------------------------------------

$articleComments = $article->getComments();
$articleCommentsCount = count($articleComments);

$articleHeadline = $article->getTitle();
$articleTeaser = $article->getLeadText(true);

if (array_key_exists('images', $params)) {
	$images = $params['images'];
} else {
	$images = $article->getRelatedImages();
}

// -------------------------------------------
$author = ($article->getOptions(true, true)->getByKey("showAuthor") && $article->getFrontendAuthor()) ? $article->getFrontendAuthor() : NULL;

// Kommentare anzeigen
$showComments = $article->getOptions(true, true)->getByKey("allowPosting");
if ($showComments === null) {
	$showComments = true;
}

// Hide Social Buttons
$hideSocialButtons = $article->getOptions(true, true)->getByKey("hideSocialButtons");
if ($hideSocialButtons === null) {
	$hideSocialButtons = true;
}

// Print Button anzeigen
$showPrintButton = $article->getOptions(true, true)->getByKey("print");
if ($showPrintButton === null) {
	$showPrintButton = true;
}

// Mail Button anzeigen
$showMailButton = $article->getOptions(true, true)->getByKey("mailto");
if ($showMailButton === null) {
	$showMailButton = true;
}
// debug("articleSlideshowVoting");
// -------------------------------------------

?>
<!-- row start -->
<div class="row">
	<!-- content start -->
	<div class="content">
		<article class="article_box">
			<div class="article_box_wrapper">

				<? if (isset($hideSocialButtons) && !$hideSocialButtons && $showStickySocial): ?>
				<div class="article_social">
					<? tpl('oe24.oe24.__splitArea.article.social', array('content' => $article)); ?>
				</div>
				<? endif; ?>

				<h1><?=$articleHeadline?></h1>

				<div class="service">
					<? if (isset($showComments) && true == $showComments): ?>
					<a class="comment" onclick="$('html, body').animate({ scrollTop: ($('.comments').offset().top)}, 0);">
						<span class="icon icon_comment"></span>
						<span>Posten Sie (<?=$articleCommentsCount?>)</span>
					</a>
					<? endif ?>
					<? if (isset($showPrintButton) && $showPrintButton): ?>
					<a class="printer" href="<?=$articleId?>/print">
						<span class="icon icon_printer"></span>
					</a>
					<? endif; ?>
					<? if (0 && isset($showMailButton) && $showMailButton): ?>
					<a class="mail" href="<?=$articleId?>/mailto">
						<span class="icon icon_mail"></span>
					</a>
					<? endif; ?>
					<ul class="breadcrumbs">
					<?php foreach ($breadcrumbs as $key => $item): ?>
						<li>
							<?php if ($icon_house == $item['caption']): ?>
							<a href="<?=$item['url']?>"><span class="icon icon_house"></span></a>
							<?php else: ?>
							<span>&rsaquo;</span>
							<a href="<?=$item['url']?>">
								<?=$item['caption']?>
							</a>
							<?php endif ?>
						</li>
					<?php endforeach ?>
					</ul>
					<? if (!($showStickySocial)) : ?>
						<div id="addThis addthisSharingToolbox" class="addthis_sharing_toolbox"></div>
					<? endif; ?>
				</div>

				<? etpl('oe24.oe24.adition.adSlot',array('channel' => $channel, 'id' => 'ArticleLeft1')); ?>

				<strong class="article_teaser"><?=$articleTeaser?></strong>
				<div class="article_body">
					<script type="text/javascript">
					//<![CDATA[
						document.domain = 'oe24.at';
					//]]>
					</script>

					<?
					tpl('oe24.oe24.__splitArea.article.slideshowVoting', array(
						'slideshow' 	=> $article,
						'isInline'		=> false,
					));
					?>
					<? if($author): ?>
						<i>Autor: <?= $author; ?></i>
					<? endif; ?>
				</div>
			</div>
			<div class="article_share">
				<? tpl('oe24.oe24.__splitArea.article.socialInline', array('content' => $article)); ?>
			</div>
		</article>
		<? etpl('oe24.oe24.adition.adSlot',array('channel' => $channel, 'id' => 'ArticleLeft2')); ?>
		<? if (isset($showComments) && $showComments): ?>
			<? if ('Facebook' === $options->get('postingType')): ?>
		        <a name="comments"></a>
		        <section id="fbComment" class="fbComments comments clearfix">
					<h2 id="commentCounter" itemprop="interactionCount">Posten Sie Ihre Meinung</h2>

					<div class="hide_postings">
						<span>Kommentare ausblenden</span>
						<div class="hidePostingDiv icon icon_arrow3_up"></div>
					</div>
		            <div class="container_postings fb-comments" data-href="<?= $article->getUrl(); ?>" data-numposts="10" data-colorscheme="light"></div>
		        </section>

			<? else: ?>
				<section class="comments<?=$additionalCommentClass;?>">
					<a name="comments"></a>
					<? tpl('oe24.oe24.__splitArea.article.comments', array('article' => $article, 'articleCommentsCount' => $articleCommentsCount)); ?>
				</section>
			<? endif; ?>
		<? endif ?>
		<? etpl('oe24.oe24.adition.adSlot',array('channel' => $channel, 'id' => 'Left3')); ?>
		<?
			if($object->getCustomType()){
				if($object->getCustomType()->getName()==="channelSlideshow"){
					etpl('oe24.oe24.__splitArea._page.standardColumnsSplitArea', array(
						'columnName' => 'Split-Story-Teaser Area',
						'tabSide' => 'left',
						'channel' => $channel,
						'object' => $article,
						'hide' => array(),
					));
				}
			}
		?>
	</div>
	<!-- content end -->

	<!-- sidebar start -->
	<div class="sidebar">
		<?
		etpl('oe24.oe24.__splitArea.article.relatedStories', array(
				'contents' => $article->getRelatedStories(),
				'boxHeadline' => 'Zum Thema',
				'showNumbers' => false,
				'showImages' => true,
			)
		);

		etpl('oe24.oe24.__splitArea._page.standardColumnsSplitArea', array('columnName' => 'Split-Story-Teaser Area', 'channel' => $channel, 'object' => $article, 'hide' => array()));

		?>
	</div>
	<!-- sidebar end -->

</div>
<!-- row end -->

<?
tpl('oe24.oe24.__splitArea.tpl.row.row_margin', array('position' => 'bottom'));
