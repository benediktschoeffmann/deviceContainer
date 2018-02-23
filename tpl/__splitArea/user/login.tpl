<?php
/**
* login tpl
*
* @var channel oe24.core.Channel
* @var params array<any>
*
* @nodevmodecomments
*/

$errorMessages = (count($params['messages']) > 0) ? $params['messages']['error'] : null;
$successMessages = (count($params['messages']) > 0) ? $params['messages']['success'] : null;

$lostPasswortLink = l('oe24.oe24.user.lostPassword', array('channel' => $channel));
$lostUsernameLink = l('oe24.oe24.user.lostUsername', array('channel' => $channel));
$registerLink = l('oe24.oe24.user.index', array('channel' => $channel));

$changePw = l('oe24.oe24.user.changePass', array('channel' => $channel));
$userLogout = l('oe24.oe24.user.logout', array('channel' => $channel));

$fbLoginLink = l('oe24.oe24.user.fbLogin', array('channel' => $channel, 'action' => 'Login'));

$header = (user() === spunQ_User::getGuest()) ? 'Login' : 'Userpanel';
$fbLogin = new FacebookLogin('oe24_at', $fbLoginLink);

?>

<div class="row row_margin_top">
	<div class="row_margin_inner"></div>
</div>
<div class="row user_registration">
	<div class="row_caption">
		<div class="row_caption_body row_caption_body_noimage">
			<div class="row_caption_title">
				<h2><?=$header;?></h2>
			</div>
		</div>
	</div>
	<div class="content">
		<?if (user() === spunQ_User::getGuest()): ?>
			<? if (null !== $errorMessages): ?>
				<div class="registerErrorMessages">
					<ul>
					<? foreach($errorMessages as $errorMsg): ?>
						<li><?= $errorMsg; ?></li>
					<? endforeach; ?>
					</ul>
				</div>
			<? endif; ?>
			<? if (null !== $successMessages): ?>
				<div class="registerSuccessMessages"><?= $successMessages; ?></div>
			<? endif; ?>
			<!-- <form id="userLoginForm" method="POST"> -->
			<form id="userRegisterForm" method="POST">
				<fieldset>
					<div class="col col1 break">
						<label for="loginUsername" class="requiredBefore">Benutzername:</label>
						<input type="text" id="loginUsername" name="username" required="required"/>
						<label for="loginPassword" class="requiredBefore">Passwort:</label>
						<input type="password" id="loginPassword" name="password" required="required"/>
					</div>

					<div class="col col2 break userSubmit">
						<input type="submit" class="button" name="login" value="Einloggen"/>
					</div>
					<div class="col col2 last userSubmit">
						<a href="<?= $fbLogin->getLoginUrl(); ?>" target="_blanke">
							<img class="fb_login" src="http://images01.oe24.at/images/layout/social/fbLogin.png">
						</a>
					</div>
				</fieldset>

				<fieldset>
					<div class="col col2 break userSubmit">
						<a href="<?=$lostPasswortLink;?>" class="button">Passwort vergessen?</a>
					</div>
					<div class="col col2 last userSubmit">
						<a href="<?=$lostUsernameLink;?>" class="button">Benutzername vergessen?</a>
					</div>
                    <div class="col col2 break userSubmit">
                        <a href="<?=$registerLink;?>" class="button">Registrieren</a>
					</div>
				</fieldset>
			</form>
		<? else: ?>
			<div class="col col1 break">
				<div>
					<a href="<?= $registerLink; ?>" class="button">Meine Daten ändern</a>
				</div>
				<div>
					<a href="<?= $changePw; ?>" class="button">Passwort ändern</a>
				</div>
				<div>
					<a href="<?= $userLogout; ?>" class="button">Ausloggen</a>
				</div>
			</div>
		<? endif; ?>
	</div>

	<div class="sidebar">

	</div>
</div>
