<?php
/**
 * Header Nav Logo
 * @var oe24Desktop any
 */

$headerComponent = $oe24Desktop->getComponent(Component::HEADER);


$logoUrl = $headerComponent->getLogoUrl();
$logoLink = $headerComponent->getLogoLink();


?>
<div class="headerNavLogo clearfix">
    <a href="<?= $logoLink; ?>">
        <img src="<?= $logoUrl; ?>" alt="">
    </a>
</div>
