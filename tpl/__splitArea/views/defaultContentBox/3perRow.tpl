<?
/**
 * default Content Box - 3 per row view
 *
 * @var channel oe24.core.Channel
 * @var column oe24.core.ChannelColumn
 * @var box oe24.core.ContentBox
 * @var contents array<oe24.core.Content>
 * @var options spunQ_Map
 */
$firstArticleBig = ($options->get('firstArticleBig') == 1) ? true : false;
$firstArticleRendered = false;
$perRow=3;
$countTextualContentPerRow = 0;
$countTextualContentInRows = 0;
$countContent=0;
//New imgageFormat has to be defined before rollout
$imageFormat = '292x146NoStretch';

foreach($contents as $content){
	$countContent++;
	if($content instanceof TextualContent){
		if($firstArticleBig && ! $firstArticleRendered){
	?>
		<div class="row">
			<div class="col col1">
	<?
		etpl('oe24.oe24.__splitArea.views.tplParts.simpleArticle',array('content'=>$content,'box'=>$box,'imageFormat'=>null,'overlay'=>true));
	?>
			</div>
		</div>
	<?
		$firstArticleRendered=true;
		continue;
		}
		$countTextualContentPerRow++;
		$countTextualContentInRows++;
		if($countTextualContentPerRow == 1){
	?>
		<div class="row">
	<? }
	?>
		<div class="col col3 channel-box">
	<?
		etpl('oe24.oe24.__splitArea.views.tplParts.simpleArticle',array('content'=>$content,'box'=>$box,'imageFormat'=>$imageFormat));
	?>
		</div>
	<?
		if($countTextualContentPerRow == $perRow || $countContent == count($contents)){
		if($countContent == count($contents)){
			for($i=$countTextualContentPerRow;$i<$perRow;$i++){
				echo '<div class="four column"></div>';
			}
		}
		$countTextualContentPerRow=0;
	?>
		</div>
	<?
		}
	}
}?>