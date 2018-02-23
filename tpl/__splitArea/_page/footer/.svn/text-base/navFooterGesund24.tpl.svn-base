<?php
/**
 * Footer Navigation (Main-Menue+Submenues, footerSub1, footerSub2, footerSub3)
 *
 * @var footerNavigation any
 * @default footerNavigation 0
 * @var layout string
 * @default layout oe24
 */
?>
<!-- footer start -->
<div class="row">
	<footer class="clearfix">

		<section class="footer_top">
			<h2 class="footer_caption">Service</h2>
			<div class="footer_left clearfix">
				<!-- footer_top footer_left -->
				<? if (array_key_exists('menue', $footerNavigation)): ?>
				<? foreach ($footerNavigation['menue'] as $key => $navigationItem): ?>
					<?php $class_last = ($key > 0 && 0 == $key % 5) ? 'last' : ''; ?>
					<nav class="nav_items clearfix <?=$class_last?>">
						<h3 class="nav_item_caption"><a href="<?=$navigationItem['href']?>" onclick="<?=$navigationItem['onclick']?>"><?=$navigationItem['caption']?></a></h3>
						<ul>
						<?php if (array_key_exists('subNavigationItems', $navigationItem)): ?>
						<?php foreach ($navigationItem['subNavigationItems'] as $subNavigationItem): ?>
							<li class="subnav_item_caption"><a href="<?=$subNavigationItem['href']?>" onclick="<?=$subNavigationItem['onclick']?>"><?=$subNavigationItem['caption']?></a></li>
						<?php endforeach ?>
						<?php endif; ?>
						</ul>
					</nav>
				<?php endforeach ?>
				<? endif; ?>
			</div>
			<div class="footer_right clearfix">
				<!-- footer_top footer_right -->
				<?= (is_array($footerNavigation[2])) ? '' : $footerNavigation[2]?>
			</div>
		</section>

		<section class="footer_bottom">
			<h2 class="footer_caption">Information &amp; Offenlegung</h2>
			<div class="footer_left clearfix">
				<!-- footer_bottom footer_left -->
				<?= (is_array($footerNavigation[0])) ? '' : $footerNavigation[0]?>
			</div>
			<div class="footer_right clearfix">
				<!-- footer_bottom footer_right -->
				<?= (is_array($footerNavigation[1])) ? '' : $footerNavigation[1]?>
			</div>
		</section>

	</footer>
</div>
<!-- footer end -->

