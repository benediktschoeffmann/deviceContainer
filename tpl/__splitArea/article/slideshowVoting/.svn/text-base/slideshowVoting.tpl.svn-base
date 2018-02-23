<?
/**
 * override slideshow voting
 * @var slideshowVoting oe24.core.SlideShowVoting
 * @default slideshowVoting 0
 */

// DAILY-910 Mobil
// DAILY-926 Desktop

// /var/www/oe24_oe24/page/slideShowVoting.page

// debug($slideshowId);
// debug($votings);
// debug($voter);

// 2017-11-09 11:27:03: [  DEBUG  ] oe24.oe24.slideShowVoting.page:require() [14]: 161624401
// 2017-11-09 11:27:03: [  DEBUG  ] oe24.oe24.slideShowVoting.page:require() [15]: 161624426;jsOption2|161624405;jsOption3|161624423;jsOption1
// 2017-11-09 11:27:03: [  DEBUG  ] oe24.oe24.slideShowVoting.page:require() [16]: Roman Faraday|01 2367452|rf@upc.at

// Text fuer den modalen Dialog
// Bitte geben Sie Name, Telefonnummer und E-Mail Adresse an, um an Gewinnspielen teilzunehmen.

// E-Mail für Redaktion
// hitwahl@radio-oe24.at
//
// Dev-Test-Url
// http://oe24dev.oe24.at/hitwahl/HITWAHL/161624571

// --------------------------------------

// debug($slideshowVoting);

if ( !($slideshowVoting) || !($slideshowVoting instanceof SlideShowVoting) ) {
    return;
}

// --------------------------------------

// Erfolgt der Request von einem mobilen Device aus?
$isMobile = true;
try {
    $device = DeviceContainer::getDevice();
} catch (Exception $e) {
    $isMobile = false;
}

// --------------------------------------

//  Sind wir am Dev-Server?
$isDev = spunQ::inMode(spunQ::MODE_DEVELOPMENT) ? true : false;

// --------------------------------------------------

$votingId = $slideshowVoting->getId();
// debug($votingId);

// --------------------------------------------------

$slideshowVotingOptions = $slideshowVoting->getOptions();

// Artikel-Option "devCode": Liste der Image-Id's getrennt durch Beistrich (oder whitespaces)
$devCode = $slideshowVotingOptions->get('devCode');

// zerlegt den String anhand von whitespaces oder Beistrich
$devCodes = preg_split('/[\s,]+/', $devCode, null, PREG_SPLIT_NO_EMPTY);
// debug($devCodes);

// --------------------------------------------------

$votingType = $slideshowVoting->getVotingType();
// debug($votingType);

$votingItems = $slideshowVoting->getVotingInformation();
// debug($votingItems);

foreach ($votingItems as $key => $votingItem) {
    $votingItemId = $votingItem['id'];
    $votingItems[$key]['locked'] = in_array($votingItemId, $devCodes);
}
// debug($votingItems);

$votingOptions = $slideshowVoting->getVotingOptions();
// debug($votingOptions);

// -------------------------------------------

if ($votingType !== SlideShowVoting::VOTING_TYPE_RADIO) {
    return;
}

if (!is_array($votingOptions)) {
    return;
}

// -------------------------------------------

$overlayHeadline = $slideshowVoting->getInfoHeadline();
// debug($overlayHeadline);

$overlayText = $slideshowVoting->getInfoText();
// debug($overlayText);

$email = $slideshowVoting->getEmail();
// debug($email);

// -------------------------------------------

$competitionUrl = $slideshowVoting->getCompetitionUrl();
$competitionUrl = ($competitionUrl) ? 'http://'.preg_replace('~^http://~', '', $competitionUrl) : '';
// debug($competitionUrl);

// Vorlaeufig nicht beruecksichtigen
// TODO: Gewinnspiel-URL beruecksichtigen. Wie muss noch festgelegt werden
$competitionUrl = '';

$showCompetiton = ($competitionUrl) ? true : false;
// debug($showCompetiton);

// -------------------------------------------

// Sicherstellen, dass die Texte der Voting-Items NICHT leer sind
$votingItems = array_map(function($item) {
    $item['title'] = (empty($item['title'])) ? '-' : $item['title'];
    $item['description'] = (empty($item['description'])) ? '-' : $item['description'];
    return $item;
}, $votingItems);

// -------------------------------------------

$votingOptions = implode(',', $votingOptions);
// debug($votingOptions);

// Zur Zeit wird das Punkteschema "3-2-1 Punkte" ausgewertet
switch ($votingOptions) {

    // case '6,5,4,3,2,1':
    //     $template = 'oe24.oe24.device.smartphone.tpl._content.article.override.slideshowVoting.slideshowVoting_654321';
    //     $classSlideshowVoting = 'slideshowVoting_654321';
    //     $maxButtons = 6;
    //     break;

    case '3,2,1':
        if ($isMobile) {
            $votingContainer = 'oe24.oe24.__splitArea.article.slideshowVoting.votingContainerMobile_321';
            $modalContainer = 'oe24.oe24.__splitArea.article.slideshowVoting.modalContainer_321';
            $hintContainer = 'oe24.oe24.__splitArea.article.slideshowVoting.hintContainer_321';
        } else {
            // $template = 'oe24.oe24.__splitArea.article.slideshowVoting.slideshowVoting_321';
            $votingContainer = 'oe24.oe24.__splitArea.article.slideshowVoting.votingContainerDesktop_321';
            $modalContainer = 'oe24.oe24.__splitArea.article.slideshowVoting.modalContainer_321';
            $hintContainer = 'oe24.oe24.__splitArea.article.slideshowVoting.hintContainer_321';
        }
        $classSlideshowVoting = 'slideshowVoting_321';
        $maxButtons = 3;
        break;

    // case '1':
    //     $template = 'oe24.oe24.device.smartphone.tpl._content.article.override.slideshowVoting.slideshowVoting_1';
    //     $classSlideshowVoting = 'slideshowVoting_1';
    //     $maxButtons = 3;
    //     break;

    default:
        return;
}

// -------------------------------------------

$votingHost = (isset($_SERVER['HTTP_HOST']) && !empty($_SERVER['HTTP_HOST'])) ? $_SERVER['HTTP_HOST'] : 'www.oe24.at';
$votingUrl = 'http://'.$votingHost.'/_slideShowVoting';

// ----------------------------------------------

$valueName    = '';
$valueTelefon = '';
$valueEmail   = '';

// ----------------------------------------------

// zwecks Voter-Test koennen die Eingabefelder
// des Anmelde-Dialogs vorausgefuellt werden

// if ($isDev) {
//     $valueName    = 'Roman Faraday';
//     $valueTelefon = '01/2367452';
//     $valueEmail   = 'rf@upc.at';
// }

// ----------------------------------------------

$hintThanksVoted   = htmlspecialchars('Wir bedanken uns für\'s abstimmen.', ENT_QUOTES);
$hintAlreadyVoted  = htmlspecialchars('Sie haben bereits abgestimmt, danke.', ENT_QUOTES);

// $classVotingItem = 'votingItem';
// $classNameButton = 'votingButton';
// $classNameActive = 'active';

// $classThanksVoted  = 'hintThanksVoted';
// $classAlreadyVoted = 'hintAlreadyVoted';

// $resetAlreadyVoted = false;

$javascriptOptions = array(
    'votingId'          => $votingId,
    'votingUrl'         => $votingUrl,
    'maxButtons'        => $maxButtons,
    'classVotingItem'   => 'votingItem',
    'classNameButton'   => 'votingButton',
    'classNameActive'   => 'active',
    'classNameDisabled' => 'disabled',
    'classThanksVoted'  => 'hintThanksVoted',
    'classAlreadyVoted' => 'hintAlreadyVoted',
    'resetAlreadyVoted' => false,
    'showCompetiton'    => $showCompetiton,
    'competitionUrl'    => $competitionUrl,
);

$jsonVotingOptions = json_encode($javascriptOptions);

// ----------------------------------------------

// modalContainer

$modalData = array(
    'overlayHeadline' => $overlayHeadline,
    'overlayText'     => $overlayText,
    'showCompetiton'  => $showCompetiton,
    'competitionUrl'  => $competitionUrl,
    'valueName'       => $valueName,
    'valueTelefon'    => $valueTelefon,
    'valueEmail'      => $valueEmail,
);

// ----------------------------------------------

// hintContainer

$hintData = array(
    'classThanksVoted'  => 'hintThanksVoted',
    'classAlreadyVoted' => 'hintAlreadyVoted',
    'hintThanksVoted'   => $hintThanksVoted,
    'hintAlreadyVoted'  => $hintAlreadyVoted,
);

// ----------------------------------------------

?>

<div class="slideshowVoting <?= $classSlideshowVoting; ?>">

    <div class="votingBox" id="votingBox" data-voting-options='<?= $jsonVotingOptions; ?>'>

        <?
        tpl($votingContainer, array(
            'votingItems'     => $votingItems,
            'maxButtons'      => $maxButtons,
            'classNameButton' => 'votingButton',
        ));
        ?>

        <?
        tpl($modalContainer, array(
            'modalData' => $modalData,
        ));
        ?>

        <?
        tpl($hintContainer, array(
            'hintData' => $hintData,
        ));
        ?>

    </div>

</div>
