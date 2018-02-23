<?php
/**
 * SlideShowVoting SlideShow
 *
 * @var  slideShow oe24.core.SlideShowVoting
 */

if (!($slideShow instanceof SlideShowVoting)) {
    return;
}

$imageFormat = '620x620NoCrop';
$voteOptionsArray = $slideShow->getVotingOptions();
$competitionUrl = $slideShow->getCompetitionUrl();
$email = $slideShow->getEmail();
$infoText = $slideShow->getInfoText();

$showInputs = $email !== NULL && filter_var($email, FILTER_VALIDATE_EMAIL);

$showGame = '0';
if ($competitionUrl != '') {
    $showGame = '1';
    // sanity check :)
    if (strpos($competitionUrl, 'http://') === false) {
        $competitionUrl = 'http://'.$competitionUrl;
    }
}
/*---------------------------------------------------------------------*/
$images = $slideShow->getRelatedImages();

if (!$images) {
    debug("Slideshow is empty");
    return;
}

$slideshowTitle = $slideShow->getTitle();
$slideshowId = $slideShow->getId();
$slideShowDescription = $slideShow->getBodyText();

$domain = spunQ::inMode(spunQ::MODE_DEVELOPMENT) ? 'oe24dev' : 'www';

// this method fetches all informationen and sorts the output.
$imageInfos = array();
$imageInfos = $slideShow->getVotingInformation(true, $imageFormat);

$useCaptcha = false;
$headline = $slideShow->getInfoHeadline();

if (!$headline || '' == $headline) {
    $headline = 'Hitwahl';
}

$showResult = $slideShow->getShowResult();
// $showResult = $slideShow->getVotingType() == SlideShowVoting::VOTING_TYPE_ELECTION || $slideShow->getVotingType() == SlideShowVoting::VOTING_TYPE_SLIDESHOW;
$showPlayButton = false;

$conf = spunQ::getConfiguration()->getStringsForPrefix('google.reCaptcha');
$siteKey = $conf['public'];

?>
<section class="slideshowVoting" data-usecaptcha="<?= $useCaptcha; ?>" data-type="<?= $slideShow->getVotingType();?>" data-domain="<?=$domain;?>">
    <div class="">
        <!-- <span class="headline"><?//=$slideshowTitle;?></span> -->
        <p class="description"><?=$slideShowDescription;?></p>
    </div>

    <div class="buttonArea">
        <button class="voteButton"> Abstimmen </button>
        <? if ($showResult): ?>
            <button class="showResultButton"> Ergebnis anzeigen </button>
        <? endif; ?>
    </div>

    <? if ($showResult) : ?>
        <? tpl('oe24.oe24.__splitArea.article.slideshowVotingResult', array(
            'slideshow' => $slideShow,
            )); ?>
    <? endif; ?>

    <div class="slideshowItemsContainer" data-max="<?=count($voteOptionsArray);?>" data-id="<?=$slideshowId;?>" data-game="<?=$showGame;?>" data-url="<?=$competitionUrl;?>" data-domain="<?=$domain;?>">
        <? foreach ($imageInfos as $key => $imageInfo): ?>

            <?
                $copyright = $imageInfo['copyright'];
                if ('' != $copyright) {
                    $copyright = ' &copy; '.$copyright;
                }
            ?>


            <div class="image" data-id="<?= $imageInfo['id'];?>">
                <img src="<?= $imageInfo['imageUrl']; ?>" alt="">
                <span class="sstitle"><?= $imageInfo['title'];?> </span>
                <span class="ssdescription"><?= $imageInfo['description'];?> </span>
                <span class="sscopyright"><?= $copyright ?></span>
            </div>
        <? endforeach; ?>
        <a href="#!" class="leftArrow js-oewaLink"><span>&lsaquo;</span></a>
        <a href="#!" class="rightArrow js-oewaLink"><span>&rsaquo;</span></a>
    </div>

<div class="remodal" data-remodal-id="modal" data-remodal-options="hashTracking: false, closeOnOutsideClick: false">
  <button data-remodal-action="close" class="remodal-close"></button>
  <h1><?= $headline; ?></h1>


    <? if ($slideShow->isLocked()) : ?>
        <p> Es tut uns Leid, der Zeitraum für dieses Voting ist schon vorbei! </p>
    <? else: ?>
        <p> Durch Drücken auf den grünen 'Abschicken'-Button wird Ihre Auswahl abgeschickt. </p> <br />
        <? if ($showInputs) : ?>
            <p> <?=$infoText;?> </p> <br/>
            <!-- <img src="<?//=$albumPicture;?>"> -->

            <input id="slideShowVotingName" type="text" value="Name">
            <input id="slideShowVotingPhone" type="text" value="Telefonnummer">
            <input id="slideShowVotingEmail" type="text" value="E-Mail">

            <p> </p>
        <? endif; ?>
        <? if ($showGame) :?>
            <p> Im Anschluss daran können Sie ausserdem an einem Gewinnspiel teilnehmen. </p> <br />
        <? endif; ?>
        <p> Vielen Dank fürs Mitmachen! </p>
    <? endif; ?>

  <br/ >

    <? if ($useCaptcha) : ?>
        <div id="reCaptcha" class="g-recaptcha" data-siteKey="<?= $siteKey; ?>" data-callback="SlideShowVotingCaptchaSuccess" data-callback-expired="SlideShowVotingCaptchaExpired">
        </div>
    <? endif; ?>

  <? if (!$slideShow->isLocked()) : ?>
        <button data-remodal-action="cancel" class="remodal-cancel">Neu Starten</button>
        <button data-remodal-action="confirm" class="remodal-confirm">Abschicken</button>
  <? endif; ?>
</div>

<div class="result">

</div>
