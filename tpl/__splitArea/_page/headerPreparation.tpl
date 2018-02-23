<?php
/**
 * Collect Data for header and display it
 *
 * @var portal oe24.core.Portal
 * @var channel oe24.core.Channel
 * @var object any
 * @default object 0
 * @var params array<any>
 * @var useNewLayout any
 * @var layout string
 */

// -------------------------------------------
// NAVIGATION CONFIG
// -------------------------------------------
$navigationItemsConfig = array(
    'header' => array(
        'top' => 'top_2014',
        'tabs' => 'tabs_2014',
        'menue' => 'main',
    ),
    'footer' => array(
        'footerSub1',
        'footerSub2',
        'footerSub3',
    )
);
$navigation = new Navigation($portal, $channel, $layout, $navigationItemsConfig);

// -------------------------------------------
// HEADER
// -------------------------------------------

etpl('oe24.oe24.__splitArea._page.header', array(
    'portal'          => $portal,
    'channel'         => $channel,
    'object'          => $object,
    'layout'          => $layout,
    'navigation'      => $navigation,
    'useNewCollector' => true,
    'useNewLayout'    => $useNewLayout,
    'oe2016layouts'   => 1,
));
