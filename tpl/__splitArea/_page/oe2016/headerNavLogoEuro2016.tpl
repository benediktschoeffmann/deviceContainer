<?php
/**
 * Euro 2016 Logo oder Text
 */

$logoEuro2016 = ''; // '/images/oe2016/logo-sport24-euro2016.svg';
$textEuro2016 = 'Euro 2016';

?>

<? if (!empty($logoEuro2016)): ?>

<div class="headerNavLogoCol logoEuro2016">
    <a href="http://sport.oe24.at/fussball/euro-2016">
        <img src="<?= $logoEuro2016; ?>" alt="">
    </a>
</div>

<? elseif (!empty($textEuro2016)): ?>

<div class="headerNavLogoCol textEuro2016">
    <a href="http://sport.oe24.at/fussball/euro-2016">
        <span><?= $textEuro2016; ?></span>
    </a>
</div>

<? endif; ?>
