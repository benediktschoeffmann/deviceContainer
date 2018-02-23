<?
/**
 * Newsletter 2017 Footer
 *
 * @var portal oe24.core.Portal
 * @var channel oe24.core.Channel
 * @var subChannel string
 * @var colors array<any>
 */

$footerLinks = array(
    'impressum' => array(
        'url'    => 'http://www.oe24.at/service/Impressum-OE24/1637563',
        'text'   => 'Impressum',
    ),
    'anb' => array(
        'url'    => 'http://www.oe24.at/oesterreich/agb/AGB/800276',
        'text'   => 'AGB',
    ),
    'unsubscribe' => array(
        'url'    => 'http://www.oe24.at/service',
        'text'   => 'Newsletter abmelden',
        'id'     => 'replace1991',
    ),
);

// ----------------------------------------------

$stylesContentColumn = array(
    'padding:10px 0px 30px 0px',
    'background-color:#e8e8e8',
);

$stylesLinks = array(
    // 'text-decoration:none',
    'font-weight:bold',
    'text-align:center',
    'padding:0px 5px 0px 5px',
    'color:#b1001d',
);

$stylesUnsubscribe = array(
    // 'text-decoration:none',
    'font-size:10px',
    // 'font-weight:bold',
    'text-align:center',
    'padding:0px 5px 0px 5px',
    'color:#b1001d',
    // 'color:#999999',
);

?>

<tr>
    <td align="center" valign="top" style="<?= implode(';', $stylesContentColumn); ?>">
        <a href="<?= $footerLinks['impressum']['url']; ?>" style="<?= implode(';', $stylesLinks); ?>">
            <?= $footerLinks['impressum']['text']; ?>
        </a>
        <a href="<?= $footerLinks['anb']['url']; ?>" style="<?= implode(';', $stylesLinks); ?>">
            <?= $footerLinks['anb']['text']; ?>
        </a>
        <div style="padding:4px 0">
            <a href="<?= $footerLinks['unsubscribe']['url']; ?>" id="<?= $footerLinks['unsubscribe']['id']; ?>" style="<?= implode(';', $stylesUnsubscribe); ?>">
                <?= $footerLinks['unsubscribe']['text']; ?>
            </a>
        </div>
    </td>
</tr>

