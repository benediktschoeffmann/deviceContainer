<?
/**
 * list Article Box 
 *
 * @var contents array<oe24.core.Content>
 * @var headline string
 * @var showImage boolean
 * @var showCounter boolean
 */

$countTextualContent = 0;
$imageFormat = '92x46NoStretch';
 ?>
 <div class="col col-fullwide"><h2><?=$headline?></h2></div>
<div class="listArticleBox col col-wide">
 <?
foreach($contents as $content){
    if($content instanceof TextualContent){
		
		$countTextualContent++;
	?>
		<div class="listItem col">
		<a <?=getContentUrlAttributes($content, false, true, true, true)?>>
        <article>
            
		<?
			$headerColumns='col3';
			
			if(! $showCounter && ! $showImage){
				$headerColumns='col1';
			}elseif(! $showCounter || ! $showImage){
				$headerColumns='col2';
			}
			
			if($showCounter){
		?>
			<div class="listElement listCounter"><span><?= $countTextualContent ?></span></div>
		<?
			}
			if($showImage){
				 $image = $content->getFirstRelatedImage(true);
				 if($image){
		?>
				<div class="listElement listImage"><img src="<?=$image->getFileUrl($imageFormat)?>" /></div>
		<?
			}}
		?>
				<div class="listText">
                    <h2><?s($content->getTitle(true))?></h2>
				</div>
            <div class="clear"></div>
        </article>
		</a>
		</div>
    <?}?>
<?}?>
 </div>