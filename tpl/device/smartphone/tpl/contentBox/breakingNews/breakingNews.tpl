<?
/**
 * breaking news
 * @var channel oe24.core.Channel
 * @var box oe24.core.ContentBox
 */

$templateOptions = $box->getTemplateOptions();

// ---------------------------------------------------

$spaceBeforeBox = $templateOptions->get('insertSpaceBeforeBox');
$spaceAfterBox = $templateOptions->get('insertSpaceAfterBox');
$classSpaceBeforeBox = ($spaceBeforeBox) ? 'spaceBeforeBox' : '';
$classSpaceAfterBox = ($spaceAfterBox) ? 'spaceAfterBox' : '';

// ---------------------------------------------------

$headline = trim($templateOptions->get('Headline'));
$headline = ($headline) ? $headline : '';

// ---------------------------------------------------

$entryText = $templateOptions->get('EntryText');
$entryText = ($entryText) ? trim($entryText) : 'Breaking News';

// ---------------------------------------------------

$content = $box->getContentOfAllDropAreas(true, false);
$firstStory = (!empty($content)) ? array_shift($content) : null;
$firstStoryTitle = ($firstStory) ? $firstStory->getTitle(true, $box) : '';

// ---------------------------------------------------

$breakingNews = ($headline) ? $headline : $firstStoryTitle;

if (empty($breakingNews)) {
    return;
}

// ---------------------------------------------------

// (db) 2017-05-09 Textgeschwindigkeit je nach Textlänge anpassen

$breakingNewsTextSpeed = (120 < mb_strlen($breakingNews)) ? 'speedSlow' : 'speedNormal';
$breakingNewsTextSpeed = (80 > mb_strlen($breakingNews)) ? 'speedFast' : $breakingNewsTextSpeed;

// ---------------------------------------------------

$linkAttr = getContentUrlAttributesArray($firstStory, $box, true, true, true);

$href = (isset($linkAttr['href']) && is_string($linkAttr['href'])) ? $linkAttr['href'] : '#!';
$target = (isset($linkAttr['target']) && is_string($linkAttr['target']) && '' != $linkAttr['target']) ? 'target="'.$linkAttr['target'].'"' : '';

// ---------------------------------------------------

// Wenn eine "User-Headline" angegeben ist, aber noch kein Artikel
// dazu vorhanden ist, gibt es auch keie URL dazu.

$onClick = '';

if ($headline) {
    $href = '#!';
    $onClick = 'onclick="return false;"';
}

// ---------------------------------------------------

?>

<div class="breakingNewsWrap <?= $classSpaceBeforeBox.' '.$classSpaceAfterBox.' '.$breakingNewsTextSpeed; ?>">

    <a class="breakingNewsLine" href="<?= $href; ?>" <?= $onClick; ?> >
        <span class="breakingNewsTeaser"><?= $entryText; ?></span>
        <span class="breakingNewsHeadline"><?= $breakingNews; ?></span>
    </a>

    <?
    // wegen eines Safari-Bugs wird der Animationsname hier per JavaScript gesetzt
    ?>
    <script>
        setTimeout(function() {
            if (null === (element = document.querySelector('.breakingNewsLine'))) {
                return;
            }
            element.style.animationName = 'breakingNewsAnimation';
        }, 400);
    </script>

</div>
