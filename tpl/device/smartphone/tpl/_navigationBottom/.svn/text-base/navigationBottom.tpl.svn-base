<?
/**
 * Mobile Navigation Bottom
 */

$device = DeviceContainer::getDevice();

$portal = $device->getConfig('portal');
$channel = $device->getConfig('channel');

// sportdatenCenterId dev: 68208503
// sportdatenCenterId echt: 68208503

$showBottomNaviIdsDev = array(
    68208503,   // sportdaten-Center
    );

$showBottomNaviIdsEcht = array(
    68208503,   // sportdaten-Center
    );

$showBottomNaviIds = ($device->getConfig('isDevServer')) ? $showBottomNaviIdsDev : $showBottomNaviIdsEcht;

$showBottomNavi = false;
$parentChannels = $channel->getParentChannels(true);
$parentChannels = array_reverse($parentChannels);

foreach ($parentChannels as $parentChannel) {
    if (in_array($parentChannel->getId(), $showBottomNaviIds)) {
        $showBottomNavi = true;
        break;
    }
}

if (!$showBottomNavi) {
    return;
}

$uri = $channel->getRawUrl();

$allNavigationItems = $portal->getNavigationItems();
if (!$allNavigationItems) {
    return NULL;
}

// check navi items name match with url
$rootNaviItem = NULL;
$baseNaviItem = NULL;
foreach ($allNavigationItems as $allNavigationItem) {
    $allNavigationItemText = $allNavigationItem->getLink()->getText();
    if ($allNavigationItemText == "/") {
        $rootNaviItem = $allNavigationItem;
    }

    if (!$baseNaviItem && (preg_match("~^$allNavigationItemText$|^$allNavigationItemText/(.*?)$~i", $uri))) {
        $baseNaviItem = $allNavigationItem;
    }
}

$naviItem = (NULL === $baseNaviItem) ? $rootNaviItem : $baseNaviItem;
if (NULL === $naviItem) {
    return;
}

$naviItems = $naviItem->getChildren();
if (count($naviItems) <= 0) {
    return NULL;
}

$navigationItems = NavigationItem::getChildrensByTextName($naviItems, 'navigationBottom');

$navigationBottomArray = array();
foreach ($navigationItems as $key => $naviItem) {

    $naviItemLink = $naviItem->getLink();
    $target = $naviItemLink->getTarget();
    $target = (is_string($target) && !empty($target)) ? ' target="' . $target . '"' : '';

    $naviItemLinkUrl = $naviItemLink->toUrl();
    $naviItemLinkText = $naviItemLink->getText();
    $cssClass = $naviItemLink->getCssClasses();

    $svgFile = array(
        dirname(__FILE__),
        'icons',
        strtolower($cssClass[0]) . '.svg',
    );
    $svgFile = implode('/', $svgFile);

    if (!file_exists($svgFile)) {
        continue;
    }

    ob_start();
    include $svgFile;
    $svg = ob_get_contents();
    ob_end_clean();

    $navigationBottomArray[] = array(
        'href'   => $naviItemLinkUrl,
        'text'   => $naviItemLinkText,
        'target' => $target,
        'svg'    => $svg,
    );

}

if (empty($navigationBottomArray)) {
    return;
}

?>
<div class="navigationBottom">
    <ul>
        <? foreach ($navigationBottomArray as $navigationBottom): ?>
            <li>
                <a href="<?= $navigationBottom['href']; ?>" <?= $navigationBottom['target']; ?>>
                    <?= $navigationBottom['svg']; ?>
                </a>
            </li>
        <? endforeach; ?>
    </ul>
</div>
