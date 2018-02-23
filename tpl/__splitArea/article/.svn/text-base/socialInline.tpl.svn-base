<?
/**
* Story Site
*
* @var content oe24.core.Content
* @var layout string
* @default layout oe24
*/

$leadText = trim($content->getLeadText(true));
$leadText = urlencode($leadText);
$contentUrl = $content->getUrl();

?>

<div class="article_social_inline clearfix">
	<span class="socialInlineText">Diesen Artikel teilen:</span>

	<? if ('cooking24' === $layout): ?>
		<div id="addthisSharingToolbox" class="addthis_sharing_toolbox"></div>
	<? else: ?>
		<span class="socialInlineSocials">
			<a href="https://www.facebook.com/share.php?u=<?=$contentUrl;?>" onclick="window.open(this.href, 'oe24SocialWindow', 'toolbar=0,resizable=0,width=640,height=480'); return false;">
				<span class="icon icon_facebook" data-tooltip-message="Teilen auf Facebook"></span>
			</a>
			<a href="https://twitter.com/share?url=<?=$contentUrl;?>&amp;text=<?=$leadText;?>" onclick="window.open(this.href, 'oe24SocialWindow', 'toolbar=0,resizable=0,width=640,height=480'); return false;">
				<span class="icon icon_twitter" data-tooltip-message="Artikel Twittern"></span>
			</a>
			<a href="https://plus.google.com/share?url=<?=$contentUrl;?>" onclick="window.open(this.href, 'oe24SocialWindow', 'toolbar=0,resizable=0,width=640,height=480'); return false;">
				<span class="icon icon_googleplus" data-tooltip-message="Teilen auf Google+"></span>
			</a>
			<? if (0): ?>
				<a href="<?=$contentUrl;?>/mailto">
					<span class="icon icon_mail" data-tooltip-message="Teilen per EMail"></span>
				</a>
			<? endif; ?>
		</span>
	<? endif; ?>
</div>
