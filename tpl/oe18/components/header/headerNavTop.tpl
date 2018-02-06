<?php
/**
 * @var oe24Desktop any
 */

$headerComponent = $oe24Desktop->getComponent(Component::HEADER);
$navigationComponent = $oe24Desktop->getComponent(Component::NAVIGATION);

?>

<? if ($headerComponent->hasWeatherInformation()) : ?>
    <?
    tpl('oe24.oe24.oe18.components.header.headerNavPortal',
        array(
            'headerComponent' => $headerComponent,
            'navigationComponent' => $navigationComponent,
        )
    );
    ?>
<? else : ?>
    <?
    tpl('oe24.oe24.oe18.components.header.headerNavPortalWeatherDropDown',
        array(
            'headerComponent' => $headerComponent,
            'navigationComponent' => $navigationComponent,
        )
    );
    ?>
<? endif; ?>
