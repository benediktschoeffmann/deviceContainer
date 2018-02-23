<?php

/**
 * Liveticker - rl2014
 * @var object spunQ_Map
 */

// $liveticker_icon = '&#xe61a;';
$liveticker_icon = '&#xe61e;';
$liveticker_caption = 'Liveticker';
$liveticker_time = '17:42';
$liveticker_status = '3:3';
$liveticker_headline = '+++ Ajax <span>vs.</span> Chelsea +++ Live +++';

$liveticker_max_lines = 3;
$liveticker_no_data = 'Zur Zeit sind keine Liveticker-Daten eingelangt';
$liveticker_data = array(
	array('time' => '17:40', 'text' => 'Christian Poulsen wirft den Ball ein'),
	array('time' => '17:37', 'text' => 'Freistoss durch Davy Klaassen'),
	array('time' => '17:36', 'text' => 'Faul von Veltman an Frank Lampard'),
	array('time' => '17:34', 'text' => 'Ausgleich durch Frank Lampard'),
	array('time' => '17:33', 'text' => 'Riedewald prüft den eigenen Tormann Vermeer'),
	array('time' => '17:32', 'text' => 'Kolbeinn Sigþórsson trifft nur die Querlatte'),
);

// sidebar-demo-special.php

?>
<div class="col col_special liveticker">

	<div class="liveticker_header">
		<div class="liveticker_top clearfix">
			<span class="liveticker_icon"><?php echo $liveticker_icon; ?></span>
			<span class="liveticker_caption"><?php echo $liveticker_caption; ?></span>
			<span class="liveticker_time"><?php echo $liveticker_time; ?></span>
		</div>
		<div class="liveticker_status">
			<span><?php echo $liveticker_status; ?></span>
		</div>
		<div class="liveticker_headline">
			<span><?php echo $liveticker_headline; ?></span>
		</div>
	</div>

	<div class="liveticker_body">
		<?php if (isset($liveticker_data) && is_array($liveticker_data)): ?>
		<?php foreach ($liveticker_data as $key => $item): ?>
		<?php if (isset($liveticker_max_lines) && $key >= $liveticker_max_lines) break; ?>
		<div class="liveticker_line">
			<span><?php echo $item['time']; ?></span>
			<span><?php echo $item['text']; ?></span>
		</div>
		<?php endforeach; ?>
		<?php else: ?>
		<div class="liveticker_line">
			<span><?php echo $liveticker_no_data; ?></span>
		</div>
		<?php endif; ?>
	</div>

</div>
