<?
/**
* Liveticker Part
*
* @var article oe24.core.Text
*/

// -------------------------------------------

$tickerSections = $article->getTextSections();

if (0 === count($tickerSections)) {
	return '';
}

$tickerPages = getTextSectionAsArray($tickerSections);

$pageBody = '';
$pageStyle = '';
$tickerID = 'id="liveticker"';

foreach ($tickerPages as $key => $tickerPage) {

	if (isset($tickerPage['pageBreak']) && true === $tickerPage['pageBreak']) {
		$pageBody = 'article_page_body';
		$pageStyle = 'style="display: none;"';
		$tickerID = '';
	}

?>
	<div class="<?= $pageBody; ?> article_ticker" <?= $pageStyle; ?> <?= $tickerID; ?>>

		<div class="ticker_reload">
			<button class="btn_ticker_reload" onclick="window.location.reload();"><span class="icon icon_sharable"></span>&nbsp;Liveticker aktualisieren</button>
		</div>

		<?
		$idx=0;
		foreach($tickerPage['entrys'] as $ticker){
		?>

			<div class="ticker_row <?=$ticker['class'];?> clearfix">

				<div class="ticker_info <?=empty($ticker['leadText']) ? 'ticker_text_only' : '';?>">
					<span>
						<div><?=$ticker['shortDate'];?></div>
						<div>
							<? if (isset($ticker['austausch']) && $ticker['austausch'] == "1"): ?>
							<img src="http://webmisc.oe24.at/fussball/images/emchange.png" alt="" />
							<? endif; ?>
							<? if (isset($ticker['gelbekarte']) && $ticker['gelbekarte'] == "1"): ?>
							<img src="http://webmisc.oe24.at/fussball/images/emyellow.png" alt="" />
							<? endif; ?>
							<? if (isset($ticker['rotekarte']) && $ticker['rotekarte'] == "1"): ?>
							<img src="http://webmisc.oe24.at/fussball/images/emred.png" alt="" />
							<? endif; ?>
							<? if (isset($ticker['gelbrotekarte']) && $ticker['gelbrotekarte'] == "1"): ?>
							<img src="http://webmisc.oe24.at/fussball/images/emyellowred.png" alt="" />
							<? endif; ?>
							<? if (isset($ticker['tor']) && $ticker['tor'] == "1"): ?>
							<img src="http://webmisc.oe24.at/fussball/images/emgoal.png" alt="" />
							<? endif; ?>
							<? if (isset($ticker['anpfiff']) && $ticker['anpfiff'] == "1"): ?>
							<img src="http://webmisc.oe24.at/fussball/images/empipe.png" alt="" />
							<? endif; ?>
						</div>
					</span>
					<span class="marker">&nbsp;</span>
				</div>
				<div class="ticker_body">
					<? if (!empty($ticker['leadText'])): ?>
						<h3><?=$ticker['leadText'];?></h3>
					<? endif; ?>
					<?=$ticker['bodyText'];?>
				</div>

				<?//if(($idx % 5)==0 && $idx!=0){?>
					<?//etpl('oe24.oe24.adition.adSlot',array('channel' => $article->getHomeChannel(), 'id' => 'LiveTicker'. ($idx / 5)));?>
				<?//}?>

			</div>

		<?
			$idx++;
		}
		?>
	</div>

<?
}
?>
