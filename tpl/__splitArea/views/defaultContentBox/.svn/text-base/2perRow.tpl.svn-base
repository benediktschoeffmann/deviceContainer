<?
/**
 * default Content Box - 2 per row view
 *
 * @var channel oe24.core.Channel
 * @var column oe24.core.ChannelColumn
 * @var box oe24.core.ContentBox
 * @var contents array<oe24.core.Content>
 * @var options spunQ_Map
 */
$firstArticleBig = ($options->get('firstArticleBig') == 1) ? true : false;
$firstArticleRendered = false;
$perRow=2;
$countTextualContentPerRow = 0;
$countContent=0;
//New imgageFormat has to be defined before rollout
$imageFormat = '292x146NoStretch';
foreach($contents as $content){
	$countContent++;
	if($content instanceof TextualContent){
		if($firstArticleBig && ! $firstArticleRendered){
	?>
		<div class="row">
	<?
		etpl('oe24.oe24.__splitArea.views.tplParts.simpleArticle',array('content'=>$content,'box'=>$box,'imageFormat'=>null,'overlay'=>true,'col'=>1));
	?>
		</div>
	<?
		$firstArticleRendered=true;
		continue;
		}
		$countTextualContentPerRow++;
		if($countTextualContentPerRow == 1){
	?>
		<div class="row">
	<? }
		etpl('oe24.oe24.__splitArea.views.tplParts.simpleArticle',array('content'=>$content,'box'=>$box,'imageFormat'=>$imageFormat,'overlay'=>false,'overlayType'=>'red','col'=>2));
		if($countTextualContentPerRow == $perRow || $countContent == count($contents)){
		$countTextualContentPerRow=0;
	?>
		</div>
	<?
		}
	?>
		
	<?
	}
}?>