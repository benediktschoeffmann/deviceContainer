<?php

/**
 * OE2016 Sport Tabbox
 *
 * @var channel oe24.core.Channel
 * @var column oe24.core.ChannelColumn
 * @var box oe24.core.TabbedBox
 */

$oe24 = Portal::getPortalByName('oe24');

$clubs = array(
    array(
        'name'     => 'Red Bull Salzburg',
        'url'      => Channel::getChannelByChannelString($oe24, 'sport/fussball/fussball-national/bundesliga/red-bull-salzburg')->getUrl(),
        'imageUrl' => lp('image', 'oe2016/fussballvereine/rb_salzburg.png'),
        'cssClass' => 'rb_salzburg',
    ),
    array(
        'name'     => 'Rapid Wien',
        'url'      => Channel::getChannelByChannelString($oe24, 'sport/fussball/fussball-national/bundesliga/rapid-wien')->getUrl(),
        'imageUrl' => lp('image', 'oe2016/fussballvereine/rapid.png'),
        'cssClass' => 'rapid',
    ),
    array(
        'name'     => 'SVR Altach',
        'url'      => Channel::getChannelByChannelString($oe24, 'sport/fussball/fussball-national/bundesliga/altach')->getUrl(),
        'imageUrl' => lp('image', 'oe2016/fussballvereine/altach.png'),
        'cssClass' => 'altach',
    ),
    array(
        'name'     => 'Sturm Graz',
        'url'      => Channel::getChannelByChannelString($oe24, 'sport/fussball/fussball-national/bundesliga/sturm-graz')->getUrl(),
        'imageUrl' => lp('image', 'oe2016/fussballvereine/graz.png'),
        'cssClass' => 'graz',
    ),
    array(
        'name'     => 'Wolfsberg AC',
        'url'      => Channel::getChannelByChannelString($oe24, 'sport/fussball/fussball-national/bundesliga/wac')->getUrl(),
        'imageUrl' => lp('image', 'oe2016/fussballvereine/wolfsberg.png'),
        'cssClass' => 'wolfsberg',
    ),
    array(
        'name'     => 'LASK',
        'url'      => Channel::getChannelByChannelString($oe24, 'sport/fussball/fussball-national/bundesliga/lask')->getUrl(),
        'imageUrl' => lp('image', 'oe2016/fussballvereine/lask.png'),
        'cssClass' => 'lask',
    ),
    array(
        'name'     => 'Austria Wien',
        'url'      => Channel::getChannelByChannelString($oe24, 'sport/fussball/fussball-national/bundesliga/austria-wien')->getUrl(),
        'imageUrl' => lp('image', 'oe2016/fussballvereine/austria.png'),
        'cssClass' => 'austria',
    ),
    array(
        'name'     => 'SKN St. Pölten',
        'url'      => Channel::getChannelByChannelString($oe24, 'sport/fussball/fussball-national/bundesliga/skn-st-poelten')->getUrl(),
        'imageUrl' => lp('image', 'oe2016/fussballvereine/st_poelten.png'),
        'cssClass' => 'st_poelten',
    ),
    array(
        'name'     => 'Admira Wacker',
        'url'      => Channel::getChannelByChannelString($oe24, 'sport/fussball/fussball-national/bundesliga/admira-wacker')->getUrl(),
        'imageUrl' => lp('image', 'oe2016/fussballvereine/admira.png'),
        'cssClass' => 'admira',
    ),
    array(
        'name'     => 'SV Mattersburg',
        'url'      => Channel::getChannelByChannelString($oe24, 'sport/fussball/fussball-national/bundesliga/mattersburg')->getUrl(),
        'imageUrl' => lp('image', 'oe2016/fussballvereine/mattersburg.png'),
        'cssClass' => 'mattersburg',
    ),
);

?>

<div class="tabbedBoxNav clubArea">
    <? foreach ($clubs as $key => $club): ?>
        <a href="<?= $club['url']; ?>">
            <span class="tabbedBoxNavImage">
                <div class="fussball_<?= $club['cssClass']; ?>"></div>
            </span>
            <span class="tabbedBoxNavClubname"><?=$club['name'];?></span>
        </a>
    <? endforeach; ?>
</div>

