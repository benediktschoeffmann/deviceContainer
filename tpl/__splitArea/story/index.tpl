<?
/**
* Story Site
*
* @var params array<any>
* @var channel oe24.core.Channel
* @var object oe24.core.TextualContent
*/


$text = $object;
$portal = Portal::getPortalByName("oe24");
$options = $text->getOptions(true, true);
$articleLayout = $options->get("articleLayout");
$imageVersion = "consoleMadonnaNoStretch2";
$images = $text->getRelatedImages();
$slideshows = $text->getRelatedSlideshows();
$comments = $text->getComments();
$parentChannels=$channel->getParentChannels();

// function getSpunqTags($bodyText)
// {
// 	$spunqTags = array();
// 	preg_match('/\<spunQ:(.*?)\>/', $bodyText, $spunqTags, PREG_OFFSET_CAPTURE);
// 	return $spunqTags;
// }
?>
<div class="content">
<div class="row">
		<article class="article-box">
			<div class="overlay-box">
			<?
				if($images){
			?>
					<img src="<?= s($images[0]->getFileUrl($imageVersion)) ?>" alt="<?=$text->getTitle()?>" />
					<h2 class="caption"><?= $text->getPreTitle(); ?></h2>
			<?
				if($images[0]->getCopyright()){
			?>
					<span class="copyright">&copy; <?s($images[0]->getCopyright())?></span>
                <?}?>
			<?}?>
			</div>
					<h1><?=$text->getTitle()?></h1>
				<div class="service">
					<a class="comment" href="#comment"><span class="icon-comment"></span><span>Posten Sie (<?= count($comments)?>)</span></a>
					<a class="printer" href="<?= $text->getId()  ?>/print"><span class="icon-printer"></span></a>
					<a class="mail" href="<?= $text->getId()  ?>/mailto"><span class="icon-mail"></span></a>
					<ul class="breadcrumbs">
					<?
					foreach($parentChannels as $parentChannel){
					?>
						<li>
							<?= (trim($parentChannel->getSeoPageTitle())!=='') ? '<span>&gt;</span>' : '' ?>
							<a href="<?= $parentChannel->getUrl() ?>">
								<?= (trim($parentChannel->getSeoPageTitle())!=='') ? $parentChannel->getSeoPageTitle() : '<span class="icon-house"></span>'  ?>
							</a>
						</li>
					<?}?>
					</ul>

				</div>

				<div class="share">
					<img alt="" src="<? slp('image','relaunch2014/socialmedia/facebook_sprechblase.png') ?>" />
					<img alt="" src="<? slp('image','relaunch2014/socialmedia/facebook_like.png') ?>" />
					<img alt="" src="<? slp('image','relaunch2014/socialmedia/facebook_share.png') ?>" />
					<img alt="" src="<? slp('image','relaunch2014/socialmedia/twitter_icon.png') ?>" />
					<img alt="" src="<? slp('image','relaunch2014/socialmedia/google_plus.png') ?>" />
				</div>
			<div class="bodyContainer">
				<h3 class="article-teaser"><?=$text->getLeadText(true)?></h3>
				<p><?
				$bodyText=$text->getBodyText(true,true);
				preg_match_all("'<p>(.*?)</p>'si", $bodyText, $match);
				 foreach($match[1] as $val)
				    {
				    	$bodyText=str_replace($val,trim($val),$bodyText);

				    }
				    echo $bodyText;
    			 ?></p>
			</div>
			<?
				if(count($images)>1){
			?>
			<div id="relatedImages" class="slideshow overlay-box">
				<div class="arrow arrowLeft"></div>
				<div class="arrow arrowRight"></div>
				<div class="slideshowPics">
				<?
				foreach($images as $image){
				?>
				<img <?= ($image==$images[0]) ? '' : 'class="notVisible"' ?> src="<?= s($image->getFileUrl($imageVersion)) ?>" alt="" />
				<?}?>
				</div>
				<div class="slideshowOverlay">
					<div class="annotation">
					<h2 class="caption"><?=$text->getTitle()?></h2>
					</div>
				</div>
			</div>
			<script type="text/javascript">
			if(typeof readyCallbacks !== 'object'){
				var readyCallbacks = [];
			}
			readyCallbacks.push(function(){
				var slideshow = new Slideshow();
				slideshow.setContainerClass('slideshowPics');
				slideshow.setAutoplay(true);
				slideshow.init();
			});

			</script>
			<?
			}
			if(count($slideshows)>0){
				etpl('oe24.oe24.__splitArea.story.slideshows', array("slideshows" => $slideshows,'imageVersion'=>$imageVersion));
			}
			?>
		</article>
		<?
		if($options->getByKey("allowPosting")){
			etpl('oe24.oe24.__splitArea.story.comments', array("text" => $text,"options" => $options,"channel" => $channel));
		}
		?>
</div>
</div>
