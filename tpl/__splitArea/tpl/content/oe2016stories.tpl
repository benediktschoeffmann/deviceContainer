<?php
/**
 * OE2016 Standard ContentBox Stories
 * @var channel oe24.core.Channel
 * @var box oe24.core.ContentBox
 * @var stories array<any>
 * @var columnsCounter integer
 * @var layoutPortrait boolean
 * @var showStoryTime boolean
 * @var hideLeadText boolean
 * @var withTitleOverlay boolean
 * @var overlay string
 * @var layoutIdentifier string
 * @default hideLeadText 0
 * @default layoutIdentifier oe24
 */

$layoutIdentifier = strtolower($layoutIdentifier);

// ------------------------------------------

$showStoryTimeClass = '';
if ($showStoryTime) {
    $showStoryTimeClass = 'withStoryTime';
}

$portraitClass = '';
if ($layoutPortrait) {
    $portraitClass = 'portrait';
}

// ------------------------------------------

$validImageFormatsStandard = array(
    'bigStory',
    '292x146NoStretch',
    '190x95NoStretch',

    // 'bigStoryCrop',
    // '292x146Crop',
    // '292x146Crop',
);

$validImageFormatsPortrait = array(
    '300x300',
    '292x146NoStretch',
    '292x146NoStretch',

    // '300x300',
    // '292x146Crop',
    // '292x146Crop',
);

// ------------------------------------------

// (ws) 2017-04-06
// Anpassung, damit diese Box z.B. auch fuer Madonna "geeignet" ist

$layoutIdentifierSpecial = array(
    'madonna',
);

$validImageFormatsStandardSpecial = array(
    '620x388',
    '300x300',
    '300x300',
);

$validImageFormatsPortraitSpecial = array(
    null,
    '300x300',
    '300x300',
);

// (ws) 2017-04-06 end

// ------------------------------------------

// $emptyImage = lp('image', 'empty.gif');
$emptyImage = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNgYAAAAAMAASsJTYQAAAAASUVORK5CYII=';

// ------------------------------------------

$storiesData = array();

foreach ($stories as $key => $story) {

    $frontendDate = $story->getFrontendDate();
    $frontendTime = formatDateUsingIntlLangKey('time.short', $frontendDate);

    // ----------------------------------------------

    $preTitle = trim($story->getPreTitle(true, $box));

    // ----------------------------------------------

    $title = trim($story->getTitle(true, $box)); // mergeOverride = true (Content-Overwrite-Title), $mergeBox = true (Box-Overwrite-Title)

    // Am Dev unnoetigen Titel-Prefix entfernen
    $title = str_replace(array('OEST15 - ', 'mad15 -'), '', $title);

    // ----------------------------------------------

    $leadText = trim($story->getLeadText(true, true, $box));

    // whitespace entfernen
    $leadText = preg_replace('/\s*$/iusU','',$leadText);
    $leadText = trim(str_replace(array("\n\r","\n","\r"), ' ', $leadText));

    // ----------------------------------------------

    $linkAttr = getContentUrlAttributesArray($story, $box, true, true, true);

    $href = (isset($linkAttr['href']) && is_string($linkAttr['href'])) ? $linkAttr['href'] : '#!';
    $target = (isset($linkAttr['target']) && is_string($linkAttr['target']) && '' != $linkAttr['target']) ? 'target="'.$linkAttr['target'].'"' : '';

    // (ws) 2014-08-04
    // Beispiel: http://ad1.adfarm1.adition.com/redi?sid=2700873&kid=1017356&bid=3399153
    $href = str_replace(array('&kid', '&bid'), array('&amp;kid', '&amp;bid'), $href);

    // ----------------------------------------------

    $image = $story->getFirstRelatedImage(true, $box);
    $imageUrl = $emptyImage;

    if ($image) {

        // if ($layoutPortrait) {
        //     $imageFormat = $validImageFormatsPortrait[$key];
        // } else {
        //     $imageFormat = $validImageFormatsStandard[$columnsCounter - 1];
        // }

        // (ws) 2017-04-06

        $foundLayoutIdentifier = in_array($layoutIdentifier, $layoutIdentifierSpecial, true);

        switch ($foundLayoutIdentifier) {
            case true:
                if ($layoutPortrait) {
                    $imageFormat = $validImageFormatsPortraitSpecial[$key];
                } else {
                    $imageFormat = $validImageFormatsStandardSpecial[$columnsCounter - 1];
                }
                break;
            case false:
                if ($layoutPortrait) {
                    $imageFormat = $validImageFormatsPortrait[$key];
                } else {
                    $imageFormat = $validImageFormatsStandard[$columnsCounter - 1];
                }
                break;
            default:
                if ($layoutPortrait) {
                    $imageFormat = $validImageFormatsPortrait[$key];
                } else {
                    $imageFormat = $validImageFormatsStandard[$columnsCounter - 1];
                }
                break;
        }


        // $id = $story->getId();
        // if (161584459 == $id || 161584638 == $id) {
        //     debug($layoutIdentifier.', '.var_export($foundLayoutIdentifier, true).', '.$imageFormat);
        // }

        // (ws) 2017-04-06 end

        $imageUrl = $image->getFileUrl($imageFormat);
    }

    // ----------------------------------------------

    $copyright = (null != $image) ? trim($image->getCopyright()) : 'unbekannt';
    $copyright = '&copy; '.$copyright;

    // (ws) 2014-11-25 Copyright wird nicht angezeigt
    $copyright = '';

    // ----------------------------------------------
    // (pj) 2016-04-13 Overlaytext fuer Sportkanal hinzugefuegt

    switch ($overlay) {
        case 'Channel':
            $homeChannel = $story->getHomeChannel();
            $storyChannels = $story->getChannels();
            $homeChannel = ($homeChannel) ? $homeChannel : reset($storyChannels);
            $overlayText = ($homeChannel) ? $homeChannel->getPageTitle() : '';
            break;

        case 'Tag':
            $tags = $story->getTags();
            $overlayText = (isset($tags[0])) ? $tags[0]->getName() : '';
            break;

        default:
            $overlayText = '';
            break;
    }

    // (pj) 2016-04-13 end

    // ----------------------------------------------
    // ----------------------------------------------

    $storiesData[] = array(
        'href'         => $href,
        'target'       => $target,
        'preTitle'     => $preTitle,
        'title'        => $title,
        'leadText'     => $leadText,
        'frontendTime' => $frontendTime,
        'imageUrl'     => $imageUrl,
        'copyright'    => $copyright,
        'overlayText'  => $overlayText,
    );
}

?>

<div class="standardContentBox <?= $showStoryTimeClass; ?> <?= $portraitClass; ?> <?= $layoutIdentifier; ?> clearfix">


    <? if (true == $layoutPortrait): ?>


        <?

        // ----------------------------
        // PORTRAIT
        // ----------------------------

        $story = array_shift($storiesData);

        ?>


        <div class="columnLeft">
            <div class="column column2">
                <?
                tpl('oe24.oe24.__splitArea.tpl.content.oe2016storiesStory', array(
                    'story'            => $story,
                    'columnsCounter'   => $columnsCounter,
                    'showStoryTime'    => $showStoryTime,
                    'hideLeadText'     => $hideLeadText,
                    'layoutPortrait'   => $layoutPortrait,
                    'withTitleOverlay' => false,
                    'withMarker'       => true,
                    'layoutIdentifier' => $layoutIdentifier,
                ));
                ?>
            </div>
        </div>

        <div class="columnRight">
            <? foreach ($storiesData as $key => $story): ?>
                <div class="column column2">
                    <?
                    tpl('oe24.oe24.__splitArea.tpl.content.oe2016storiesStory', array(
                        'story'            => $story,
                        'columnsCounter'   => $columnsCounter,
                        'showStoryTime'    => $showStoryTime,
                        'hideLeadText'     => $hideLeadText,
                        'layoutPortrait'   => $layoutPortrait,
                        'withTitleOverlay' => false,
                        'withMarker'       => false,
                        'layoutIdentifier' => $layoutIdentifier,
                    ));
                    ?>
                </div>
            <? endforeach; ?>
        </div>


    <? else: ?>


        <?

        // ----------------------------
        // STANDARD
        // ----------------------------

        ?>


        <? foreach ($storiesData as $key => $story): ?>

            <?

            $tempClass = array();

            $tempClass[] = 'column'.$columnsCounter;
            $tempClass[] = (0 == ($key % $columnsCounter)) ? 'break' : '';
            $tempClass[] = (0 == (($key + 1) % $columnsCounter)) ? 'last' : '';

            $storyContainerClass = implode(' ', $tempClass);

            ?>

            <div class="column <?= $storyContainerClass; ?>">
                <?
                tpl('oe24.oe24.__splitArea.tpl.content.oe2016storiesStory', array(
                    'story'            => $story,
                    'columnsCounter'   => $columnsCounter,
                    'showStoryTime'    => $showStoryTime,
                    'hideLeadText'     => $hideLeadText,
                    'layoutPortrait'   => $layoutPortrait,
                    'withTitleOverlay' => $withTitleOverlay,
                    'withMarker'       => false,
                    'layoutIdentifier' => $layoutIdentifier,
                ));
                ?>
            </div>

        <? endforeach; ?>


    <? endif; ?>


</div>
