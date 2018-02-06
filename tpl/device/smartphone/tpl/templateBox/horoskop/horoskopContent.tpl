<?
/**
 * horoskop content
 *
 * @var channel oe24.core.Channel
 */

$device = DeviceContainer::getDevice();

// ------------------------------------------------------------

$signs = array(

    'widder'     => array('char' => '&#9809;', 'sign' => 'widder',     'name' => 'Widder',     'start' => '21.03.', 'end' => '20.04.'),
    'stier'      => array('char' => '&#9801;', 'sign' => 'stier',      'name' => 'Stier',      'start' => '21.04.', 'end' => '20.05.'),
    'zwillinge'  => array('char' => '&#9802;', 'sign' => 'zwillinge',  'name' => 'Zwillinge',  'start' => '21.05.', 'end' => '21.06.'),
    'krebs'      => array('char' => '&#9803;', 'sign' => 'krebs',      'name' => 'Krebs',      'start' => '22.06.', 'end' => '22.07.'),

    'loewe'      => array('char' => '&#9804;', 'sign' => 'loewe',      'name' => 'Löwe',       'start' => '23.07.', 'end' => '22.08.'),
    'jungfrau'   => array('char' => '&#9805;', 'sign' => 'jungfrau',   'name' => 'Jungfrau',   'start' => '23.08.', 'end' => '23.09.'),
    'waage'      => array('char' => '&#9806;', 'sign' => 'waage',      'name' => 'Waage',      'start' => '24.09.', 'end' => '23.10.'),
    'skorpion'   => array('char' => '&#9807;', 'sign' => 'skorpion',   'name' => 'Skorpion',   'start' => '24.10.', 'end' => '22.11.'),

    'schuetze'   => array('char' => '&#9808;', 'sign' => 'schuetze',   'name' => 'Schütze',    'start' => '23.11.', 'end' => '21.12.'),
    'steinbock'  => array('char' => '&#9800;', 'sign' => 'steinbock',  'name' => 'Steinbock',  'start' => '22.12.', 'end' => '20.01.'),
    'wassermann' => array('char' => '&#9810;', 'sign' => 'wassermann', 'name' => 'Wassermann', 'start' => '21.01.', 'end' => '18.02.'),
    'fische'     => array('char' => '&#9811;', 'sign' => 'fische',     'name' => 'Fische',     'start' => '19.02.', 'end' => '20.03.'),
);

$types = array(
    'tageshoroskop' => 'tag',
    'jahreshoroskop' => 'jahr',
);

$months = array('Jänner', 'Februar', 'März', 'April', 'Mai', 'Juni', 'Juli', 'August', 'September', 'Oktober', 'November', 'Dezember');

// -----------------------------------------------------------------------------------------

$sign = 'widder';
$type = 'tag';
$classType = array('tag' => '' , 'jahr' => '');

$channelName = $channel->getName();
if (array_key_exists($channelName, $signs)) {
    $sign = $channelName;
}

$tempChannel = $channel->getParent();
$channelName = $tempChannel->getName();
if (array_key_exists($channelName, $types)) {
    $type = $types[$channelName];
}

$classType['tag'] = ('tag' == $type) ? 'active' : '';
$classType['jahr'] = ('jahr' == $type) ? 'active' : '';

$ts = time();
$zodiacDate = date('j.', $ts).'&nbsp;'.$months[date('n', $ts) - 1].'&nbsp;'.date('Y', $ts);

$signName = ucfirst($sign);
$signStartDate = str_replace('.0', '.', $signs[$sign]['start']);
$signEndDate = str_replace('.0', '.', $signs[$sign]['end']);

// -----------------------------------------------------------------------------------------

$infoFieldsTag = array(
    'Erfolg',
    'Fitness',
    'Singles',
);

$infoFieldsJahr = array(
    'Beruf',
    'Liebe',
    'Fitness',
);

$url = 'http://webmisc.oe24.at/horoskop/import3.php?sign='.$sign.'&type='.strtoupper($type);
$xmlData = spunQ_HttpBrowser::sendRequest($url, 5, false)->getBody();

$xml = @simplexml_load_string($xmlData);
if (!$xml) {
    return;
}

$infos = $xml->xPath('/horoscope/info');

$zodiacInfo = array();

$horoskopHeaderText = '';

foreach ($infos as $info) {

    $title = (string) $info->attributes()->title;

    $text = $info->text->asXML();

    // $text = str_replace(array('<horotext>', '</horotext>', '<text>', '</text>'), array('', '', '<span>', '</span>'), $text);
    $text = str_replace(array('<horotext>', '</horotext>', '<text>', '</text>'), array('', '', '', ''), $text);
    $text = preg_split('#<br\/>#', $text, null, PREG_SPLIT_NO_EMPTY);

    if (!$title || !$text) {
        continue;
    }

    $horoskopHeaderText = 'Das sagen Ihre Sterne heute '.$zodiacDate.'.';

    switch ($type) {
        case 'tag':
            $infoFields = $infoFieldsTag;
            $horoskopHeaderText = 'Das sagen Ihre Sterne heute '.$zodiacDate.'.';
            break;
        case 'jahr':
            $infoFields = $infoFieldsJahr;
            $horoskopHeaderText = 'Das sagen Ihre Sterne dieses Jahr.';
            break;
        default:
            $infoFields = $infoFieldsTag;
            $horoskopHeaderText = 'Das sagen Ihre Sterne heute '.$zodiacDate.'.';
            break;
    }

    if (in_array($title, $infoFields)) {
        $zodiacInfo[] = array(
            'title' => $title,
            'text' => $text,
            'count' => count($text),
        );
    }
}

$horoskopHeaderTextRogers = 'Von Gerda Rogers.';

// -----------------------------------------------------------------------------------------

$channelUrl = $channel->getUrl();

// Wenn das Tageshoroskop gezeigt wird, enthaelt die URL 'tageshoroskop'.
// Dieser Part wird fuer den Link zum Jahreshoroskop ersetzt durch 'jahreshoroskop'.
// Umgekehrt enthaelt die URL 'jahreshoroskop', wenn das Jahreshoroskop gezeigt
// wird und dieser Part wird fuer den Link zum Tageshoroskop eben ersetzt
// durch 'tageshoroskop'.

$urlDay = str_replace('jahreshoroskop', 'tageshoroskop', $channelUrl);
$urlYear = str_replace('tageshoroskop', 'jahreshoroskop', $channelUrl);

// -----------------------------------------------------------------------------------------

// (ws) 2017-06-06
// Wenn die Horoskop-URL unvollstaendig ist, werden die beiden URL's der Links fuer
// Tages- bzw. Jahreshoroskop unvollstaendig generiert.
// Folgender Programmcode soll dafuer sorgen, dass die Link-URL's vollstaendig sind, also auf
// einen Horoskop-Typ (tages- bzw. jahreshoroskop) und auf ein Sternzeichen (widder) verlinken.

$requestUsesSsl = request()->getUsesSsl();
$requestScheme = (true == $requestUsesSsl) ? 'https://' :  'http://';

$requestHost = request()->getHost();
$requestUri = request()->getUri();

$urlPath = parse_url($requestScheme.$requestHost.$requestUri, PHP_URL_PATH);
$urlPath = trim($urlPath, ' /');

$urlParts = explode('/', $urlPath);
$lastUrlPart = end($urlParts);

if ('' == $lastUrlPart || 'horoskop' == $lastUrlPart) {
    $urlDay  .= '/tageshoroskop/'.$sign;
    $urlYear .= '/jahreshoroskop/'.$sign;
}

if ('_mobile' == $lastUrlPart) {
    $urlDay  .= 'tageshoroskop/'.$sign;
    $urlYear .= 'jahreshoroskop/'.$sign;
}

if ('tageshoroskop' == $lastUrlPart || 'jahreshoroskop' == $lastUrlPart) {
    $urlDay  .= '/'.$sign;
    $urlYear .= '/'.$sign;
}

// -----------------------------------------------------------------------------------------

$imageUrl = lp('image', 'rl2014/zodiacBackground.jpg');
$emptyImages = $device->getConfig('emptyImages');
$emptyImage = $emptyImages['emptyImage1x1'];

// -----------------------------------------------------------------------------------------

$isDevServer = $device->getConfig('isDevServer');
$appUrlQuery = $device->getConfig('appUrlQuery');

$search = 'm.oe24dev.oe24.at';
$replace = 'oe24dev.oe24.at/_mobile';

if ($isDevServer && strpos($urlDay, $search) !== false) {
    $urlDay = str_replace($search, $replace, $urlDay).$appUrlQuery;
}

if ($isDevServer && strpos($urlYear, $search) !== false) {
    $urlYear = str_replace($search, $replace, $urlYear).$appUrlQuery;
}

// -----------------------------------------------------------------------------------------

?>

<?
// Wird durch die templateBox (z.B. 'Madonna Horoskop Tierkreszeichen') eingebunden
// tpl('oe24.oe24.device.smartphone.tpl.templateBox.horoskop.horoskopSigns', array('channel' => $channel));
?>

<? if (1): ?>

<div class="articleBox horoskopContent horoskopContent<?= ucFirst($type); ?>">

    <div class="horoskopHeader clearfix">

        <? if (1): ?>
        <div class="horoskopHeaderImage">
            <img class="emptyImage" src="<?= $emptyImage; ?>" alt="">
            <img class="realImage" src="<?= $imageUrl; ?>" alt="">
        </div>
        <? endif; ?>

        <? if (1): ?>
        <div class="horoskopHeaderText">

            <h1 class="horoskopHeaderCaption">Horoskop</h1>
            <p class="horoskopHeaderSubCaption"><?= $horoskopHeaderText; ?></p>
            <p class="horoskopHeaderSubCaption"><?= $horoskopHeaderTextRogers; ?></p>

            <div class="horoskopHeaderSign">
                <? if (0): ?>
                <div class="horoskopHeaderSignIcon icon<?= $signName; ?>"></div>
                <? endif; ?>
                <? if (0): ?>
                <p class="horoskopHeaderSignName"><?= $signName; ?></p>
                <p class="horoskopHeaderSignDate"><?= $signStartDate.' bis '.$signEndDate; ?></p>
                <? endif; ?>
                <p class="horoskopHeaderSignName"><?= $signName; ?> <?= $signStartDate.' bis '.$signEndDate; ?></p>
            </div>

        </div>
        <? endif; ?>

    </div>


    <div class="horoskopBody">

        <? if (1): ?>
            <div class="horoskopBodyTop">
                <a class="horoskopBodyTopDay <?= $classType['tag']; ?>" href="<?= $urlDay; ?>">Tageshoroskop</a>
                <a class="horoskopBodyTopYear <?= $classType['jahr']; ?>" href="<?= $urlYear; ?>">Jahreshoroskop</a>
            </div>
        <? endif; ?>


        <? if (1): ?>
            <div class="storyAd">
                <? tpl('oe24.oe24.device.smartphone.tpl._adition.adition', array(
                        'channel' => $channel,
                        'object'  => null,
                        'banner'  => 'MobileArtikelTop',
                )); ?>
            </div>
        <? endif; ?>


        <? if (1): ?>
            <div class="storySocialMedia">
                <? tpl('oe24.oe24.device.smartphone.tpl._content.article.tpl.articleSocialMedia'); ?>
            </div>
        <? endif; ?>


        <? if (1): ?>
            <div class="horoskopBodyText">
                <? foreach ($zodiacInfo as $info): ?>
                    <p>
                        <strong class="horoskopBodyTitle"><?= $info['title'].':'; ?></strong>
                        <? foreach ($info['text'] as $key => $text): ?>
                            <? if ($info['count'] > 1 && 0 == $key % 2): // Jahreshoroskop, der Text enthaelt den Monatsnamen ?>
                                <strong class="horoskopMonth"><?= $text; ?></strong>
                            <? else: ?>
                                <span class="horoskopInfoText"><?= $text; ?></span>
                            <? endif;?>
                        <? endforeach; ?>
                    </p>
                <? endforeach; ?>
            </div>
        <? endif; ?>


        <? if (0): ?>
            <div class="horoskopBodyBottom"></div>
        <? endif; ?>

    </div>


</div>

<? endif; ?>

