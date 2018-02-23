<?php
/**
* lostPassword tpl
*
* @var params array<any>
*
* @nodevmodecomments
*/

$errorMessages = (count($params['messages']) > 0) ? $params['messages']['error'] : null;
$successMessages = (count($params['messages']) > 0) ? $params['messages']['success'] : null;

$header = 'Passwort vergessen';

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
		<!-- <form id="userLostPasswordForm" method="POST"> -->
		<form id="userRegisterForm" method="POST">
			<fieldset>
				<div class="col col1 break">
					<label for="lostUsername" class="requiredBefore">Benutzername:</label>
					<input type="text" id="lostUsername" name="lostUsername" required="required"/>
					<label for="lostMail" class="requiredBefore">E-Mail Adresse:</label>
					<input type="text" id="lostMail" name="lostEmail" required="required"/>
				</div>

				<dic class="col col1 break userSubmit">
					<input type="submit" class="button" name="lostPassword" value="Passwort anfordern"/>
				</dic>
			</fieldset>
		</form>
	</div>

	<div class="sidebar">

	</div>
</div>
