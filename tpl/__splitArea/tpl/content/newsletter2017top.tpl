<?
/**
 * Newsletter 2017 Top
 *
 * @var portal oe24.core.Portal
 * @var channel oe24.core.Channel
 * @var subChannel string
 * @var colors array<any>
 */

$channelUrl = $channel->getUrl();

$stylesShowWebsite = array(
    'text-align:center',
    'padding:10px 0px 10px 0px',
    'background-color:#e8e8e8',
);

$stylesShowWebsiteLink = array(
    // 'text-decoration:none',
    'color:#b1001d',
);

?>
<tr>
    <td valign="top">
        <div style="<?= implode(';', $stylesShowWebsite); ?>">
            <a href="<?= $channelUrl; ?>" style="<?= implode(';', $stylesShowWebsiteLink); ?>">Im Web-Browser zeigen</a>
        </div>
    </td>
</tr>
