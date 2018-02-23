<?
/**
 * list Content Box - default view
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
<div class="topgelesen">

<?php foreach ($contents as $key => $content): ?>

	<?php if (!($content instanceof TextualContent)) continue; ?>

	<div class="col col-default listItem">
		<a <?php echo getContentUrlAttributes($content, $box, true, true, true); ?> >

			<article class="clearfix">

				<?php if ($showCounter): ?>
				<div class="listElement listCounter"><span><?php echo ($key + 1); ?></span></div>
				<?php endif; ?>

				<?php if ($showImage): ?>
				<?php $image = $content->getFirstRelatedImage(true, $box); ?>
				<div class="listElement listImage"><img src="<?php echo $image->getFileUrl($imageFormat); ?>" /></div>
				<?php endif; ?>

				<div class="listText">
					<h2><? show($content->getTitle(true, $box)); ?></h2>
				</div>

			</article>

		</a>
	</div>

<?php endforeach; ?>

</div>