<?
/**
 * Newsletter 2017 Image Row
 *
 * @var box oe24.core.ContentBox
 * @var channel oe24.core.Channel
 * @var image oe24.core.Image
 * @var url string
 */

$class = 'imageRow';

// ----------------------------------------------

$stylesColumn = array(
    'padding:10px 0 10px 0',
    // 'background-color:transparent',
);

$stylesContentColumn = array(
);

?>
<tr class="<?= $class; ?>">
    <td style="<?= implode(';', $stylesColumn); ?>">
        <table align="center" valign="top" border="0" cellpadding="0" cellspacing="0" width="620">
            <tr>
                <td valign="top" width="100%" style="<?= implode(';', $stylesContentColumn); ?>">
                    <?
                    tpl('oe24.oe24.__splitArea.tpl.content.newsletter2017imageStory', array(
                        'box'     => $box,
                        'channel' => $channel,
                        'image'   => $image,
                        'url'     => $url,
                    ));
                    ?>
                </td>
            </tr>
        </table>
    </td>
</tr>
