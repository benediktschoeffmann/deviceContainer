<?php
/**
 * @var oe24Desktop any
 */
$navigationComponent = $oe24Desktop->getComponent('navigation');
$topNavigation = $navigationComponent->getNavigationItems('footer');

debug('navigationFooter.tpl');
?>


<div style="background-color: blue">
    <span><strong>NAVIGATION FOOTER</strong></span>
</div>
