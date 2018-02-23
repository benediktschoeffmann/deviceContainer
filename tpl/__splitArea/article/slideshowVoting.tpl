<?php
/**
* Template für RadioVoting.
*
* @var slideshow any
* @var isInline boolean
*/

if (!($slideshow instanceof SlideShowVoting)) {
	return;
}

if ($slideshow->getVotingType() == SlideShowVoting::VOTING_TYPE_SLIDESHOW) {
	tpl('oe24.oe24.__splitArea.article.slideshowVotingSlideshow', array(
		'slideShow'	=> $slideshow,
		)
	);
	return;
}

$imageFormat = '200x200';
$voteOptionsArray = $slideshow->getVotingOptions();
// debug($slideshow);
// debug($voteOptionsArray);
$competitionUrl = $slideshow->getCompetitionUrl();
$email = $slideshow->getEmail();
$infoText = $slideshow->getInfoText();

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
$images = $slideshow->getRelatedImages();

if (!$images) {
	debug("Slideshow is empty");
	return;
}

$slideshowTitle = $slideshow->getTitle();
$slideshowId = $slideshow->getId();
$slideShowDescription = $slideshow->getBodyText();

// $domain = spunQ::inMode(spunQ::MODE_DEVELOPMENT) ? 'oe24dev' : 'www';
$domain = (isset($_SERVER['HTTP_HOST']) && !empty($_SERVER['HTTP_HOST'])) ? $_SERVER['HTTP_HOST'] : 'www.oe24.at';

// this method fetches all informationen and sorts the output.
$imageInfos = array();
$imageInfos = $slideshow->getVotingInformation();

$headline = $slideshow->getInfoHeadline();

if (!$headline || '' == $headline) {
	$headline = 'Hitwahl';
}
$showResultButton = $slideshow->getVotingType() == SlideShowVoting::VOTING_TYPE_ELECTION;
$showResultButton = $showResultButton && $slideshow->getShowResult();

$showPlayButton = ($slideshow->getVotingType() == SlideShowVoting::VOTING_TYPE_RADIO) ? true : false;

$useCaptcha = $slideshow->needsCaptcha();
$conf = spunQ::getConfiguration()->getStringsForPrefix('google.reCaptcha');
$siteKey = $conf['public'];

// (ws) 2018-02-08
$isLocked = $slideshow->isLocked();
// (ws) 2018-02-08 end

?>
<? if ($useCaptcha) : ?>
	<script src='https://www.google.com/recaptcha/api.js'></script>
<? endif; ?>

<section class="slideshowVoting" data-usecaptcha="<?= $useCaptcha; ?>" data-type="<?= $slideshow->getVotingType();?>">
	<a name="hitlistAnchor"></a>
	<? if (!$isInline) :?>
		<div class="">
			<!-- <span class="headline"><?//=$slideshowTitle;?></span> -->
			<p class="description"><?=$slideShowDescription;?></p>
		</div>

	<? endif; ?>

	<? if ($showResultButton): ?>
	<!-- <div class="buttonArea">
		<button class="showResultButton"> Ergebnis anzeigen </button>
	</div> -->
    <?
    tpl('oe24.oe24.__splitArea.article.slideshowVotingResult', array(
        'slideshow' => $slideshow,
        ));
   	?>
	<? endif; ?>

	<table class="slideshowItemsContainer" data-max="<?=count($voteOptionsArray);?>" data-id="<?=$slideshowId;?>" data-game="<?=$showGame;?>" data-url="<?=$competitionUrl;?>" data-domain="<?=$domain;?>" >


		<? foreach ($imageInfos as $key => $imageInfo) : ?>
			<? $classRow = ($key & 1) ? 'slideshowVotingOdd' : 'slideshowVotingEven'; ?>
			<tr class="slideShowItem <?=$classRow;?>" data-id="<?=$imageInfo['id'];?>">

				<!-- 				<td>
					<span class="jsPoints points"> <?//=$imageInfo['points'];?></span>
				</td>
				-->

 				<td class="covercell">
                    <? if($imageInfo['copyright']): ?>
					<img class="cover" src="<?=$imageInfo['imageUrl'];?>" alt="<?= $imageInfo['title'];?>" title="&copy; <?= $imageInfo['copyright'];?>" />
                    <? else: ?>
                    <img class="cover" src="<?=$imageInfo['imageUrl'];?>" alt="<?= $imageInfo['title'];?>" />
                    <? endif; ?>
					<span class="position"><?=$key+1;?></span>
				</td>
				<td class="infocell">
					<span class="title"><?=$imageInfo['title'];?></span>
					<span class="description"><?=$imageInfo['description'];?></span>
				</td>
				<td class="buttoncell">
					<? if ($showPlayButton) : ?>
						<a href="<?=$imageInfo['link'];?>" target="_blank">
							<span class="icon icon_arrow4_right"></span>
						</a>
					<? endif; ?>
				</td>
				<? foreach ($voteOptionsArray as $key => $voteOption) : ?>
				<td class="pointcell">
					<a class="jsSlideshowVoting jsOption<?=$voteOption;?>" href="#"><?=$voteOption;?></a>
				</td>
				<? endforeach; ?>
			</tr>
		<? endforeach; ?>
	</table
</section>

<div class="remodal" data-remodal-id="modal" data-remodal-options="hashTracking: false, closeOnOutsideClick: false">
  <button data-remodal-action="close" class="remodal-close"></button>
  <h1><?= $headline; ?></h1>


	<? if ($isLocked) : ?>
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

  <? if (!$isLocked) : ?>
	  	<button data-remodal-action="cancel" class="remodal-cancel">Neu Starten</button>
	  	<button data-remodal-action="confirm" class="remodal-confirm">Abschicken</button>
  <? endif; ?>
</div>
