<?
/**
 * content box
 * @var channel oe24.core.Channel
 * @var box oe24.core.ContentBox
 */

// im Frontend/Startseite nicht ausspielen
$parentChannel = $channel->getParent();
if ($parentChannel instanceof Portal) {
	return;
}

$templateOptions = $box->getTemplateOptions();

// -----------------------------------------------------------------------

$maxClips = 4;
$autostart = $templateOptions->get('autoPlayFirstVideo') ? true : false;
$setMuted = $templateOptions->get('Video-Stumm-Starten') ? true : false;
$volume = trim($templateOptions->get('Volume'));
if (!$volume || '' == $volume) {
    $volume = 100;
}

$emptyImg = lp('image', 'empty_2x1.png');
$tplName = '_shared.1_0.jwplayer.jwplayerSetupProxy';

// -----------------------------------------------------------------------

$objects = $box->getContentOfAllDropAreas();

if (0 >= count($objects)) {
    return;
}

$clips = array();

foreach($objects as $object) {
	// items aus collection filtern
	if($object instanceof ContentCollection){
	
		$objectContents = $object->getItemsRecursive(true);
		if ($objectContents) {
			foreach ($objectContents as $objectContent) {
				$clips[] = $objectContent;
			}
		}
	}
	else {
		$clips[] = $object;
	}
}

// -----------------------------------------------------------------------

$clips = array_slice($clips, 0, $maxClips);
$clipInfos = array();
foreach ($clips as $key => $clip) {

    $img = $clip->getFirstRelatedImage();
    if ($img) {
        $imgSrc = $img->getFileUrl('bigStoryCrop');
        $imgPoster = $img->getFileUrl('620x388');
    } else {
        $imgSrc = $emptyImg;
        $imgPoster = $emptyImg;
    }
    $title = $clip->getTitle();
    $preTitle = $clip->getPretitle();
    $length = ($clip->getVideoLength()) ? $clip->getVideoLength() : '';
    // no leadtext

    // ----------------------------------------------

    $linkAttr = getContentUrlAttributesArray($clip, $box, true, true, true);
    $href = (isset($linkAttr['href']) && is_string($linkAttr['href'])) ? $linkAttr['href'] : '#!';
    
    // ----------------------------------------------

    $videoSrcArray = getVideoSources($clip);

    

    $clipInfos[] = array(
        'imgSrc'   => $imgSrc,
        'image'    => $img,
        'poster'   => $imgPoster,
        'title'    => $title,
        'preTitle' => $preTitle,
        'length'   => $length,
        'videoSrc' => json_encode($videoSrcArray),
        'video'    => $clip,
        'href'     => $href,
    );
}

// -----------------------------------------------------------------------

if (0 >= count($clipInfos)) {
    return;
}


// (db) 2017-05-30 - helper zur sofortigen Ausspielung der Images oder via LazyLoad
$device = DeviceContainer::getDevice();
$boxImageCounter = $device->getConfig('boxImageCounter');
$boxImageCounter = ($boxImageCounter) ? $boxImageCounter : 0;
// (db) 2017-05-30 end

$channelOptions = $channel->getOptions();
$channelLayoutOverride = $channelOptions->get('layoutOverride');

?>


<div class='oe24tvTopVideoBox mobile_<?= $channelLayoutOverride; ?>'>
	<div class="contentBox">
		<div class="contentBoxChannel">
			 <? foreach ($clipInfos as $key => $clip): ?>
				
			    <? if (0 == $key): ?>
			    	
			    	<div class="bigClipArea">
			    		<? 
			    			tpl(
				    			$tplName, 
				    			array(
				    				'video' => $clip['video'],
				    				'events' => array(),
				    				'jsClass' => 'js-oe24tvTopVideoBoxPlayer',
				    				'autostart' => $autostart,
				    				'setMuted' => $setMuted,
				    				'params'   => array(
				                        'volume' => $volume
				                    ),
				    			)
			    			); 
			    		?>
			    	</div>

			    <? endif; ?>

				<? if (1 < count($clipInfos)): ?>

					<div class="contentBoxStory">
				    <a class="nextStory js-topVideoBoxSmallClip smallClip videoContainer clearfix story" href="#!" data-videosrc='<?= $clip['videoSrc']; ?>' data-videoposter="<?= $clip['poster'];?>">
				       
				       <? 
				       	$lazyLoad = (2 > $boxImageCounter) ? false : true;    
				       ?>
				       
				       	<div class="storyImage videoStory">
					       <? if ($lazyLoad): ?>
					           <?
					            if (1) {
					                etpl('oe24.oe24.device.smartphone.tpl._content.image.defaultImage', array(
					                    'channel' => $channel,
					                    // 'imagse' => $clip['imgSrc'],
					                    'image' => $clip['image'],
					                    'withCopyright' => 0,
					                    'emptyImageFormat' => $emptyImg,
					                ));
					            }
					            ?>

					        <? else: ?>

								<? if (1): ?>
					            <span class="imageContainer">

					                <? if (1): ?>
					                    <img src="<?= $clip['imgSrc']; ?>" alt="">
					                <? endif; ?>

					            </span>
					            <? endif; ?>

					        <? endif; ?>

					        <? if (!empty($clip['length']) && 0 != $key): ?>
								<span class="videoLength"><?= $clip['length']; ?></span>
			            	<? endif; ?>
			            	
						</div>
				        <div class="textContainer storyText">
							<? if (!empty($clip['preTitle'])): ?>
				                <strong class="storyPreTitle"><?= $clip['preTitle']; ?></strong>
				            <? endif; ?>

					        <? if (!empty($clip['title'])): ?>
					            <h3 class="storyTitle"><?= $clip['title']; ?></h3>	            
					        <? endif; ?>

						</div>

				        <? if (0): ?>
				        <div class="textContainer textContainerOverlay">

				            <? if ('firstStory' == $classStory): ?>

				                <? if (!empty($story['preTitle'])): ?>
				                    <strong class="storyPreTitle defaultChannelBackgroundColor"><?= $story['preTitle']; ?></strong>
				                <? endif; ?>

				                <? if (!empty($story['title'])): ?>
				                    <h3 class="storyTitle"><?= $story['title']; ?></h3>
				                <? endif; ?>

				                <? if ($showLeadText && !empty($story['leadText']) && 0 == $key): ?>
				                    <p class="storyLeadText"><?= $story['leadText']; ?></p>
				                <? endif; ?>

				            <? else: ?>

				                <? if (!empty($story['preTitle'])): ?>
				                    <strong class="storyPreTitle"><?= $story['preTitle']; ?></strong>
				                <? endif; ?>

				                <? if (!empty($story['title'])): ?>
				                    <h3 class="storyTitle defaultChannelColor"><?= $story['title']; ?></h3>
				                <? endif; ?>

				                <? if ($showLeadText && !empty($story['leadText']) && 0 == $key): ?>
				                    <p class="storyLeadText"><?= $story['leadText']; ?></p>
				                <? endif; ?>

				            <? endif; ?>

				        </div>
				        <? endif; ?>               
						
				    </a>
				    </div>
				<? endif; ?>

				<? 
			        // Image-counter für LazyLoading (kleine Bilder verbrauchen weniger Platz)
					if (1 == count($clipInfos)) {
			        	$boxImageCounter += 1;
			        }
			        else {
			        	$boxImageCounter = (0 == $key) ? $boxImageCounter + 1.5 : $boxImageCounter + 0.5;
			        }
			    ?>

			<? endforeach; ?>

		</div>
	</div>
</div>


<? $device->setConfig('boxImageCounter',$boxImageCounter); ?>
