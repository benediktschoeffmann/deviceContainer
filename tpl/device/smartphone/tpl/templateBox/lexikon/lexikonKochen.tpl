<?php
/**
 * OE2016 Lexikon kochen
 *
 * Holt sich die Lexikon-Einträge aus dem MappingLevel mit dem Namen des LayoutOverride.
 * Gibt es in diesem MappingLevel kein Level 'Lexikon', oder gibt es keine Einträge, wird nichts ausgespielt.
 * &nbsp;
 * Header-Text: Zum Anzeigen eines Textes über dem eigentlichen Lexikon, als Information gedacht.
 * Lexikon-Auswahl: Zum Auswählen eines Lexikons
 *
 * @var channel oe24.core.Channel
 * @var box oe24.core.TemplateBox
 * @templateOption Header-Text text
 * @templateOption Lexikon-Auswahl select[Kochen,ObstUndGemuese,Gewuerze]
 */

$templateOptions = $box->getTemplateOptions();
$templateHeaderText = $templateOptions->get('Header-Text');
$templateLexikonAuswahl = (null === $templateOptions->get('Lexikon-Auswahl')) ? 'LexikonKochen' : 'Lexikon' . $templateOptions->get('Lexikon-Auswahl');
$templateLexikonAuswahl = str_replace('ue', 'ü', $templateLexikonAuswahl);

$channelOptions = $channel->getOptions(true, true);
$layoutOverride = $channelOptions->get('layoutOverride');
etpl('oe24.oe24.device.smartphone.tpl.contentBox.lexikon.lexikon', array('layout' => $layoutOverride, 'headerText' => $templateHeaderText, 'lexikonAuswahl' => $templateLexikonAuswahl));
return;
