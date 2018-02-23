<?php
/**
 * OE2016 Newsletter Subscribe Form
 *
 * showDescription - im Artikel zur Newsletteranmeldung (verlinked von der Startseite) wird hier zusätzlich der Beschreibungstext angedruckt
 * Position - wo wird das Formular angedruckt, Fullwidth für Anmeldung unter www.oe24.at/newsletter - Box über die volle Breite, Positionierung via css
 *
 * @var showDescription string
 * @default showDescription 0
 * @var position string
 * @default position Sidebar
 * @var newsletter string
 * @default newsletter oe24
  */

// Anmeldemöglichkeit für den Newsletter via emarsys

$showDescription = ($showDescription == '1') ? true : false;

// -----------------------------------------------------

$domain = (spunQ::inMode(spunQ::MODE_DEVELOPMENT)) ? 'http://oe24dev.oe24.at/' : 'http://www.oe24.at/';

$formAction = ($newsletter == 'MediaMonitor') ? $domain . 'service/newsletter/subscribe/mediamonitor' : $domain . 'service/newsletter/subscribe';

// -----------------------------------------------------

$validPositions = array(
	'Sidebar', 'Fullwidth'
);
$position = (in_array($position,$validPositions)) ? $position : 'Sidebar';

// -----------------------------------------------------

$showHeadline = ($position == 'Sidebar') ? true : false;

$showFieldCompanyname = ('MediaMonitor' == $newsletter) ? true : false;

// -----------------------------------------------------
// session-überprüfung
// response()->setSessionValue('newsletterEmarsysRegistration', 'RCahnedcokmtShtirsinnogw1');

// -----------------------------------------------------

$teaserText = ('MediaMonitor' == $newsletter) ? 'Melden Sie sich hier für den oe24 MediaMonitor-Newsletter an.' : 'Mit dem oe24.at-Newsletter erhalten Sie regelmäßig die aktuellsten News und Infos in Ihre Mailbox.';

?>

<? if ($showDescription): ?>
	<p>
		Für alle Interessierte gibt es mit dem oe24-Newsletter täglich die Top-Meldungen direkt in den E-Mail-Posteingang.
	</p>
<? endif; ?>

<div class="defaultbox newsletter <?= $position; ?>">
	<? if ($showHeadline): ?>
		<div class="defaultbox_header">
			<span class="defaultbox_header_caption defaultChannelBackgroundColor">Newsletter Anmelden</span>
		</div>
	<? endif; ?>

	<div class="defaultbox_body">



		<? if (1): ?>

			<div class="newsletterteaser">

				<img src="<?=slp('image','newsletter/mail_img.gif')?>" alt="" class="nlImg">
				<div class="nlTeaser"><?= $teaserText; ?></div>

				<? // formular über oe24 und von dort an emarsys übermitteln -> eigene überprüfung der email-adressen, via 'direkt an emarsys' kann jeder bot eintragungen machen, da emarsys alles übernimmt, email-adressen nicht kontrolliert, auch doppelte einträge sind möglich ?>
				<? if (1): ?>
					<form name="ProfileForm" onsubmit="return emarsys.register.CheckInputs();" action="<?= $formAction; ?>" method="get">
						<input type="hidden" name="nltype" id="nltype" value="<?= $newsletter; ?>">
						<input type="hidden" name="inp_5" id="inp_5" value="">

						<div class="nlFloat nlEmail">E-Mail:</div>
						<div class="nlFloat"><input type=text name="email" id="inp_3" maxlength=255 value=""></div>

						<div class="nlClear nlSpacer">
							<div class="nlFloat nlEmail">Anrede:</div>
							<div class="nlFloat"><select name="gender" id="inp_46" size=1><option value=""> </option><option value="1">Herr</option><option value="2">Frau</option></select></div>
						</div>

						<div class="nlClear nlSpacer">
							<div class="nlFloat nlEmail">Vorname:</div>
							<div class="nlFloat"><input type=text name="firstname" maxlength=60 value=""></div>
						</div>

						<div class="nlClear nlSpacer">
							<div class="nlFloat nlEmail">Nachname:</div>
							<div class="nlFloat"><input type=text name="lastname" maxlength=60 value=""></div>
						</div>

						<div class="nlClear nlSpacer nlDis">
							<div class="nlFloat nlEmail">Adresse:</div>
							<div class="nlFloat"><input type=text name="address" maxlength=120 value=""></div>
						</div>

						<? if ($showFieldCompanyname): ?>
							<div class="nlClear nlSpacer">
								<div class="nlFloat nlEmail">Firmenname:</div>
								<div class="nlFloat"><input type=text name="companyname" maxlength=60 value=""></div>
							</div>

						<? endif; ?>

						<? if (0): ?>
							<div class="nlClear nlSpacer">
								<div class="nlFloat nlEmail"></div>
								<div class="nlFloat nlCheck">
									<input type=checkbox name="optin" id="nlOptin" value="y"> Ja, ich habe die <a href="http://www.oe24.at/oesterreich/agb/AGB/800276" class="nlLink" target="_blank">Allgemeinen Nutzungsbedingungen</a> gelesen und bin damit einverstanden.
								</div>
							</div>
						<? endif; ?>

						<div class="nlSubmit nlClear"><input type=submit name="submit1" value="Anmelden"></div>

						<? if (0): ?>
							<script language="javascript" src="http://news.oe24.at/u/nprefill.js" type="text/javascript"></script>
						<? endif; ?>

					</form>

				<? endif; ?>


				<? // registrierung direkt an emarsys posten ?>
				<? if (0): ?>
					<form name="ProfileForm" onsubmit="return emarsys.register.CheckInputs();" action="http://news.oe24.at/u/register.php" method="get">
						<input type="hidden" name="CID" value="766072558">
						<input type="hidden" name="SID" value="">
						<input type="hidden" name="UID" value="">
						<input type="hidden" name="f" value="1717">
						<input type="hidden" name="p" value="2">
						<input type="hidden" name="a" value="r">
						<input type="hidden" name="el" value="">
						<input type="hidden" name="endlink" value="">
						<input type="hidden" name="llid" value="">
						<input type="hidden" name="c" value="">
						<input type="hidden" name="counted" value="">
						<input type="hidden" name="RID" value="">
						<input type="hidden" name="mailnow" value="">
						<input type="hidden" name="inp_5" id="inp_5" value="">

						<div class="nlFloat nlEmail">E-Mail:</div>
						<div class="nlFloat"><input type=text name="inp_3" maxlength=255 value=""></div>

						<div class="nlClear nlSpacer">
							<div class="nlFloat nlEmail">Anrede:</div>
							<div class="nlFloat"><select name="inp_46" id="inp_46" size=1><option value=""> </option><option value="1">Herr</option><option value="2">Frau</option></select></div>
						</div>

						<div class="nlClear nlSpacer">
							<div class="nlFloat nlEmail">Vorname:</div>
							<div class="nlFloat"><input type=text name="inp_1" maxlength=60 value=""></div>
						</div>

						<div class="nlClear nlSpacer">
							<div class="nlFloat nlEmail">Nachname:</div>
							<div class="nlFloat"><input type=text name="inp_2" maxlength=60 value=""></div>
						</div>

						<? if (0): ?>
							<div class="nlClear nlSpacer">
								<div class="nlFloat nlEmail"></div>
								<div class="nlFloat nlCheck">
									<input type=checkbox name="optin" id="nlOptin" value="y"> Ja, ich habe die <a href="http://www.oe24.at/oesterreich/agb/AGB/800276" class="nlLink" target="_blank">Allgemeinen Nutzungsbedingungen</a> gelesen und bin damit einverstanden.
								</div>
							</div>
						<? endif; ?>

						<div class="nlSubmit nlClear"><input type=submit onclick="javascript:emarsys.register.SubmitIt('a')" name="submit1" value="Anmelden"></div>

						<? if (0): ?>
							<script language="javascript" src="http://news.oe24.at/u/nprefill.js" type="text/javascript"></script>
						<? endif; ?>

					</form>

				<? endif; ?>

			</div>

		<? endif; ?>


		<? if (0): ?>
		<div class="newsletterteaser">

			<img src="<?=slp('image','newsletter/mail_img.gif')?>" alt="" class="nlImg">
			<div class="nlTeaser">Mit dem oe24.at-Newsletter erhalten Sie regelmäßig die aktuellsten News und Infos in Ihre Mailbox.</div>

			<form name="newsletter" target="_top" method="post" action="http://www.oe24.at/service/newsletter/subscribe/oe24">
			<? /* <form name="newsletter" target="_top" method="get" action="http://www.oe24.at/_api/service_newsletter/oe24/subscribe/"> */ ?>
			<? /* <form name="newsletter" target="_top" method="get" action="http://www.oe24.at/service/">	 */ ?>
				<div class="nlFloat nlEmail">* E-Mail: </div>
				<div class="nlFloat"><input name="email" value="" type="text" class="form"/></div>

				<div class="nlClear nlSpacer">
					<div class="nlFloat nlEmail">Anrede: </div>
					<div class="nlFloat">
						<select name="gender" class="form">
							<option value=""></option>
							<option value="f">Frau</option>
							<option value="m">Herr</option>
						</select>
					</div>
				</div>

				<div class="nlClear nlSpacer">
					<div class="nlFloat nlEmail">Vorname: </div>
					<div class="nlFloat"><input name="firstname" value="" type="text" class="form"/></div>
				</div>

				<div class="nlClear nlSpacer">
					<div class="nlFloat nlEmail">Nachname: </div>
					<div class="nlFloat"><input name="lastname" value="" type="text" class="form"/></div>
				</div>

				<div class="nlSubmit nlClear"><input type="submit" value="Anmelden"></div>

				<div class="nlHint">Sie können sich jederzeit wieder abmelden: <a href="http://www.oe24.at/oesterreich/agb/AGB/800276">weitere Informationen</a></div>
			</form>

		</div>
		<? endif; ?>

	</div>

</div>

<? if ($showDescription): ?>
	<p>
		Sie können sich jederzeit wieder abmelden: <a href="http://www.oe24.at/oesterreich/agb/AGB/800276">weitere Informationen</a>
	</p>
	<p>
		Sollten noch Fragen offen geblieben sein, senden Sie uns bitte ein E-Mail an <a href="mailto:online@oe24.at?subject=WhatsApp-Service%20oe24.at">online@oe24.at</a>.
	</p>
<? endif; ?>
