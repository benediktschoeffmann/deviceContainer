<?php
/**
 * collector.tpl
 * @var oe24Desktop any
 */

$collector = $oe24Desktop->getComponent(Component::COLLECTOR);

$jsHeadUrl = $collector->getFileUrl('js', 'head');
$cssHeadUrl = $collector->getFileUrl('css', 'head');


?>

<script type="application/javascript" src="<?=$jsHeadUrl;?>"></script>
<link rel="stylesheet" href="<?=$cssHeadUrl;?>">
