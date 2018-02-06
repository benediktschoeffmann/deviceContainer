<?
/**
 * Teaser Story Box
 *
 * @var channel oe24.core.Channel
 * @var box oe24.core.TemplateBox
 */

$check = isBoxInTabbox($channel, $box);

if ($check instanceof TabbedBox || !$check) {
    return;
}

// --------------------------------------------------

$templateOptions = $box->getTemplateOptions();

$boxId = $templateOptions->get('Teaser-Story-Box-Id');
$boxId = ($boxId && ctype_digit($boxId)) ? $boxId : null;

if (null == $boxId) {
    return;
}

$showHeadline = $templateOptions->get('show-Headline');
$showHeadline = ($showHeadline) ? true : false;

$layoutIdentifier = $templateOptions->get('Layout-Identifier');
$layoutIdentifier = ($layoutIdentifier) ? $layoutIdentifier : 'oe24';

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

// debug($story);

// ------------------------------------------

$linkAttr = getContentUrlAttributesArray($story, $box, true, true, true);

$href = (isset($linkAttr['href']) && is_string($linkAttr['href'])) ? $linkAttr['href'] : '#!';
$target = (isset($linkAttr['target']) && is_string($linkAttr['target']) && '' != $linkAttr['target']) ? 'target="'.$linkAttr['target'].'"' : '';

// ------------------------------------------

// Eine "Liste" der Stories mit genau dieser einen Story
$stories = array(
    $story,
);

?>

<div class="tabbedBox <?= $layoutIdentifier; ?>">

    <? if (true == $showHeadline): ?>

        <div class="headlineBox layout_<?= $layoutIdentifier; ?>">
            <h2 class="headline defaultChannelBackgroundColor">
                <a href="<?= $href; ?>">
                    <?= $headline; ?>
                </a>
            </h2>
        </div>

    <? endif; ?>

    <?
    tpl('oe24.oe24.device.smartphone.tpl.contentBox.contentBoxStories', array(
        'channel'          => $channel,
        'box'              => $box,
        'stories'          => $stories,
        'showStoryTime'    => false,
        'overlay'          => '',
        'layoutIdentifier' => $layoutIdentifier,
    ));
    ?>

</div>
