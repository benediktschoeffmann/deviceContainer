<?
/**
 * headline
 *
 * @var channel oe24.core.Channel
 * @var column oe24.core.ChannelColumn
 * @var box oe24.core.ContentBox
 * @var options spunQ_Map
 */
?>
 <div class="row">
	<div class="col col1">
<?
if($options->get('showTitle')){?>
  <h3><?s($box->getTitle())?></h3>
<?}?>
</div>
</div>