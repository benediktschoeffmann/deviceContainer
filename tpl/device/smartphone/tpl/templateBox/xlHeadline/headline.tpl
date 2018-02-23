<?
/**
 * xlHeadline
 *
 * @var channel oe24.core.Channel
 * @var box oe24.core.TemplateBox
 */

$templateOptions = $box->getTemplateOptions();

// -------------------------------------------

$hideMobile = $templateOptions->get('Hide-Mobile-Box');
if ($hideMobile) {
	return;
}

// -------------------------------------------

$headline = $templateOptions->get('Headline');
if (!$headline) {
    return;
}

// -------------------------------------------

$layoutIdentifier = $templateOptions->get('Layout-Identifier');
$layoutIdentifier = ($layoutIdentifier) ? $layoutIdentifier : 'oe24';

// -------------------------------------------

$backgroundLeft = $templateOptions->get('BgColorLeft');
$backgroundRight = $templateOptions->get('BgColorRight');
// mobil nur die Hintergrundfarbe andrucken - kein Verlauf
$styleDefinition = ($backgroundLeft && $backgroundRight) ? 'style="background-color: ' . $backgroundLeft . ';"' : '';

// -------------------------------------------

$distanceTop = $templateOptions->get('Abstand-oben');
$distanceBottom = $templateOptions->get('Abstand-unten');

// -------------------------------------------

$classDistanceTop = ($distanceTop) ? 'distanceTop' : '';
$classDistanceBottom = ($distanceBottom) ? 'distanceBottom' : '';

// -------------------------------------------

$link = $templateOptions->get('Link');
if(0 < mb_strlen($link)) {
	$link = ('http' == mb_substr(mb_strtolower($link),0,4)) ? $link : 'http://' . $link;
}
$link = (0 == mb_strlen($link)) ? '#!' : $link;
$onClick = ('#!' == $link) ? 'onclick="return false;"' : '';

// -------------------------------------------

$icon = $templateOptions->get('Icon');

switch ($icon) {

    case 'Oesterreich-Flagge':
        $iconImage = '/images/oe2016/xlHeadline/iconFlaggeOesterreich.png';
        $classIcon = 'withIcon oesterreichFlagge';
        break;

    case 'Weltkugel':
        $iconImage = '/images/oe2016/xlHeadline/iconWeltkugel.png';
        $classIcon = 'withIcon weltkugel';
        break;

    case 'Geld':
        $iconImage = '/images/oe2016/xlHeadline/iconGeld.png';
        $classIcon = 'withIcon geld';
        break;

    case 'Rakete':
        $iconImage = '/images/oe2016/xlHeadline/iconRakete3.png';
        $classIcon = 'withIcon rakete';
        break;

    default:
        $iconImage = '';
        $classIcon = '';
        break;
}

// -------------------------------------------


?>
<div class="xlHeadLineBox <?= $layoutIdentifier; ?> <?= $classDistanceTop; ?> <?= $classDistanceBottom; ?> <?= $classIcon; ?>">
    <h2 class="xlHeadLine headline defaultChannelBackgroundColor" <?= $styleDefinition; ?>>
        <a href="<?= $link; ?>" <?= $onClick; ?>>
        	<? if (0): ?>
        		<? /* (db) icons vorläufig herausgenommen, falls sie doch auch mobil gewünscht werden im css headline.css einkommentieren */ ?>
	        	<? if (!empty($iconImage)):?>
	                <span class="xlHeadLineIcon">
	                    <img src="<?= $iconImage; ?>" alt="">
	                </span>
	            <? endif; ?>
			<? endif; ?>
        	<span class="xlText"><?= $headline; ?></span>
        </a>
    </h2>
</div>

