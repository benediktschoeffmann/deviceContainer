<?
/**
 * navigationMain
 */

$smartphone = DeviceContainer::getDevice();

$navigationItems = $smartphone->getConfig('navigationItems');
$navigationTop = $navigationItems['mobilTop'];

?>

<? if (1): ?>
<ul>
    <? foreach ($navigationTop as $navigationTopItem): ?>
        <li>
            <a href="<?= $navigationTopItem['href']; ?>" <?= $navigationTopItem['target']; ?>>
                <?= $navigationTopItem['caption']; ?>
            </a>
        </li>
    <? endforeach; ?>
</ul>
<? endif; ?>
