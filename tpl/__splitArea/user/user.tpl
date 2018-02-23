<?php
/**
* user tpl
*
* @var channel oe24.core.Channel
* @var params array<any>
*
* @nodevmodecomments
*/
$errorMessages = (count($params['messages']) > 0) ? $params['messages']['error'] : null;
$successMessages = (count($params['messages']) > 0) ? $params['messages']['success'] : null;

$header = (user() === spunQ_User::getGuest()) ? 'Registrierung' : 'Meine Daten';
$type = (user() === spunQ_User::getGuest()) ? 'register' : 'profil';

if ($successMessages && isset($_GET['redirect'])) {
	redirect(request()->getGetValue('redirect'));
	return null;
}

$userFields = Oe24User::oe24GetUserFields($type);

$fieldsArr = array();

foreach ($userFields as $formBereich => $columns) {
	// in welches fieldset kommen die formularfelder
	$formCols = array();
	$lastFieldName = '';

	foreach ($columns as $position => $fields) {
		// die positionierung der divs innerhalb des fieldsets (anrede eigenständig, linkes div, rechtes div und ein submit-div)
		$formFelder = array();
		$divPosition = '';

		foreach ($fields as $key => $field) {
			// die einzelnen input-felder durchgehen
			$isRequired = (isset($field['required'])) ? $field['required'] : false;
			$required = ($isRequired) ? ' required="required"' : '';
			$requiredClass = ($isRequired) ? 'requiredBefore' : '';

			$fieldClass = (isset($field['class'])) ? $field['class'] : '';

			$inputField = '';

			switch ($field['field']) {
				case 'input':
					$postLabel = '';
					$inputValue = '';
					if (isset($field['value'])) {
						$inputValue = $field['value'];
					}
					if (isset($field['type']) && 'checkbox' === $field['type']) {
						$inputValue = 'on';
					}

					$labelFor = $field['name'];
					if (isset($field['post-label'])) {
						$labelFor = $field['name'] . '_' . strtolower($field['post-label']);
						$postLabel = '<label for="' . $labelFor . '">' . $field['post-label'] . '</label>' . "\n";
					}

					$class = '';
					if ('submit' === $field['type']) {
						$class = ' class="button"';
					}

					$maxLength = '';
					if (isset($field['maxlength'])) {
						$maxLength = ' maxlength="' . $field['maxlength'] . '"';
					}

					$checked = '';
					if (isset($field['checked']) && 'checked' === $field['checked']) {
						$checked = ' checked="checked"';
					}
					$inputField = '<input type="' . $field['type'] . '" id="' . $labelFor . '" name="' . $field['name']. '" value="' . $inputValue . '" ' . $required . $maxLength . $class . $checked . ' />' . "\n" . $postLabel;
					break;

				case 'select':
					$postValue = (isset($field['value'])) ? $field['value'] : null;
					$options = array();
					foreach ($field['options'] as $option) {

						if (is_array($option)) {
							$optionValue = $option[0];
							if (isset($option[1])) {
								$optionText = $option[1];
							} else {
								$optionText = $option[0];
							}
						} else {
							$optionValue = $option;
							$optionText = $option;
						}

						$selected = ($optionValue == $postValue) ? ' selected="selected"' : '';

						$options[] = '<option value="' . $optionValue . '"' . $selected . '>' . $optionText . '</option>' . "\n";
					}
					$inputField = '<select id="' . $field['name'] . '" name="' . $field['name'] . '">' . implode('', $options) . '</select>' . "\n";
					break;
			}

			if (isset($field['label']) && $field['name'] !== $lastFieldName) {

				$labelField = '<label class="' . $requiredClass . ' ' . $fieldClass . '" for="' . $field['name'] . '">' . $field['label'] . '</label>';

				// select-felder zusammenfassen in ein span-element
				if (isset($field['field']) && $field['field'] === 'select') {
					$fieldName = (substr($field['name'], -3) === 'Day') ? substr($field['name'], 4, -3) : substr($field['name'], 4);
					$formFelder[] = '<span class="selectBox clearfix ' . $fieldName . '">';
				}

				if (isset($field['type']) && $field['type'] === 'checkbox') {
					$formFelder[] = $inputField;
					$formFelder[] = $labelField;
				} else {
					$formFelder[] = $labelField;
					$formFelder[] = $inputField;
				}

				// select-felder zusammenfassen in ein span-element
				if (isset($field['field']) && $field['field'] === 'select') {
					$formFelder[] = '</span>';
				}

			} else {

				// bei Geburtstag oder Anrede gibt es keine label-felder, darum werden die input-felder 'zusammengefasst'
				$formFelderCount = count($formFelder);
				if ($formFelderCount > 0) {
					$formFeld = (isset($field['field']) && $field['field'] === 'select') ? 2 : 1;
					$lastTemp = $formFelderCount - $formFeld;
					$formFelder[$lastTemp] = $formFelder[$lastTemp] . $inputField;
				}

			}

			$lastFieldName = $field['name'];
			$divPosition = $field['divPosition'];

		}

		$formCols[$divPosition][] = implode("\n", $formFelder);

	}

	$fieldsArr[] = $formCols;

}

// ANFANG zum einfuegen von elementen in einem Array
if (isset($_GET['noFirstLastName'])) {
	$inputArr = array(
		'topRight' => array(
			0 => '<label style="color:#f00;">Um die Qualität unserer Leserbeiträge sicherzustellen, zeigt oe24 bei Postings ab sofort Klarnamen an.<br><br>Wir sind überzeugt davon, dass die besten Kommentare dadurch gewährleistet sind, wenn unsere User für Ihre Meinung mit Ihrem Namen einstehen.</label>',
		),
	);
	$firstPart = array_splice($fieldsArr[0], 0, 1);
	$fieldsArr[0] = array_merge($firstPart, $inputArr, $fieldsArr[0]);
}

if ($type === 'register') {
	// $popup = "window.open('" . l('oe24.oe24.user.fbRegister', array('channel' => $channel)) . "', 'popup', 'width=1000, height=400')";
	// $inputArr = array(
	// 	'topRight' => array(
	// 		0 => '<label>oder registrieren mit Facebook</label><img class="fb_register" src="http://images01.oe24.at/images/layout/social/fbRegister.png" onclick="' . $popup . '"/>',
	// 	),
	// );

	$fbLogin = new FacebookLogin('oe24_at', l('oe24.oe24.user.fbLogin', array('channel' => $channel, 'action' => 'Register')));

	$inputArr = array(
		'topRight' => array(
			0 => '<label>oder registrieren mit Facebook</label><a href="' . $fbLogin->getLoginUrl() . '" target="_blank"><img class="fb_register" src="http://images01.oe24.at/images/layout/social/fbRegister.png"></a>',
		),
	);

	$firstPart = array_splice($fieldsArr[0], 0, 1);
	$fieldsArr[0] = array_merge($firstPart, $inputArr, $fieldsArr[0]);
}

if ($type === 'profil') {
	$inputArr = array(
		'left' => array(
			0 => '<label class="requiredBefore" for="reg_password_now">Ihr jetziges Passwort</label><input id="reg_password_now" name="reg_password_now" type="password" required="required"/>',
		),
		'submitRight' => array(
			0 => '<a class="button" href="' . l('oe24.oe24.user.lostPassword', array('channel' => $channel)) . '">Passwort vergessen</a>',
		),
	);
	$fieldsArr[1] = $inputArr;
}
// ENDE
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
		<? if (null !== $errorMessages && is_array($errorMessages)): ?>
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
		<form id="userRegisterForm" method="POST">

			<? foreach($fieldsArr as $fieldSetKey => $fieldSets): ?>
			<fieldset>

				<? foreach($fieldSets as $fieldDivKey => $fieldDivs): ?>
				<?
				$col = ('submit' === $fieldDivKey) ? 'col1' : 'col2';

				$break = ('topLeft' === $fieldDivKey || 'agreeLeft' === $fieldDivKey || 'left' === $fieldDivKey || 'submit' == $fieldDivKey) ? 'break' : '';
				$last = ('topRight' === $fieldDivKey || 'agreeRight' === $fieldDivKey || 'right' === $fieldDivKey || 'submitRight' == $fieldDivKey) ? 'last' : '';

				$submitClass = '';
				if ('agreeLeft' === $fieldSetKey || 'agreeRight' === $fieldSetKey) {
					$submitClass = 'userAgree';
				}
				if ('submit' === $fieldDivKey || 'submitRight' === $fieldDivKey) {
					$submitClass = 'userSubmit';
				}

				$class = array();
				$class[] = 'col';
				$class[] = $col;
				if ('break' === $break) {
					$class[] = $break;
				}
				if ('last' === $last) {
					$class[] = $last;
				}
				if ('userAgree' === $submitClass || 'userSubmit' === $submitClass) {
					$class[] = $submitClass;
				}
				$class = implode(' ', $class);
				?>
				<div class="<?=$class;?>">

					<? foreach($fieldDivs as $key => $fields): ?>
						<?=$fields;?>
					<? endforeach; ?>

				</div>
				<? endforeach; ?>

			</fieldset>
			<? endforeach; ?>

		</form>
	</div>

	<div class="sidebar">

	</div>
</div>
