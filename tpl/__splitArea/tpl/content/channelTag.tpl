<?php
/**
 * @var portal oe24.core.Portal
 * @var channel oe24.core.Channel
 * @var channelTag strg.tagging.Tag
 * @var contents array<oe24.core.TextualContent>
 * @var searchLimit integer
 * @var searchPage string
 * @var oe2016layouts any
 * @var layout any
 *
 * @default oe2016layouts 0
 * @default layout 0
 */

$icon_house = '&xe603;';
$parentChannels = $channel->getParentChannels(true);
$breadcrumbs = array();
foreach ($parentChannels as $parentChannel) {

	$caption = trim($parentChannel->getPageTitle());
	$caption = ('' == $caption) ? $icon_house : $caption;
	$url = $parentChannel->getUrl();

	$breadcrumbs[] = array('caption' => $caption, 'url' => $url);
}

$breadcrumbs[] = array('caption' => $channelTag->getName(), 'url' => l('oe24.oe24.channel.tag', array('channel' => $channel, 'channelTag' => $channelTag)));

// (pj) 2014-11-15 fuer die suche
// if (spunQ::inMode(spunQ::MODE_DEVELOPMENT)) {
//     tpl("oe24.oe24.__splitArea.search.pager", array("pages" => (count($contents) >= $limit) ? $page+1 : $page, "page" => $page));
//     if(count($contents) >= $limit){
//         array_pop($contents);
//     }
// }
// (pj) ENDE

$useNewLayout = '';
$additionalRowClasses = '';

if (in_array($layout, $oe2016layouts)) {
    $additionalRowClasses = 'wsRecipe recipe2016';
    $useNewLayout = 'oe2016';
}

?>

<div class="row <?= $additionalRowClasses; ?>">

    <div class="content <?= $useNewLayout; ?>">

        <? tpl("oe24.oe24.__splitArea.recipe.pager", array("pages" => (count($contents) >= $searchLimit) ? $searchPage+1 : $searchPage, "page" => $searchPage)); ?>
        
        <div class="service recipe">
            <ul class="breadcrumbs">
            <?php foreach ($breadcrumbs as $key => $item): ?>
                <li>
                    <?php if ($icon_house == $item['caption']): ?>
                    <a href="<?=$item['url']?>">
                        <span class="icon icon_house"></span>
                    </a>
                    <?php else: ?>
                    <span>&rsaquo;</span>
                    <a href="<?=$item['url']?>">
                        <?=$item['caption']?>
                    </a>
                    <?php endif ?>
                </li>
            <?php endforeach ?>
            </ul>
        </div>

        <div class="recipelist">
            <div class="headboxes clearfix">
                <div class="title">Rezept</div>
                <div class="duration">Dauer</div>
                <div class="effort">Aufwand</div>
            </div>

            <?
            $cnt=0;
            foreach($contents as $content) {
                $cnt++;
                if($cnt > $searchLimit){
                    break;
                }
                if($content instanceof Recipe) {
                ?>
                    <div class="recipelist_row clearfix">
                        <a href="<?=$content->getUrl()?>">
                            <span class="title"><?= $content->getTitle()?></span>
                            <span class="duration"><?= $content->getDuration()?></span>
                            <span class="effort"><?= $content->getEffort()?></span>
                        </a>
                    </div>
            <? }
            }
            ?>
        </div>

        <? tpl("oe24.oe24.__splitArea.recipe.pager", array("pages" => (count($contents) >= $searchLimit) ? $searchPage+1 : $searchPage, "page" => $searchPage)); ?>
        
    </div>

    <div class="sidebar <?= $useNewLayout; ?>">
        <? 
        if ('oe2016' == $useNewLayout){
            tpl('oe24.oe24.__splitArea.article.articleDetailSidebar',array('channel' => $channel)); 
        }
        else {
            etpl('oe24.oe24.__splitArea._page.standardColumnsSplitArea', array(
                'columnName' => 'Split-Story-Teaser Area',
                'channel' => $channel,
                'object' => null,
                'hide' => array(),
            ));
        }
        ?>         

        <?
        // <div style="width:300px;height:250px;background-color:#f00;margin-top:20px"></div>
        ?>
    </div>

</div>
