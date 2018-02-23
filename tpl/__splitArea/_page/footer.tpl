<?php
/**
 * The footer template for the oe24 project.
 *
 * @var channel oe24.core.Channel
 * @var portal oe24.core.Portal
 * @var layout string
 * @default layout oe24
 * @var object any
 * @default object 0
 * @var navigation any
 * @var oe2016layouts any
 * @var useNewCollector any
 * @default useNewCollector 0
 * @var useNewLayout any
 * @default useNewLayout 0
 */


$isArticle = ($object && $object instanceof TextualContent);
$isOe2016Layout = isOe2016Layout($layout, $isArticle);

$useNewCollector = $useNewCollector && $isOe2016Layout;

// (ws) 2015-01-12
$facebookAppId = '203583476343648';
// (ws) 2015-01-12 end

// $showFacebook = !spunQ::inMode(spunQ::MODE_DEVELOPMENT);
$showFacebook = true;

// ---------------------------------------------------------------------------------------

// (db) 2017-06-12 emarsys-newsletter user recognition
$oNewsletterApi = Oe24NewsletterApi::getInstance();
$newsletterUserEmail = $oNewsletterApi->getNewsletterUserEmail();
$newsletterArticleView = ($object instanceof Text) ? $object->getId() : false;
if ($newsletterArticleView) {
	// zu testzwecken nur diese Artikel zulassen
	switch ($newsletterArticleView) {
		case '287256462':
		case '287122244':
		case '286320078':
			break;

		default:
			$newsletterArticleView = '123456789';
			break;
	}
}
// ---------------------------------------------------------------------------------------

$options = $channel->getOptions(true, true);
if ($object instanceof TextualContent) {
	$options = $object->getOptions(true, true);
}

if (isOverride("antenne", $channel) or isOverride("antenne_wien", $channel)) {
	tpl("oe24.oe24.overrides.antenne.footer", array("portal" => $portal, "channel" => $channel));
} elseif (isOverride("spiele", $channel)) {
	tpl("oe24.oe24.overrides.spiele.footer", array("portal" => $portal, "channel" => $channel));
} else {

	$footerNavigation = $navigation->getFooterNavigation();
	$headerNavigation = $navigation->getHeaderNavigation();
	switch ($layout) {
		case 'oe24':
			if ($navigation instanceof Navigation2014) {
				$nav_footer_template = 'oe24.oe24.__splitArea._page.footer.nav_footer_oe24';
			} else {
				$nav_footer_template = 'oe24.oe24.__splitArea._page.footer.navFooterOe24';
			}

			// if ($useNewLayout === 'oe2016') {
			// 	$nav_footer_template = ' NEW LAYOUT_2016';
			// }
			break;
		case 'gesund24':
			if ($navigation instanceof Navigation2014) {
				$nav_footer_template = 'oe24.oe24.__splitArea._page.footer.nav_footer_gesund24';
			} else {
				$nav_footer_template = 'oe24.oe24.__splitArea._page.footer.navFooterGesund24';
			}
			// (ws) 2015-01-12 - gesund24 hat eine eigene facebook-AppId
			$facebookAppId = '440421566061199';
			// (ws) 2015-01-12 end
			break;
		case 'radiooe24':
		case 'antenne_tirol':
		case 'antenne_salzburg':
			if ($navigation instanceof Navigation2014) {
				$nav_footer_template = 'oe24.oe24.__splitArea._page.footer.nav_footer_radiooe24';
			} else {
				$nav_footer_template = 'oe24.oe24.__splitArea._page.footer.navFooterRadiooe24';
			}
			break;
		case 'madonna':
			if ($navigation instanceof Navigation2014) {
				$nav_footer_template = 'oe24.oe24.__splitArea._page.footer.nav_footer_madonna';
			} else {
				$nav_footer_template = 'oe24.oe24.__splitArea._page.footer.navFooterMadonna';
			}
			break;
		// case 'songcontest':
		// 	if ($navigation instanceof Navigation2014) {
		// 		$nav_footer_template = 'oe24.oe24.__splitArea._page.footer.nav_footer_songcontest';
		// 	} else {
		// 		$nav_footer_template = 'oe24.oe24.__splitArea._page.footer.navFooterSongcontest';
		// 	}
		// 	break;
		case 'cooking24':
			if ($navigation instanceof Navigation2014) {
				$nav_footer_template = 'oe24.oe24.__splitArea._page.footer.nav_footer_oe24';
			} else {
				$nav_footer_template = 'oe24.oe24.__splitArea._page.footer.navFooterOe24';
			}
			// (pj) 2015-02-23 - wirkochen hat eine eigene facebook-AppId
			$facebookAppId = '1547811598841137';
			// (pj) 2015-02-23 end
			break;
		case 'tv':
			if ($navigation instanceof Navigation2014) {
				$nav_footer_template = 'oe24.oe24.__splitArea._page.footer.nav_footer_tv';
			} else {
				$nav_footer_template = 'oe24.oe24.__splitArea._page.footer.navFooterTv';
			}
			break;
		default:
			if ($navigation instanceof Navigation2014) {
				$nav_footer_template = 'oe24.oe24.__splitArea._page.footer.nav_footer_oe24';
			} else {

				$nav_footer_template = 'oe24.oe24.__splitArea._page.footer.navFooterOe24';
			}
			break;
	}

	tpl($nav_footer_template, array(
		'footerNavigation' => $footerNavigation,
		'headerNavigation' => $headerNavigation,
		'layout' => $layout,
		'portal' => $portal,
		'channel' => $channel,
	));

	?>

	</div>
	<!-- #wrap end -->
<?
}
?>

	<!-- Gravity Ad -->
	<!-- // <script type="text/javascript" src="/misc/js/jwplayer.js"></script> -->
	<!-- // <script type="text/javascript" src="/misc/js/jwplayer.html5.js"></script> -->
	<? tpl('oe24.oe24.__splitArea._page.gravity'); ?>
	<!-- Gravity Ad End -->

<?
	if ($useNewCollector) {
		tpl('oe24.oe24.__splitArea._page.oe2016cssJsBottom', array('layout' => $layout));
	} else {
		//getJsAndCssWormhole('css', 'SplitArea', 'footer');
		if (spunQ::inMode(spunQ::MODE_DEVELOPMENT)) {
			getJsAndCssWormhole('js', 'SplitArea', 'preFooter');
			getJsAndCssWormhole('js', 'SplitArea', 'footer');
		} else {
			getJsAndCssWormhole('js', 'SplitArea', 'footerList');
		}

		$jsCollector = spunQ_html::getJsCollector();
		$jsVersion = $jsCollector->getVersion();
		?>
		<script src="<?= l('spunQ.wormhole.js', array('js' => array('_shared.1_0.tracking.oewa.v2.oewaTracking'), 'timestamp' => $jsVersion)); ?>"></script>

		 <script src="<?= l('spunQ.wormhole.js', array('js' => array('_shared.1_0.jwplayer.7_8_7.jwplayer.jwplayer', '_shared.1_0.jwplayer.7_8_7.jwplayerSetup'), 'timestamp' => $jsVersion)); ?>"></script>

		<? /*
		<script src="<?// = l('spunQ.wormhole.js', array('js' => array('_shared.1_0.jwplayer.8_0_11.jwplayer.jwplayer', '_shared.1_0.jwplayer.8_0_11.jwplayerSetup'), 'timestamp' => $jsVersion)); ?>"></script>
		*/
		?>


		<!--[if lt IE 8]>
		<?
			getJsAndCssWormhole('js', 'SplitArea', 'footerIE7');
		?>
		<![endif]-->
		<!--[if lt IE 9]>
		<?
			getJsAndCssWormhole('js', 'SplitArea', 'footerIE8');
		?>
		<![endif]-->
		<?
	}


	// Adition
	etpl('oe24.oe24.adition.adSlot',array('channel' => $channel, 'id' => 'Fixplatzierung'));


	?>

	<? if ('sport' === $layout || 'sport_euro2016' === $layout): ?>

		<?
		etpl('oe24.oe24.__splitArea._page.footer.footerLoadApaSpine',array('channel' => $channel, 'layout' => $layout));
		?>

	<? endif; ?>

	<script type="text/javascript">
	$(document).ready(function() {
		$('.slideshow').oe24slideShow({
			showAds: <?= ($options->get("showGoogleAds") == false) ? "false" : "true"; ?>
		});
	});
	</script>


<?
	$aditionAdTags = $options->get('AditionAdTags');
	$aditionAdTags = (NULL === $aditionAdTags) ? 'Werbung laden' : $aditionAdTags;
?>
	<? if ("Werbung laden" === $aditionAdTags): ?>
		<!-- BEGIN Twyn Targeting -->
		<img src="//et.twyn.com/sense?pubid=154253" width="10" height="1" style="display:none;" alt=""/>
		<!-- END Twyn Targeting -->
	<? endif; ?>


	<!-- BEGIN ChartBeat -->
	<?
		$canonicalUrl = ($object instanceof TextualContent) ? stripDomainFromString($object->getUrl()) : stripDomainFromString($channel->getUrl()).'/';
		$channelDomain = (null === $channel->getDomain(true)) ? "oe24.at" : $channel->getDomain(true);
        if ($options->get('layoutOverride') === 'business'){
            $channelDomain = 'businesslive.at';
        }
	?>
	<script type='text/javascript'>
		var _sf_async_config={};
		/** CONFIGURATION START **/
		_sf_async_config.uid = 57858;
		_sf_async_config.domain = '<?= $channelDomain; ?>';
		_sf_async_config.useCanonical = true;
		_sf_async_config.sections = '<?=$channel->getName();?>';
		_sf_async_config.path = '<?= $channelDomain . $canonicalUrl; ?>';
<?
		// JAVASCRIPT-CODE
		// _sf_async_config.title = ''; // angedacht war "TITEL - ARTIKEL-ID"
		// _sf_async_config.authors = 'Change this to your Author name';    //CHANGE THIS
?>
		/** CONFIGURATION END **/
		(function(){
			function loadChartbeat() {
				window._sf_endpt=(new Date()).getTime();
				var e = document.createElement('script');
				e.setAttribute('language', 'javascript');
				e.setAttribute('type', 'text/javascript');
				e.setAttribute('src', '//static.chartbeat.com/js/chartbeat_video.js');
				document.body.appendChild(e);
			}
			var oldonload = window.onload;
			window.onload = (typeof window.onload != 'function') ?
				loadChartbeat : function() { oldonload(); loadChartbeat(); };
		})();
	</script>
	<!-- END ChartBeat -->


	<? if ($showFacebook) : ?>
	<div id="fb-root"></div>
	<script>
	(function(w, d, s) {
		function go() {
			var js, fjs = d.getElementsByTagName(s)[0],
			load = function(url, id) {
				if (d.getElementById(id)) { return; }
				js = d.createElement(s);
				js.src = url;
				js.id = id;
				fjs.parentNode.insertBefore(js, fjs);
			};

			// (ws) 2015-01-12
			load('//connect.facebook.net/de_DE/sdk.js#xfbml=1&version=v2.4&appId=<?= $facebookAppId; ?>', 'fbjssdk');
			// (ws) 2015-01-12 end

			// (bs) 2017-03-01 DAILY-692 neue FB version
			// load('//connect.facebook.net/de_DE/sdk.js#xfbml=1&version=v2.8appId', 'fbjssdk');
			// (bs) end

			load('//platform.twitter.com/widgets.js', 'tweetjs');
			load('//apis.google.com/js/plusone.js', 'plusone');
			<? // (bs) 2015-11-17 OE2016-24 added oe24 layout ?>
			<? // (bs) 2016-03-17 added money ?>
			<? // (bs) 2016-03-18 added sport ?>
			<? if ('cooking24' === $layout || 'tv' === $layout || 'oe24' === $layout || 'money' === $layout || 'sport' === $layout /*|| 'gesund' === $layout*/): ?>
			load('//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-546c9bf525facb45&domready=1', 'addthis');
			<? endif; ?>

			load('//widgets.outbrain.com/outbrain.js', 'outbrain');

			if (typeof jwplayer != "undefined") {
				window._cbv = window._cbv || [];
				window._cbv.push(jwplayer);
			}
		}
		if (w.addEventListener) {
			w.addEventListener("load", go, false);
		} else if (w.attachEvent) {
			w.attachEvent("onload", go);
		}
	}(window, document, 'script'));
	</script>
	<? endif; ?>

<? /* (bs) 2017-05-30 DAILY-776 GLOMEX-Einbindung */?>

	<script src="https://dx46a7p7ieaml.cloudfront.net/lobster-loader/1/lobster-loader.js"></script>
	<script>
	  var domNode = document.getElementById('glomexCad_1');
	  var domNode2 = document.getElementById('glomexCad_2');

	  if (null !== domNode) {
	  	id = domNode.dataset.glomexid;
	  	glomex.init(domNode, id);
	  }

	  if (null !== domNode2) {
	 	id2 = domNode2.dataset.glomexid;
	  	glomex.init(domNode2, id2);
	  }

	</script>

	<? /* GLOMEX END */ ?>


	<!-- BEGIN KEYWORD TARGETING -->
	<?
		// MH Bugfix DAILY-740
		$adSlots = json_decode($options->get('AditionAdSlots'), true);
		if (is_array($adSlots)) {
			foreach ($adSlots as $adSlot) {
				if (strpos($adSlot['banner'], 'Keywords') !== 0) {
					continue;
				}
				$showKeywords = false;
				$keywords = array($adSlot['keyword']);
				if ($object instanceof TextualContent) {
					if ($adSlot['artikel']) {
						$keywords[] = stripDomainFromString($object->getUrl());
						$showKeywords = true;
					}
				} else {
					if ($adSlot['channel']) {
						$keywords[] = stripDomainFromString($channel->getUrl());
						$showKeywords = true;
					}
				}
	?>
				<? if ($showKeywords) : ?>
				<iframe src="http://ad1.adfarm1.adition.com/banner?sid=<?= $adSlot['id']; ?>&amp;wpt=H&amp;kw=<?= implode('_', $keywords); ?>" width="1" height="1" style="width:1px; height:1px; background-color:transparent; border:none; position: absolute; "></iframe>
				<? endif; ?>
	<?
			}
		}
	?>
	<!-- END KEYWORD TARGETING -->


	<!-- Cookies Overlay -->
	<?
	tpl('oe24.oe24.__splitArea._page.cookiesOverlay', array(
		'layout' => $layout,
	));
	?>
	<!-- Cookies Overlay end -->


	<!-- newStories Overlay -->
	<?
	tpl('oe24.oe24.__splitArea._page.newStoriesOverlay', array(
		'channel' => $channel,
		'layout' => $layout,
		'object' => $object,
	));
	?>
	<!-- newStories Overlay end -->


	<? if ($object instanceof TextualContent && "Werbung laden" === $aditionAdTags): ?>
		<!-- BEGIN Vibrant Tags -->
		<script type="text/javascript" src="http://oe24.at.intellitxt.com/ast/js/oe24/oe24_cs.js"></script>
		<!-- END Vibrant Tags -->
	<? endif; ?>

    <!-- DAILY-741 Xaxis Tag MH 20170411 -->
        <script>
            window.top.xaxParams = window.top.xaxParams || {};
            window.top.xaxParams.CHS = {
                placementID: 11212720,
                segmentURI: '//ad1.adfarm1.adition.com/tagging?type=image&network=1017&tag[Xaxis.footerbidding]',
                type: 'iframe'
            };
        </script>
        <script async src="https://static-tagr.gd1.mookie1.com/s1/sas/lh1/checkSegments.min.js"></script>
    <!-- End Xaxis Tag -->
	<? if ($newsletterUserEmail && $newsletterArticleView): ?>
		<script>
		<!--
			var cartItems = new Array();

			ScarabQueue.push(['setEmail', '<?= $newsletterUserEmail; ?>']);
			//ScarabQueue.push(['cart', cartItems]);

			<? if ($newsletterArticleView): ?>
				ScarabQueue.push(['view', '<?= $newsletterArticleView; ?>']);
			<? endif; ?>
			ScarabQueue.push(['go']);
		//-->
		</script>
	<? endif; ?>

	<!-- DAILY-919 Mindtake -->
	<? $d = new spunQ_Date(); $ts = $d->getTimestamp(); ?>
		<script src="https://t.mindtake.com/tag/cid/9C0R4/trace.js?Publisher=Oesterreich&uid=<?= $ts;?>" type="text/javascript" async></script>
	<!-- DAILY-919 end -->
</body>
</html>
