<?
/**
 * Newsletter 2017 Content Rows
 *
 * @var box oe24.core.ContentBox
 * @var channel oe24.core.Channel
 * @var validImageInfo array<any>
 * @var allRowStories array<any>
 * @var rowCols integer
 * @var rowColumnWidth string
 * @var color string
 * @var class string
 * @var useNumbers boolean
 */

// ----------------------------------------------

$stylesContentColumn = array(
    'padding:10px 0px 10px 0px',
    // 'background-color:transparent',
);

?>
<? if (1): // Middle Rows Stories ?>
    <? foreach ($allRowStories as $rowStories): ?>
    <tr class="<?= $class; ?>">
        <td style="<?= implode(';', $stylesContentColumn); ?>">
            <table align="center" valign="top" border="0" cellpadding="0" cellspacing="0" width="620">
                <tr>
                    <? foreach ($rowStories as $key => $story): ?>
                        <?
                        if ($rowCols > 1) {
                            $padding = (0 == $key) ? 'padding:0px 18px 0px 0px;' : 'padding:0px 0px 0px 18px;';
                        } else {
                            $padding = '';
                        }
                        ?>
                        <td valign="top" width="<?= $rowColumnWidth; ?>" style="<?= $padding; ?>">
                            <?
                            tpl('oe24.oe24.__splitArea.tpl.content.newsletter2017contentStory', array(
                                'box'          => $box,
                                'channel'      => $channel,
                                'story'        => $story,
                                'storyType'    => (1 == $rowCols) ? 'bigStory' : 'smallStory',
                                'color'        => $color,
                                'useNumbers'   => $useNumbers,
                                'imageInfo'    => (1 == $rowCols) ? $validImageInfo['bigStory'] : $validImageInfo['smallStory'],
                                'isVideoStory' => ($story instanceof Video) ? true : false,
                            ));
                            ?>
                        </td>
                    <? endforeach; ?>
                </tr>
            </table>
        </td>
    </tr>
    <? endforeach; ?>
<? endif; ?>
