<?
/**
 * navigationMain
 */

$smartphone = DeviceContainer::getDevice();

$navigationItems = $smartphone->getConfig('navigationItems');
$navItems = $navigationItems['mobil'];

$latestCoverSrc = 'http://file.oe24.at/tz-cover/epaper_320x437.jpg';
$latestCoverUrl = 'https://www.epaper-oesterreich.at/shelf.act?filter=CITYW';
$latestCoverItemText = 'Österreich als E-Paper';

// ---------------------------------------------------------------

// // zwecks Test - kann später auskommentiert werden bzw. geloescht

// $lorem = 'lorem ipsum dolor consectetur adipisicing elit dolor unde laboriosam esse cum obcaecati soluta magni placeat dolores quae nisi quibusdam maxime quae dicta';

// $appendParameter = array(
//     'oe24'      => '&layout=oe24',
//     'sport'     => '&layout=sport',
//     'society'   => '&layout=society',
//     'oe24tv'    => '&layout=tv',
//     'radiooe24' => '&layout=radiooe24',
//     'madonna'   => '&layout=madonna',
// );

// $navItems = array();

// foreach ($appendParameter as $key => $value) {
//     $navItems[] = array(
//         'href' => 'http://oe24dev.oe24.at/_mobile/test/ws/smartphone?smartphone'.$value,
//         'target' => '',
//         'cssClass' => 'dummy',
//         'caption' => ucfirst($key),
//     );
// }

// foreach (explode(' ', $lorem) as $key => $value) {
//     $navItems[] = array(
//         'href' => 'http://oe24dev.oe24.at/_mobile/test/ws/smartphone?smartphone',
//         'target' => '',
//         'cssClass' => 'dummy',
//         'caption' => ucfirst($value),
//     );
// }

// // zwecks Test Ende

// ---------------------------------------------------------------

?>

<? if (1): ?>

    <nav class="navigationMainBox">

        <? foreach ($navItems as $key => $navItem): ?>
            <a class="navigationMainItem <?= $navItem['cssClass']; ?>" href="<?= $navItem['href']; ?>" <?= $navItem['target']; ?> ><?= $navItem['caption']; ?></a>
        <? endforeach; ?>

        <? if (1 /*&& $latestCoverSrc*/ ): ?>
            <a class="navigationMainItem latestCover" href="<?= $latestCoverUrl; ?>" target="_blank">
                <span><?= $latestCoverItemText; ?></span>
                <img class="js-ePaperCover" src="<?= $latestCoverSrc; ?>" alt="">
            </a>
        <? endif; ?>

    </nav>

<? endif; ?>
