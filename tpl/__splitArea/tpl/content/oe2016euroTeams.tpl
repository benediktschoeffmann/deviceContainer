<?php

/**
 * OE2016 Sport Tabbox Nationalteam
 *
 * @var channel oe24.core.Channel
 * @var column oe24.core.ChannelColumn
 * @var box oe24.core.TabbedBox
 * @var params array<any>
 */

$collectionId = isset($params['collectionId']) ? $params['collectionId'] : null;
if (null == $collectionId || false == ctype_digit($collectionId)) {
    return;
}

$cssClassBox = isset($params['cssClassBox']) ? $params['cssClassBox'] : null;
if (null == $cssClassBox || false == is_string($cssClassBox)) {
    return;
}

// ------------------------------------------

$collection = db()->getById($collectionId, 'oe24.core.ContentCollection', false);
if (null == $collection) {
    return;
}

if (!($collection instanceof DynamicContentCollection)) {
    return;
}

$collection = db()->getById($collectionId, 'oe24.core.DynamicContentCollection', false);
if (null == $collection) {
    return;
}

if (false == $collection->isPublished()) {
    return;
}

// ------------------------------------------

$collectionChannels = $collection->getChannels();
if (!$collectionChannels) {
    return;
}

$data = array();
foreach ($collectionChannels as $collectionChannel) {

    $itemText = $collectionChannel->getPageTitle();
    if (!$itemText) {
        continue;
    }

    $itemName = $collectionChannel->getName();
    if (!$itemName) {
        continue;
    }

    $itemUrl = $collectionChannel->getUrl();
    if (!$itemUrl) {
        continue;
    }

    $data[] = array(
        'itemText' => $itemText,
        'itemName' => $itemName,
        'itemUrl'  => $itemUrl,
        'hasIcon'  => false,
    );
}

// ------------------------------------------

if (count($data) <= 0) {
    return;
}

// ------------------------------------------

//  EM 2016 Teilnehmer -> Zuordnung Channel-Name zu CSS-Icon-Class (ohne Praefix)

$participants = array(
    'nordirland'  => 'gb-ni',
    'ungarn'      => 'hu',
    'irland'      => 'ie',
    'kroatien'    => 'hr',
    'deutschland' => 'de',
    'england'     => 'gb-en',
    'wales'       => 'gb-wa',
    'schweden'    => 'se',
    'tuerkei'     => 'tr',
    'albanien'    => 'al',
    'tschechien'  => 'cz',
    'spanien'     => 'es',
    'frankreich'  => 'fr',
    'italien'     => 'it',
    'polen'       => 'pl',
    'portugal'    => 'pt',
    'rumaenien'   => 'ro',
    'russland'    => 'ru',
    'slowakei'    => 'sk',
    'ukraine'     => 'ua',
    'oesterreich' => 'at',
    'island'      => 'is',
    'belgien'     => 'be',
    'schweiz'     => 'ch',
);

foreach ($data as $key => $item) {
    // $data[$key]['itemName'] = $participants[$item['itemName']];
    // (ws) 2016-06-10
    // Ausnahme: Es soll der oefb-team-Channel anstatt des oesterreich-Channels verwendet werden
    // Der Text, der gezeigt werden soll, muss aber "Oesterreich" bleiben
    if (isset($participants[$item['itemName']])) {
        $data[$key]['itemName'] = $participants[$item['itemName']];
    } else {
        $data[$key]['itemName'] = $participants['oesterreich'];
        $data[$key]['itemText'] = 'Österreich';
    }
    // (ws) 2016-06-10 end
    $data[$key]['hasIcon'] = true;
}

?>
<div class="participantsBox <?= $cssClassBox; ?>">
    <table>
        <tr>
            <? foreach ($data as $key => $item): ?>
            <td class="channelsListItem">
                <a class="itemText" href="<?= $item['itemUrl']; ?>">
                    <? if ($item['hasIcon']): ?>
                    <span class="itemIcon itemName_<?= $item['itemName']; ?>"></span>
                    <? endif; ?>
                    <span><?= $item['itemText']; ?></span>
                </a>
            </td>
            <? endforeach; ?>
        </tr>
    </table>
</div>
