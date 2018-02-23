<?
/**
* Mailto Template for Slideshows
*
* @var params array<any>
* @var channel oe24.core.Channel
*/


// (ws)
$useSplitArea = false;
if($channel && $channel instanceof Channel && $channel !== NULL){
	$useSplitArea = $channel->getOptions(true,true)->get('useSplitArea');
}
// (ws) end


# Send E-Mails
$content = $params["content"];
$messages = array();
$form = form("oe24.oe24.story.mailTo");
if(isset($_POST['mailNow'])){
	# Check Form submit is OK
	if($form->wasSubmittedSuccessfully()){
		# Remove duplicate emails
		$toMails = explode(";",trim(strtolower($form->getField("to")->getSubmittedValue())));
		$toMails = array_unique($toMails);
		# Maximum of 10 E-Mail per request
		if(count($toMails)>10){
			$messages[] = "Nicht mehr als 10 Empfänger erlaubt";
		}else{
			# Build Mailtext
			$mailText = "Diese Slideshow wurde Ihnen geschickt von ".$form->getField("from")->getSubmittedValue();
			if($form->getField("text")->getSubmittedValue()){
				$mailText .= " mit der persönlichen Nachricht\n\n".htmlspecialchars($form->getField("text")->getSubmittedValue(), ENT_NOQUOTES, 'UTF-8');
			}
			$mailText .= "\n\nBitte beachten Sie:\nÖsterreich hat die Identität des Absenders nicht überprüft\n\n";
			$mailText .= $content->getHomeChannel()->getPageTitle().", ".formatDateUsingIntlLangKey("datetime.medium", $content->getFrontendDate())."\n";
			$mailText .= "-------------------------------------------\n";
			$mailText .= htmlspecialchars($content->getTitle(), ENT_NOQUOTES, 'UTF-8')."\n";
			$mailText .= "-------------------------------------------\n";
			$mailText .= htmlspecialchars(trim(preg_replace("~<(.*?)>~is","",$content->getPreTitle())), ENT_NOQUOTES, 'UTF-8')."\n\n";
			$mailText .= "Den vollständigen Artikel erreichen Sie im Internet unter der URL:\n";
			$mailText .= $content->getUrl();
			# Send
			$mail = strg_Mail::create(implode(";", $toMails), "oe24.at <noreply@oe24.at>", "oe24.oe24.mail.subject", "oe24.oe24.mail.body", "oe24.oe24.mail.bodyHTML");
			$mail->send(array("subject" => "Empfehlung oe24.at",  "text" => $mailText));
			response()->addHeader("location: ".request()->getUri(true)."?success");
			return NULL;		}
	}else{
		// $messages[] = "Bitte korrekte E-Mails eintragen";
		$messages[] = '<p class="userFormError">Bitte korrekte E-Mails eintragen</p>';
	}
}elseif(isset($_GET['success'])){
	 $messages[] = "Die Diashow wurde versendet.";
	 $messages[] = '<p class="backTo"><a href="'.$content->getUrl().'">&laquo; Zurück zur Diashow</a></p>';
}

?>

<? if (!$useSplitArea): ?>

<div class="storybox" style="background-image: none; padding:14px;">
	<div class="main" style="padding: 0px; float: none; width: auto;">
		<? tpl("oe24.oe24.standardHeadline", array("title" => "Diashow weitersenden")) ?>

		<div class="preTitle"><? s($content->getPreTitle())?></div>
		<div class="texttitle"><? s($content->getTitle())?></div>
		<br/><br/>

		<form <? $form->showFormAttributes() ?> class="userForm">
			<?if(!empty($messages)){?>
			<div class="messages<?=(isset($_GET['success'])?" success":"")?>">
				<?
				foreach($messages as $message){
					echo "$message<br/>\n";
				}
				?>
			</div>
			<?}
			if(!isset($_GET['success'])){?>
				<table align="center" width="100%" cellpadding="2" cellspacing="0">
					<tr>
						<td width="40%" valign="top">Diashow senden an <font color="red">*</font></td>
						<td><? $form->getField("to")->show(NULL, array("long"))?><br/>
						Geben Sie hier die E-Mail-Adresse des Empfängers ein (z.B. xy@z.com).<br/>
						Mehrere Empfänger werden durch Kommata getrennt.
						</td>
					</tr>
					<tr>
						<td>Ihre eigene E-Mail-Adresse <font color="red">*</font></td>
						<td><? $form->getField("from")->show((user()->getGuest()!==user())?user()->getEmail():"", array("long"))?></td>
					</tr>
					<tr>
						<td valign="top">Mitteilung an den Empfänger (optional): </td>
						<td>
						<textarea cols="5" rows="8" class="long" name="<?=$form->getField("text")->getHtmlName()?>"><?s($form->getField("text")->getSubmittedValue())?></textarea>
						</td>
					</tr>
					<tr>
						<td></td>
						<td><input type="submit" name="mailNow" value="Abschicken"/></td>
					</tr>
				</table>
			<?}?>
		</form>

		<div class="headline">
			<a class="more" href="<?=$content->getUrl()?>">zurück zur Diashow</a>
		</div>
	</div>
</div>

<? else: ?>

<?

$options = array(
	'Headline-Titel' => 'Mail versenden',
	'Headline-Text' => '',
	'Headline-Von' => '',
	'RedakteurIn-Bild' => null,
	'RedakteurIn-Text' => '',
	'RedakteurIn-Name' => '',
);

$templateOptions = new spunQ_Map($options);

tpl('oe24.oe24.__splitArea.tpl.row.row_margin', array('position' => 'top'));

?>

<div class="row">

	<? tpl('oe24.oe24.__splitArea.tpl.row.row_caption', array('templateOptions' => $templateOptions, 'homeChannelUrl' => '')); ?>

	<!-- content start -->
	<div class="content">

		<article class="article_box">
			<div class="article_box_wrapper">

				<h2 class="caption"><? s($content->getPreTitle()) ?></h2>
				<h1><? s($content->getTitle()) ?></h1>

				<form <? $form->showFormAttributes() ?> class="userForm">

					<?if (!empty($messages)):?>
					<div class="messages<?=(isset($_GET['success']) ? ' success' : '')?>">
						<?foreach ($messages as $message):?>
						<p><?=$message?></p>
						<?endforeach?>
					</div>
					<?endif?>

					<?if (!isset($_GET['success'])):?>
					<table width="100%">
						<tr>
							<td class="firstCell">Diashow senden an <span class="formRequired">*</span></td>
							<td>
								<p><? $form->getField('to')->show(null, array('long'))?></p>
								<p>Geben Sie hier die E-Mail-Adresse des Empfängers ein (z.B. xy@z.com).</p>
								<p>Trennen Sie bitte mehrere Empfänger durch Kommata.</p>
							</td>
						</tr>
						<tr>
							<td class="firstCell">Ihre eigene E-Mail-Adresse <span class="formRequired">*</span></td>
							<td><? $form->getField('from')->show((user()->getGuest() !== user()) ? user()->getEmail() : '', array('long')) ?></td>
						</tr>
						<tr>
							<td class="firstCell">Mitteilung an den Empfänger (optional): </td>
							<td><textarea cols="5" rows="8" class="long" name="<?=$form->getField('text')->getHtmlName()?>"><?=$form->getField('text')->getSubmittedValue()?></textarea></td>
						</tr>
						<tr>
							<td><p class="backTo"><a href="<?=$content->getUrl()?>">&laquo; Zurück zur Diashow</a></p></td>
							<td class="userFormSubmit"><input type="submit" name="mailNow" value="Abschicken"/></td>
						</tr>
					</table>
					<?endif?>

				</form>

			</div>
		</article>

	</div>
	<!-- content end -->

	<!-- sidebar start -->
	<div class="sidebar">
	<?
		etpl('oe24.oe24.__splitArea.article.relatedStories', array(
				'contents' => $content->getRelatedStories(),
				'boxHeadline' => 'Zum Thema',
				'showNumbers' => false,
				'showImages' => true,
			)
		);

		etpl('oe24.oe24.__splitArea._page.standardColumnsSplitArea', array('columnName' => 'Split-Story-Teaser Area', 'channel' => $channel, 'object' => $content, 'hide' => array()));
	?>
	</div>
	<!-- sidebar end -->

</div>

<?
tpl('oe24.oe24.__splitArea.tpl.row.row_margin', array('position' => 'bottom'));
?>

<? endif; ?>
