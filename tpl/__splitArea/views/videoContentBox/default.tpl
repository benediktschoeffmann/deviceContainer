<?
/**
 * video Content Box - default view
 *
 * @var channel oe24.core.Channel
 * @var column oe24.core.ChannelColumn
 * @var box oe24.core.ContentBox
 * @var contents array<oe24.core.Content>
 * @var options spunQ_Map
 */
$showCounter = ($options->get('showCounter') == 1) ? true : false;
$showImage = ($options->get('showImage') == 1) ? true : false;
$countTextualContent = 0;
$imageFormat = '92x46NoStretch';
 ?>
<div class="videoBox">
 <?
foreach($contents as $content){
    if($content instanceof TextualContent){
		
		$countTextualContent++;
	?>
		<div class="listItem col col-default">
		<a <?=getContentUrlAttributes($content, $box, true, true, true)?>>
        <article>
            
		<?
			$headerColumns='col3';
			
			if(! $showCounter && ! $showImage){
				$headerColumns='col1';
			}elseif(! $showCounter){
				$headerColumns='col2';
			}elseif(! $showImage){
				$headerColumns='col2';
			}
			
			if($showCounter){
		?>
			<div class="listElement listCounter"><span><?= $countTextualContent ?></span></div>
		<?
			}
			if($showImage){
				 $image = $content->getFirstRelatedImage(true, $box);
		?>
				<div class="listElement listImage"><img src="<?=$image->getFileUrl($imageFormat)?>" /></div>
		<?
			}
		?>
				<div class="listText">
                    <h2><?s($content->getTitle(true, $box))?></h2>
				</div>
            <div class="clear"></div>
        </article>
		</a>
		</div>
    <?}?>
<?}?>
 </div>