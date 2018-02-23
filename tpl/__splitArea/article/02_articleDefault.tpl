<?
/**
* Story Site
*
* @var channel oe24.core.Channel
* @var params array<any>
* @var object oe24.core.Text
* @var layout string
*/

//BASIC INFORMATION  ********************************
$article = $object;
$articleId = $article->getId();
$articleOptions = $article->getOptions(true, true);
$layout = $articleOptions->get('layoutOverride');
$articleTeaserAreaColumn = $channel->getColumnByName('Split-Story-Teaser Area');

$isOe2016Article = isOe2016Layout($layout , $article);
$isVideo = (($article->getVideoId() 		 !== NULL ||
			 $article->getVideoOptions() 	 !== NULL ||
			 $article->getLiveVideoOptions() !== NULL) &&
			 $article instanceof Text);
$isVideo = $isVideo || $article instanceof Video;

$isNewsTicker = $article->isNewsticker();

$isDev = (spunQ::inMode(spunQ::MODE_DEVELOPMENT));
// -------------------------------------------

// IMAGES *******************************************
$images = $article->getRelatedImages();
$videos = $article->getRelatedVideos();
$firstVideo = reset($videos);

switch ($layout) {
	case 'madonna':
		$imageFormat = '620x388';
		break;
	default:
		$imageFormat = 'bigStory';
		break;
}

$overlayImage = array_shift($images);

if (null == $overlayImage) {
	$overlayImageSrc = null;
	$overlayImageCopyright = '';
} else {

	$overlayImageArray = array();
	foreach ($images as $key => $image) {
		$copyright = $image->getCopyright();
		$tempArr = array(
			'class' => (0 == $key) ? 'active' : '',
			'imageSrc' => $image->getFileUrl($imageFormat),
			'copyright' => (null != $copyright && '' != $copyright)
				? '© '.$copyright
				: '&nbsp;',
		);

		$overlayImageArray[] = $tempArr;
	}

	$overlayImageSrc = $overlayImage->getFileUrl($imageFormat);
	$overlayAlt = $article->getTitle();
	$overlayCaption = $article->getPreTitle();
	$overlayImageCopyright = '© '.$overlayImage->getCopyright();
}

if ('' == $overlayImageCopyright ||
	'©' == $overlayImageCopyright ||
	'© ' == $overlayImageCopyright) {
	$overlayImageCopyright = '&nbsp;';
}

$overlayAlt = $article->getTitle();
$overlayCaption = $article->getPreTitle();
// -------------------------------------------

// CHECK ADS ****************************************
$showAds = $articleOptions->get('AditionAdTags') !== 'Keine Werbung laden';
$showOutbrain = ($articleOptions->get('hideOutbrain')) ? false : true;
$showLigatus  = $showOutbrain && $isOe2016Article;
if (true == $showLigatus) {
	// ausgenommen bei den folgenden oe2016-layouts###########
	switch ($layout) {
		case 'madonna':
		case 'money':
		case 'business':
			$showLigatus = false;
			break;
	}
}
// -------------------------------------------

// KOMMENTARE *******************************************
$showComments = false;
$showComments = $articleOptions->getByKey('allowPosting');
if ($showComments === null) {
	$showComments = true;
}

if ($hasVideo) {
	$showComments = false;
}

$articleCommentsCount = 0;
$fbCommentsNumberOfPosts = 100;
$postingTemplate = $articleOptions->getByKey('postingTemplate');

$commentsNoBorders = '';
if ('Petition' === $postingTemplate || $isOe2016Article) {
	$commentsNoBorders = 'no_borders';
}

// SOCIAL BUTTONS ****************************************
$hideSocialButtons = false;
$hideSocialButtons = $articleOptions->getByKey('hideSocialButtons');
if ($hideSocialButtons === null) {
	$hideSocialButtons = true;
}

$firstSocial  = (isset($hideSocialButtons) && !$hideSocialButtons && !$isOe2016Article);
$secondSocial = (isset($hideSocialButtons) && !$hideSocialButtons &&  $isOe2016Article);
// -------------------------------------------

// DIV. ANZEIGEN ****************************************
$author = ($articleOptions->getByKey('showAuthor') && $article->getFrontendAuthor())
	? $article->getFrontendAuthor()
	: null;

$videoAutoplay = $articleOptions->getByKey('videoAutoplay');
if ($videoAutoplay === null) {
	$videoAutoplay = true;
}

$showPrintButton = false;
$showPrintButton = $articleOptions->getByKey('print');
if ($showPrintButton === null) {
	$showPrintButton = true;
}

$showMailButton = false;
$showMailButton = $articleOptions->getByKey('mailto');
if ($showMailButton === null) {
	$showMailButton = true;
}

$recipeClass = '';
if ('cooking24' == $layout) {
	$recipeClass = 'wsRecipe';
}

// Breadcrumbs
$icon_house = '&xe603;';
$breadcrumbs = getBreadcrumbsForChannel($channel);
// -------------------------------------------

// GEWINNSPIEL URL ****************************************
$contestUrl = $articleOptions->getByKey('gewinnspielUrl');
$oe24win = 'http://app.oe24.at/oe24win';
$temp = substr($contestUrl, 0, strlen($oe24win));
if ($temp !== $oe24win || filter_var($contenstUrl, FILTER_VALIDATE_URL) === FALSE) {
	$contestUrl = '';
}
// -------------------------------------------

// ARTIKELTEXTS *****************************************
// TODO: sollte hier nicht override sein?
$articleHeadline = $article->getTitle();

// Filter Dev-Stories
$articleHeadline = preg_replace('/^mad.+ - /', '', $articleHeadline);


$articleLeadText = $article->getLeadText(true);

// FIXME
$articleTeaser = $articleLeadText;

// Datum + Uhrzeit: 17. August 2010, 14:16
$articleDateTime = formatDateUsingIntlLangKey('date.long', $article->getFrontendDate()).' '.formatDateUsingIntlLangKey('time.short', $article->getFrontendDate());
// -------------------------------------------
// FIXME
$overrideFolder = ('madonna' === $layout) ? 'madonna' : 'gesund24';
$overrideFolder = $overrideFolder;

$relatedArticles = $object->getRelatedStories();
$relatedSlideshows = $object->getRelatedSlideshows();

// TEXT SECTIONS ****************************************

// Wenn im Artikel, in den TextSections, ein Seitenumbruch gefordert wird, Anzahl der angeklickten Seitenumbrueche herausbekommen
$textSectionPages = ($article->isNewsticker()) ? getTextSectionPages($article) : 0;
$pages = $article->getTotalBodyPages() + $textSectionPages;

// Wird verwendet fuers auslesen fuer mehrere Seiten (umgebrochen mit "<spunQ:pagebreak/>"), oder durch die Seitenumbruch-Checkbox in den TextSections
$bodyTextArray = array();
if ($pages > 1) {

	ArticleTextHelper::transfromTextSections($article, &$bodyTextArray, &$articlePages);

} else {

	// (bs) DAILY - 780 Werbung in den Bodytext injizieren
	// derzeit nicht verwendet
	if (0 && $showAds) {
		$bodyTextArray[] = ArticleTextHelper::getBodyTextWithAdInserted($channel, $article);
	} else {
		$bodyTextArray[] = $article->getBodyText(true, true, $overrideFolder);
	}

	// Bei Newsticker/Liveticker TextSections an den Body anfuegen, ohne Paging.
	if ($isNewsticker) {
		$liveTickerHtml = templateAsString(
			'oe24.oe24.__splitArea.article.articleNewsticker',
			array(
				'article' => $article
			)
		);
		$bodyTextArray[] = $liveTickerHtml;
	}
}

$articleBodyText = implode('', $bodyTextArray);

// -------------------------------------------

// TODO: auslagern

// (bs) 2015-11-03 DAILY-343 Ad Reload
// Wenn ein Referer angegeben wird, soll ein Button ausgespielt werden, der
// den Artikel nochmal lädt.
$showAdReloadButton = (request()->getGetValue('referer') !== NULL);

if ($showAdReloadButton) {
	$firstParagraphPos = strpos($articleBodyText, '</p>') + 4;
	$firstParagraph = substr($articleBodyText, 0, $firstParagraphPos);
	$slicedArticleBodyText = substr($articleBodyText, $firstParagraphPos);
	$secondParagraph = substr($slicedArticleBodyText, 0, strpos($slicedArticleBodyText, '</p>') + 4);
	$adReloadLink = $object->getUrl(true);
	if (NULL === $secondParagraph) {
		$secondParagraph = '';
	}
}

// -------------------------------------------

// Boxen aller linken Tabboxen der Split-Story Teaser Area, die gewisse Templates haben.
// articleBoxes ist ein Array mit Indizes 'fullWidth' und 'articleWidth'
$articleBoxes = BoxGetterHelper::getArticleTeaserBoxes($channel);

// -------------------------------------------

?>

<!-- row start -->
<div class="row <?= $recipeClass; ?>">

	<!-- content start -->
	<div class="content article">

		<article class="article_box">

			<p class="article_date_time"><?=$articleDateTime?></p>

			<? if (null !== $firstVideo): ?>

				<div class="articleTopVideo">
					<?
		                tpl(
		                	'oe24.oe24.__splitArea.tpl.content.videoPlayer',
		                	array(
		                        'content' => $firstVideo,
		                        'area' => 'Story-FirstVideo',
		                        'forceWideScreen' => true,
		                        'forceAutostart' => $videoAutoplay,
		                	)
		                );
					?>
				</div>

			<? elseif ($overlayImageSrc): ?>
				<? if (count($overlayImageArray)>1): ?>
					<? etpl(
							'oe24.oe24.__splitArea.article.slideshowsFlickity',
							array(
								'slideshow' => $article,
								'imageFormat' => $imageFormat
							)
						); ?>
				<? else: ?>

					<div class="overlay_box">

					<? foreach ($overlayImageArray as $key => $overlayImage): ?>
						<img src="<?=s($overlayImage['imageSrc'])?>" alt="<?=$overlayAlt?>" style="display: <?= ($key == 0) ? 'block' : 'none';?>">

						<? if (null !== $overlayCaption && '' !== $overlayCaption): ?>
							<h2 class="caption topOverlayCaption"><?=$overlayCaption?></h2>
						<? endif; ?>

						</div>

						<? if ($overlayImage['copyright']): ?>
							<p class="copyright"><?= $overlayImage['copyright']; ?></p>
						<? endif; ?>
					<? endforeach; ?>
				<? endif; ?>

			<? else: ?>

				<? if (null !== $overlayCaption && '' !== $overlayCaption): ?>
					<h2 class="caption"><?=$overlayCaption?></h2>
				<? endif; ?>

			<? endif; ?>

			<div class="article_box_wrapper">

				<? if ($firstSocial): ?>
					<div class="article_social">
						<? tpl(
							'oe24.oe24.__splitArea.article.social',
							array(
								'content' => $article
								)
							);
						?>
					</div>
				<? endif; ?>


				<? if ($firstVideo && $overlayCaption): ?>
					<h2 class="topOverlayCaption firstVideoCaption">
						<?=$overlayCaption?>
					</h2>
				<? endif; ?>

				<h1>
					<?=$articleHeadline?>
				</h1>

				<div class="service">
					<? if ($showComments): ?>
						<a class="comment" href="#comments">
							<span class="icon icon_comment"></span>
							<span id="commentText">Posten Sie (<?=$articleCommentsCount?>)</span>
						</a>
					<? endif; ?>
					<? if ($showPrintButton): ?>
						<a class="printer" href="<?=$articleId?>/print">
							<span class="icon icon_printer"></span>
						</a>
					<? endif; ?>
					<? if ($showMailButton): ?>
						<a class="mail" href="<?=$articleId?>/mailto">
							<span class="icon icon_mail"></span>
						</a>
					<? endif; ?>

					<ul class="breadcrumbs">
						<? foreach ($breadcrumbs as $key => $item): ?>
							<li>
								<? if ($icon_house == $item['caption']): ?>
									<a href="<?=$item['url']?>"><span class="icon icon_house"></span></a>
								<? else: ?>
								<span>&rsaquo;</span>
								<a href="<?=$item['url']?>">
									<?=$item['caption']?>
								</a>
								<? endif ?>
							</li>
						<? endforeach ?>
					</ul>
					<? if ($secondSocial): ?>
						<div id="addThis addthisSharingToolbox" class="addthis_sharing_toolbox"></div>
					<? endif; ?>
				</div>

				<?
					etpl(
						'oe24.oe24.adition.adSlot',
						array(
							'channel' => $channel,
							'id' => 'ArticleLeft1'
						)
					);
				?>
				<? if($articleTeaser && '' != trim($articleTeaser)): ?>
					<strong class="article_teaser">
						<?=$articleTeaser?>
					</strong>
				<? endif; ?>

				<? if($pages > 1): ?>
					<a name="textBegin"></a>
					<div class="article_pages">
						<?=implode('', $articlePages);?>
					</div>
				<? endif; ?>

				<div class="article_body">

					<?
						etpl(
							'oe24.oe24.adition.adSlot',
							array(
								'channel' => $channel,
								'id' => 'OutstreamAd1'
							)
						);
					?>

					<?
					// Lokales Testen eines outstreamAd:
					// - obiges Template nicht laden (auskommentieren)
					// - dieses Template laden (Kommentar entfernen)
					// etpl('oe24.oe24.dev.adition.outstreamLocalTest', array());
					?>

					<? if ($showAdReloadButton) : ?>
						<?= $firstParagraph; ?>
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
						<? $newsletterRegistration = ($isDev) ? 161625188 : 227144488; ?>
						<? if( $newsletterRegistration == $articleId): ?>
							<?
								// registrierungsformular
								etpl(
									'oe24.oe24.__splitArea.newsletter.registerform',
									array(
										'showDescription' => '1'
									)
								);
							?>
						<? else: ?>
							<?=$articleBodyText;?>
						<? endif; ?>
					<? endif; ?>

					<? if($author):?>
						<i>Autor: <?=$author;?></i>
					<? endif; ?>
				</div>

				<? if ($pages > 1): ?>
					<div class="article_pages">
						<?=implode('', $articlePages);?>
					</div>
				<? endif; ?>

			</div>

			<? if (!empty($contestUrl)): ?>
				<div class="article_contest">
					<iframe id="contestFrame" src="<?=$contestUrl?>" frameborder="0" width="620" height="800" scrolling="no" marginheight="0" marginwidth="0"></iframe>
				</div>
			<? endif; ?>

			<?
			// HTMLBoxen / Reisewerbung
			if ($isOe2016Article) {
				foreach ($articleBoxes['articleWidth'] as $key => $box) {
					tpl(
						$box->getTemplate(),
						array(
							'box' 		=>	$box,
							'channel'	=>	$channel,
							'column'	=>	$articleTeaserAreaColumn,
							'article'	=>  $article
					));
				}
			}
			?>

			<? if (!$hideSocialButtons): ?>
			<div class="article_share">
				<?
					tpl(
						'oe24.oe24.__splitArea.article.socialInline',
						array(
							'content' => $article,
							'layout' => $layout
						)
					);
				?>
			</div>
			<? endif; ?>

			<?
				if ($isOe2016Article && $showAds && $showSocialConnectBox) {
					// (db) 2017-08-29 box newsletter/facebook
					etpl(
						'oe24.oe24.__splitArea.article.socialConnectBox',
						array(
							'channel' => $channel,
							'content' => $article,
							'layout'  => $layout,
						)
					);
				}

				// (db) 2017-10-16 nationalratswahl - ergebnis
				etpl(
					'oe24.oe24.__splitArea.article.nationalratswahl2017Widget',
					array(
						'channel' => $channel,
						'content' => $article
					)
				);
			?>

            <? if ($articleOptions->get('EntgeltlicherContent')) : ?>
            	<div class="row paidContent">Entgeltliche Einschaltung</div>
            <? endif; ?>
		</article>


		<? // (db) Anchor für Posting Button ?>
		<? if ($showComments): ?>
			<a name='comments'></a>
		<? endif ?>

		<?
		if ($isOe2016Article) {
			tpl(
				'oe24.oe24.__splitArea.article.videoAndContentAd',
				array(
					'channel' => $channel
				)
			);
		}
		?>

        <? // OUTBRAIN
        	$allowedOverrides = array(
                'oe24',
                'society',
                'sport',
                'gesund24',
                'madonna',
                'cooking24',
                'money',
                'business',
                'games24',
            );

            if (!in_array($layout, $allowedOverrides) || !$showAds) {
            	$showOutbrain = false;            }
        ?>

        <? if ($showOutbrain): ?>
                <div class="OUTBRAIN" data-src="<?= $article->getUrl(); ?>" data-widget-id="AR_11" data-ob-template="AT_Oe24.at" ></div>
            <? endif; ?>
        <? endif; ?>

        <? if ($showComments): ?>
            <? if ('Facebook' === $articleOptions->get('postingType')): ?>
                <section id="fbComment" class="fbComments comments clearfix">
                    <h2 id="commentCounter" itemprop="interactionCount">Posten Sie Ihre Meinung</h2>

                    <div class="hide_postings">
                        <span>Kommentare ausblenden</span>
                        <div class="hidePostingDiv icon icon_arrow3_up"></div>
                    </div>
                    <div class="container_postings fb-comments" data-href="<?= $article->getUrl(); ?>" data-numposts="<?= $fbCommentsNumberOfPosts; ?>" data-colorscheme="light"></div>
                </section>

            <? else: ?>
                <section id="comments" class="comments <?= $commentsNoBorders; ?> clearfix">
                    <?
                    tpl(
                    	'oe24.oe24.__splitArea.article.comments',
                    	array(
                    		'article' => $article,
                    		'articleCommentsCount' => $articleCommentsCount
                    	)
                    );
                    ?>
                </section>
            <? endif; ?>
        <? endif; ?>

        <? // Related Stories (wenn nicht Outbrain)
	        if ($isOe2016Article) :
	            if (!$showOutbrain):
	                if ($relatedSlideshows && count($relatedSlideshows > 0)) {
	                    $relatedArticles = array_merge($relatedArticles, $relatedSlideshows);
	                }
	                if ($relatedArticles && (count($relatedArticles) > 0)) {
	                    tpl(
	                    	'oe24.oe24.__splitArea.article.oe2016relatedStories',
	                    	array(
		                        'relatedArticles' => $relatedArticles,
		                        'layout'		  => $layout,
	                    	)
	                    );
	                }
	            endif;
	        endif;
        ?>

		<?
			if ('oe24' == $layout) {
				$box = new TemplateBox();

				// Bei der rl2014contentAdStories ist die Box irrelevant,
				// und es gibt Standard-Ad-Positionen,
				// deshalb wird hier eine 'leere' Box genommen
				etpl(
					'oe24.oe24._templateBoxes.rl2014contentAdStories',
					array(
						'channel' => $channel,
						'column'  => $articleTeaserAreaColumn,
						'box'     => $box
					)
				);
			}
		?>
	</div>
	<!-- content end -->

	<!-- sidebar start -->
	<div class="sidebar article">

		<?

		if (!$isOe2016Article)	{
			etpl(
				'oe24.oe24.__splitArea.article.relatedStories',
				array(
					'contents'    => $relatedArticles,
					'boxHeadline' => 'Zum Thema',
					'showNumbers' => false,
					'showImages'  => true,
					'layout'      => $layout,
			));
		}

		// (pj) 2014-11-27 Assoziierte Rezepte wird ausgegeben
		// TODO: hä ?!
		if ('cooking24' != $layout) {
			etpl(
				'oe24.oe24.__splitArea.article.relatedStories',
				array(
					'contents'    => $article->getRelatedRecipes(),
					'boxHeadline' => 'Ähnliche Rezepte',
					'showNumbers' => false,
					'showImages'  => true,
				)
			);
		}
		// (pj) 2014-11-27 END

		if (!$isOe2016Article)	{
			etpl(
				'oe24.oe24.__splitArea.article.relatedStories',
				array(
					'contents'    => $relatedSlideshows,
					'boxHeadline' => 'Mehr Bilder',
					'showNumbers' => false,
					'showImages'  => true,
					'layout'      => $layout,
			));

			etpl(
				'oe24.oe24.__splitArea._page.standardColumnsSplitArea',
				array(
					'columnName' => 'Split-Story-Teaser Area',
					'channel'    => $channel,
					'object'     => $article,
					'hide'       => array()
				)
			);
		}
		?>

		<? // (ws) 2015-11-24 OE2016-24 Rebrush ?>
		<? if ($isOe2016Article): ?>
			<div class="sidebarContainer">

				<?
					tpl(
						'oe24.oe24.__splitArea.article.01_articleDetailSidebar',
						array(
							'channel' => $channel,
							'showAds' => $showAds,
						)
					);
				?>

				<?
					tpl('oe24.oe24.adition.adSlot',
						array(
							'channel' => $channel,
							'id'      => 'Contentad2'
						)
					);
				?>

			</div>
		<? endif; ?>

	</div>
	<!-- sidebar end -->

	<?

	/* COLLECTOR ************************************************************* */


	$jsCollector = spunQ_html::getJsCollector();
	$jsVersion = $jsCollector->getVersion();
	$jsPath = array('oe24.oe24.__splitArea.js.v3.articleObserver');
	?>
	<? if ($isDev): ?>
		<script src="<?= l('oe24.frontend.wormhole.jsStatic', array('js' => $jsPath, 'fileName' => 'articleObserver.js')); ?>"></script>
	<? else: ?>
		<script src="<?= l('spunQ.wormhole.js', array('js' => $jsPath, 'timestamp' => $jsVersion)); ?>"></script>
	<? endif; ?>

</div>
<!-- row end -->

<?

	if ($isOe2016Article) {
		foreach ($articleBoxes['fullWidth'] as $key => $box) {
				tpl(
					$box->getTemplate(),
					array(
						'box' 		=>	$box,
						'channel'	=>	$channel,
						'column'	=>	$articleTeaserAreaColumn,
						'article'   =>  $article,
					)
				);
		}
	}
?>

<?
	tpl(
		'oe24.oe24.__splitArea.tpl.row.row_margin',
		array(
			'position' => 'bottom'
		)
	);
?>

<? /* (db) 2017-04-27 Ligatus-Script direkt einbinden, nach Artikelcontent vor Slider - derzeit noch für alle layouts */ ?>
<? if ($showLigatus): ?>
	<div class="row contentAd">
		<script type="text/javascript" src="https://a-ssl.ligatus.com/?ids=78827&t=js&s=1&bc=2"></script>
	</div>
<? endif; ?>

<?
	etpl(
		'oe24.oe24.__splitArea.article.channelTopStoriesWide',
		array(
			'channel'       => $channel,
			'content'       => $article,
			'oe2016layouts' => $isOe2016Article,
			'col_count'     => 3,
			'row_count'     => 2,
			'object'        => $article,
		)
	);
?>
