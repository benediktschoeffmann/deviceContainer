<?
/**
 * horoskop signs
 *
 * @var channel oe24.core.Channel
 */

$device = DeviceContainer::getDevice();

// ------------------------------------------------------------

$signs = array(
    'widder'     => 'Widder',
    'stier'      => 'Stier',
    'zwillinge'  => 'Zwillinge',
    'krebs'      => 'Krebs',
    'loewe'      => 'Löwe',
    'jungfrau'   => 'Jungfrau',
    'waage'      => 'Waage',
    'skorpion'   => 'Skorpion',
    'schuetze'   => 'Schütze',
    'steinbock'  => 'Steinbock',
    'wassermann' => 'Wassermann',
    'fische'     => 'Fische',
);

$channelName = $channel->getName();

$currentSign = '';
if (array_key_exists($channelName, $signs)) {
    $currentSign = $channelName;
}

$horoskopChannel = Channel::getChannelByChannelstring($channel->getPortal(), 'madonna/horoskop/tageshoroskop/');
$horoskopChannelUrl = $horoskopChannel->getUrl();

// ------------------------------------------------------------

$isDevServer = $device->getConfig('isDevServer');
$appUrlQuery = $device->getConfig('appUrlQuery');

$search = 'm.oe24dev.oe24.at';
$replace = 'oe24dev.oe24.at/_mobile';
if ($isDevServer && strpos($horoskopChannelUrl, $search) !== false) {
    $horoskopChannelUrl = str_replace($search, $replace, $horoskopChannelUrl);
}

// ------------------------------------------------------------

$flickityInitialIndex = 0;

$chunks = array_chunk(array_keys($signs), 3);
foreach ($chunks as $key => $chunk) {
    if (in_array(strtolower($currentSign), $chunk)) {
        $flickityInitialIndex = $key;
        break;
    }
}

$flickityOptions = array(
    'autoplay'        => false,
    'groupCells'      => true,
    'prevNextButtons' => false,
    'pageDots'        => true,
    'cellSelector'    => '.horoskopSign',
    'initialIndex'    => $flickityInitialIndex,
);

$options = json_encode($flickityOptions);

?>

<? if (1): ?>

<div class="contentBox horoskopSigns">
    <div class="horoskopContainer flickitySlider" data-options='<?= $options; ?>'>
        <? foreach ($signs as $key => $sign): ?>
            <? $classActive = ($key == $currentSign) ? 'active' : ''; ?>
            <a class="horoskopSign <?= $classActive; ?>" href="<?= $horoskopChannelUrl.'/'.$key.'/'.$appUrlQuery; ?>">
                <span class="horoskopSignIcon <?= $key; ?>"></span>
                <span class="horoskopSignText"><?= $sign; ?></span>
            </a>
        <? endforeach; ?>
    </div>
</div>

<? endif; ?>
