<?php

/**
 * Channel Stories Fussball - rl2014
 * @var box oe24.core.ContentBox
 * @var boxTitle string
 * @var drop_areas_content array<any>
 * @var col_count integer
 * @var row_count integer
 * @var max_stories integer
 * @var with_stories boolean
 */

// Verlinkung

// http://sport.oe24.at/fussball/fussball-national/bundesliga
// http://sport.oe24.at/fussball/fussball-national/erste-liga

// http://sport.oe24.at/fussball/fussball-national/bundesliga/wiener-neustadt
// http://sport.oe24.at/fussball/fussball-national/bundesliga/red-bull-salzburg
// http://sport.oe24.at/fussball/fussball-national/bundesliga/austria-wien
// http://sport.oe24.at/fussball/fussball-national/bundesliga/admira-wacker
// http://sport.oe24.at/fussball/fussball-national/bundesliga/wacker-innsbruck
// http://sport.oe24.at/fussball/fussball-national/bundesliga/rapid-wien
// http://sport.oe24.at/fussball/fussball-national/bundesliga/ried
// http://sport.oe24.at/fussball/fussball-national/bundesliga/wac
// http://sport.oe24.at/fussball/fussball-national/bundesliga/mattersburg
// http://sport.oe24.at/fussball/fussball-national/bundesliga/sturm-graz

// $bundesligaUrl = 'http://sport.oe24.at/fussball/fussball-national/bundesliga';
// $ersteligaUrl  = 'http://sport.oe24.at/fussball/fussball-national/erste-liga';

// $vereineBundesliga = array(
// 	'1040' => array(
// 		'name' => 'FK Austria Wien',
// 		'link' => 'http://sport.oe24.at/fussball/fussball-national/bundesliga/austria-wien',
// 	),
// 	'5075' => array(
// 		'name' => 'FC Red Bull Salzburg',
// 		'link' => 'http://sport.oe24.at/fussball/fussball-national/bundesliga/red-bull-salzburg',
// 	),
// 	'1097' => array(
// 		'name' => 'SK Rapid Wien',
// 		'link' => 'http://sport.oe24.at/fussball/fussball-national/bundesliga/rapid-wien',
// 	),
// 	'8015' => array(
// 		'name' => 'SK Puntigamer Sturm Graz',
// 		'link' => 'http://sport.oe24.at/fussball/fussball-national/bundesliga/sturm-graz',
// 	),
// 	'9110' => array(
// 		'name' => 'RZ Pellets WAC',
// 		'link' => 'http://sport.oe24.at/fussball/fussball-national/bundesliga/wac',
// 	),
// 	'4373' => array(
// 		'name' => 'SV Josko Ried',
// 		'link' => 'http://sport.oe24.at/fussball/fussball-national/bundesliga/ried',
// 	),
// 	'4276' => array(
// 		'name' => 'SC Wiener Neustadt',
// 		'link' => 'http://sport.oe24.at/fussball/fussball-national/bundesliga/wiener-neustadt',
// 	),
// 	'6159' => array(
// 		'name' => 'FC Wacker Innsbruck',
// 		'link' => 'http://sport.oe24.at/fussball/fussball-national/bundesliga/wacker-innsbruck',
// 	),
// 	'2201' => array(
// 		'name' => 'FC Admira Wacker Mödling',
// 		'link' => 'http://sport.oe24.at/fussball/fussball-national/bundesliga/admira-wacker',
// 	),
// 	'5029' => array(
// 		'name' => 'SV Scholz Grödig',
// 		'link' => 'http://sport.oe24.at/fussball/fussball-national/bundesliga/groedig',
// 	),
// );

// $vereineErsteliga = array(
// 	'7084' => array(
// 		'name' => 'SV Mattersburg',
// 		'link' => 'http://sport.oe24.at/fussball/fussball-national/bundesliga/mattersburg',
// 	),
// 	'3055' => array(
// 		'name' => 'CASHPOINT SCR Altach',
// 		'link' => '',
// 	),
// 	'3094' => array(
// 		'name' => 'SC Austria Lustenau',
// 		'link' => '',
// 	),
// 	'2622' => array(
// 		'name' => 'SKN St. Pölten',
// 		'link' => '',
// 	),
// 	'8411' => array(
// 		'name' => 'KSV 1919',
// 		'link' => '',
// 	),
// 	'2461' => array(
// 		'name' => 'SV Horn',
// 		'link' => '',
// 	),
// 	'1119' => array(
// 		'name' => 'First Vienna FC 1894',
// 		'link' => '',
// 	),
// 	'8142' => array(
// 		'name' => 'TSV Lopocasport Hartberg',
// 		'link' => '',
// 	),
// 	'7071' => array(
// 		'name' => 'SC/ESV Parndorf 1919',
// 		'link' => '',
// 	),
// 	'5005' => array(
// 		'name' => 'FC Liefering',
// 		'link' => '',
// 	),
// );

$vereineFussball = new VereineFussball();

$imageDirPath = $vereineFussball->getImageDirPath();
$bundesligaUrl = $vereineFussball->getBundesligaUrl();
$ersteligaUrl = $vereineFussball->getBundesligaUrl();
$vereineBundesliga = $vereineFussball->getVereineBundesliga();
$vereineErsteliga = $vereineFussball->getVereineErsteliga();

if (2 == $col_count) {
	$image_format = '292x146NoStretch';
	$image_dimension = 'width="292" height="146"';
	$logo_format =  'col2';
	$logo_dimension = 'width="129" height="21"';
} else {
	$image_format = '190x95NoStretch';
	$image_dimension = 'width="190" height="95"';
	$logo_format =  'col3';
	$logo_dimension = 'width="84" height="14"';
}

$class_marker_with_stories = ($with_stories) ? 'marker_with_stories' : 'marker_no_stories';
$class_marker = ($with_stories) ? 'marker' : '';

// aus dem CMS ??? (Template Option ???)
$class_marker = $class_marker.' fussball';
// $class_marker = $class_marker.' skialpin';

$imageAT_src = lp('image', 'layout/freeHTML/overlay/'.$logo_format.'.jpg');

?>

<div class="col col1 <?=$class_marker.' '.$class_marker_with_stories?>">

	<!--
	<div class="marker <?//=$class_marker?>">
		<h2><span><?//=$boxTitle?></span></h2>
	</div>
	-->

	<?if(true == $with_stories):?>
	<h2><?=$boxTitle?></h2>
	<?endif?>

	<div class="marker_body">

		<div class="tabs_fussball_box">

			<div class="tabs_fussball">
				<a class="fussball_bundesliga" href="#" onclick="toggleLigaTabs(this);return false;">Bundesliga</a>
				<a class="fussball_ersteliga" href="#" onclick="toggleLigaTabs(this);return false;">Erste Liga</a>
			</div>

			<div id="fussball_bundesliga" class="clearfix">
				<?foreach($vereineBundesliga as $k => $v):?>
				<a href="<?= (empty($v['link'])) ? $bundesligaUrl : $v['link']; ?>" title="<?=$v['name']?>">
					<img src="<?slp('image', $imageDirPath.$k.'.png');?>" alt="">
				</a>
				<?endforeach?>
			</div>

			<div id="fussball_ersteliga" class="clearfix">
				<?foreach($vereineErsteliga as $k => $v):?>
				<a href="<?= (empty($v['link'])) ? $ersteligaUrl : $v['link']; ?>" title="<?=$v['name']?>">
					<img src="<?slp('image', $imageDirPath.$k.'.png');?>" alt="">
				</a>
				<?endforeach?>
			</div>

			<script type="text/javascript">
			function toggleLigaTabs(el) {
				var bundesliga = document.getElementById('fussball_bundesliga');
				var ersteliga = document.getElementById('fussball_ersteliga');
				var attrClass = el.getAttribute("class");
				if ("fussball_bundesliga" === attrClass) {
					bundesliga.style.display = 'block';
					ersteliga.style.display = 'none';
				} else {
					bundesliga.style.display = 'none';
					ersteliga.style.display = 'block';
				}
			}
			</script>

		</div>


		<?if ($with_stories):?>


			<? foreach ($drop_areas_content as $key => $content): ?>

				<?

				if (!($content instanceof TextualContent)) {
					continue;
				}

				if ($key >= $max_stories) {
					break;
				}

				$additional_class  = ($col_count-1 == ($key % $col_count)) ? 'last' : '';
				$additional_class .= (0 == ($key % $col_count)) ? ' break' : '';

				$link_attr = getContentUrlAttributesArray($content, $box, true, true, true);

				$link_href = (isset($link_attr['href']) && is_string($link_attr['href'])) ? $link_attr['href'] : '#';
				$link_title = (isset($link_attr['title']) && is_string($link_attr['title'])) ? $link_attr['title'] : '';
				$link_target = (isset($link_attr['target']) && is_string($link_attr['target']) && '' != $link_attr['target']) ? 'target="'.$link_attr['target'].'"' : '';

				$image = $content->getFirstRelatedImage(true, $box);

				// test
				// if (3 == $key) $image = null;
				// test ende

				$image_src = (null !== $image) ? $image->getFileUrl($image_format) : 'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7';

				$preTitle = trim($content->getPreTitle(true, $box));
				$pageTitle = trim($content->getTitle(true, $box));

				$leadText = trim($content->getLeadText(true, true, $box));
				// <br>'s entfernen
				$pattern = '/(<br\ ?\/?>)+/iusU';
				$leadText = preg_replace($pattern, '', $leadText);
				// <h1-6>'s entfernen
				$pattern = '/<h[1-6].*?>(.*?)<\/h[1-6]>/isu';
				$leadText = preg_replace($pattern, '${1}', $leadText);
				// einzelnen Punkt entfernen
				$leadText = trim($leadText, '.');
				// whitespace entfernen
				$leadText = preg_replace('/\s*$/iusU','',$leadText);

				// Ueberpruefen ob content ein Video ist
				$videoClass = '';
				if ($content instanceof Text) {
					$videoClass = $content->getVideoOptions() ? 'video_container' : '';
				} else if ($content instanceof Video) {
					$classVideo = 'video_container';
				}

				$atClass = '';
				if (preg_match('/[www|oe24dev].xn--sterreich-z7a.at/i', $link_href)) {
					$atClass = 'oesterreich_article';
				}

				?>

			<section class="col col<?=$col_count?> channel_box <?=$additional_class?>">
				<a href="<?=$link_href?>" title="<?=$link_title?>" <?=$link_target?>>
					<div class="<?=$videoClass;?> <?=$atClass;?>">

						<?if (!empty($atClass)): ?>
						<?if(isset($_GET['oe24NoLazy'])){?>
							<img src="<?=$imageAT_src?>" alt="" <?=$logo_dimension?> class="oesterreich_logo" />
						<?} else {?>
							<img data-original="<?=$imageAT_src?>" src="/images/empty.gif" alt="" <?=$logo_dimension?> class="oe24Lazy oesterreich_logo" />
						<?}?>
						<?endif; ?>

						<?if(isset($_GET['oe24NoLazy'])){?>
							<img src="<?=$image_src?>" alt="" <?=$image_dimension?> >
						<?} else {?>
							<img data-original="<?=$image_src?>" src="/images/empty.gif" alt="" <?=$image_dimension?> class="oe24Lazy" />
						<?}?>
					</div>
					<strong class="story_pretitle"><?=$preTitle?></strong>
					<h1 class="story_pagetitle"><?=$pageTitle?></h1>
					<?if ('' != $leadText):?>
					<p class="story_leadtext"><?=$leadText?></p>
					<?endif?>
				</a>
			</section>

			<? endforeach ?>

		<?endif;?>

	</div>

</div>
