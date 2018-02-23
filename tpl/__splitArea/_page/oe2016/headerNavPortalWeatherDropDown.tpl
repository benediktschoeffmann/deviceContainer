<?
/**
 * headerNavWeatherDropdown
 *
 * @var weatherDomain string
 * @var weatherJson array<any>
 */

if (empty($weatherJson)) {
    return;
}

?>

<script>
weatherDropdown = {
    places     : <?=json_encode($weatherJson['places'])?>,
    placeIndex : 0,
    timeout    : 3600
};
</script>

<ul class="headerNavWeatherDropdown">
<? foreach ($weatherJson['places'] as $v): ?>
    <li>
        <a class="clearfix" href="<?=$weatherDomain.$v['link']?>" target="_blank">
            <span class="icon_weather icon-wi<?=sprintf('%03s', $v['icon'])?>" title="<?=$v['iconText']?>"></span>
            <span class="headerNavWeatherDegree"><?=sprintf('%2s', $v['temp'])?>&deg;</span>
            <span class="headerNavWeatherCity"><?=$v['name']?></span>
        </a>
    </li>
<? endforeach; ?>
</ul>
