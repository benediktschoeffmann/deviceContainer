<?
/**
 * TeleTrader Top Flop XML Box
 * @var channel oe24.core.Channel
 * @var box oe24.core.XmlBox
 */

// $xsltFileMobile = 'http://oe24dev.oe24.at/misc/xsl/oe2016ttTopFlopMobile.xsl';
$templateOptions = $box->getTemplateOptions();

// -------------------------------------------

$boxTitle = trim($box->getTitle());
$boxTitle = ($boxTitle) ? $boxTitle : '';

// -------------------------------------------

$xsltMobile = $templateOptions->get('Xslt-Mobile');

if ($xsltMobile) {

	// $xsltFileMobile = 'http://oe24dev.oe24.at/misc/xsl/oe2016ttTopFlopMobile.xsl';
	$html = $box->renderXmlContentWithNewXsl($xsltMobile);

	if (!$html) {
		return;
	}
}
else {
	$html = $box->getHtml();
}

// -------------------------------------------

$flickityOptions = array(

    'autoplay'        => false,
    'prevNextButtons' => true,
    'pageDots'        => false,
    'groupCells'      => true,

    // classCounter ist KEINE flickity-Option
    // wird verwendet um die CSS-Klasse des Zaehlerelements zu uebergeben
    'classCounter'    => '.storiesCounter',
); 

$options = json_encode($flickityOptions);

?>

<div class="teleTrader">
	<? if ($boxTitle): ?>
		<div class="teleTraderHeadlineBox">
			<span class="teleTraderHeadlineCaption defaultChannelBackgroundColor">
				<span class="teleTraderTitle headline"><?= $boxTitle; ?></span>				
			</span>
		</div>
	<? endif; ?>

	<? if (1): ?>
		<? if ($xsltMobile): ?>
			<div class="flickitySlider teleTraderTopFlop" data-options='<?= $options; ?>'>
				<?= $html; ?>
				<div class="storiesCounter">1</div>
			</div>
		<? else: ?>
			<?= $html; ?>
		<? endif; ?>
	<? endif; ?>
</div>
