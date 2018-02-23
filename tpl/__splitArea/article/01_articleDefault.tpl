<?
/**
* Story Site
*
* @var channel oe24.core.Channel
* @var params array<any>
* @var object oe24.core.Text
* @var layout string
* @var oe2016layouts array<string>
*/

// Oe24Benchmarker::getInstance()->setCheckPoint("oe24.__splitArea.article.articleDefault start");
// -------------------------------------------

$article = $object;
$articleId = $article->getId();

$parentChannels = $channel->getParentChannels();

// -------------------------------------------

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

// Overlay

$images = $article->getRelatedImages();
$videos = $article->getRelatedVideos();
$firstVideo = reset($videos);

// (ws) 2015-02-23
// $imageFormat = 'bigStory';
switch ($layout) {
	case 'madonna':
		$imageFormat = '620x388';
		break;
	default:
		$imageFormat = 'bigStory';
		break;
}
// (ws) 2015-02-23 //



$overlayDimension = ''; // width="620" height="250"';
$overlayImage = (isset($images[0])) ? $images[0] : null;

// Test
// $overlayImage = null;
// Test end

if (null == $overlayImage) {
	$overlayImageSrc = null; // 'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7';
	$overlayImageCopyright = '';
} else {

	$overlayImageArray = array();

	foreach ($images as $key => $image) {
		$copyright = $image->getCopyright();
		$tempArr = array(
			'class' => (0 == $key) ? 'active' : '',
			'imageSrc' => $image->getFileUrl($imageFormat),
			'copyright' => (null != $copyright && '' != $copyright) ? '© '.$copyright : '&nbsp;',
		);

		$overlayImageArray[] = $tempArr;
	}

	$overlayImageSrc = $overlayImage->getFileUrl($imageFormat);
	$overlayAlt = $article->getTitle();
	$overlayCaption = $article->getPreTitle();
	$overlayImageCopyright = '© '.$overlayImage->getCopyright();
}

if ('' == $overlayImageCopyright || '©' == $overlayImageCopyright || '© ' == $overlayImageCopyright) {
	$overlayImageCopyright = '&nbsp;';
}

debug($overlayImageArray);

$overlayAlt = $article->getTitle();
$overlayCaption = $article->getPreTitle();

// Test
// $overlayCaption = null;
// Test end

// -------------------------------------------

// (ws) 140605
// Datum + Uhrzeit: 17. August 2010, 14:16
$articleDateTime = formatDateUsingIntlLangKey('date.long', $article->getFrontendDate()).' '.formatDateUsingIntlLangKey('time.short', $article->getFrontendDate());
// (ws) 140605 ENDE

// -------------------------------------------

// Service
// $articleComments = $article->getComments();
// $articleCommentsCount = count($articleComments);
$articleCommentsCount = 0;

// -------------------------------------------

// Body
$articleHeadline = $article->getTitle();
$articleTeaser = $article->getLeadText(true);

// (pj) INFORMATION
// ToDo:
// statt gesund24 vl. einen anderen override-ordner angeben
// betrifft die spunQ-Tags, welche aufgeloest werden
// mit 'gesund24' werden die spunQ-Tags fuers neue Layout bereitgestellt
// sollte fuers erste funktionieren, wenn ein artikel fuer ne andere domain anders aussehen sollte, waere hier eine andere Loesung optimal.
$load_article_layout = ('madonna' === $layout) ? 'madonna' : 'gesund24';

// Wenn im Artikel, in den TextSections, ein Seitenumbruch gefordert wird, Anzahl der angeklickten Seitenumbrueche herausbekommen
$textSectionPages = 0;
if ($article->isNewsticker()) {
	$textSectionPages = getTextSectionPages($article);
}

// (pj) Start
// Wird verwendet fuers auslesen fuer mehrere Seiten (umgebrochen mit "<spunQ:pagebreak/>"), oder durch die Seitenumbruch-Checkbox in den TextSections
$pages = $article->getTotalBodyPages() + $textSectionPages;
if ($pages > 1) {

	$pageBodyText = $article->getPagedBodyText(true, true, $load_article_layout);
	$bodyTextArr = array();
	$articlePages[] = 'Seiten: ';
	$page = 1;
	// BodyText Seiten durchgehen, mind. 1x
	foreach ($pageBodyText as $bodyText) {
		$style = (0 === count($bodyTextArr)) ? '' : 'style="display: none;"';
		$class = (0 === count($bodyTextArr)) ? 'active' : '';
		$bodyTextArr[] = '<div class="article_page_body" ' . $style .'>' . $bodyText . '</div>';
		$articlePages[] = '<a class="' . $class . ' js-oewaLink" onclick="pager.gotoPage(' . $page . '); oe24Tracking.loadOewa(); oe24Tracking.googleAnalyticsRefreshTracking();" href="#textBegin">' . $page . '</a>';
		// $articlePages[] = '<a ' . $class . ' data-var="' . $page . '" href="#textBegin">' . $page . '</a>';
		++$page;
	}

	// TextSection Seiten hinzufuegen, falls vorhanden
	while ($pages >= $page) {
		$articlePages[] = '<a class="js-oewaLink" onclick="pager.gotoPage(' . $page . '); oe24Tracking.loadOewa(); oe24Tracking.googleAnalyticsRefreshTracking();" href="#textBegin">' . $page . '</a>';
		++$page;
	}

	// Wenn Artikel ein Newsticker/Liveticker ist
	if ($article->isNewsticker()) {

		$liveTickerHtml = templateAsString('oe24.oe24.__splitArea.article.articleNewsticker', array('article' => $article));

		// Regex fuer TextSectionen, erstes Paging-Element suchen (<div class="article_page_body article_ticker").
		$textSectionRegex = '/<div\sclass="article_page_body\sarticle_ticker".*$/s';
		preg_match_all($textSectionRegex, $liveTickerHtml, $matches);

		// die oberen TextSections rausfiltern, die noch zum bodyText dazugehoeren sollen
		if (0 < count($matches) && 0 < count($matches[0])) {
			$pageTicker = strpos($liveTickerHtml, $matches[0][0]);
			$firstTickerPart = substr($liveTickerHtml, 0, $pageTicker);

			// firstTickerPart auf vorige Seite schreiben und den rest (matches[0][0]) dranhaengen, hier kommt das paging schon aus der articleNewsticker.tpl
			$bodyTextCount = count($bodyTextArr)-1;
			$bodyTextArr[$bodyTextCount] = '<div class="article_page_body" ' . $style .'>' . $bodyText . $firstTickerPart . '</div>';
			$bodyTextArr[] = $matches[0][0];
		} else {
			$bodyTextCount = count($bodyTextArr)-1;
			$bodyTextArr[$bodyTextCount] = '<div class="article_page_body" ' . $style .'>' . $bodyText . $liveTickerHtml . '</div>';
		}

	}

} else {

	$bodyTextArr[] = $article->getBodyText(true, true, $load_article_layout);

	// Wenn Artikel ein Newsticker/Liveticker ist, TextSections an den Body anfuegen, ohne Paging.
	if ($article->isNewsticker()) {
		$liveTickerHtml = templateAsString('oe24.oe24.__splitArea.article.articleNewsticker', array('article' => $article));
		$bodyTextArr[] = $liveTickerHtml;
	}

}
$articleBodyText = implode('', $bodyTextArr);

// (pj) ENDE

// -------------------------------------------

// Red. wuenscht keinen Copyright-Vermerk
// $overlayImageCopyright = null; // 2014-06-05 Images, Videos doch mit Copyright

//Autor anzeigen MH
$author = ($article->getOptions(true, true)->getByKey("showAuthor") && $article->getFrontendAuthor()) ? $article->getFrontendAuthor() : NULL;

//Video Autostart MH
$videoAutoplay = $article->getOptions(true, true)->getByKey("videoAutoplay");
if ($videoAutoplay === null) {
	$videoAutoplay = true;
}

// Kommentare anzeigen
$showComments = $article->getOptions(true, true)->getByKey("allowPosting");
if ($showComments === null) {
	$showComments = true;
}

if ($article instanceof Text && ($article->getVideoId() !== NULL || $article->getVideoOptions() !== NULL || $article->getLiveVideoOptions() !== NULL)) {
	$showComments = false; // zum ausblenden der Kommentare bei Videoartikeln.
}

$commentsNoBorders = '';
$postingTemplate = $article->getOptions(true, true)->getByKey('postingTemplate');

// (bs) OE2016-24 2015-11-17 adding the OR part
if ('Petition' === $postingTemplate || in_array($layout, $oe2016layouts)) {
	$commentsNoBorders = 'no_borders';
}

// Hide Social Buttons
$hideSocialButtons = $article->getOptions(true, true)->getByKey("hideSocialButtons");
if ($hideSocialButtons === null) {
	$hideSocialButtons = true;
}

$firstSocial = (isset($hideSocialButtons) && !$hideSocialButtons && !(in_array($layout, $oe2016layouts)));
$secondSocial = (isset($hideSocialButtons) && !$hideSocialButtons && (in_array($layout, $oe2016layouts)));

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

// kein Mailen, Drucken und keine Breadcrums auf WirKochen.at
$recipeClass = '';
if ('cooking24' == $layout) {
	$recipeClass = 'wsRecipe';
}

//Prüfen ob entgeltlicher Content
$showPaidContentMarker = $article->getOptions(true, true)->get('EntgeltlicherContent');
if ($showPaidContentMarker == null) {
        $showPaidContentMarker = false;
}
// Fuer Gewinnspiele die URL auslesen
$contestUrl = $article->getOptions(true, true)->getByKey("gewinnspielUrl");

// Pruefung auf gueltige Domain + oe24win
$oe24win = 'http://app.oe24.at/oe24win';
$temp = substr($contestUrl, 0, strlen($oe24win));
if ($temp !== $oe24win) {
	$contestUrl = '';
}

// Pruefen, ob die URL gueltig ist
if ('' !== $contestUrl) {
	$browser = spunQ_HttpBrowser::createRequest($contestUrl);
	try {
		$response = $browser->send();
		$pos = strpos($response->getBody(), '<title>Fehler</title>');
		if ($pos && $pos >= 0) {
			$contestUrl = '';
		}
	} catch (Exception $e) {
		$contestUrl = '';
	}
}


//Show Outbrain als globale Variable MH 20170411 DAILY-741
$showOutbrain = false;

// -------------------------------------------

// $layout = 'oe24';

// tpl('oe24.oe24.__splitArea.article.articleDefault2', array('channel' => $channel, 'article' => $article));
// return;

// Wird verwendet zu unterscheiden ob die TopStories innerhalb des Content-Bereichs oder unterhalb des Artikels ueber die gesamte Seitenbreite ausgespielt werden.
// $useChannelTopStoriesWide = true;

// Dev-Stories
$articleHeadline = preg_replace('/^mad.+ - /', '', $articleHeadline);
// Dev-Stories //


// (bs) 2015-11-03 DAILY-343 Ad Reload
// Wenn ein Referer angegeben wird, soll ein Button ausgespielt werden, der
// den Artikel nochmal lädt.
$showAdReloadButton = (request()->getGetValue('referer') !== NULL);

if ($showAdReloadButton) {
	$firstParagraphPos = strpos($articleBodyText, '</p>') + 4;
	$firstParagraph = substr($articleBodyText, 0, $firstParagraphPos);
	$slicedArticleBodyText = substr($articleBodyText, $firstParagraphPos);
	$secondParagraph = substr($slicedArticleBodyText, 0, strpos($slicedArticleBodyText, '</p>') + 4);
	$adReloadLink = $object->getUrl();
	if (NULL === $secondParagraph) {
		$secondParagraph = '';
	}
}
// (bs) end

// (bs) 2016-03-09 Alle Boxen der linken Seite mit dem TV Default Content Box Template in der Split-Story-Teaser Area sollen angezeigt werden.
// (pj) 2016-04-19 ueberarbeitet
$otherColumn = $channel->getColumnByName('Split-Story-Teaser Area');
$boxesFullWidth = array();
$boxesArticleWidth = array();
if ($otherColumn) {
	$boxes = $otherColumn->getBoxes();
	foreach ($boxes as $key => $box) {

		if (! $box instanceof TabbedBox) {
			continue;
		}

		$tabItems = $box->getTabbedBoxItems();
		if (empty($tabItems)) {
			continue;
		}

		// wir wollen nur die Boxen der linken Seite
		$leftTabBoxes = $tabItems[0]->getBoxes();
		if (empty($leftTabBoxes)) {
			continue;
		}

		// Filter alle Boxen heraus, die das gewünschte Template haben.
		$fullWidthBoxes = array_filter($leftTabBoxes, function ($a) {
			$validTemplates = array(
				'oe24.oe24._contentBoxes.rl2014oe24TvDefaultContentBox',
				'oe24.oe24._contentBoxes.oe2016standardContentSlider',
			);
			$isValid = false;
			foreach ($validTemplates as $validTemplate) {
				if ($a->getTemplate() == $validTemplate) {
					$isValid = true;
				}
			}
			return $isValid;
		});
		$articleWidthBoxes = array_filter($leftTabBoxes, function ($a) {
			$validTemplates = array(
				'oe24.oe24._htmlBoxes.defaultHtmlBox',
			);
			$isValid = false;
			foreach ($validTemplates as $validTemplate) {
				if ($a->getTemplate() == $validTemplate) {
					$isValid = true;
				}
			}
			return $isValid;
		});
		$boxesFullWidth = array_merge($boxesFullWidth, $fullWidthBoxes);
		$boxesArticleWidth = array_merge($boxesArticleWidth, $articleWidthBoxes);
	}
}
// (pj) 2016-04-19 end

?>
<!-- row start -->
<div class="row <?= $recipeClass; ?>">

	<!-- content start -->
	<div class="content article">

		<article class="article_box">

			<p class="article_date_time"><?=$articleDateTime?></p>

			<? if (false !== $firstVideo): ?>

				<div class="articleTopVideo">
					<?
		                tpl('oe24.oe24.__splitArea.tpl.content.videoPlayer', array(
	                        'content' => $firstVideo,
	                        'area' => 'Story-FirstVideo',
	                        'forceWideScreen' => true,
	                        'forceAutostart' => $videoAutoplay,
		                ));
					?>
				</div>

			<? elseif ($overlayImageSrc): ?>

				<? if (1): ?>
					<div class="overlay_box">

						<? foreach($overlayImageArray as $key => $overlayImage): ?>
						<img src="<?=s($overlayImage['imageSrc'])?>" alt="<?=$overlayAlt?>" style="display: <?= ($key == 0) ? 'block' : 'none';?>">
						<? endforeach; ?>

						<? if (count($overlayImageArray) > 1): ?>
						<div class="arrowContainer arrowContainerLeft">
							<a class="js-oewaLink arrow arrowLeft unselectable icon icon_arrow3_left"></a>
						</div>
						<div class="arrowContainer arrowContainerRight">
							<a class="js-oewaLink arrow arrowRight unselectable icon icon_arrow3_right"></a>
						</div>
						<? endif; ?>

						<? if (null !== $overlayCaption && '' !== $overlayCaption): ?>
						<h2 class="caption topOverlayCaption"><?=$overlayCaption?></h2>
						<? endif; ?>

						<? //if (null !== $overlayImageCopyright && '' !== $overlayImageCopyright): ?>
						<!-- <span class="copyright"><?//=$overlayImageCopyright?></span> -->
						<? //endif; ?>

					</div>

					<? foreach($overlayImageArray as $key => $overlayImage): ?>
					<p class="article_box_top_copyright <?=$overlayImage['class']?>"><?=$overlayImage['copyright']?></p>
					<? endforeach; ?>

					<? //if (null !== $overlayImageCopyright && '' !== $overlayImageCopyright): ?>
					<!-- <p class="copyright"><?//=$overlayImageCopyright?></p> -->
					<? //endif; ?>
				<? endif; ?>

				<? if (0): ?>
						<? if (count($overlayImageArray)>1): ?>
							<? etpl('oe24.oe24.__splitArea.article.slideshowsFlickity', array('slideshow' => $article, 'imageFormat' => $imageFormat)); ?>
						<? else: ?>

							<div class="overlay_box">

							<? foreach($overlayImageArray as $key => $overlayImage): ?>
								<img src="<?=s($overlayImage['imageSrc'])?>" alt="<?=$overlayAlt?>" style="display: <?= ($key == 0) ? 'block' : 'none';?>">

								<? if (null !== $overlayCaption && '' !== $overlayCaption): ?>
									<h2 class="caption topOverlayCaption"><?=$overlayCaption?></h2>
								<? endif; ?>

								</div>
								<? if ($overlayImage['copyright']): ?>
									<p class="copyright">© <?= $overlayImage['copyright']; ?></p>
								<? endif; ?>
							<? endforeach; ?>
						<? endif; ?>
				<? endif; ?>

			<? else: ?>

				<? if (null !== $overlayCaption && '' !== $overlayCaption): ?>
				<h2 class="caption"><?=$overlayCaption?></h2>
				<? endif; ?>

			<? endif; ?>

			<div class="article_box_wrapper">


				<? if ($firstSocial): // (bs) 2015-11-17 hide sticky social things ?>
				<div class="article_social">
					<? tpl('oe24.oe24.__splitArea.article.social', array('content' => $article)); ?>
				</div>
				<? endif; ?>


				<? if ($firstVideo && $overlayCaption): ?>
				<h2 class="topOverlayCaption firstVideoCaption"><?=$overlayCaption?></h2>
				<? endif; ?>


				<h1><?=$articleHeadline?></h1>

				<div class="service">
					<? if (isset($showComments) && true == $showComments): ?>
					<a class="comment" href="#comments">
						<span class="icon icon_comment"></span>
						<span id="commentText">Posten Sie (<?=$articleCommentsCount?>)</span>
					</a>
					<? endif; ?>
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
					<? if ($secondSocial): ?>
						<div id="addThis addthisSharingToolbox" class="addthis_sharing_toolbox"></div>
					<? endif; ?>
				</div>

				<? etpl('oe24.oe24.adition.adSlot',array('channel' => $channel, 'id' => 'ArticleLeft1')); ?>
				<? if($articleTeaser && '' != trim($articleTeaser)): ?>
				<strong class="article_teaser"><?=$articleTeaser?></strong>
				<? endif; ?>

				<? if($pages > 1): ?>
				<a name="textBegin"></a>
				<div class="article_pages">
					<?=implode('', $articlePages);?>
				</div>
				<? endif; ?>

				<div class="article_body">

					<? etpl('oe24.oe24.adition.adSlot', array('channel' => $channel, 'id' => 'OutstreamAd1')); ?>

					<?
					// Lokales Testen eines outstreamAd:
					// - obiges Template nicht laden (auskommentieren)
					// - dieses Template laden (Kommentar entfernen)
					// etpl('oe24.oe24.dev.adition.outstreamLocalTest', array());
					?>

					<? if ($showAdReloadButton) : ?>
						<?=$firstParagraph;?>
						<div class="transparencyWrapper">
							<span class="adReloadReadMore">
								<?=$secondParagraph;?>
							</span>
						</div>
						<div class="service adReloadButton">
							<a class="comment" href="<?=$adReloadLink;?>">
								<span>Ganzen Artikel anzeigen</span>
							</a>
						</div>
					<? else : ?>
						<?=$articleBodyText;?>
					<? endif; ?>
					<? if($author):?>
						<i>Autor: <?=$author;?></i>
					<? endif; ?>
				</div>

				<? if($pages > 1): ?>
				<div class="article_pages">
					<?=implode('', $articlePages);?>
				</div>
				<? endif; ?>

			</div>

			<? if(!empty($contestUrl)): ?>
			<div class="article_contest">
				<iframe id="contestFrame" src="<?=$contestUrl?>" frameborder="0" width="620" height="800" scrolling="no" marginheight="0" marginwidth="0"></iframe>
			</div>
			<? endif; ?>

			<?
			// (pj) 2016-04-19 fuer Sport gewuenscht, dass HTML-Boxen hier rein kommen sollen
            // MH 20170407 Position change for Outbrain
			if (in_array($layout, $oe2016layouts)) {
				foreach ($boxesArticleWidth as $key => $box) {
					tpl($box->getTemplate(), array(
						'box' 		=>	$box,
						'channel'	=>	$channel,
						'column'	=>	$channel->getColumnByName('Split-Story-Teaser Area'),
					));
				}
			}
			// (pj) 2016-04-19 end
			?>

			<? if(!$hideSocialButtons): ?>
			<div class="article_share">
				<? tpl('oe24.oe24.__splitArea.article.socialInline', array('content' => $article, 'layout' => $layout)); ?>
			</div>
			<? endif; ?>

            <? if ($showPaidContentMarker) : ?>
            <div class="row paidContent">entgeltliche Einschaltung</div>
            <? endif; ?>
		</article>

		<?
		// if (!$useChannelTopStoriesWide) {
			// etpl('oe24.oe24.__splitArea.article.channelTopStoriesSmall', array('channel' => $channel, 'content' => $article, 'col_count' => 3, 'row_count' => 2));
		// }
		?>

		<? // (bs) 2015-11-23 OE2016-24 ?>

		<? // (db) 2017-03-13 Posting-Button benötigt ein Ziel ?>
		<? if (isset($showComments) && $showComments): ?>
			<a name='comments'></a>
		<? endif ?>
		<? // (db) 2017-03-13 end ?>

		<?
		if (in_array($layout, $oe2016layouts)) {
			// (pj) 2015-12-14 niki wuenscht sich an dieser position links das "News TV"-Video und rechts ein Contentad
			tpl('oe24.oe24.__splitArea.article.videoAndContentAd', array('channel' => $channel));
			// (pj) 2015-12-14 end
		}
		?>

        <? //MH 20170407 OUTBRAIN Integration ?>
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
                'gesund24',
                'madonna',
                'cooking24',
                'money',
            );
            $layoutOverride = $article->getOptions(true, true)->get('layoutOverride');

            $showOutbrain = false;
            // if (count($parentChannels) > 1 && in_array($parentChannels[1]->getName(), $allowedChannels)) {
            if (in_array($layoutOverride, $allowedOverrides)) {
                $showOutbrain = true;
            }
        ?>
        <? if ($showOutbrain):
            if ($article->isNewsticker()): ?>
                <div class="OUTBRAIN" data-src="<?= $article->getUrl(); ?>" data-widget-id="AR_11" data-ob-template="AT_Oe24.at" ></div>
            <? else: ?>
                <div class="OUTBRAIN" data-src="<?= $article->getUrl(); ?>" data-widget-id="AR_11" data-ob-template="AT_Oe24.at" ></div>
            <? endif; ?>
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

		<?
		// wenn layout == 'gesund24' -> nur Left2, wenn Outbrain aktiv dann kein Left 3 MH 20170411 DAILY-741
		if ('gesund24' == $layout || $showOutbrain) {
			etpl('oe24.oe24.adition.adSlot',array('channel' => $channel, 'id' => 'ArticleLeft2'));
		} else {
			etpl('oe24.oe24.adition.adSlot',array('channel' => $channel, 'id' => 'ArticleLeft2'));
			etpl('oe24.oe24.adition.adSlot',array('channel' => $channel, 'id' => 'ArticleLeft3'));
		}
		?>

       <? //MH 20170411 Related Stories nur wenn kein Outbrain
       if (in_array($layout, $oe2016layouts)) :
            if (false == $showOutbrain):
                    $relatedArticles = $object->getRelatedStories();
                    $relatedSlideshows = $object->getRelatedSlideshows();
                    if ($relatedSlideshows && count($relatedSlideshows > 0)) {
                        $relatedArticles = array_merge($relatedArticles, $relatedSlideshows);
                    }
                    if ($relatedArticles && count($relatedArticles) > 0) {
                        tpl('oe24.oe24.__splitArea.article.oe2016relatedStories', array(
                            'relatedArticles' => $relatedArticles,
                            'layout'		  => $layout,
                        ));
                    }
            endif;
        endif;
        //MH End
        ?>



		<?
		// wenn layout == 'oe24' -> zeige CPCBox wie auf Startseite im Politik Bereich
		if ('oe24' == $layout) {
			$box = new TemplateBox();
			etpl('oe24.oe24._templateBoxes.rl2014contentAdStories', array(
				'channel' => $channel,
				'column' => $channel->getColumnByName('Split-Story-Teaser Area'),
				'box' => $box)
			);
		}
		// wenn layout == 'gesund24' -> nur Left3
		if ('gesund24' == $layout) {
			etpl('oe24.oe24.adition.adSlot',array('channel' => $channel, 'id' => 'ArticleLeft3'));
		} else {
			etpl('oe24.oe24.adition.adSlot',array('channel' => $channel, 'id' => 'ArticleLeft4'));
			etpl('oe24.oe24.adition.adSlot',array('channel' => $channel, 'id' => 'ArticleLeft5'));
		}
		if ('gesund24' != $layout) {
			// etpl("oe24.oe24.story.plistaAd", array("text" => $article));
		}
		?>
	</div>
	<!-- content end -->

	<!-- sidebar start -->
	<div class="sidebar article">

		<?

		// etpl('oe24.oe24.__splitArea.views.tplParts.listArticles', array('contents' => $object->getRelatedStories(), 'headline' => 'Zum Thema', 'showImage' => true, 'showCounter' => false));
		// etpl('oe24.oe24.__splitArea._page.standardColumns', array('columnName' => 'Story-Teaser Area', 'channel' => $channel, 'object' => $object));
		//Oe24Benchmarker::getInstance()->setCheckPoint("oe24.__splitArea.article.articleDefault sidebar start");

		if (!in_array($layout, $oe2016layouts))	{
			etpl('oe24.oe24.__splitArea.article.relatedStories', array(
					'contents' => $article->getRelatedStories(),
					'boxHeadline' => 'Zum Thema',
					'showNumbers' => false,
					'showImages' => true,
					'layout' => $layout,
			));
		}

		// (pj) 2014-11-27 Assoziierte Rezepte wird ausgegeben
		if ('cooking24' != $layout) {
			etpl('oe24.oe24.__splitArea.article.relatedStories', array(
					'contents' => $article->getRelatedRecipes(),
					'boxHeadline' => 'Ähnliche Rezepte',
					'showNumbers' => false,
					'showImages' => true,
			));
		}
		// (pj) 2014-11-27 END

		if (!in_array($layout, $oe2016layouts))	{
			etpl('oe24.oe24.__splitArea.article.relatedStories', array(
					'contents' => $article->getRelatedSlideshows(),
					'boxHeadline' => 'Mehr Bilder',
					'showNumbers' => false,
					'showImages' => true,
					'layout' => $layout,
			));
		}

		if (!in_array($layout, $oe2016layouts))	{
			etpl('oe24.oe24.__splitArea._page.standardColumnsSplitArea', array(
				'columnName' => 'Split-Story-Teaser Area',
				'channel' => $channel,
				'object' => $article,
				'hide' => array()
			));
		}

		//Oe24Benchmarker::getInstance()->setCheckPoint("oe24.__splitArea.article.articleDefault sidebar end");

		?>

		<? // (ws) 2015-11-24 OE2016-24 Rebrush ?>
		<? if (in_array($layout, $oe2016layouts)): ?>
			<div class="sidebarContainer">

				<? tpl('oe24.oe24.__splitArea.article.articleDetailSidebar',array('channel' => $channel)); ?>

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
// (bs) 2016-03-09 neue top gelesen Box Logik
if (in_array($layout, $oe2016layouts)) {
	foreach ($boxesFullWidth as $key => $box) {
		tpl($box->getTemplate(), array(
			'box' 		=>	$box,
			'channel'	=>	$channel,
			'column'	=>	$channel->getColumnByName('Split-Story-Teaser Area'),
		));
	}
}
?>

<? tpl('oe24.oe24.__splitArea.tpl.row.row_margin', array('position' => 'bottom')); ?>

<?
// (pj) 2015-12-14 Es wurde eine neue Position verkauft, die wird ueber ArticleLeft6 ausgespielt.
if (in_array($layout, $oe2016layouts)) {
	etpl('oe24.oe24.adition.adSlot',array('channel' => $channel, 'id' => 'ArticleLeft6'));
}
// (pj) 2015-12-14 end
?>

<?
// if ($useChannelTopStoriesWide): // (ws) 140731
etpl('oe24.oe24.__splitArea.article.channelTopStoriesWide', array(
	'channel' => $channel,
	'content' => $article,
	'oe2016layouts' => $oe2016layouts,
	'col_count' => 3,
	'row_count' => 2,
));
// endif;
?>

