<?php
/**
 * Footer Template
 *
 * @var portal oe24.core.Portal
 */

$footer = array();
$navigationItems = $portal->getNavigationItems();
foreach ($navigationItems as $navItem) {
	if ($navItem->getLink()->getText() !== '/Madonna') {
		continue;
	}

	foreach ($navItem->getChildren() as $portalItem) {
		if ($portalItem->getLink()->getText() !== 'footer') {
			continue;
		}

		foreach ($portalItem->getChildren() as $footerItem) {
			$footerItemLink = $footerItem->getLink();
			$footerItemUrl = ($footerItemLink instanceof ContentLink) ? $footerItemLink->toUrl() : $footerItemLink->getUrl();

			$footer[] = array(
				'url' => $footerItemUrl,
				'name' => $footerItemLink->getText(),
			);
		}
	}
}
?>
<div class="row">
	<footer class="clearfix">
		<ul class="clearfix">

			<? if (is_array($footer) && count($footer) > 0): ?>
			<? foreach($footer as $footerItem): ?>
			<li>
				<a href="<?= $footerItem['url']; ?>"><?= $footerItem['name']; ?></a>
			</li>
			<? endforeach; ?>
			<? endif; ?>

			<li>
				<span> &copy; oe24 GmbH </span>
			</li>

		</ul>
	</footer>
</div>
