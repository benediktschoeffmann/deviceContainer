<?
/**
* Social Connect Box
*
* @var channel oe24.core.Channel
* @var content oe24.core.Content
* @var layout string
*/

// soll nicht in allen oe2016-layouts angedruckt werden, nur in den folgenden
$validLayouts = array(
	'oe24',
	'society',
	'sport',
	'business',
	'businesslive',
	'games24',
	'gesund24',
	'cooking24',
);

if (!in_array($layout, $validLayouts)) {
	return;
}

// ---------------------------------------------------------

// channel überprüfen
$channelId = $channel->getId();
$parentId = ($channel->getParent()) ? $channel->getParent()->getId() : false;

$isDevServer = (spunQ::inMode(spunQ::MODE_DEVELOPMENT)) ? true : false;

// nur andrucken, wenn wir NICHT im 'Wahl2017' - Channel sind
// Test/Development - id: '161622022'
// Produktiv - id: '296327773'

if ($isDevServer) {
	if ($channelId == '161622022' || $parentId == '161622022') {
		return;
	}
}
else {
	if ($channelId == '296327773' || $parentId == '296327773') {
		return;
	}
}

// ---------------------------------------------------------

// bei geraden Stunden Newsletter-Anmeldung, bei ungeraden Facebook-Like andrucken
$showInfo = date('H') % 2;
// auf Newsletter-Anmeldeseite immer Facebook andrucken
$showInfo = ($content->getId() == '227144488') ? 1 : $showInfo;

// ---------------------------------------------------------

?>

<div class="article_share socialBox">

	<? if (0 == $showInfo): ?>
		<? /* Newsletter-Anmeldung */ ?>
		<div class="newsletterBox">

			<form name="ProfileForm" onsubmit="return emarsys.register.CheckInputs('a');" action="http://news.oe24.at/u/register.php" method="post">
				<input type=hidden name="CID" value="766072558">
				<input type=hidden name="SID" value="">
				<input type=hidden name="UID" value="">
				<input type=hidden name="f" value="1200">
				<input type=hidden name="p" value="2">
				<input type=hidden name="a" value="r">
				<input type=hidden name="el" value="">
				<input type=hidden name="endlink" value="">
				<input type=hidden name="llid" value="">
				<input type=hidden name="c" value="">
				<input type=hidden name="counted" value="">
				<input type=hidden name="RID" value="">
				<input type=hidden name="mailnow" value="">

				<input type="text" name="inp_3" placeholder="E-Mailadresse hier eintragen">
				<input type="submit" value="LOS">
			</form>

		</div>


	<? endif; ?>

	<? if (1 == $showInfo): ?>
		<? /* Facebook-Like */ ?>

		<div class="fbPluginBox">
			<div class="fbBack">

				<? if (1): ?>
					<div class="fbCont">
						<div class="fb-like" data-href="https://www.facebook.com/oe24.at/" data-layout="button_count" data-action="like" data-size="small" data-show-faces="false" data-share="false"></div>
					</div>
				<? endif; ?>

			</div>
		</div>

	<? endif; ?>
</div>