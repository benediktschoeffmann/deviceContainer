<?php
class Oe24User extends OesterreichUser {

	const PORTAL_NAME = 'oe24'; //default

    // protected static function requireClearing() {
    // 	//FIXME -> get right value from spunq.conf
    // 	//and put it into frontend/OesterreichUser
    // 	return true;
    // }

	private static function returnStatus($type, $error = null, $success = null) {
		if (count($error) > 0) {
			if ('html' === $type) {
				$ret = self::getUserData($error);
			} else {
				$ret = self::outputJsonUserData($error);
			}
		} else {
			if ($type === 'html') {
				$ret = self::getUserData(null, $success);
			} else {
				$ret = self::outputJsonUserData(null, $success);
			}
		}
		return $ret;
	}

	public static function login($type = 'html') {
		$errorMessage = array();
		$successMessage = null;
		$loginForm = form("oe24." . self::getPortalName() .".user.login");
		//$redirect = isset($_GET['redirect']) ? "&redirect=".urlencode(request()->getGetValue("redirect")) : "";
		if ($loginForm->wasSubmittedSuccessfully()) {
			# perform a automatic login
			$formName = "oe24." . self::getPortalName() .".user.login";
			$errorMsg = false;
			$errorCode = 0;
			$errorUser = NULL;
			$user = User::performLogin($formName, self::getPortal(), $errorCode, $errorMsg, $errorUser);
			$form = spunQ_FormFactory::getByName($formName);
			if ($user !== NULL) {
				$t = new spunQ_User();
				if (!$user->inGroup("oe24.frontend") && !$user->inGroup("oe24.backend")) {
					// if ($user->inGroup('oe24.frontendWaitForClearing')) {
					// 	$errorMessage[] = t('.oe24.core.Registration.login.waitForClearing');
					// }

					if ($user->inGroup('oe24.frontendWaitForActivation')) {
						// $errorMessage[] = t('.oe24.core.Registration.login.waitForFrontendActivation');
						$errorMessage[] = 'Ihre Registrierung wird aktiviert, sobald Sie den Freischaltungslink in der E-Mail geöffnet haben.';
					}
				} else {
					response()->changeUser($user);
					VarnishHash::setHashCookies($user);
					$successMessage = '';
				}
			} else {
				if ($errorCode == 2 && !empty($errorUser)) {
					self::sendUserActivationMail($errorUser->getEmail());
				}
				// $errorMessage[] = $errorMsg;
				$errorMessage[] = 'Der Benutzername und/oder das Passwort ist falsch. ';
			}
		} else {
			$errorMessage[] = 'Der Benutzername und/oder das Passwort ist falsch. ';
		}
		return Oe24User::returnStatus($type, $errorMessage, $successMessage);
	}

	public static function getPass($type = 'html') {
		$lost_username = self::_getPostData('lostUsername', '');
		$lost_email = self::_getPostData('lostEmail', '');
		$errorMsg = array();
		$successMsg = null;

		if (strlen($lost_username) < self::USER_NICK_MIN_LEN  || strlen($lost_username ) > self::USER_NICK_MAX_LEN ) {
			$errorMsg[] = 'Der Benutzername muss zwischen ' . self::USER_NICK_MIN_LEN . ' und ' . self::USER_NICK_MAX_LEN . ' Zeichen lang sein.';
		}
		if (!self::isEmail($lost_email)) {
			$errorMsg[] = 'Die eingegebene E-Mail Adresse ist nicht korrekt.';
		}

		$user = User::getUserbyNameAndEmail($lost_username,$lost_email, self::getPortal());
		if (empty($user)) {
			$errorMsg[] = 'Der Benutzername und/oder die E-Mail Adresse ist falsch.';
		} else {

			# send email
			$user = $user[0];
			$channel = Channel::getChannelByChannelstring(self::getPortal(), 'frontend');
			$valideUrl = l("oe24." . self::getPortalName() .".user.lostPass", array(
				"channel" => $channel,
				"email" => $user->getEmail(),
				"username" => $user->getUsernameLower(),
				"code" => substr (spunQ_Crypto::encrypt($user->getEmail(), "email"), 0, 20),
			));

			$mailText1 = "Sie haben auf oe24.at die Passwort vergessen Funktion benutzt.\nDamit Sie ein neues Passwort bekommen öffnen Sie den untenstehenden Link.";
			$mailText2 = "Nach Eingabe des Links in Ihren Browser erhalten Sie in Kürze Ihr neues Passwort zugeschickt.";
			$mail = strg_Mail::create($user->getEmail(), getStaticTextMsg('user.reg.noreply.email','noreply@oe24.at'), "oe24." . self::getPortalName() .".mail.subject", "oe24." . self::getPortalName() .".mail.body", "oe24." . self::getPortalName() .".mail.bodyHTML");
			$mail->send(array(
				"subject" => getStaticTextMsg('user.reg.getpass.mail.subject',"österreich.at - Passwort vergessen"),
				"text" => getStaticTextMsg('user.reg.getpass.mail.text1',$mailText1). "\n\n$valideUrl\n\n" .getStaticTextMsg('user.reg.getpass.mail.text2',$mailText2),
			));

			$successMsg = 'Öffnen Sie ihr E-Mailpostfach. Eine E-Mail mit dem Passwort rücksetzen Link wurde ihnen geschickt.';

		}

		return Oe24User::returnStatus($type, $errorMsg, $successMsg);
	}

	public static function getUsername($type = 'html'){
		$lostU_email = self::_getPostData('lostEmail', '');
		$lostU_pass = self::_getPostData('lostPass', '');

		$errorMsg = array();
		$successMsg = null;

		if (!self::isEmail($lostU_email)) {
			$errorMsg[] = 'Die eingegebene E-Mail Adresse ist nicht korrekt.';
		}
		if (strlen($lostU_pass) < self::USER_PASS_MIN_LEN) {
			$errorMsg[] = 'Das Passwort muss mindestens '.self::USER_PASS_MIN_LEN.' Zeichen lang sein.';
		}
		$users = User::getUserbyEmail($lostU_email, self::getPortal());
		if (empty($users)) {
			$errorMsg[] = 'Es konnte kein Benutzer mit diesen Daten gefunden werden.';
		} else {

			$currentUser = $users[0];
			$foundUser = false;
			foreach ($users as $user) {
				if($user->getPasswordHash() == spunQ_Crypto::encrypt($lostU_pass, $user->getPasswordSalt())){
					$currentUser=$user;
					$foundUser=true;
					break;
				}
			}

			if(!$foundUser){
				$errorMsg[] = 'Es konnte kein Benutzer mit diesen Daten gefunden werden.';
			} else {

				$mailText = "Sie haben auf oe24.at ihren Benutzernamen vergessen.\nIhr Benutzername lautet:";
				$mail = strg_Mail::create($currentUser->getEmail(), getStaticTextMsg('user.reg.noreply.email','noreply@oe24.at'), "oe24." . self::getPortalName() .".mail.subject", "oe24." . self::getPortalName() .".mail.body", "oe24." . self::getPortalName() .".mail.bodyHTML");
				$mail->send(array(
					"subject" => getStaticTextMsg('user.reg.getusername.mail.subject',"oe24.at - Benutzername vergessen"),
					"text" => getStaticTextMsg('user.reg.getusername.mail.text',$mailText). ' ' . $currentUser->getUsername()
				));

				$successMsg = 'Eine E-Mail mit dem Benutzername wurde Ihnen zugeschickt.';

			}
		}

		return Oe24User::returnStatus($type, $errorMsg, $successMsg);
	}

	public static function register($type = 'html'){
		$reg_usergender = self::_getPostData('reg_usergender', NULL);
		$reg_userfirstname = self::_getPostData('reg_userfirstname');
		$reg_userlastname = self::_getPostData('reg_userlastname');
		$reg_email = self::_getPostData('reg_email', '');
		$reg_username = self::_getPostData('reg_username', '');
		$reg_password = self::_getPostData('reg_password', '');
		$reg_password_repeat = self::_getPostData('reg_password_repeat', '');
		$reg_password_now = self::_getPostData('reg_password_now', '');

		$reg_useraddress = self::_getPostData('reg_useraddress', '');
		$reg_userstreetnr = self::_getPostData('reg_userstreetnr', '');
		$reg_userstairs = self::_getPostData('reg_userstairs', '');
		$reg_userdoor = self::_getPostData('reg_userdoor', '');
		$reg_userzip = self::_getPostData('reg_userzip', '');
		$reg_usercity = self::_getPostData('reg_usercity', '');
		$reg_usercountry = self::_getPostData('reg_usercountry', '');
		$reg_userstate = self::_getPostData('reg_userstate', '');
		$reg_userjob = self::_getPostData('reg_userjob', NULL);
		$reg_userphonenumber = self::_getPostData('reg_userphonenumber', '');
		$reg_userbirthdayDay = self::_getPostData('reg_userbirthdayDay','');
		$reg_userbirthdayMonth = self::_getPostData('reg_userbirthdayMonth','');
		$reg_userbirthdayYear = self::_getPostData('reg_userbirthdayYear','');

		$reg_agb = self::_getPostData('reg_agb', '');
		$reg_netiquette = self::_getPostData('reg_netiquette');

		$reg_userid = self::_getPostData('reg_userid', 0);
		$reg_status = self::_getPostData('reg_status', '0');

		$user = user();
		$spunQUser = null;

		$errorMsg = array();

		if (is_null($reg_usergender) || !is_numeric($reg_usergender)){
			$errorMsg[] = 'Bitte geben Sie die gewünschte Anrede ein.';
		}
		if (!$reg_userfirstname || !preg_match('/^([\.a-zA-ZÄÖÜäöü\ _-]+){2,}$/', $reg_userfirstname)){
			$errorMsg[] = 'Bitte geben Sie Ihren Vornamen ein.';
		}
		if (!$reg_userlastname || !preg_match('/^([\.a-zA-ZÄÖÜäöü\ _-]+){2,}$/', $reg_userlastname)){
			$errorMsg[] = 'Bitte geben Sie Ihren Nachnamen ein.';
		}
		if (!self::isEmail($reg_email)){
			$errorMsg[] = 'Die E-Mail Adresse ist nicht korrekt';
		}
		if (!preg_match('/^\+?[0-9\s-]{3,}$/', $reg_userphonenumber)) {
			$errorMsg[] = 'Bitte geben Sie Ihre Telefonnummer ein.';
		}
		$reg_username_length = strlen($reg_username);
		if ($reg_username_length<self::USER_NICK_MIN_LEN || $reg_username_length>self::USER_NICK_MAX_LEN){
			$errorMsg[] = 'Der Benutzername muss zwischen ' . self::USER_NICK_MIN_LEN . ' und ' . self::USER_NICK_MAX_LEN . ' Zeichen lang sein.';
		}
		if ($user === spunQ_User::getGuest() || '' !== $reg_password || '' !== $reg_password_repeat) {
			if ($reg_password_repeat!=$reg_password){
				$errorMsg[] = 'Die Passwörter stimmen nicht überein';
			}
			if (strlen($reg_password)<self::USER_PASS_MIN_LEN) {
				$errorMsg[] = 'Passwort muss mindestens ' . self::USER_PASS_MIN_LEN . ' Zeichen lang sein';
			}
		}

		if ($user !== spunQ_User::getGuest() && '' === $reg_password_now) {
			$errorMsg[] = 'Sie müssen ein Passwort angeben, um Ihre Daten zu aktualisieren.';
		}

        if ($user !== spunQ_User::getGuest() && spunQ_Crypto::encrypt($reg_password_now, $user->getPasswordSalt()) !== $user->getPasswordHash()) {
            $errorMsg[] = "Bitte geben Sie ihr aktuelles Passwort ein.";
        }

		if ($reg_agb != 'on'){
			$errorMsg[] = 'Sie müssen die AGB akzeptieren.';
		}
		if ($reg_netiquette != 'on'){
			$errorMsg[] = 'Sie müssen die Netiquette akzeptieren.';
		}

		$isNewEmailAddress = true;
		$checkUsername = User::getUserbyName($reg_username, self::getPortal());
		$checkEmail = User::getUserbyEmail($reg_email, self::getPortal());
		if ($user === spunQ_User::getGuest()) {
			if(count($checkUsername) > 0){
				$errorMsg[] = 'Der eingegebene Benutzername ist schon vorhanden.';
			}
			if(count($checkEmail) > 0){
				$errorMsg[] = 'Die eingegebene E-Mail Adresse ist schon vorhanden.';
			}
		} else {
			if ($reg_userid == $user->getId()) {
				$spunQUser = $user;
			} else {
				$errorMsg[] = 'Sie sind mit einem anderen User eingeloggt.';
			}

			if (count($checkUsername) > 0 && $checkUsername[0]->getUsername() !== $user->getUsername()) {
				$errorMsg[] = 'Der eingegebene Benutzername ist schon vorhanden.';
			}

			if(count($checkEmail) > 0 && $checkEmail[0]->getEmail() !== $user->getEmail()) {
				$errorMsg[] = 'Die eingegebene E-Mail Adresse ist schon vorhanden.';
			}

			if ($reg_email === $user->getEmail()) {
				$isNewEmailAddress = false;
			}
		}

		// Weitere Überprüfungen aus der OesterreichUser.class.php holen

		if (count($errorMsg) > 0) {
			return oe24User::returnStatus($type, $errorMsg);
		}

		if ($user === spunQ_User::getGuest()) {
			// debug("generate new user");
			// neuen User generieren.
			$spunQUser = new spunQ_User();
			$spunQUser->setRegistrationDate(new spunQ_DateTime());
		}

		// Daten setzen und alles speichern.
		$spunQUser->setGender($reg_usergender);
		$spunQUser->setFirstName($reg_userfirstname);
		$spunQUser->setLastName($reg_userlastname);
		$spunQUser->setEmail($reg_email);
		$spunQUser->setUsername($reg_username);
		// Password für den User setzen.
		if ('' !== $reg_password) {
			$spunQUser->setPasswordSalt(spunQ_Crypto::randomSalt());
			$spunQUser->setPasswordHash(spunQ_Crypto::encrypt($reg_password, $spunQUser->getPasswordSalt()));
		}

		// if ($isNewEmailAddress) {
		// 	if (self::requireClearing()) {
		// 		debug("register requires clearing");
		// 		$groupsData = db()->getByMember("spunQ.user.Group", "name", "oe24.frontendWaitForClearing");
		// 	}
		// 	else {
				if(self::requireEmailActivation()){
					debug("register requires activation");
					$groupsData = db()->getByMember("spunQ.user.Group", "name", "oe24.frontendWaitForActivation");
				} else {
					$groupsData = db()->getByMember("spunQ.user.Group", "name", "oe24.frontend");
				}
			// }
			$spunQUser->setGroups(array($groupsData[0]));
		// }

		// debug($spunQUser->getGroups());

		$spunQUser->store();

		// Restliche Daten setzen und speichern.
		if ($user === spunQ_User::getGuest()) {
			$oe24User = new User();
		} else {
			$oe24User = $spunQUser->getOe24User();
		}
		$oe24User->setAddress($reg_useraddress);
		$oe24User->setStreetNr($reg_userstreetnr);
		$oe24User->setStairs($reg_userstairs);
		$oe24User->setDoor($reg_userdoor);
		$oe24User->setZip(intval($reg_userzip));
		$oe24User->setCity($reg_usercity);
		$oe24User->setCountry($reg_usercountry);
		$oe24User->setState($reg_userstate);
		$oe24User->setJob($reg_userjob);
		$oe24User->setPhoneNumber($reg_userphonenumber);
		if ('' === $reg_userbirthdayDay && '' === $reg_userbirthdayMonth && '' === $reg_userbirthdayYear) {

		} else {
			$birthday = new spunQ_Date();
			$birthday->setTimestamp(strtotime($reg_userbirthdayYear .'-' . $reg_userbirthdayMonth .'-' . $reg_userbirthdayDay));
			$birthday->setDay($reg_userbirthdayDay);
			$birthday->setMonth($reg_userbirthdayMonth);
			$birthday->setYear($reg_userbirthdayYear);
			$oe24User->setBirthday($birthday);
		}
		$oe24User->setUser($spunQUser);
		$oe24User->setSkipUpdateContent(true);
		$oe24User->setPortal(self::getPortal());
		$oe24User->store();

		// Registrierter User ist kein Gast mehr
		response()->changeUser($spunQUser);
		VarnishHash::setHashCookies($spunQUser);
		// response()->changeUser($oe24User);
		// VarnishHash::setHashCookies($oe24User);

 		$successMsg = '';
		if ($user === spunQ_User::getGuest()) {
			// debug("register get guest");
			// if (self::requireClearing()) {
			// 	debug("register get guest require clearing");
			// 	$successMsg = t('.oe24.core.Registration.register.waitForClearing');
			// }
			// else
			if(self::requireEmailActivation()){
				// $successMsg = t('.oe24.core.Registration.register.waitForFrontendActivation');
				$successMsg = 'Ihre Registrierung wurde erfolgreich abgeschlossen. Sie erhalten in Kürze eine E-Mail an die von Ihnen angegebene E-Mail-Adresse. In dieser E-Mail finden Sie für Ihre Registrierung einen Freischaltungslink. Ihre Registrierung wird aktiviert, sobald Sie diesen Link geöffnet haben. Danach haben Sie die Möglichkeit sich in Ihren Account einzuloggen.';
			}
			else {
				$success = true;
				$successMsg = 'Ihre Registrierung wurde erfolgreich abgeschlossen.';
			}
		} else {
			// if (self::requireClearing()) {
			// 	$successMsg = t('.oe24.core.Registration.actualize.waitForClearing');
			// } else
			if ($isNewEmailAddress) {
				self::sendUserActivationMail($reg_email);
				// $successMsg = t('.oe24.core.Registration.actualize.waitForFrontendActivation');
			 	$successMsg = 'Ihre Aktualisierung wurde erfolgreich abgeschlossen. Sie erhalten in Kürze eine E-Mail an die von Ihnen angegebene E-Mail-Adresse. In dieser E-Mail finden Sie für Ihre Aktualisierung einen Freischaltungslink. Ihre Aktualisierung wird aktiviert, sobald Sie diesen Link geöffnet haben. Danach haben Sie die Möglichkeit sich in Ihren Account einzuloggen.';

			} else {
				// $success = true;
				$successMsg = 'Ihre persönlichen Daten wurden aktualisiert.';
			}
		}

		return Oe24User::returnStatus($type, null, $successMsg);
	}

	public static function outputJsonUserData($inError = null, $inSuccess = null) {
		return parent::outputJsonUserData($inError, $inSuccess);
	}

	// AENDERUNGEN AN DIESER LOGIK AUCH AUF MOBIL CHECKEN!!!
	public static function oe24GetUserFields($site, $isMobile = false) {
		$userFields = parent::getUserFields();

		// Für den Fall, dass wir neue Felder auf oe24 brauchen, können diese hier eingefügt werden.
		$userFields[] = array(
			'field' => 'input',
			'type' => 'text',
			'label' => 'Ort',
			'name' => 'reg_usercity',
			'data-source' => 'userCity',
			'maxlength' => 100
		);
		$userFields[] = array(
			'field' => 'input',
			'type' => 'text',
			'label' => 'Hausnummer',
			'name' => 'reg_userstreetnr',
			'data-source' => 'userStreetNr',
			'maxlength' => 10
		);
		$userFields[] = array(
			'field' => 'input',
			'type' => 'text',
			'label' => 'Stiege',
			'name' => 'reg_userstairs',
			'data-source' => 'userStairs',
			'maxlength' => 10
		);
		$userFields[] = array(
			'field' => 'input',
			'type' => 'text',
			'label' => 'Türnummer',
			'name' => 'reg_userdoor',
			'data-source' => 'userDoor',
			'maxlength' => 10
		);


		$passwordRequired = ('register' === $site) ? true : false;

		$agbLink = 'http://www.oe24.at/oesterreich/agb/AGB/800276';
		$netiquetteLink = 'http://www.oe24.at/service/Netiquette-Hausordnung-oe24-at/1603065';

		// AENDERUNGEN AN DIESER LOGIK AUCH AUF MOBIL CHECKEN!!!
		$userFieldsOverride = array(
			'reg_usergender' => array(
				'required' => true,
				'formBereich' => 0,
				'position' => 0,
				'divPosition' => 'topLeft',
				'class' => 'usergender',

				'mobilFormBereich' => 0,
				'mobilPosition' => 0,
				'mobilDivPosition' => 'topLeft',
			),
			'reg_userfirstname' => array(
				'required' => true,
				'formBereich' => 0,
				'position' => 1,
				'divPosition' => 'left',

				'mobilFormBereich' => 0,
				'mobilPosition' => 1,
				'mobilDivPosition' => 'left',
			),
			'reg_userlastname' => array(
				'required' => true,
				'formBereich' => 0,
				'position' => 3,
				'divPosition' => 'right',

				'mobilFormBereich' => 0,
				'mobilPosition' => 3,
				'mobilDivPosition' => 'right',
			),
			'reg_email' => array(
				'required' => true,
				'formBereich' => 0,
				'position' => 4,
				'divPosition' => 'right',
				'label' => 'Ihre E-Mail Adresse',

				'mobilFormBereich' => 0,
				'mobilPosition' => 4,
				'mobilDivPosition' => 'right',
			),
			'reg_username' => array(
				'required' => true,
				'formBereich' => 0,
				'position' => 2,
				'divPosition' => 'left',
				'label' => 'Ihr Benutzername',

				'mobilFormBereich' => 0,
				'mobilPosition' => 2,
				'mobilDivPosition' => 'left',
			),
			'reg_password' => array(
				'required' => $passwordRequired,
				'formBereich' => 1,
				'position' => 0,
				'divPosition' => 'left',
				'label' => 'Ihr Passwort',

				'mobilFormBereich' => 1,
				'mobilPosition' => 0,
				'mobilDivPosition' => 'left',
			),
			'reg_password_repeat' => array(
				'required' => $passwordRequired,
				'formBereich' => 1,
				'position' => 1,
				'divPosition' => 'right',
				'label' => 'Passwort wiederholen',

				'mobilFormBereich' => 1,
				'mobilPosition' => 1,
				'mobilDivPosition' => 'right',
			),
			'reg_useraddress' => array(
				'required' => false,
				'formBereich' => 2,
				'position' => 0,
				'divPosition' => 'left',
				'label' => 'Strasse',

				'mobilFormBereich' => 2,
				'mobilPosition' => 0,
				'mobilDivPosition' => 'left',
			),
			'reg_userstreetnr' => array(
				'required' => false,
				'formBereich' => 2,
				'position' => 1,
				'divPosition' => 'left',

				'mobilFormBereich' => 2,
				'mobilPosition' => 1,
				'mobilDivPosition' => 'left',
			),
			'reg_userstairs' => array(
				'required' => false,
				'formBereich' => 2,
				'position' => 2,
				'divPosition' => 'left',

				'mobilFormBereich' => 2,
				'mobilPosition' => 2,
				'mobilDivPosition' => 'left',
			),
			'reg_userdoor' => array(
				'required' => false,
				'formBereich' => 2,
				'position' => 3,
				'divPosition' => 'left',

				'mobilFormBereich' => 2,
				'mobilPosition' => 3,
				'mobilDivPosition' => 'left',
			),
			'reg_userzip' => array(
				'required' => false,
				'formBereich' => 2,
				'position' => 4,
				'divPosition' => 'right',

				'mobilFormBereich' => 2,
				'mobilPosition' => 4,
				'mobilDivPosition' => 'right',
			),
			'reg_usercity' => array(
				'required' => false,
				'formBereich' => 2,
				'position' => 5,
				'divPosition' => 'right',

				'mobilFormBereich' => 2,
				'mobilPosition' => 5,
				'mobilDivPosition' => 'right',
			),
			'reg_usercountry' => array(
				'required' => false,
				'formBereich' => 9999,
				'position' => 9999,
				'divPosition' => 'left',

				'mobilFormBereich' => 9999,
				'mobilPosition' => 9999,
				'mobilDivPosition' => 'left',
			),
			'reg_userstate' => array(
				'required' => false,
				'formBereich' => 9999,
				'position' => 9999,
				'divPosition' => 'left',

				'mobilFormBereich' => 9999,
				'mobilPosition' => 9999,
				'mobilDivPosition' => 'left',
			),
			'reg_userjob' => array(
				'required' => false,
				'formBereich' => 9999,
				'position' => 9999,
				'divPosition' => 'right',

				'mobilFormBereich' => 9999,
				'mobilPosition' => 9999,
				'mobilDivPosition' => 'right',
			),
			'reg_userphonenumber' => array(
				'required' => true,
				'formBereich' => 2,
				'position' => 6,
				'divPosition' => 'right',

				'mobilFormBereich' => 2,
				'mobilPosition' => 6,
				'mobilDivPosition' => 'right',
			),
			'reg_userbirthdayDay' => array(
				'required' => false,
				'formBereich' => 2,
				'position' => 7,
				'divPosition' => 'right',

				'mobilFormBereich' => 3,
				'mobilPosition' => 0,
				'mobilDivPosition' => 'center',
			),
			'reg_userbirthdayMonth' => array(
				'required' => false,
				'formBereich' => 2,
				'position' => 7,
				'divPosition' => 'right',

				'mobilFormBereich' => 3,
				'mobilPosition' => 0,
				'mobilDivPosition' => 'center',
			),
			'reg_userbirthdayYear' => array(
				'required' => false,
				'formBereich' => 2,
				'position' => 7,
				'divPosition' => 'right',

				'mobilFormBereich' => 3,
				'mobilPosition' => 0,
				'mobilDivPosition' => 'center',
			),
			'reg_agb' => array(
				'required' => true,
				'formBereich' => 3,
				'position' => 0,
				'divPosition' => 'agreeLeft',
				'label' => 'Ich habe die <u><a href="' . $agbLink . '" target="_blank">AGB</a></u> gelesen und erkläre mich damit einverstanden.',

				'mobilFormBereich' => 4,
				'mobilPosition' => 0,
				'mobilDivPosition' => 'agreeLeft',
			),
			'reg_netiquette' => array(
				'required' => true,
				'formBereich' => 3,
				'position' => 1,
				'divPosition' => 'agreeRight',
				'label' => 'Ich habe die <u><a href="' . $netiquetteLink . '" target="_blank">Netiquette</a></u> gelesen und erkläre mich damit einverstanden.',

				'mobilFormBereich' => 4,
				'mobilPosition' => 1,
				'mobilDivPosition' => 'agreeRight',
			),
			'register' => array(
				'required' => false, // true
				'formBereich' => 3,
				'position' => 2,
				'divPosition' => 'submit',

				'mobilFormBereich' => 4,
				'mobilPosition' => 2,
				'mobilDivPosition' => 'submit',
			),
			'reg_status' => array(
				'required' => true,
				'formBereich' => 3,
				'position' => 2,
				'divPosition' => 'submit',

				'mobilFormBereich' => 4,
				'mobilPosition' => 2,
				'mobilDivPosition' => 'submit',
			),
			'reg_userid' => array(
				'required' => true,
				'formBereich' => 3,
				'position' => 2,
				'divPosition' => 'submit',

				'mobilFormBereich' => 4,
				'mobilPosition' => 2,
				'mobilDivPosition' => 'submit',
			),
			'userRegister' => array(
				'required' => true,
				'formBereich' => 3,
				'position' => 2,
				'divPosition' => 'submit',

				'mobilFormBereich' => 4,
				'mobilPosition' => 2,
				'mobilDivPosition' => 'submit',
			),
			'successUrl' => array(
				'required' => true,
				'formBereich' => 3,
				'position' => 2,
				'divPosition' => 'submit',

				'mobilFormBereich' => 4,
				'mobilPosition' => 2,
				'mobilDivPosition' => 'submit',
			),
		);

		$userPostLabel = array(
			spunQ_User::GENDER_FEMALE => 'Frau',
			spunQ_User::GENDER_MALE => 'Herr',
		);

		$colIndex = 0;
		$userFieldsCols = array();
		$postRegister = self::_getPostData('register');

		foreach($userFields as $key => $fields){

			if ('newcolumn' == $fields['field']) {
				$colIndex++;
				continue;
			}

			if ('reg_userjob' == $fields['name'] || 'reg_usercountry' == $fields['name'] || 'reg_userstate' == $fields['name']) {
				continue;
			}

			$formBereich = null;
			$position = null;
			$divPosition = null;

			if ( isset( $userFieldsOverride[$fields['name']] ) ) {

				if (true === $isMobile) {
					$formBereich = $userFieldsOverride[$fields['name']]['mobilFormBereich'];
					$position = $userFieldsOverride[$fields['name']]['mobilPosition'];
					$divPosition = 'mobilDivPosition';
				} else {
					$formBereich = $userFieldsOverride[$fields['name']]['formBereich'];
					$position = $userFieldsOverride[$fields['name']]['position'];
					$divPosition = 'divPosition';
				}

				if ( isset( $userFieldsOverride[$fields['name']]['required'] ) ) {
					$value = $userFieldsOverride[$fields['name']]['required'];
					$userFields[$key]['required'] = $value;
				}

				if ( isset( $userFieldsOverride[$fields['name']]['label'] ) ) {
					$value = $userFieldsOverride[$fields['name']]['label'];
					$userFields[$key]['label'] = $value;
				}

				if ( isset( $userFieldsOverride[$fields['name']]['class'] ) ) {
					$value = $userFieldsOverride[$fields['name']]['class'];
					$userFields[$key]['class'] = $value;
				}

				if ( isset( $userFieldsOverride[$fields['name']][$divPosition] ) ) {
					$value = $userFieldsOverride[$fields['name']][$divPosition];
					$userFields[$key]['divPosition'] = $value;
				}

			}

			if (null === $formBereich) {
				continue;
			}
			if (null === $position) {
				continue;
			}

			$spunqUser = user();
			if ('Speichern und Weiter' === $postRegister) {
				$postValue = self::_getPostData($fields['name']);
				if (false !== $postValue) {

					if (isset($fields['type'])) {

						switch ($fields['type']) {
							case 'radio':
								if ($postValue == $fields['value']) {
									$userFields[$key]['checked'] = 'checked';
								}
								break;

							case 'text':
							case 'tel':
								$userFields[$key]['value'] = $postValue;
								break;

							case 'hidden':
								if ($fields['name'] === 'reg_userid') {

									if ($postValue == 0 && $spunqUser !== spunQ_User::getGuest()) {
										$retField = self::setValueInputFields($userFields[$key], $spunqUser);
										$userFields[$key] = $retField;
									}

									// Sicherheitsmechanismus, damit man die ID nicht überschreiben kann im hidden-feld und sich als anderen User ausgibt.
									if ($postValue > 0) {
										if ($spunqUser->getId() != $postValue) {
											$userFields[$key]['value'] = $postValue;
										} else {
											$retField = self::setValueInputFields($userFields[$key], $spunqUser);
											$userFields[$key] = $retField;
										}
									}

								} else {
									$userFields[$key]['value'] = $postValue;
								}
								break;
						}
					}

					if (isset($fields['field']) && 'select' === $fields['field']) {
						$userFields[$key]['value'] = $postValue;
					}

				}
			} else if ($spunqUser !== spunQ_User::getGuest()) {
				$retField = self::setValueInputFields($userFields[$key], $spunqUser);
				$userFields[$key] = $retField;
			}

			if ( isset($fields['post-label']) && isset( $userPostLabel[$fields['value']] ) ) {
				$value = $userPostLabel[$fields['value']];
				$userFields[$key]['post-label'] = $value;
			}

			$userFieldsCols[$formBereich][$position][] = $userFields[$key];
		}

		function sortUserFields($a, $b) {
			return ($a < $b) ? -1 : 1;
		}
		uksort($userFieldsCols, "sortUserFields");
		foreach ($userFieldsCols as $key => $val) {
			uksort($userFieldsCols[$key], "sortUserFields");
		}

		return $userFieldsCols;
	}

	private static function setValueInputFields($field, $spunqUser) {
		$value = null;
		$checked = null;
		$oe24User = $spunqUser->getOe24User();
		$birthday = $oe24User->getBirthday();
		switch ($field['name']) {
			case 'reg_usergender':
				$checked = $spunqUser->getGender();
				break;

			case 'reg_userfirstname':
				$value = $spunqUser->getFirstName();
				break;

			case 'reg_userlastname':
				$value = $spunqUser->getLastName();
				break;

			case 'reg_email':
				$value = $spunqUser->getEmail();
				break;

			case 'reg_username':
				$value = $spunqUser->getUsername();
				break;

			case 'reg_useraddress':
				$value = $oe24User->getAddress();
				break;

			case 'reg_userstreetnr':
				$value = $oe24User->getStreetNr();
				break;

			case 'reg_userstairs':
				$value = $oe24User->getStairs();
				break;

			case 'reg_userdoor':
				$value = $oe24User->getDoor();
				break;

			case 'reg_userzip':
				$value = $oe24User->getZip();
				break;

			case 'reg_usercity':
				$value = $oe24User->getCity();
				break;

			case 'reg_usercountry':
				$value = $oe24User->getCountry();
				break;

			case 'reg_userstate':
				$value = $oe24User->getState();
				break;

			case 'reg_userjob':
				$value = $oe24User->getJob();
				break;

			case 'reg_userphonenumber':
				$value = $oe24User->getPhoneNumber();
				break;

			case 'reg_userbirthdayDay':
				if (null === $birthday) {
					break;
				}
				$value = $birthday->getDay();
				break;

			case 'reg_userbirthdayMonth':
				if (null === $birthday) {
					break;
				}
				$value = $birthday->getMonth();
				break;

			case 'reg_userbirthdayYear':
				if (null === $birthday) {
					break;
				}
				$value = $birthday->getYear();
				break;

			case 'reg_userid':
				$value = $spunqUser->getId();
				break;
		}
		if (null !== $value) {
			$field['value'] = $value;
		}
		if (null !== $checked && $checked == $field['value']) {
			$field['checked'] = 'checked';
		}
		return $field;
	}

}
?>
