<?php
/**
 * Newsletter 2017 Content Story
 *
 * @var box oe24.core.ContentBox
 * @var channel oe24.core.Channel
 * @var story oe24.core.TextualContent
 * @var storyType string
 * @var color string
 * @var imageInfo array<any>
 * @var isVideoStory boolean
 * @var useNumbers boolean
 */

// storyType: bigStory | smallStory

// ----------------------------------------------

$id = $story->getId();

$preTitle = trim($story->getPreTitle(true, $box));

$title = trim($story->getTitle(true, $box));

$leadText = trim($story->getLeadText(true, true, $box));
// whitespace entfernen
$leadText = preg_replace('/\s*$/iusU','',$leadText);
$leadText = trim(str_replace(array("\n\r","\n","\r"), ' ', $leadText));

$bodyText = trim($story->getBodyText(true, true));

$linkAttr = getContentUrlAttributesArray($story, $box, true, true, true);
$href = (isset($linkAttr['href']) && is_string($linkAttr['href'])) ? $linkAttr['href'] : '#!';
$target = 'target="_blank"';

$image = $story->getFirstRelatedImage(true, $box);

if ($image) {
    $imageSrc = $image->getFileUrl($imageInfo['format']);
} else {
    $imageSrc = $imageInfo['emptyImage'];
}

// $sequentialNumber = $story->sequentialNumber;
$storyOptions = $story->getOptions();
$sequentialNumber = $storyOptions->getByKey('sequentialNumber');

// ----------------------------------------------

$fontSizePreTitle = ('bigStory' == $storyType) ? '14px' : '12px';
$fontSizeTitle    = ('bigStory' == $storyType) ? '30px' : '24px';
$fontSizeLeadText = ('bigStory' == $storyType) ? '15px' : '15px';

$lineHeightPreTitle = ('bigStory' == $storyType) ? '30px' : '24px';
$lineHeightTitle    = ('bigStory' == $storyType) ? '33px' : '27px';
$lineHeightLeadText = ('bigStory' == $storyType) ? '19px' : '18px';

// ----------------------------------------------

$stylesStoryImage = array(
    'width:100%',
    'background-color:#f8f8f8',
    // 'display:block',
);

$stylesLink = array(
    // "font-family:'Arial'",
    'text-decoration:none',
    'color:#000000',
    // 'display:block',
);

// ----------------------------------------------

$stylesPreTitle = array(
    "font-family:'Arial'",
    'font-size:'.$fontSizePreTitle,
    'font-weight:bold',
    'text-transform:uppercase',
    // 'padding:6px 0px 0px 0px',
    'color:'.$color,
    // 'display:block',
);

$stylesTitle = array(
    // "font-family:'Arial Black','Arial Rounded MT Bold',Arial,sans-serif",
    "font-family:'Arial'",
    'font-size:'.$fontSizeTitle,
    'font-weight:bold',
    'line-height:'.$lineHeightTitle,
    // 'padding:2px 0px 2px 0px',
);

$stylesLeadText = array(
    "font-family:'Arial'",
    'font-size:'.$fontSizeLeadText,
    'font-weight:normal',
    'line-height:'.$lineHeightLeadText,

    // 'padding:6px 0px 6px 0px',
);

$stylesVideoStory = array(
    'padding:0px 6px 0px 6px',
    'color:#ffffff',
    'background-color:'.$color,
);

// ----------------------------------------------

$stylesPreTitleBox = array(
    // 'padding:6px 0px 0px 0px',
    'margin:6px 0px 0px 0px',
);

$stylesTitleBox = array(
    // 'padding:2px 0px 2px 0px',
    'margin:2px 0px 2px 0px',
);

$stylesLeadTextBox = array(
    // 'padding:6px 0px 6px 0px',
    // 'padding:4px 0px 4px 0px',
    // 'padding:2px 0px 2px 0px',
    'margin:6px 0px 6px 0px',
);

// ----------------------------------------------

$fontSizeSequentialNumber = ('bigStory' == $storyType) ? '21px' : '17px';
// $lineHeightSequentialNumber =  ('bigStory' == $storyType) ? '33px' : '27px';
$lineHeightSequentialNumber =  ('bigStory' == $storyType) ? '21px' : '17px';

// $stylesSequentialNumber = array(
//     "font-family:'Arial'",
//     'font-size:'.$fontSizeSequentialNumber,
//     'font-weight:bold',
//     // 'vertical-align:top',
//     // 'padding:0px 8px',
//     // 'color:#ffffff',
//     // 'background-color:'.$color,
//     'line-height:'.$lineHeightSequentialNumber,
//     // 'vertical-align:middle',
// );

// $stylesSequentialNumberContent = array(
//     'color:#ffffff',
//     'background-color:'.$color,
//     'line-height:'.$lineHeightSequentialNumber,
//     'vertical-align:top',
// );

$stylesSequentialNumber = array(
    'font-size:'.$fontSizeSequentialNumber,
    // 'line-height:'.$lineHeightSequentialNumber,
    'color:#ffffff',
    'background-color:'.$color,
    'vertical-align:top',
);

$stylesTitleContent = array(
    'vertical-align:top',
);

// ----------------------------------------------

// Zwecks Debugging
// $preTitle = $preTitle.' '.$id;

?>
<div>

    <div>
        <a href="<?= $href; ?>" <?= $target; ?> style="<?= implode(';', $stylesLink); ?>">
            <img src="<?= $imageSrc; ?>" alt="" style="<?= implode(';', $stylesStoryImage); ?>">
        </a>
    </div>

    <div style="<?= implode(';', $stylesPreTitleBox); ?>">
        <a href="<?= $href; ?>" <?= $target; ?> style="<?= implode(';', $stylesLink); ?>">
            <? if ($isVideoStory): ?>
                <? if ($preTitle): ?>
                    <span style="<?= implode(';', $stylesPreTitle); ?>">
                        <span style="<?= implode(';', $stylesVideoStory); ?>">Video</span>&nbsp;<?= $preTitle; ?>
                    </span>
                <? endif; ?>
            <? else: ?>
                <? if ($preTitle): ?>
                    <span style="<?= implode(';', $stylesPreTitle); ?>">
                        <?= $preTitle; ?>
                    </span>
                <? endif; ?>
            <? endif; ?>
        </a>
    </div>

    <? if ($title): ?>
    <div style="<?= implode(';', $stylesTitleBox); ?>">
        <a href="<?= $href; ?>" <?= $target; ?> style="<?= implode(';', $stylesLink); ?>">
            <? if ($useNumbers && is_int($sequentialNumber)): ?>

                <? if (0): ?>
                <strong style="<?= implode(';', $stylesTitle); ?>">
                    <span style="<?= implode(';', $stylesSequentialNumber); ?>"><?= $sequentialNumber; ?></span>
                    <?= $title; ?>
                </strong>
                <? endif; ?>

                <? if (0): ?>
                <strong style="<?= implode(';', $stylesSequentialNumber); ?>">
                    <span style="<?= implode(';', $stylesSequentialNumberContent); ?>">&nbsp;<?= $sequentialNumber; ?>&nbsp;</span>
                </strong>
                <? endif; ?>

                <strong style="<?= implode(';', $stylesTitle); ?>">
                    <span style="<?= implode(';', $stylesSequentialNumber); ?>">&nbsp;<?= $sequentialNumber; ?>&nbsp;</span>
                    <span style="<?= implode(';', $stylesTitleContent); ?>"><?= $title; ?></span>
                </strong>

            <? else: ?>
                <strong style="<?= implode(';', $stylesTitle); ?>">
                    <?= $title; ?>
                </strong>
            <? endif; ?>
        </a>
    </div>
    <? endif; ?>

    <? if ($leadText): ?>
    <div style="<?= implode(';', $stylesLeadTextBox); ?>">
        <a href="<?= $href; ?>" <?= $target; ?> style="<?= implode(';', $stylesLink); ?>">
            <span style="<?= implode(';', $stylesLeadText); ?>"><?= $leadText; ?></span>
        </a>
    </div>
    <? endif; ?>

</div>
