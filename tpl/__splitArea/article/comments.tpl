<?php
/**
 * Artikel Kommentare
 *
 * @var article oe24.core.TextualContent
 * @var articleCommentsCount integer
 * @default articleCommentsCount 0
 */

$postingTemplate = $article->getOptions(true, true)->get('postingTemplate');
$onlyRegisteredPostings = $article->getOptions(true, true)->get('onlyRegisteredPostings');
$registerLink = '/user?redirect=' . $article->getUrl() . '#comments';
$registerLink2 = '/user?noFirstLastName&redirect=' . $article->getUrl() . '#comments';
$lostPWLink = '/user/lostPassword?redirect=' . $article->getUrl() . '#comments';
$userName = user()->getUsername();

$checkProfile = false;

if ($userName !== 'guest') {
	if (null === user()->getFirstName() || null === user()->getLastName()) {
		$checkProfile = true;
	} else {
		$userName = array();
		$userName[] = user()->getFirstName();
		$userName[] = user()->getLastName();
		$userName[] = '(' . user()->getUsername() . ')';
		$userName = implode(' ', $userName);
	}
}

$showCommentForm = ($onlyRegisteredPostings && $userName == 'guest') ? 'none' : 'inline';
$showCommentForm = ($checkProfile) ? 'none' : $showCommentForm;

$displayLoginForm = ('Petition' === $postingTemplate) ? 'none' : 'block';
$displayPostingsHeader = ('Petition' === $postingTemplate) ? 'none' : 'inline';
$displayGuestComment = ($userName == 'guest') ? 'inline' : 'none';

$homeChannel = $article->getHomeChannel();
$fbLogin = new FacebookLogin('oe24_at', l('oe24.oe24.user.fbLogin', array('channel' => $homeChannel, 'action' => 'Login')));
?>


<h2 id="commentCounter" itemprop="interactionCount" style="display: <?= $displayPostingsHeader; ?>">Postings <span>(<?=$articleCommentsCount?>)</span></h2>

<div class="hide_postings" style="display: <?= $displayLoginForm; ?>">
	<span>Postings ausblenden</span>
	<div class="hidePostingDiv icon icon_arrow3_up"></div>
</div>

<div class="container_postings">
	<h3 class="commentsHeaderText" style="display: <?= $displayLoginForm; ?>">Posten Sie Ihre Meinung</h3>

	<div class="left">
		<h4 id="loginUsername" style="display: <?=($userName == 'guest') ? 'none' : 'inline';?>">Hallo <?= $userName; ?></h4>
	</div>

	<div id="loginFormDiv" class="clearfix" style="display: <?= $displayLoginForm; ?>">
		<form id="loginForm" style="display: <?=($userName == 'guest') ? 'inline' : 'none';?>">
			<input type="hidden" name="login" value="" />
			<input class="userLogin" type="text" name="username" value="" placeholder="Username" />
			<input class="userLogin" type="password" name="password" value="" placeholder="Password" />
			<div class="fb-login-button" data-max-rows="1" data-size="medium" data-show-faces="false" data-auto-logout-link="false"></div>&nbsp;

			<? // (bs) DAILY-692 Entfernung des FB Login beim alten Kommentar Template ?> 
			<a href="<?= $fbLogin->getLoginUrl(); ?>" target="_blank">
				<img class="fb_login" src="http://images01.oe24.at/images/layout/social/fbLogin.png">
				
			</a>
			<? // (bs) end. ?> 

			<input class="submitText" name="login" type="submit" value="Login" />&nbsp;|&nbsp;
			<a href="<?=$registerLink;?>">Neu anmelden</a>
			<span class="right">
				<a href="<?= $lostPWLink; ?>">Passwort vergessen</a>
			</span>
		</form>
		<div class="right">
			<form id="logoutForm" style="display: <?=($userName == 'guest') ? 'none' : 'inline';?>">
				<input type="hidden" name="logout" value="" />
				<a href="<?=$registerLink;?>">Meine Daten</a>&nbsp;|&nbsp;
				<input class="submitText" name="logout" type="submit" value="Logout" />
			</form>
		</div>
	</div>

	<div>
		<div id="noFirstAndLastname" style="display: <?=($userName !== 'guest' && $checkProfile) ? 'block' : 'none';?>">
			<div class="profilHinweis">Um die Qualität unserer Leserbeiträge sicherzustellen, zeigt oe24 bei Postings ab sofort Klarnamen an.</div>
			<a class="profilHinweis" href="<?=$registerLink2;?>">Meine Daten vervollständigen</a>
		</div>
		<form id="setCommentForm" style="display: <?=$showCommentForm;?>">
			<? if(!$onlyRegisteredPostings): ?>
				<input id="commentGuestUsername" type="text" placeholder="Angezeigter Name" name="commentGuestUsername" style="display: <?= $displayGuestComment; ?>" />
			<? endif; ?>
			<textarea placeholder="Schreiben Sie hier Ihren Kommentar" name="commentText"></textarea>
			<input name="setComment" type="hidden" value="0"/>
			<input name="commentRef" type="hidden" value="<?=$article->getId()?>" />
			<input name="commentAnswerRef" type="hidden" value="0" />
			<input class="button" type="submit" value="Posten" disabled="disabled" />
			<div class="clearfix"></div>
		</form>
	</div>
	<div id="commentMsg"></div>

	<div id="commentsContainer" class="commentsContainer clearfix">
	</div>
</div>
