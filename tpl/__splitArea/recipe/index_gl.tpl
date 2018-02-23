<?
/**
 * Recipe Site
 *
 * @var channel oe24.core.Channel
 * @var params array<any>
 * @var object oe24.core.Recipe
 * @var layout string
 */
if (isset($_POST["speichern"])) {
    handleRecipeForm($object);
}
$recipe = $object;
$childChannels = $object->getSecondaryChannels();
$tags = $object->getTags();
$tagIds = array_map_property($tags, 'id');
$similarChannels = array();
foreach ($childChannels as $childChannel) {
    $channelIds[] = $childChannel->getId();
    foreach($childChannel->getTags() as $tag){
        if(!in_array($tag->getId(), $tagIds)){
            continue;
        }
        $similarChannels[] = array($tag->getName(), l('oe24.oe24.channel.tag', array('channel' => $childChannel, 'channelTag' => $tag)));
    }
}
if (spunQ::inMode(spunQ::MODE_DEVELOPMENT)) {
    $inUserObj = spunQ_User::getCurrent();
    $isAdmin = ($inUserObj && $inUserObj->inGroup("oe24.backend.admin"));
} else {
    $isAdmin = false; // not yet
}
$unit = $recipe->getUnitScope();
$recipeId = $recipe->getId();
$parentChannels = $channel->getParentChannels();
$icon_house = '&xe603;';
$breadcrumbs = array();
foreach ($parentChannels as $parentChannel) {
    $caption = trim($parentChannel->getPageTitle());
    $caption = ('' == $caption) ? $icon_house : $caption;
    $url = $parentChannel->getUrl();
    $breadcrumbs[] = array('caption' => $caption, 'url' => $url);
}
$caption = trim($channel->getPageTitle());
$url = $channel->getUrl();
$breadcrumbs[] = array('caption' => $caption, 'url' => $url);
$images = $recipe->getRelatedImages();
$imageFormat = 'bigStory';
$overlayDimension = ''; // width="620" height="250"';
$overlayImage = (isset($images[0])) ? $images[0] : null;
if (null == $overlayImage) {
    $overlayImageSrc = null; // 'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7';
    $overlayImageCopyright = '';
} else {
    $overlayImageArray = array();
    foreach ($images as $key => $image) {
        $copyright = $image->getCopyright();
        $tempArr = array(
            'class' => (0 == $key) ? 'active' : '',
            'imageSrc' => $image->getFileUrl($imageFormat),
            'copyright' => (null != $copyright && '' != $copyright) ? '© ' . $copyright : '&nbsp;',
            'id' => $image->getId(),
        );
        $overlayImageArray[] = $tempArr;
    }
    $overlayImageSrc = $overlayImage->getFileUrl($imageFormat);
    $overlayAlt = $recipe->getTitle();
    $overlayCaption = $recipe->getPreTitle();
    $overlayImageCopyright = '© ' . $overlayImage->getCopyright();
}
if ('' == $overlayImageCopyright || '©' == $overlayImageCopyright || '© ' == $overlayImageCopyright) {
    $overlayImageCopyright = '&nbsp;';
}
$overlayAlt = $recipe->getTitle();
$overlayCaption = $recipe->getPreTitle();
$recipeDateTime = formatDateUsingIntlLangKey('date.long', $recipe->getFrontendDate()) . ' ' . formatDateUsingIntlLangKey('time.short', $recipe->getFrontendDate());
$recipeCommentsCount = 0;
$recipeHeadline = $recipe->getTitle();
$recipeTeaser = $recipe->getLeadText(true);
$recipeBodyText = $recipe->getBodyText(true, true);
$showComments = $recipe->getOptions(true, true)->getByKey("allowPosting");
if ($showComments === null) {
    $showComments = true;
}
if ($recipe instanceof Text && ($recipe->getVideoId() !== NULL || $recipe->getVideoOptions() !== NULL || $recipe->getLiveVideoOptions() !== NULL)) {
    $showComments = false; // zum ausblenden der Kommentare bei Videoartikeln.
}
// Hide Social Buttons
$hideSocialButtons = $recipe->getOptions(true, true)->getByKey("hideSocialButtons");
if ($hideSocialButtons === null) {
    $hideSocialButtons = true;
}
// Box Rezept-Infos -----------------
$zubereitungszeit = $recipe->getDuration();
$zubereitungszeit = r_interpretDuration($zubereitungszeit);
$schwierigkeitsgrad = $recipe->getEffort(false);
$preiskategorie = $recipe->getPrice(false);
// ----------------------------------
// Zutaten fuer n Personen ----------
$personen = $recipe->getPeople();
if (empty($personen)) {
    $personen = 4;
}
// Zutaten
$zutaten = $recipe->getRecipeIngredient();
$pattern = "#<table[^>]*>(.*)</table>#iUs";
$recipeBodyText = preg_replace($pattern, '', $recipeBodyText);
?>
<div class="row">
<div class="content recipe">
<? if($isAdmin){?>
<script language="javascript">
    window.onload = function (){
    setKat(Array("nocatx",<?= join(",",$channelIds); ?>));
    setKat(Array("nocatx",<?= join(",",$tagIds); ?>));
    };
</script>
<? } ?>
<article class="article_box clearfix">
<div class="article_box_wrapper">
<form enctype="multipart/form-data" name="articleform" method="post">
<? if ($overlayImageSrc): ?>
    <div class="overlay_box">
        <? foreach ($overlayImageArray as $key => $overlayImage): ?>
            <img src="<?= s($overlayImage['imageSrc']) ?>" alt="<?= $overlayAlt ?>"
                 style="display: <?= ($key == 0) ? 'block' : 'none'; ?>">
        <? endforeach; ?>
        <? if (count($overlayImageArray) > 1): ?>
            <div class="arrowContainer arrowContainerLeft">
                <a class="arrow arrowLeft unselectable icon icon_arrow3_left"></a>
            </div>
            <div class="arrowContainer arrowContainerRight">
                <a class="arrow arrowRight unselectable icon icon_arrow3_right"></a>
            </div>
        <? endif; ?>
        <? if (null !== $overlayCaption && '' !== $overlayCaption): ?>
            <h2 class="caption"><?= $overlayCaption ?></h2>
        <? endif ?>
        <? //if (null !== $overlayImageCopyright && '' !== $overlayImageCopyright): ?>
        <!-- <span class="copyright"><? //=$overlayImageCopyright?></span> -->
        <? //endif ?>
    </div>
    <? foreach ($overlayImageArray as $key => $overlayImage): ?>
        <p class="article_box_top_copyright <?= $overlayImage['class'] ?>"><?= $overlayImage['copyright'] ?></p>
    <? endforeach;
    ?>
    <? if ($isAdmin) {
        echo "<h2>Bilder:</h2>";
        foreach ($overlayImageArray as $key => $overlayImage) {
            ?>
            <div class="del img" data-id="<?= $key ?>"></div>
            <img id="r_img<?= $key ?>" src="<?= s($overlayImage['imageSrc']) ?>" height="40">
            <input type="hidden" class="hidden_img<?= $key ?>" name="noDelImg[]" data-id="<?= $key ?>"
                   value="<?= $overlayImage['id'] ?>"/>
            <div class="clear"></div>
        <? } ?>
    <? } ?>
<? else: ?>
    <? if (null !== $overlayCaption && '' !== $overlayCaption): ?>
        <h2 class="caption"><?= $overlayCaption ?></h2>
    <? endif ?>
<? endif ?>
<? if ($isAdmin) { ?>
    <input type="file" class="imageinput" name="bild[]" data-id="<?= $key + 1 ?>"/>
    <div class="add image"></div>
<? } ?>
<h1> <? if ($isAdmin) { ?>            <h2>Titel:</h2>
        <input type="text" class="wide headline" name="headline"
               value="<?= $recipeHeadline ?>"/> <?
    } else {
        echo $recipeHeadline;
    } ?></h1>
<div class="article_body_left">
    <? etpl('oe24.oe24.adition.adSlot', array('channel' => $channel, 'id' => 'ArticleLeft1')); ?>
    <div class="clear"></div>
    <strong class="article_teaser"><? # echo $recipeTeaser; ?></strong>
    <div class="berechnen">
        <span>Zutaten für </span><input type="text" class="anzPersonen narrow tf"
                                        name="anzPersonen<?= ($isAdmin) ? "_change" : ""; ?>"
                                        data-value="<?= $personen ?>"
                                        value="<?= $personen ?>"/><span><?= ($personen != 1) ? "Personen" : "Person"; ?></span>
        <? if (!$isAdmin) { ?><input type="button" name="button" class="button" value="berechnen"/><? } ?>
    </div>
    <div class="seperator"></div>
    <table class="zutaten">
        <tr>
            <th class="menge">Menge</th>
            <th class="mass">Ma&szlig;</th>
            <th class="zutat">Zutat</th>
        </tr>
        <?
        if ($isAdmin) {             $zutaten[] = array("ingredient" => "", "unit"=>"","amount" => "");        }
        foreach ($zutaten as $i => $zutat) { ?>
            <tr <? if ($isAdmin) {
                echo 'data-id="' . $i . '"';
            } ?>>
                <td class="menge" data-value="<?= $zutat["amount"] ?>"><?
                    if ($isAdmin) {
                        ?>
                        <div class="del"></div>
                        <input type="text" class="narrow" value="<?= $zutat["amount"] ?>" data-id="<?= $i ?>"
                               name="menge[]"/>
                    <?
                    } else {
                        echo (!empty($zutat["amount"])) ? $zutat["amount"] : "";
                    } ?>
                </td>
                <td class="mass">
                    <? if ($isAdmin) {
                        ?><select class="einheitdd" name="einheit[]">
                        <? foreach ($unit as $key => $einheit) { ?>
                            <option<?= ($zutat["unit"] == $einheit && !empty($zutat["unit"])) ? " selected" : "" ?>
                                value="<?= $einheit ?>"><?= $einheit ?></option>
                        <? } ?>
                        </select>
                    <?
                    } else {
                        echo (!empty($zutat["unit"])) ? $zutat["unit"] : "";
                    }
                    ?></td>
                <td class="zutat">
                    <? if ($isAdmin) {
                        ?><input type="text" class="semiwide" value="<?= $zutat["ingredient"] ?>"
                                 data-id="<?= $i ?>" name="zutat[]" />
                    <?
                    } else {
                        echo (!empty($zutat["ingredient"])) ? $zutat["ingredient"] : "";
                    } ?></td>
            </tr>
        <? } ?>
    </table>
    <? if ($isAdmin) { ?>
        <div class="add ingredient"></div>
    <? } ?>
</div>
<div class="article_body_right">
    <div class="topbox">
        <span class="icon"></span><span class="headline">Rezeptinfos</span>
        <div class="seperator"></div>
        <? if (!empty($zubereitungszeit) || $isAdmin) { ?>
            <span class="desc">Zubereitungszeit:</span>
                <? if ($isAdmin) { ?>
                    <input type="text" name="zubereitungszeit" class="narrow zubereitungszeit" value="<?=$recipe->getDuration();?>"> <span class="zubereitungszeit_b nobg"> min.</span>
            <? } else { ?>
                <span class="zubereitungszeit inaktiv"><span class="zubereitungszeit w<?= $zubereitungszeit ?>"></span></span>
                <? } ?>
        <? } ?>
        <? if (!empty($schwierigkeitsgrad) || $isAdmin) { ?>
            <span class="desc">Schwierigkeitsgrad:</span> <span class="schwierigkeitsgrad inaktiv">
                <? if ($isAdmin) { ?>
                    <select name="schwierigkeitsgrad">
                        <option></option>
                        <?
                        foreach ($recipe->getEffortScope() as $x => $text) {
                            ?>
                            <option<?= ($schwierigkeitsgrad == $x) ? " selected" : "" ?>
                                value="<?= $x ?>"><?= $text ?></option>
                        <? } ?>
                    </select>
                <? } else { ?>
                    <span class="schwierigkeitsgrad w<?= $schwierigkeitsgrad ?>"></span>
                <? } ?>
                </span>
        <? } ?>
        <? if (!empty($preiskategorie) || $isAdmin) { ?>
            <span class="desc">Preiskategorie:</span> <span class="preiskategorie inaktiv">
                <? if ($isAdmin) { ?>
                    <select name="preiskategorie">
                        <option></option>
                        <?
                        foreach ($recipe->getPriceScope() as $x => $text) {
                            ?>
                            <option<?= ($preiskategorie == $x) ? " selected" : "" ?>
                                value="<?= $x ?>"><?= $text ?></option>
                        <? } ?>
                    </select>
                <? } else { ?>
                    <span class="preiskategorie w<?= $preiskategorie ?>"></span>
                <? } ?>
                </span>
        <? } ?>
        <div class="empfehlungsbox">
            <div class="drucken"><span class="icon"></span><span class="label">Drucken</span></div>
            <div class="empfehlen"><span class="icon"></span><span class="label">Empfehlen</span></div>
        </div>
        <div class="clear"></div>
    </div>
    <div class="box">
        <div class="headline">&Auml;hnliche Kategorien</div>
        <div class="seperator"></div>
        <ul>
            <? foreach($similarChannels as $sc){
                ?><li><a href="<?=$sc[1]?>"><?=$sc[0]?></a></li><?
            }?>
        </ul>
    </div>
</div>
<div class="clear"></div>
<div class="seperator zb"></div>
<? if($isAdmin) {?><div class="kategorien"><?printCategories($channel);?></div><?} ?>
<div class="clear"></div>
<div class="article_body">
    <h3>Zubereitung</h3>
    <? if ($isAdmin) { ?>
        <textarea name="zubereitung" class="zubereitung"><?= $recipeBodyText ?></textarea>
    <? } else { ?>
        <?= $recipeBodyText ?>
    <? } ?>
</div>
<? if ($isAdmin) { ?>
    <input type="hidden" name="speichern" value="1"/>
    <div class="speichern button">speichern</div>
<? } ?>
</form>
</div>
</article>
<?
etpl('oe24.oe24.adition.adSlot', array('channel' => $channel, 'id' => 'ArticleLeft2'));
etpl('oe24.oe24.adition.adSlot', array('channel' => $channel, 'id' => 'ArticleLeft3'));
?>
<? if (isset($showComments) && $showComments): ?>
    <section id="comments" class="comments clearfix">
        <? tpl('oe24.oe24.__splitArea.article.comments', array('article' => $recipe, 'recipeCommentsCount' => $recipeCommentsCount)); ?>
    </section>
<? endif ?>
<?
etpl('oe24.oe24.adition.adSlot', array('channel' => $channel, 'id' => 'ArticleLeft4'));
etpl('oe24.oe24.adition.adSlot', array('channel' => $channel, 'id' => 'ArticleLeft5'));
etpl("oe24.oe24.story.plistaAd", array("text" => $recipe));
?>
</div>
<div class="sidebar">
    <? // demo begin   ?>
    <div class="col col_wide_right defaultbox coverbox coverbox_wirkochen">
        <div class="defaultbox_header">
            <span class="defaultbox_header_icon icon icon_layout"></span>
            <span class="defaultbox_header_caption">Suche</span>
        </div>
        <div class="listbox_body coverbox_teasertext">
            <div class="search_box">
                <form class="form_search" action="<?=l('oe24.oe24.recipe.search')?>" method="GET" name="search">
                       <input class="textfield" type="input" name="q" value="" placeholder="Bitte geben Sie hier ihre Suche ein...">
                       <input class="button" type="submit" value="Suche starten">
                </form>
            </div>
        </div>
    </div>
    <? // demo end ?>
    <?
    etpl('oe24.oe24.__splitArea.article.relatedStories', array(
            'contents' => $recipe->getRelatedStories(),
            'boxHeadline' => 'Zum Thema',
            'showNumbers' => false,
            'showImages' => true,
        )
    );
    etpl('oe24.oe24.__splitArea.article.relatedStories', array(
            'contents' => $recipe->getRelatedSlideshows(),
            'boxHeadline' => 'Mehr Bilder',
            'showNumbers' => false,
            'showImages' => true,
        )
    );
    etpl('oe24.oe24.__splitArea.article.relatedStories', array(
            'contents' => $recipe->getRelatedRecipes(),
            'boxHeadline' => 'Ähnliche Rezepte',
            'showNumbers' => false,
            'showImages' => true,
        )
    );
    etpl('oe24.oe24.__splitArea.article.relatedStories', array(
            'contents' => $recipe->getUserRecipes(5),
            'boxHeadline' => 'Weitere Autor-Rezepte',
            'showNumbers' => false,
            'showImages' => true,
        )
    );
    $relatedContentsByTags = $channel->getRelatedContentsByTags(5, 0, array("oe24.core.Recipe"),true);
    if(!empty($relatedContentsByTags)){
        etpl('oe24.oe24.__splitArea.article.relatedStories', array(
                'contents' => $relatedContentsByTags,
                'boxHeadline' => 'Ähnliche Rezepte',
                'showNumbers' => false,
                'showImages' => true,
            )
        );
    }
    etpl('oe24.oe24.__splitArea._page.standardColumnsSplitArea', array('columnName' => 'Split-Story-Teaser Area', 'channel' => $channel, 'object' => $recipe, 'hide' => array()));
    ?>
</div>
</div>
<? tpl('oe24.oe24.__splitArea.tpl.row.row_margin', array('position' => 'bottom')); ?>