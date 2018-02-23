<?php

/**
 * Split Area - SidebarRelatedStories - rl2014
 *
 * var channel oe24.core.Channel
 * var column oe24.core.ChannelColumn
 * var box oe24.core.ContentBox
 *
 * @var contents array<oe24.core.TextualContent>
 * @var boxHeadline string
 * @var showNumbers boolean
 * @var showImages boolean
 * @var layout string
 * @default layout oe24
 */

// $boxHeaderIcon = '&#xe618;';
$boxHeaderIcon = 'icon icon_list1';

$boxData = getRelatedStories($contents);
$listeboxClass = 'listbox_image';

if (empty($boxData)) {
	return null;
}

$colClass = 'col_wide_right';
if ('madonna' == $layout) {
	$colClass = 'col_default';
}

?>
<div class="col <?= $colClass; ?> listbox <?=$listeboxClass?>">

	<div class="listbox_header">
		<span class="listbox_header_icon <?=$boxHeaderIcon?>"></span>
		<span class="listbox_header_caption"><?=$boxHeadline?></span>
	</div>

	<div class="listbox_body">
		<ul class="clearfix">
			<?foreach ($boxData as $key => $item):?>
			<li>
				<a href="<?=$item['urlAttr']['href']?>" title="<?=$item['urlAttr']['title']?>" <? if(isset($item['urlAttr']['target']) && "" !== $item['urlAttr']['target']){?> target="<?=$item['urlAttr']['target']?>" <?}?> >
					<? if ($showNumbers): ?>
					<span class="listbox_key"><?=($key + 1)?></span>
					<? endif; ?>
					<? if ($showImages): ?>
					<img class="listbox_image" src="<?=$item['imageUrl']?>" alt="">
					<? endif; ?>
					<span class="listbox_caption">
						<?//<span class="listbox_pre_title"><?=$item['preTitle']?###></span>?>
						<span class="listbox_title"><?=$item['title']?></span>
					</span>
				</a>
			</li>
			<?endforeach?>
		</ul>
	</div>

</div>
