<?
/**
 * Newsletter 2017
 *
 * @var portal oe24.core.Portal
 * @var channel oe24.core.Channel
 * @var subChannel string
 */

// --------------------------------------

// DAILY-649

// page/newsletter.page

// public/images/newsletter
// tpl/_contentBoxes/newsletter2017Image.tpl
// tpl/_contentBoxes/newsletter2017Content.tpl
// tpl/_contentBoxes/newsletter2017Header.tpl
// tpl/__splitArea/tpl/content/newsletter2017.tpl
// tpl/__splitArea/tpl/content/newsletter2017top.tpl
// tpl/__splitArea/tpl/content/newsletter2017footer.tpl
// tpl/__splitArea/tpl/content/newsletter2017boxHeadline.tpl
// tpl/__splitArea/tpl/content/newsletter2017contentRow.tpl
// tpl/__splitArea/tpl/content/newsletter2017contentRows.tpl
// tpl/__splitArea/tpl/content/newsletter2017contentStory.tpl
// tpl/__splitArea/tpl/content/newsletter2017imageRow.tpl
// tpl/__splitArea/tpl/content/newsletter2017imageStory.tpl

// --------------------------------------

$currentDate = formatDateUsingIntlLangKey('date.long', new spunQ_DateTime());
$channelColumnName = 'Split Area 2016';

// --------------------------------------

$column = $channel->getColumnByName($channelColumnName);
if (!$column) {
    return;
}

$boxes = $column->getBoxes();

// --------------------------------------

$colors = array(
    'oe24'          => '#d0113a',
    'oe24tv'        => '#d0113a',
    'new'           => '#d0113a',
    'politik'       => '#d0113a',
    'welt'          => '#0051b2',
    'oesterreich'   => '#f50f39',
    'bundeslaender' => '#f50f39',
    'wetter'        => '#007ddc',
    'sport'         => '#22b480',
    'money'         => '#174584',
    'madonna'       => '#ec589f',
    'leute'         => '#ff2b22',
    'society'       => '#ff2b22',
    'tv'            => '#59cad2',
    'video'         => '#59cad2',
    'gesund24'      => '#6a9dff',
    'kochen'        => '#b11679',
    'digital'       => '#708ab9',
    'reise'         => '#ff6200',
    'auto'          => '#2c3564',
);

// <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
$doctype = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">';

?>
<?= $doctype; ?>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="UTF-8" />
<title>Aktuelle Nachrichten vom <?= $currentDate; ?></title>

<?
// font-family: 'Merriweather', serif;
// font-family: 'Open Sans', sans-serif;
// <link href="https://fonts.googleapis.com/css?family=Merriweather:400,700|Open+Sans" rel="stylesheet">
?>

<style type="text/css">
a {
    text-decoration: none;
}
</style>

<!--[if mso]>
<style type="text/css">
body, table, td {
    font-family: "Arial Black", Arial, sans-serif !important;
}
</style>
<![endif]-->

<?

$stylesBody = array(
    // "font-family:'Arial Rounded MT Bold',Arial,sans-serif",
    // "font-family:'Arial Black',Arial,sans-serif",
    'font-family:Arial',
    'font-size:12px',
    'padding:0px 0px 0px 0px',
    'margin:0px 0px 0px 0px',
    'background-color:#e8e8e8',
);

$stylesWrapper = array(
    // "font-family:'Arial Rounded MT Bold',Arial,sans-serif",
    // "font-family:'Arial Black',Arial,sans-serif",
    'font-family:Arial',
    'font-size:12px',
    'padding:0px 0px 0px 0px',
    'margin:0px 0px 0px 0px',
    'background-color:#e8e8e8',
);

$stylesTable = array(
    'background-color:#ffffff',
);

// -----------------------------

$defaultAttributesTable = array(
    'align="center"',
    'valign="top"',
    'border="0"',
    'cellpadding="0"',
    'cellspacing="0"',
);

?>

</head>
<body style="<?= implode(';', $stylesBody); ?>">

    <table <?= implode(' ', $defaultAttributesTable); ?> width="100%" style="<?= implode(';', $stylesWrapper); ?>">
        <tr>
            <td>

                <table <?= implode(' ', $defaultAttributesTable); ?> width="670" style="<?= implode(';', $stylesTable); ?>" summary="Newsletter">
                    <tbody>

                        <?
                        if (1) {
                            tpl('oe24.oe24.__splitArea.tpl.content.newsletter2017top', array(
                                'portal'     => $portal,
                                'channel'    => $channel,
                                'subChannel' => $subChannel,
                                'colors'     => $colors,
                            ));
                        }
                        ?>

                        <?
                        if (1) {
                            _iterateFrontendBoxes($boxes, $channel, $channelColumnName, array(
                                'subChannel'  => $subChannel,
                                'colors'      => $colors,
                                'currentDate' => $currentDate,
                            ));
                        }
                        ?>

                        <?
                        if (1) {
                            tpl('oe24.oe24.__splitArea.tpl.content.newsletter2017footer', array(
                                'portal'     => $portal,
                                'channel'    => $channel,
                                'subChannel' => $subChannel,
                                'colors'     => $colors,
                            ));
                        }
                        ?>

                    </tbody>
                </table>

            </td>
        </tr>
    </table>

</body>
</html>
