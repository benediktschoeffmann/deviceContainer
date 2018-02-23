<?
/**
* Story Site - Slideshows
*
* @var slideshows any
* @var imageVersion string
*/
?>
<?
$id=uniqid();
foreach($slideshows as $slideshow){
?>
	<div id="relatedSlideshow-<?= $id ?>" class="slideshow overlay-box">
		<div class="arrow arrowLeft"></div>
		<div class="arrow arrowRight"></div>
		<div class="clear"></div>
		<div class="slideshowPics-<?= $id ?>">
		<?
			$images = $slideshow->getRelatedImages();
			$imageInfos = '';
			foreach($images as $image){
			$imageInfos .= '<div class="annotation caption"><h2>' . $slideshow->getTitleForImage($image) . '</h2><p>' .  $slideshow->getDescriptionForImage($image) . '</p></div>';
		?>
			<img src="<?= $image->getFileUrl($imageVersion); ?>" alt="<?= $slideshow->getTitleForImage($image); ?>" />
			
		<?}?>
		</div>
		<div class="slideshowOverlay">
		<?=$imageInfos?>
		</div>
		<script type="text/javascript">
			if(typeof readyCallbacks !== 'object'){
				var readyCallbacks = [];
			}
			readyCallbacks.push(function(){
				var slideshow<?= $id ?> = new Slideshow();
				slideshow<?= $id ?>.setContainerClass('slideshowPics-<?= $id ?>');
				slideshow<?= $id ?>.setAutoplay(true);
				slideshow<?= $id ?>.init();
			});

			</script>
	</div>

<?
$id=uniqid();
}?>