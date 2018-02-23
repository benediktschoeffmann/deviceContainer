<?php
/**
 * Row Caption - rl2014
 * @var templateOptions spunQ_Map
 * @var homeChannelUrl string
 */

$row_caption = array(
	'row_caption_title' => $templateOptions->get('Headline-Titel'),
	'row_caption_text' => $templateOptions->get('Headline-Text'),
	'row_caption_from' => $templateOptions->get('Headline-Von'),
	'row_caption_editor_image' => $templateOptions->get('RedakteurIn-Bild'),
	'row_caption_editor_text' => $templateOptions->get('RedakteurIn-Text'),
	'row_caption_editor_name' => $templateOptions->get('RedakteurIn-Name'),
);

// Workaround fuer das Umlautproblem der @templateOption select [...]
// Falls andere @templateOption select [...] mit Umlauten im Text oben eingetragen werden muessen die hier auch "hart codiert" angepasst werden
$row_caption['row_caption_from'] = ('OESTERREICH' === $row_caption['row_caption_from']) ? 'ÖSTERREICH' : $row_caption['row_caption_from'];

// Wenn beim Headline-Titel z.B. nur Leerzeichen eingegeben wurden, werden diese auch von spunQ so zurückgeliefert.
// D.h. $row_caption['row_caption_title'] !== null
$row_caption['row_caption_title'] = (null !== $row_caption['row_caption_title']) ? $row_caption['row_caption_title'] : ' '; //$channel->getName();


$urlLinks = ($templateOptions['URL-LinkerTeil']) ? $templateOptions['URL-LinkerTeil'] : '';
if ('' === $urlLinks) {
	$urlLinks = ($templateOptions['Links-HomeChannel']) ? $homeChannelUrl : '';
}
$targetLinks = ($templateOptions['Links-Target-Blank']) ? 'target="'.$templateOptions['Links-Target-Blank'].'"' : '';

$urlRechts = ($templateOptions['URL-RechterTeil']) ? $templateOptions['URL-RechterTeil'] : '';
$targetRechts = ($templateOptions['Rechts-Target-Blank']) ? 'target="'.$templateOptions['Rechts-Target-Blank'].'"' : '';

$class_row_caption_body = (isset($row_caption['row_caption_editor_image'])) ? '' : 'row_caption_body_noimage';

?>
<!-- row_caption start -->
<div class="row_caption">

	<div class="row_caption_body <?=$class_row_caption_body?>">

		<div class="row_caption_title">
			<? if (isset($row_caption['row_caption_title'])): ?>
				<? if ('' == $urlLinks): ?>
				<h2><?=$row_caption['row_caption_title']?></h2>
				<? else: ?>
				<h2><a href="<?=$urlLinks?>" <?=$targetLinks?>><?=$row_caption['row_caption_title']?></a></h2>
				<? endif ?>
			<? endif; ?>
		</div>

		<div class="row_caption_info">
			<? if ($urlRechts): ?>
			<a href="<?=$urlRechts?>" <?=$targetRechts?>>
			<? endif; ?>
				<? if (isset($row_caption['row_caption_text'])): ?>
				<span class="row_caption_text"><?=$row_caption['row_caption_text']?></span>
				<? endif; ?>

				<? if (isset($row_caption['row_caption_from'])): ?>
				<span class="row_caption_from"><?=$row_caption['row_caption_from']?></span>
				<? endif; ?>

				<? if (isset($row_caption['row_caption_editor_image'])): ?>
				<img class="row_caption_editor_image" src="<?=$row_caption['row_caption_editor_image']?>" alt="">
				<? endif; ?>

				<? if (isset($row_caption['row_caption_editor_text'])): ?>
				<span class="row_caption_editor_text"><?=$row_caption['row_caption_editor_text']?></span>
				<? endif; ?>

				<? if (isset($row_caption['row_caption_editor_name'])): ?>
				<span class="row_caption_editor_name"><?=$row_caption['row_caption_editor_name']?></span>
				<? endif; ?>
			<? if ($urlRechts): ?>
			</a>
			<? endif; ?>
		</div>

	</div>
</div>
<!-- row_caption end -->
