<?
/**
 * IFrames
 *
 * @var protocol string
 * @var id string
 *
 * @cache 360d
 */

// Test Artikel 161568029
// http://oe24dev.oe24.at/_mobile/sport/fussball/international/Smartphone-Test-Messi-boykottiert-FIFA-Gala/161568502?smartphone
//
// Test Artikel 161552703 (ws)
// http://oe24dev.oe24.at/_mobile/test/ws/smartphone/Das-Geheimnis-der-schlanken-Franzoesinnen/161552703?smartphone
//
// Original Programmcode in ...
// /var/www/oe24_oe24/tpl/_htmltagging/IFrame.tpl

$src = '';

if ('Youtube' === $protocol) {
    $src = 'https://www.youtube.com/embed/' . $id . '?wmode=transparent';
} else if ('Vimeo' === $protocol) {
    $src = 'https://player.vimeo.com/video/' . $id;
} else if ('Facebook' === $protocol) {
    try {
        $device = DeviceContainer::getDevice();
        if ($device instanceof Oe24App) {
            tpl('oe24.oe24.device.oe24app.tpl._override.facebook' , array('post' => $id));

            return;
        }

    } catch (Exception $e) {
        // we are not in device-mode, return;
        return;
    }
    $src = $id;
} else if ('Twitter' === $protocol) {
    $src = $id;
    $device = DeviceContainer::getDevice();
    $device->setConfig('useTwitter', true);
} else if ('APA-Livestream' === $protocol) {
    $src = '//dev.uvp.apa.at/embed/' . $id;
} else if ('AustriaVideoPlatform' === $protocol) {
    $src = $id;
} else if ('Scoreboard' === $protocol) {
    $src = $id;
} else if ('Glomex' === $protocol) {
    $src = $id;
} else {
    $src = '';
}

?>
<!-- <div class="flex-video"> -->

    <? if ('Youtube' === $protocol): ?>

        <div class="frameContainer">
            <iframe src="<?= $src; ?>" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
        </div>

    <? elseif ('Vimeo' === $protocol): ?>

        <div class="frameContainer">
            <iframe src="<?= $src; ?>" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
        </div>

    <? elseif ('Facebook' === $protocol): ?>
        <div class="fb-post" data-href="<?= $src; ?>"" data-width="auto"></div>
    <? elseif ('AustriaVideoPlatform' === $protocol): ?>

        <div class="frameContainer">
            <iframe src="<?= $src; ?>" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
        </div>


    <? elseif ('Twitter' === $protocol): ?>

        <blockquote class="twitter-tweet" lang="de">
            <a href="<?= $src; ?>"></a>
        </blockquote>

    <? // -------------------------------------- ?>

    <? elseif (false && 'Scoreboard' === $protocol): // (bs) 2017-01-18 Scoreboards laut Florian aussen vor lassen ?>

        <div class="apaOuterFrame apaSportwidgets" id="scoreboardoeblsingle" data-view="<?= $src; ?>" data-package="sportwidgets.scoreboard" data-scoreboard-type="bigsingle"></div>

    <? elseif (false && 'APA-Livestream' === $protocol): // TODO ?>

        <div style="position: relative; width: 100%; height: 0; padding-bottom: 60%;">
            <iframe src="<?= $src; ?>" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
        </div>

    <? elseif ('Glomex' === $protocol): ?>

        <? /*externes Script nur laden, wenn es gebraucht wird */ ?>
        <script async src="//component-vvs.glomex.com/glomex-embed/1/glomex-embed.js"></script>
        <div class="glomex-responsive-container">
              <glomex-player data-height="348" data-player-id="fc1yf2d2j628mw5r" data-playlist-id="<?= $src; ?>" data-width="620"></glomex-player>
        </div>
    <? endif; ?>

<!-- </div> -->
