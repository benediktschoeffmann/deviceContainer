<?
/**
* Story Site
*
* @var channel oe24.core.Channel
* @var params array<any>
* @var object oe24.core.SlideShow
* @var layout string
* @var oe2016layouts any
*/

// Beispiel am Dev
// http://oe24dev.oe24.at/madonna/slideshow/Die-schoensten-Promis/161320642

// -------------------------------------------

// (bs) 2015-11-18 OE2016-24
$additionalCommentClass = '';
$showStickySocial = true;

$isOe24SlideShow = isOe2016Layout($layout, $object);

if ($isOe24SlideShow) {
	$showStickySocial = false;
	$additionalCommentClass = ' no_borders';
}
// (bs) end



// Voting Konfiguration
$options = $object->getOptions(true, true);

$oe24Conf = spunQ::getConfiguration()->getStringsForPrefix("oe24.oe24");
$votingPrefix = (isset($oe24Conf['votingPrefix'])) ? $oe24Conf['votingPrefix'] : '';
$votingUrl = (isset($oe24Conf['votingUrl'])) ? $oe24Conf['votingUrl'] : '';
if ('madonna' === $layout) {
	$votingUrl = (isset($oe24Conf['votingUrlResult'])) ? $oe24Conf['votingUrlResult'] : '';
}

$voteKey = $votingPrefix.$object->getId();

$customType = $object->getCustomType();
if($customType && $customType->getName() == "SlideshowVotingOptions"){
    if($options->get("overrideVoteKey")){
        $voteKey = $votingPrefix.$options->get("overrideVoteKey");
    }
	//MH Start: Auskommentiert wegen Wirkochen Voting
	/*
	if($options->get("hideSlideshowResults")){
        echo '<div class="column"><br/><br/>'.s($options->get("hideSlideshowResultsText"), false).'</div>';
        return;
    }
	*/

}
//$template = "spunq";
$template = ($options->get("hideSlideshowResults")) ? "spunq_noresult" : "spunq";
//MH END
if(isOverride("madonna", $channel)){
    $template = ($options->get("hideSlideshowResults")) ? "madonna_noresult" : "madonna";
}
$htmlConf = spunQ::getConfiguration()->getStringsForPrefix("spunQ.html.static");
$imgUrls = $htmlConf['image'];
$firstImgUrl = $imgUrls[0];
// debug("first: ".$firstImgUrl);

// -------------------------------------------

$article = $object;
$articleId = $article->getId();
// -------------------------------------------
$isVoting = ($object instanceof SlideShowVoting);

// -------------------------------------------
$parentChannels = $channel->getParentChannels();

// -------------------------------------------

// Breadcrumbs
$icon_house = '&xe603;';

$breadcrumbs = getBreadcrumbsForChannel($channel);
// -------------------------------------------


// Service
$articleComments = $article->getComments();
$articleCommentsCount = count($articleComments);

// -------------------------------------------

// Body
$articleHeadline = $article->getTitle();
$articleTeaser = $article->getLeadText(true);

if (array_key_exists('images', $params)) {
	$images = $params['images'];
} else {
	$images = $article->getRelatedImages();
}

/* (ws) 1407010
$imagesPerPage = 5;

$i = 0;
$articlePages = 'Seiten: ';
$articleBodyText = '<div class="article_page_body active">';

$countPages = ceil(count($images)/$imagesPerPage);
for ($c=1; $c<=$countPages; ++$c) {
	$class = ($c==1) ? 'class="active"' : "";
	$articlePages .= '<a ' . $class . ' onclick="pager.gotoPage(' . $c . '); oe24Tracking.loadOewa(); oe24Tracking.googleAnalyticsRefreshTracking(); return false;" href="#textBegin">' . $c . '</a>';
}

foreach ($images as $image) {

	if ($i % $imagesPerPage == 0 && $i < count($images) && $i > 0) {
		$articleBodyText .= '</div><div class="article_page_body" style="display: none; ">';
	}

	$articleBodyText .= '<a href="#" onclick="window[\'slideshow\' + slideShows[0]].slideTo(\'' . ($i + 1) . '\'); return false;" alt=""><img src="' . $image->getFileUrl("100x100") . '" alt="" /></a>';

	++$i;
}

$articleBodyText .= '</div>';
*/

// -------------------------------------------
//Autor anzeigen MH
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

//Prüfen ob entgeltlicher Content
$showPaidContentMarker = $object->getOptions(true, true)->get('EntgeltlicherContent');
if ($showPaidContentMarker == null) {
        $showPaidContentMarker = false;
}
// -------------------------------------------

if ('madonna' === $layout && isset($_GET['voting']) && isset($_GET['result'])) {
	$urlParameter = array(
		'key' => $voteKey,
		'template' => $template,
		'imgUrl' => urlencode($firstImgUrl),
	);
	$query = http_build_query($urlParameter);
	$votingHtml = spunQ_HttpBrowser::sendRequest($votingUrl . 'voteResult.do?' . $query, 5, false)->getBody();
	$pattern = '#(<div class="votingResult">.*</div>).*<script language="JavaScript">#si';
	$temp = preg_match($pattern, $votingHtml, $match);
	if ($match && is_array($match) && isset($match[1])) {
        $votingResult = utf8_encode($match[1]);
    } else {
        $votingResult = $votingHtml;
    }
}

// (pj) 2015-11-30 templateName nur einmal definieren ;)
$topGelesenBoxTemplate = 'oe24.oe24._contentBoxes.oe2016articleTopGelesen';
$topGelesenBoxTemplate = 'oe24.oe24._contentBoxes.rl2014oe24TvDefaultContentBox';
// (pj) 2015-11-30 end

// (bs) 2015-11-25 OE2016-24
// das 'break 3' ist GENAU SO erwünscht! spart rechenzeit und speicher!
$topGelesenBox = false;
$otherColumn = $channel->getColumnByName('Split-Story-Teaser Area');
if ($otherColumn) {
	$boxes = $otherColumn->getBoxes();
	foreach ($boxes as $key => $box) {
		if ($box instanceof TabbedBox) {
			$tabItems = $box->getTabbedBoxItems();
			foreach ($tabItems as $key => $tabItem) {
				foreach ($tabItem->getBoxes() as $key => $box) {
					$templateString = $box->getTemplate();
					if ($topGelesenBoxTemplate == $templateString) {

						$topGelesenBox = $box;
						// exit the outer loop
						break 3;
					}
				}
			}
		}
		else {
			$templateString = $box->getTemplate();
			if ($topGelesenBoxTemplate == $templateString) {

				$topGelesenBox = $box;
				break;
			}
		}
	}
}

?>
<!-- row start -->
<div class="row">

	<!-- content start -->
	<div class="content article">

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
					<!-- bugfix für votings -->
					<!-- <a class="comment" href="#comments"> -->
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

				<? etpl('oe24.oe24.__splitArea.article.voting', array('channel' => $channel, 'images' => $images, 'slideshow' => $article)); ?>

				<div class="article_body">
					<? if (isset($_GET['voting']) && isset($_GET['result'])): ?>
						<? if ('madonna' === $layout): ?>
							<section class="clearfix">
								<?= $votingResult;?>
							</section>
						<? else: ?>
				            <script type="text/javascript">
				            //<![CDATA[
				              document.domain = 'oe24.at';
				            //]]>
				            </script>
							<iframe id="vresultframe" name="vresultframe" src="<?=$votingUrl?>voteResult.do?key=<?=$voteKey?>&template=<?=$template?>&imgUrl=<?=urlencode($firstImgUrl)?>" frameborder="no" scrolling="no" width="610px" height="8500px" ></iframe>
						<? endif; ?>
					<? else: ?>
						<?
						if ($article instanceof SlideShowVoting) {
							$voteOptions = $article->getVotingOptions();
							tpl('oe24.oe24.__splitArea.article.slideshowVoting', array(
								'slideshow' 	=> $article,
								'isInline'		=> false,
							));
						}
						else {
							// (db) 2017-04-12 Umstellung auf fickity-Slider
							tpl('oe24.oe24.__splitArea.article.slideshowsFlickity', array(
									'slideshow' => $article,
									'imageFormat' => '620x620NoCrop',
							));

							// tpl('oe24.oe24.__splitArea.article.slideshows', array(
							// 		'slideshow' => $article,
							// 		// 'imageVersion' => '620x620',
							// 		// 'imageVersion' => 'storySlideshow',
							// 		'imageVersion' => '620x620NoCrop',
							// 		'showThumbnails' => false,
							// ));
						}?>
					<? endif; ?>
					<? if($author): ?>
						<i>Autor: <?= $author; ?></i>
					<? endif; ?>
				</div>

			</div>

			<div class="article_share">
				<? tpl('oe24.oe24.__splitArea.article.socialInline', array('content' => $article)); ?>
			</div>
            <? if ($showPaidContentMarker) : ?>
            <div class="row paidContent">entgeltliche Einschaltung</div>
            <? endif; ?>
		</article>

        <? //MH 20170411 new Outbrain Integration DAILY-741 ?>

        <?
            // OUTBRAIN PART

            // $allowedChannels = array(
            // 	'news',
            // 	'welt',
            // 	'oesterreich',
            // );
            // $parentChannels = $channel->getParentChannels(true);

            $allowedOverrides = array(
                'oe24',
                'society',
                'sport',
            );
            $layoutOverride = $article->getOptions(true, true)->get('layoutOverride');

            $showOutbrain = false;
            // if (count($parentChannels) > 1 && in_array($parentChannels[1]->getName(), $allowedChannels)) {
            if (in_array($layoutOverride, $allowedOverrides)) {
                $showOutbrain = true;
            }
        ?>
        <? if ($showOutbrain): ?>
            <div class="OUTBRAIN" data-src="<?= $article->getUrl(); ?>" data-widget-id="AR_11" data-ob-template="AT_Oe24.at" ></div>
        <? endif; ?>

         <? if (isset($showComments) && $showComments): ?>
            <? if ('Facebook' === $article->getOptions(true, true)->get('postingType')): ?>
                <section id="fbComment" class="fbComments comments clearfix">
                    <h2 id="commentCounter" itemprop="interactionCount">Posten Sie Ihre Meinung</h2>

                    <div class="hide_postings">
                        <span>Kommentare ausblenden</span>
                        <div class="hidePostingDiv icon icon_arrow3_up"></div>
                    </div>
                    <div class="container_postings fb-comments" data-href="<?= $article->getUrl(); ?>" data-numposts="10" data-colorscheme="light"></div>
                </section>

            <? else: ?>
                <section id="comments" class="comments <?= $commentsNoBorders; ?> clearfix">
                    <? tpl('oe24.oe24.__splitArea.article.comments', array('article' => $article, 'articleCommentsCount' => $articleCommentsCount)); ?>
                </section>
            <? endif; ?>
        <? endif; ?>
       <? //MH END ?>




		<? etpl('oe24.oe24.adition.adSlot',array('channel' => $channel, 'id' => 'ArticleLeft2')); ?>

		<?
		if ($isOe24SlideShow) {
			$relatedArticles = $object->getRelatedStories();
			if ($relatedArticles && count($relatedArticles) > 0) {
				tpl('oe24.oe24.__splitArea.article.oe2016relatedStories', array(
					'relatedArticles' => $relatedArticles,
					'layout'		  => $layout,
				));
			}
		}
		?>

		<? etpl('oe24.oe24.adition.adSlot',array('channel' => $channel, 'id' => 'Left1')); ?>

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
	<div class="sidebar article">
		<?
		// etpl('oe24.oe24.__splitArea.views.tplParts.listArticles', array('contents' => $object->getRelatedStories(), 'headline' => 'Zum Thema', 'showImage' => true, 'showCounter' => false));
		// etpl('oe24.oe24.__splitArea._page.standardColumns', array('columnName' => 'Story-Teaser Area', 'channel' => $channel, 'object' => $object));

		// etpl('oe24.oe24.__splitArea.article.voting', array(
		// 	'channel' => $channel,
		// 	'images' => $images,
		// 	'slideshow' => $article
		// ));

		if (!$isOe24SlideShow) {
			etpl('oe24.oe24.__splitArea.article.relatedStories', array(
					'contents' => $article->getRelatedStories(),
					'boxHeadline' => 'Zum Thema',
					'showNumbers' => false,
					'showImages' => true,
				)
			);
			etpl('oe24.oe24.__splitArea._page.standardColumnsSplitArea', array('columnName' => 'Split-Story-Teaser Area', 'channel' => $channel, 'object' => $article, 'hide' => array()));
		}
		?>

		<? // (ws) 2015-11-24 OE2016-24 Rebrush ?>
		<? if ($isOe24SlideShow): ?>
			<div class="sidebarContainer">
				<?
				// tpl('oe24.oe24.adition.adSlot',array('channel' => $channel, 'id' => 'Contentad1'));
				tpl('oe24.oe24.adition.adSlot',array('channel' => $channel, 'id' => 'Contentad_Sky1'));
				?>
				<?
				// <div style="width:300px;height:250px;background-color:#f00;margin-top:20px"></div>
				?>
				<? tpl('oe24.oe24.adition.adSlot',array('channel' => $channel, 'id' => 'Contentad2')); ?>
			</div>
		<? endif; ?>


	</div>
	<!-- sidebar end -->

	<?
	$jsCollector = spunQ_html::getJsCollector();
	$jsVersion = $jsCollector->getVersion();
	$jsPath = array('oe24.oe24.__splitArea.js.v3.articleObserver');
	?>
	<? if (spunQ::inMode(spunQ::MODE_DEVELOPMENT)): ?>
		<script src="<?= l('oe24.frontend.wormhole.jsStatic', array('js' => $jsPath, 'fileName' => 'articleObserver.js')); ?>"></script>
	<? else: ?>
		<script src="<?= l('spunQ.wormhole.js', array('js' => $jsPath, 'timestamp' => $jsVersion)); ?>"></script>
	<? endif; ?>


</div>
<!-- row end -->

<?
// (bs) 2015-11-24 OE2016-24 Neue Top Gelesen Box
// debug($topGelesenBox);
if ($topGelesenBox && $isOe24SlideShow) {
	tpl($topGelesenBoxTemplate, array(
		'box' => $topGelesenBox,
		'channel' => $channel,
		'column' => $otherColumn,
	));
}

if ($isOe24SlideShow) {
	etpl('oe24.oe24.__splitArea.article.channelTopStoriesWide', array(
		'channel' => $channel,
		'content' => $article,
		'oe2016layouts' => $oe2016layouts,
		'col_count' => 3,
		'row_count' => 2,
	));
}
?>
<?
tpl('oe24.oe24.__splitArea.tpl.row.row_margin', array('position' => 'bottom'));
