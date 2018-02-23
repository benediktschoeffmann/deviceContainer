<?php

/**
 * Channel Stories - rl2014
 * @var box oe24.core.ContentBox
 * @var drop_areas_content array<any>
 * @var col_count integer
 * @var row_count integer
 * @var max_stories integer
 */

if (2 == $col_count) {
	$image_format = '292x146NoStretch';
	$image_format_video = '292x146Crop';
	$image_dimension = 'width="292" height="146"';
	$logo_format =  'col2';
	$logo_dimension = 'width="129" height="21"';
} else {
	$image_format = '190x95NoStretch';	
	$image_format_video = '190x95Crop';
	$image_dimension = 'width="190" height="95"';
	$logo_format =  'col3';
	$logo_dimension = 'width="84" height="14"';
}

// $imageAT_src = lp('image', 'layout/freeHTML/overlay/'.$image_format.'.png');
$imageAT_src = lp('image', 'layout/freeHTML/overlay/'.$logo_format.'.jpg');

// -------------------------------------------

$recipeDefaultImages = array(
	'1a-'.str_replace('NoStretch', '', $image_format).'.jpg',
	'1b-'.str_replace('NoStretch', '', $image_format).'.jpg',
);
$recipeDefaultImagesMax = count($recipeDefaultImages);

?>

<? foreach ($drop_areas_content as $key => $content): ?>

	<?

	$additional_class  = ($col_count - 1 == ($key % $col_count)) ? 'last' : '';
	$additional_class .= (0 == ($key % $col_count)) ? ' break' : '';

	if (!($content instanceof TextualContent)) {

		// (pj) 2014-08-08 Wird für AdPositionen in den ContentStories (tpl/_contentBoxes/rl2014contentStories.tpl) verwendet.
		if (is_array($content) && array_key_exists('adSlotPosition', $content)) {
?>
		<div class="col col<?=$col_count?> channel_box <?=$additional_class?>">
			<? etpl('oe24.oe24.adition.adSlot', array('channel' => $content['channel'], 'id' => $content['adSlotPosition'])); ?>
		</div>
<?
		}
		// (pj) ENDE

		continue;
	}

	if ($key >= $max_stories) {
		break;
	}

	if ($content instanceof Recipe) {
		$duration = $content->getDuration();
		$effort = $content->getEffort(true);
		$price = $content->getPrice(true);
	}

	$link_attr = getContentUrlAttributesArray($content, $box, true, true, true);

	$link_href = (isset($link_attr['href']) && is_string($link_attr['href'])) ? $link_attr['href'] : '#';
	$link_title = (isset($link_attr['title']) && is_string($link_attr['title'])) ? $link_attr['title'] : '';
	$link_target = (isset($link_attr['target']) && is_string($link_attr['target']) && '' != $link_attr['target']) ? 'target="'.$link_attr['target'].'"' : '';

	// (ws) 140804
	// Beispiel: http://ad1.adfarm1.adition.com/redi?sid=2700873&kid=1017356&bid=3399153
	$link_href = str_replace(array('&kid', '&bid'), array('&amp;kid', '&amp;bid'), $link_href);
	// (ws) 140804 end

	

	// (ws) 2014-11-25 Copyright wird nicht angezeigt
	$copyright = '';

	// $preTitle = trim($content->getPreTitle());
	$preTitle = trim($content->getPreTitle(true, $box));

	// (pj) 2014-11-26
	if ($content instanceOf Recipe && !$preTitle) {
		$tags = $content->getTags();
		$tagIds = array_map_property($tags, 'id');
		$boxChannel = $box->getHomeChannel();
		// (pj) 2014-11-27 if-Abfrage, ob es einen HomeChannel gibt
		if ($boxChannel) {
			foreach ($boxChannel->getTags() as $boxTag) {
				if (!in_array($boxTag->getId(), $tagIds)) {
					continue;
				}
				$preTitle = $boxTag->getName();
			}
			if (!$preTitle && isset($tags[0])) {
				$preTitle = $tags[0]->getName();
			}
		}
		// (pj) 2014-11-27 END
	}
	// (pj) 2014-11-26 END

	// $pageTitle = trim($content->getTitle());
	$pageTitle = trim($content->getTitle(true, $box)); // mergeOverride = true (Content-Overwrite-Title), $mergeBox = true (Box-Overwrite-Title)

	// $leadText = trim($content->getLeadText());
	$leadText = trim($content->getLeadText(true, true, $box));
	// <br>'s entfernen
	$pattern = '/(<br\ ?\/?>)+/iusU';
	$leadText = preg_replace($pattern, '', $leadText);
	// <h1-6>'s entfernen
	$pattern = '/<h[1-6].*?>(.*?)<\/h[1-6]>/isu';
	$leadText = preg_replace($pattern, '${1}', $leadText);
	// <p>'s entfernen
	$pattern = '/<p.*?>(.*?)<\/p>/isu';
	$leadText = preg_replace($pattern, '${1}', $leadText);
	// einzelnen Punkt entfernen
	// $leadText = trim($leadText, '.');
	// whitespace entfernen
	$leadText = preg_replace('/\s*$/iusU','',$leadText);
	$leadText = trim(str_replace(array("\n\r","\n","\r"), ' ', $leadText));

	$image = $content->getFirstRelatedImage(true, $box);
	$copyright = (null != $image) ? trim($image->getCopyright()) : 'unbekannt';
	$copyright = '&copy; '.$copyright;


	// Ueberpruefen ob content ein Video ist
	$videoClass = '';
	if ($content instanceOf Recipe) {
		$defaultImage = $recipeDefaultImages[($key % $recipeDefaultImagesMax)];
		$image_src = (null !== $image) ? $image->getFileUrl($image_format) : lp('image', 'rl2014/recipe/defaultImages/'.$defaultImage);
	}

	if ($content instanceof Text) {
		$videoTmp = $content->getRelatedVideos(); 
		$videoClass = $content->getVideoOptions() ? 'video_container' : '';
		if ($videoTmp && !empty($videoTmp)) {
			$videoClass = 'video_container';
		}

		$image_src = (null !== $image) ? $image->getFileUrl($image_format) : 'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7';
	} 

	if ($content instanceof Video) {
		$videoClass = 'video_container';
		$image_src = (null !== $image) ? $image->getFileUrl($image_format_video) : 'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7';
	}

	if ($content instanceof SlideShow) {
		$image_src = (null !== $image) ? $image->getFileUrl($image_format) : 'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7';
	}

	$atClass = '';
	if (preg_match('/[www|oe24dev].xn--sterreich-z7a.at/i', $link_href)) {
		$atClass = 'oesterreich_article';
	}

	if ('' == $videoClass && '' == $atClass) {
		$containerClass = '';
	} else {
		$containerClass = 'class="'.$videoClass.' '.$atClass.'"';
	}


	?>

	<? if ($content instanceOf Recipe) { ?>

	<div class="col col<?=$col_count?> channel_box <?=$additional_class?> recipe">
		<a href="<?=$link_href?>" title="<?=$link_title?>" <?=$link_target?>>
			<div <?=$containerClass;?>>
				<?if(!empty($atClass)): ?>
				<?if(isset($_GET['oe24NoLazy'])){?>
					<img src="<?=$imageAT_src?>" alt="" <?=$logo_dimension?> class="oesterreich_logo" />
				<?} else {?>
					<img data-original="<?=$imageAT_src?>" src="/images/empty.gif" alt="" <?=$logo_dimension?> class="oe24Lazy oesterreich_logo" />
				<?}?>
				<?endif; ?>
				<?if(isset($_GET['oe24NoLazy'])){?>
					<img src="<?=$image_src?>" alt="" <?=$image_dimension?> />
				<?} else {?>
					<img data-original="<?=$image_src?>" src="/images/empty.gif" alt="" <?=$image_dimension?> class="oe24Lazy" />
				<?}?>
			</div>
			<? if (isset($copyright) && '' != $copyright) { ?>
			<p class="story_copyright"><?=$copyright?></p>
			<? } ?>
			<strong class="story_pretitle"><?=$preTitle?></strong>
			<h1 class="story_pagetitle"><?=$pageTitle?></h1>
		</a>
		<div class="recipeInfo">
			<? if ($duration) { ?>
			<p>Zubereitungszeit: <?=$duration?> Min.</p>
			<? } ?>
		</div>
	</div>

	<? } else { ?>

	<div class="col col<?=$col_count?> channel_box <?=$additional_class?>">
		<a href="<?=$link_href?>" title="<?=$link_title?>" <?=$link_target?>>
			<div <?=$containerClass;?>>
				<?if(!empty($atClass)): ?>
				<?if(isset($_GET['oe24NoLazy'])){?>
					<img src="<?=$imageAT_src?>" alt="" <?=$logo_dimension?> class="oesterreich_logo" />
				<?} else {?>
					<img data-original="<?=$imageAT_src?>" src="/images/empty.gif" alt="" <?=$logo_dimension?> class="oe24Lazy oesterreich_logo" />
				<?}?>
				<?endif; ?>
				<?if(isset($_GET['oe24NoLazy'])){?>
					<img src="<?=$image_src?>" alt="" <?=$image_dimension?> />
				<?} else {?>
					<img data-original="<?=$image_src?>" src="/images/empty.gif" alt="" <?=$image_dimension?> class="oe24Lazy" />
				<?}?>
			</div>
			<strong class="story_pretitle"><?=$preTitle?></strong>
			<h1 class="story_pagetitle"><?=$pageTitle?></h1>
			<?if(isset($leadText) && '' != $leadText){?>
			<p class="story_leadtext"><?=$leadText?></p>
			<?}?>
		</a>
	</div>

	<? } ?>

<? endforeach ?>
