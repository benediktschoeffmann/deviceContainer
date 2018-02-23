<?
/**
 * Simple Article Template
 *
 * @var box oe24.core.ContentBox
 * @var content oe24.core.Content
 * @var imageFormat any
 * @var overlay boolean
 * @default overlay 0
 * @var overlayType string
 * @default overlayType black
 * @var col integer
 * @default col 1
 */
 
 $image = $content->getFirstRelatedImage(true, $box);
 if($overlayType != 'black' && $overlayType != 'red'){
	$overlayType = 'black';
 }
?>

<article class="col col<?=$col?> channel-box">
<a <?=getContentUrlAttributes($content, $box, true, true, true)?>>
<?
	if($overlay && $overlayType=='black'){
?>	
<div class="overlay-box">
	<?}
	//Image
	if($image !== null){
	?>
		<img src="<?=$image->getFileUrl($imageFormat)?>" />
	<?
	}else{
	?>
		<img src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" width="206" height="103" style="height: 103px;" />
	<?}
	if($overlay && $overlayType=='black'){
?>
	<h2 class="caption"><?s($content->getTitle(true, $box))?></h2>
	</div>	
	<?}
	 //Header ?>
	<header <?= ($overlay && $overlayType=='black') ? ' style="display:none;"' : '' ?>>
		<p class="text"><strong class="tag"><?s($content->getPreTitle(true, $box))?></strong></p>
		<h2 class="caption"><?s($content->getTitle(true, $box))?></h2>
	</header>
	<? //Leadtext ?>
	<p class="text" <?= ($overlay && $overlayType=='black') ? ' style="display:none;"' : '' ?>><?s($content->getLeadText(true,true,$box))?></p>
</a>
</article>