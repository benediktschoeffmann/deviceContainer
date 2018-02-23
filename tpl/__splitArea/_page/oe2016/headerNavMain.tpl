<?php
/**
 * headerNavMain
 *
 * @var channel oe24.core.Channel
 * @var layout string
 * @var headerNavMain array<any>
 * @default headerNavMain 0
 */

// zwecks schnellerer Ladezeit kann diese Variable
// am Dev-Server auf false gesetzt werden
$showFacebook = true;

switch ($layout) {
    case 'antenne_salzburg':
        $fbLike = 'antennesalzburg/?fref=ts';
        break;
    case 'antenne_tirol':
        $fbLike = 'Antennetirol/?fref=ts';
        break;
    default:
        $fbLike = 'oe24.at';
        break;
}

$facebookDataHref = 'http://www.facebook.com/'.$fbLike;

$facebookDataAttributes = array(
    'data-href="'.$facebookDataHref.'"',
    'data-layout="button_count"',
    'data-action="like"',
    'data-show-faces="false"',
    // 'data-width="244"',
);

// Die Menueeintraege in diesem Array
// werden mit einer festen Breite dargestellt
$headerNavMainFixedWide = array(
    'unterhaltung',
);

?>
<ul class="headerNavMain">

    <? foreach ($headerNavMain as $key => $item): ?>

        <?
        if (in_array(strtolower($item['caption']), $headerNavMainFixedWide)) {
            $item['cssClass'] = $item['cssClass'].' fixedWide';
        }
        ?>

        <li class="headerNavMainItem <?= $item['cssClass']; ?>">
            <a href="<?= $item['href']; ?>" <?=$item['target'];?> >
                <span><?= $item['caption']; ?></span>
            </a>
            <?
            if (array_key_exists('subNavigationItems', $item)) {
                tpl('oe24.oe24.__splitArea._page.oe2016.headerNavMainSubNav', array(
                    'layout' => $layout,
                    'subnav_items' => $item['subNavigationItems'],
                    'caption' => $item['caption'],
                ));
            }
            ?>
        </li>

    <? endforeach; ?>

    <? if ($showFacebook): ?>
        <li class="headerNavMainItem facebook">
            <a href="#!">
                <span class="fbContainer fb-like" <?= implode(' ', $facebookDataAttributes); ?> >&nbsp;</span>
            </a>
        </li>
    <? endif; ?>

</ul>
