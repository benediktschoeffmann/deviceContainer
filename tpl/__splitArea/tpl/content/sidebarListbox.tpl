<?php
/**
 * Sidebar ListBox Top Gelesen - rl2014
 *
 * @var contents array<oe24.core.Content>
 * @var listboxHeaderIcon string
 * @var listboxHeaderCaption string
 * @var maxListItems integer
 */

// $listbox_header_icon = '&#xe618;';
// $listbox_header_caption = 'Top Gelesen';
// $max_list_items = 10;

// function truncate_str($string, $maxlen) {
// 	if (strlen($string) <= $maxlen) {
// 		return $string;
// 	}
// 	$string = substr($string, 0, $maxlen);
// 	$string = preg_replace('#[^\s]*$#s', '', $string);
// 	$string = rtrim($string, ' .,;:-!?');
// 	return $string;
// }

$image_format = '92x46NoStretch';
$top_gelesen = array();

foreach ($contents as $key => $content) {

	if ($key >= $maxListItems) {
		break;
	}

	$attr = getContentUrlAttributesArray($content, false, true, true, true);
	$listbox_href = (isset($attr['href']) && is_string($attr['href'])) ? $attr['href'] : '#';
	$listbox_target = (isset($attr['target']) && is_string($attr['target'])) ? $attr['target'] : '';
	$listbox_title = (isset($attr['title']) && is_string($attr['title'])) ? $attr['title'] : '';

	// $listbox_href = '#';
	// $listbox_target = '';
	// $listbox_title = '';


	// $image = $content->getRelatedImages();
	// $image_src = (isset($image[0])) ? $image[0]->getFileUrl($image_format) : null;

	// if (null == $image) {
	// 	$image_src = 'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7';
	// 	$image_dimension = ''; // width="74" height="37"';
	// }

	$image = $content->getFirstRelatedImage(true, $content);
	if ($image) {
		$image_src = $image->getFileUrl($image_format);
	} else {
		$image_src = 'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7';
		$image_dimension = ''; // width="74" height="37"';
	}

	$caption = $content->getPageTitle();
	// $caption = truncate_str($caption, 50);

	$temp = array(
		'listbox_href' => $listbox_href,
		'listbox_target' => $listbox_target,
		'listbox_title' => $listbox_title,
		'listbox_key' => $key + 1,
		'listbox_image' => $image_src,
		'listbox_caption' => $caption,
	);

	$top_gelesen[] = $temp;
}

// unset($top_gelesen);

?>
<div class="col col_wide_right listbox">

	<div class="listbox_header">
		<span class="listbox_header_icon <?= $listboxHeaderIcon; ?>"></span>
		<span class="listbox_header_caption"><?= $listboxHeaderCaption; ?></span>
	</div>

	<div class="listbox_body">
		<?php if (isset($top_gelesen) && is_array($top_gelesen)): ?>
		<ul class="clearfix">
			<?php foreach ($top_gelesen as $key => $item): ?>
			<?php //if ($key >= $maxListItems) break; ?>
			<?php $item_listbox_caption = $item['listbox_caption']?>
			<li>
				<a href="<?=$item['listbox_href']?>">
					<?php if (isset($item['listbox_key']) && '' !== $item['listbox_key']): ?>
					<span class="listbox_key"><?= (isset($item['listbox_key'])) ? $item['listbox_key'] : ''; ?></span>
					<?php else: ?>
					<span class="listbox_key"><?= $key + 1; ?></span>
					<?php endif; ?>
					<img class="listbox_image" src="<?= (isset($item['listbox_image'])) ? $item['listbox_image'] : ''; ?>" alt="">
					<span class="listbox_caption"><?=$item['listbox_caption']?></span>
				</a>
			</li>
			<?php endforeach; ?>
		</ul>
		<?php endif; ?>
	</div>

</div>
