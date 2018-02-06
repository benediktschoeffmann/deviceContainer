<?
/**
 * Article NewsTicker TextSection
 * @var section oe24.core.TextSection
 */

$sectionName = $section->getName();
$sectionTitle = $section->getTitle();
$sectionLeadText = $section->getLeadText();
$sectionBodyText = $section->getBodyText();

$isSportTicker = $section->getTemplate() === 'sportticker';

$bodyText = TextualProcessor::getProcessedBodyText($section, Portal::getPortalByName('oe24', false), 'smartphone');
$shortDate = formatDateUsingIntlLangKey('time.short', $section->getFrontendDate());

$showImage = false;
if ($isSportTicker) {
    $tickerOptions = $section->getOptions();
    switch (true) {
        case (isset($tickerOptions['austausch']) && $tickerOptions['austausch'] == '1') :
            $imgUrl     = 'http://webmisc.oe24.at/fussball/images/emchange.png';
            $showImage  = true;
            break;
        case (isset($tickerOptions['gelbekarte']) && $tickerOptions['gelbekarte'] == '1') :
            $imgUrl     = 'http://webmisc.oe24.at/fussball/images/emyellow.png';
            $showImage  = true;
            break;
        case (isset($tickerOptions['rotekarte']) && $tickerOptions['rotekarte'] == '1') :
            $imgUrl     = 'http://webmisc.oe24.at/fussball/images/emred.png';
            $showImage  = true;
            break;
        case (isset($tickerOptions['gelbrotekarte']) && $tickerOptions['gelbrotekarte'] == '1') :
            $imgUrl     = 'http://webmisc.oe24.at/fussball/images/emyellowred.png';
            $showImage  = true;
            break;
        case (isset($tickerOptions['tor']) && $tickerOptions['tor'] == '1') :
            $imgUrl     = 'http://webmisc.oe24.at/fussball/images/emgoal.png';
            $showImage  = true;
            break;
        case (isset($tickerOptions['anpfiff']) && $tickerOptions['anpfiff'] == '1') :
            $imgUrl     = 'http://webmisc.oe24.at/fussball/images/empipe.png';
            $showImage  = true;
            break;
        default:
            break;
    }
}

?>

<div class="newsTickerEntry clearfix">
    <div class="tickerHeader clearfix">
        <div class="marker"></div>
        <div class="time"><?= $isSportTicker ? $sectionTitle : $shortDate; ?></div>
        <? if ($showImage) : ?>
            <span>&nbsp;</span>
            <img src="<?= $imgUrl; ?>" alt="">
        <? endif; ?>
        <!--
        <span class="name"><?//= $sectionName; ?></span>
        <h1 class="title"><?//= $sectionTitle; ?> </h1>
        -->
    </div>
    <div class="tickerBody">
        <? if ($sectionLeadText && !empty($sectionLeadText)) : ?>
            <h3><?= $sectionLeadText; ?></h3>
        <? endif; ?>
        <p>
            <?= $bodyText; ?>
        </p>
    </div>
</div>

