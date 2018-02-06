<?
/**
 * Teaser Story Box
 *
 * @var channel oe24.core.Channel
 * @var box oe24.core.TemplateBox
 */

// --------------------------------------------------

$templateOptions = $box->getTemplateOptions();

$boxId = $templateOptions->get('Teaser-Story-Box-Id');
$boxId = ($boxId && ctype_digit($boxId)) ? $boxId : null;

if (null == $boxId) {
    return;
}

// --------------------------------------------------

$originalBox = db()->getById($boxId, 'oe24.core.ContentBox', false);

if ( ! $originalBox) {
    error('Box nicht gefunden');
    return;
}

// --------------------------------------------------

$box = $originalBox;

// --------------------------------------------------

$templateOptions = $box->getTemplateOptions();

$headline = trim($templateOptions->get('Headline'));
$headline = ($headline) ? $headline : '';

// ------------------------------------------

$contentStories = $box->getContentOfAllDropAreas(true, true);

if (count($contentStories) < 1) {
    return;
}

// ------------------------------------------

$story = array_shift($contentStories);

if (!($story instanceof TextualContent)) {
    return;
}

// ------------------------------------------

$device = DeviceContainer::getDevice();
$layoutIdentifier = $device->getConfig('tabbedBoxLayoutIdentifier');

// Eine "Liste" der Stories mit genau dieser einen Story
$stories = array(
    $story,
);

// Muss dieser "Artikel" als Werbung gekennzeichnet werden?
// Wenn ja, dann komme ich fuer diese Art der Umsetzung ins Web-Programmierer-Fegefeuer
// $headline = $headline.'<span style="font-size:.5rem;padding-left:4px">(Werbung)</span>';

tpl('oe24.oe24.device.smartphone.tpl.contentBox.contentBoxStories', array(
    'channel'          => $channel,
    'box'              => $box,
    'stories'          => $stories,
    'showStoryTime'    => false,
    'overlay'          => $headline,
    'layoutIdentifier' => $layoutIdentifier,
));

?>
