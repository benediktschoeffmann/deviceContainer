<?php
/**
 * Footer Navigation (Main-Menue+Submenues, footerSub1, footerSub2, footerSub3)
 *
 * @var channel oe24.core.Channel
 * @var footerNavigation any
 * @default footerNavigation 0
 * @var headerNavigation any
 * @default headerNavigation 0
 * @var layout string
 * @default layout oe24
 */
?>

<?
// $showPaidContentMarker = false;
// // kann true, false oder null sein.
// if ($channel->getOptions(true, true)->get('EntgeltlicherContent')) {
// 	$showPaidContentMarker = true;
// }
?>
<!-- footer start -->
<div class="row">
	<footer class="clearfix">

		<section class="footer_top clearfix">
			<? // if ($showPaidContentMarker) : ?>
				<!-- <div class="paid_content">Entgeltlicher Channel</div> -->
			<? // endif; ?>
			<h2 class="footer_caption">Information &amp; Offenlegung</h2>
			<div class="footer_left clearfix">
				<div class="footer_inner clearfix">
					<!-- footer_bottom footer_left -->
					<?= (is_array($footerNavigation[0])) ? '' : $footerNavigation[0]?>
				</div>
				<div class="footer_inner clearfix">
					<!-- footer_bottom footer_right -->
					<?= (is_array($footerNavigation[1])) ? '' : $footerNavigation[1]?>
				</div>
			</div>
			<div class="footer_right clearfix">
				<!-- footer_top footer_right -->
				<?= (is_array($footerNavigation[2])) ? '' : $footerNavigation[2]?>
			</div>
		</section>

		<section class="footer_portale">
			<strong>Die Portale des OE24-Netzwerks</strong>
			<ul>
				<? foreach ($headerNavigation['top'] as $topNavigation): ?>
					<li>
						<a href="<?= $topNavigation['href']; ?>"><?= $topNavigation['caption']; ?></a>
					</li>
				<? endforeach; ?>
			</ul>
		</section>

	</footer>
</div>
<!-- footer end -->

