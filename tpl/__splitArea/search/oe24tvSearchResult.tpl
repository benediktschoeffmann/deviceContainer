<?php
/**
 * oe24tv Search Result
 *
 * @var channel oe24.core.Channel
 * @var stories array<oe24.core.Video>
 */

$box = new ContentBox();
$box->setChannels(array($channel));

// Anzahl der Spalten
$columnsCounter = 4;

// Anzahl der gewuenschten Zeilen
$rows = 3;

// ------------------------------------------

$imageFormat = '292x146NoStretch';
$emptyImage = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNgYAAAAAMAASsJTYQAAAAASUVORK5CYII=';

// (ws) 2016-10-19
$channelOptions = $channel->getOptions(true, true);
$channelLayoutOverride = $channelOptions->get('layoutOverride');
if ('tv' == $channelLayoutOverride) {
    $imageFormat = '292x146Crop';
}
// (ws) 2016-10-19 end

// ------------------------------------------

$storiesData = array();

foreach ($stories as $key => $story) {

    $frontendDate = $story->getFrontendDate();
    $frontendTime = formatDateUsingIntlLangKey('time.short', $frontendDate);

    // ----------------------------------------------

    $preTitle = trim($story->getPreTitle(true));

    // ----------------------------------------------

    $title = trim($story->getTitle(true)); // mergeOverride = true (Content-Overwrite-Title), $mergeBox = true (Box-Overwrite-Title)

    // Am Dev unnoetigen Titel-Prefix entfernen
    $title = str_replace(array('OEST15 - ', 'mad15 -'), '', $title);

    // ----------------------------------------------

    $leadText = trim($story->getLeadText(true, true));

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
        $imageUrl = $image->getFileUrl($imageFormat);
    }

    // ----------------------------------------------

    $copyright = (null != $image) ? trim($image->getCopyright()) : 'unbekannt';
    $copyright = '&copy; '.$copyright;

    // (ws) 2014-11-25 Copyright wird nicht angezeigt
    $copyright = '';

    $isVideo = ($story instanceof Video) ? true : false;
    $videoLength = '--:--';
    if ($isVideo) {
        $videoLength = $story->getVideoLength();
        $videoLength = ($videoLength) ? $videoLength : '--:--';
        $leadText = $videoLength;
    }

    // (ws) 2016-10-29 end

    // ----------------------------------------------

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
        // 'overlayText'  => $overlayText,
        'isVideo'      => $isVideo,
    );
}

// ------------------------------------------

$showStoryTimeClass = 'withStoryTime';

?>

<div class="row oe24">
    <div class="content fullwide">

        <div class="standardContentBox <?= $showStoryTimeClass; ?> clearfix">

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
                        'columnsCounter'   => 4,
                        'showStoryTime'    => false,
                        'layoutPortrait'   => false,
                        'withTitleOverlay' => false,
                        'withMarker'       => false,
                    ));
                    ?>
                </div>

            <? endforeach; ?>

        </div>

    </div>
</div>
