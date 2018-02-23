<?
/**
 * Recipe Site
 *
 * @var channel oe24.core.Channel
 * @var params array<any>
 * @var object oe24.core.Recipe
 * @var layout string
 */

$parentChannels = $channel->getParentChannels();

// Rezeptbeispiele
//
// http://oe24dev.oe24.at/cooking24/rezepte/rezepte/Gehobelter-Spargel-mit-Orangen-und-Langostinos/161273306
// http://oe24dev.oe24.at/cooking24/rezepte/rezepte/Forelle-mit-Sommergemuese-in-Folie-gegart/161272940
// http://oe24dev.oe24.at:6081/cooking24/rezepte/zubereitung/Gehobelter-Spargel-mit-Orangen-und-Langostinos-WS/161286704

// -------------------------------------------

$recipe = $object;
$recipeId = $object->getId();

// -------------------------------------------

$recipeHeadline = $recipe->getTitle();

$imageFormat = 'bigStory';
$overlayDimension = ''; // width="620" height="250"';

$images = $recipe->getRelatedImages();
$overlayImage = (isset($images[0])) ? $images[0] : null;

$overlayImageSrc = null; // 'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7';
$overlayImageCopyright = '';

$overlayAlt = $recipeHeadline;
$overlayCaption = $recipe->getPreTitle();

if ($overlayImage) {
    $overlayImageArray = array();
    foreach ($images as $key => $image) {
        $copyright = $image->getCopyright();
        $tempArr = array(
            'class' => (0 == $key) ? 'active' : '',
            'imageSrc' => $image->getFileUrl($imageFormat),
            // 'copyright' => ($copyright) ? '© '.$copyright : '© unbekannt',
            'copyright' => ($copyright) ? '© '.$copyright : '&nbsp;',
        );
        $overlayImageArray[] = $tempArr;
    }
}

// -------------------------------------------

$duration = $recipe->getDuration();
$durationISO = 'P' . floor($duration / 60) . 'H'.($duration-(floor($duration / 60)*60)).'M';
$duration = ( ($duration <= 30) ? 1 : (($duration <= 90) ? 2 : 3) );
$effort = $recipe->getEffort(false);
$price = $recipe->getPrice(false);

$classDuration = ($duration && in_array($duration, array(1,2,3))) ? 'duration'.$duration : '';
$classEffort = ($effort && in_array($effort, array(1,2,3))) ? 'effort'.$effort : '';
$classPrice = ($price && in_array($price, array(1,2,3))) ? 'price'.$price : '';

$author = $recipe->getFrontendAuthor();
$source = $recipe->getFrontendSource();
if ($source instanceof Source) {
    if (preg_match('/@oe24.at/i', $source->getName())) {
        $author = 'wirkochen.at';
    }
}

// -------------------------------------------

$childChannels = $object->getSecondaryChannels();
$tags = $object->getTags();
$tagIds = array_map_property($tags, 'id');
$similarChannels = array();
$relatedContentsByTags = $recipe->getRelatedRecipes();
$relatedContentLimitTag = 5;
if (count($tagIds) == 0) {
    $relatedContentLimitTagChannel = 0;
} else {
    $relatedContentLimitTagChannel = ceil($relatedContentLimitTag / count($tagIds));
}
//$relatedContentsByTags
foreach ($childChannels as $childChannel) {
    $channelIds[] = $childChannel->getId();
    foreach($childChannel->getTags() as $tag) {
        if (!in_array($tag->getId(), $tagIds)) {
            continue;
        }
        $similarChannels[] = array($tag->getName(), l('oe24.oe24.channel.tag', array('channel' => $childChannel, 'channelTag' => $tag)));
        if(count($relatedContentsByTags) < $relatedContentLimitTag){
            $relatedContentsByTagsTmp = $childChannel->getRelatedContentsByTagId($tag->getId(), $relatedContentLimitTagChannel,0,array("oe24.core.Recipe"), true);
            foreach($relatedContentsByTagsTmp as $relatedContentsByTagTmp) {
                if(count($relatedContentsByTags) < $relatedContentLimitTag){
                    if (!in_array($relatedContentsByTagTmp->getId(), array_map_property($relatedContentsByTags, 'id')) && $relatedContentsByTagTmp->getId() != $recipe->getId()) {
                        $relatedContentsByTags[] = $relatedContentsByTagTmp;
                    }
                } else {
                    break;
                }
            }
        }
    }
}

// -------------------------------------------

// Service
// $articleComments = $article->getComments();
// $articleCommentsCount = count($articleComments);
$articleCommentsCount = 0;

// -------------------------------------------

// Hide Social Buttons
$hideSocialButtons = $object->getOptions(true, true)->getByKey("hideSocialButtons");
if ($hideSocialButtons === null) {
    $hideSocialButtons = true;
}

// Print Button anzeigen
$showPrintButton = $object->getOptions(true, true)->getByKey("print");
if ($showPrintButton === null) {
    $showPrintButton = true;
}

// Mail Button anzeigen
$showMailButton = $object->getOptions(true, true)->getByKey("mailto");
if ($showMailButton === null) {
    $showMailButton = true;
}

// -------------------------------------------

$personenText = '';
$personenCounter = '';
$personen = $recipe->getPeople();
if (!$personen) {
    $recipeTeaser = $recipe->getLeadText(true);
    if ('###' == substr($recipeTeaser, 0, 3)) {
        // Vereinbart ist, dass der Teaser-Text in spunQ mit '###' beginnt,
        // und bei 'Personen' 0 angegeben ist, wenn die Angabe sich NICHT auf
        // eine Anzahl von Personen bezieht, sondern die Angabe beispielsweise
        // 'Portionen: ca. 150 Stück' lautet.
        $personenText = str_replace('###', '', $recipeTeaser);
    }
} else {
    $personenCounterArr = array('eine','zwei','drei','vier','fünf','sechs','sieben','acht','neun','zehn','elf','zwölf');
    $personenCounter = array_key_exists($personen - 1, $personenCounterArr) ? $personenCounterArr[$personen - 1] : $personen;
    $personenText = ($personen > 1) ? 'Personen' : 'Person';
}

// -------------------------------------------

$recipeIngredients = $recipe->getRecipeIngredients();
if (!$recipeIngredients) {
    $recipeIngredients = array();
}

// -------------------------------------------

$recipeBodyText = $recipe->getBodyText(true, true);

// -------------------------------------------

$recipeDateTime = formatDateUsingIntlLangKey('date.long', $recipe->getFrontendDate()) . ' ' . formatDateUsingIntlLangKey('time.short', $recipe->getFrontendDate());

$showComments = $recipe->getOptions(true, true)->getByKey("allowPosting");
if ($showComments === null) {
    $showComments = true;
}

if ($recipe instanceof Text && ($recipe->getVideoId() !== NULL || $recipe->getVideoOptions() !== NULL || $recipe->getLiveVideoOptions() !== NULL)) {
    // zum Ausblenden der Kommentare bei Videoartikeln.
    $showComments = false;
}

$hideSocialButtons = $recipe->getOptions(true, true)->getByKey("hideSocialButtons");
if ($hideSocialButtons === null) {
    $hideSocialButtons = true;
}

// -------------------------------------------

// Breadcrumbs

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

// -------------------------------------------

// Anzahl der Kommentare wird per JS ermittelt
$commentsCount = 0;

// -------------------------------------------

// <div class "wsRecipe"> spaeter durch <div class="recipe"> ersetzen ???

?>
<div class="row wsRecipe recipe2016">

    <div class="content" itemscope itemtype="http://schema.org/Recipe">


        <div class="article_box">

            <? if (isset($overlayImageArray[0])) { ?>

                <div class="overlay_box">

                    <? foreach ($overlayImageArray as $key => $overlayImage) { ?>
                    <img src="<?=s($overlayImage['imageSrc'])?>" alt="" itemprop="image">
                    <? } ?>

                    <? if (count($overlayImageArray) > 1) { ?>
                    <div class="arrowContainer arrowContainerLeft">
                        <a class="arrow arrowLeft unselectable icon icon_arrow3_left"></a>
                    </div>
                    <div class="arrowContainer arrowContainerRight">
                        <a class="arrow arrowRight unselectable icon icon_arrow3_right"></a>
                    </div>
                    <? } ?>

                    <? if ($overlayCaption) { ?>
                    <h2 class="caption" itemprop="name"><?=$overlayCaption?></h2>
                    <? } ?>

                </div>

                <? foreach($overlayImageArray as $key => $overlayImage) { ?>
                <p class="article_box_top_copyright <?=$overlayImage['class']?>"><?=$overlayImage['copyright']?></p>
                <? } ?>

            <? } else { ?>

                <? if ($overlayCaption) { ?>
                <h2 class="caption" itemprop="name"><?=$overlayCaption?></h2>
                <? } ?>

            <? } ?>


            <h1 itemprop="name"><?=$recipeHeadline?></h1>

            <div class="service">
                <? if (isset($showComments) && true == $showComments): ?>
                <a class="comment" href="#comments">
                    <span class="icon icon_comment"></span>
                    <span id="commentText">Posten Sie (<?=$articleCommentsCount?>)</span>
                </a>
                <? endif; ?>
                <? if (isset($showPrintButton) && $showPrintButton): ?>
                <a class="printer" href="<?=$recipeId?>/print">
                    <span class="icon icon_printer"></span>
                </a>
                <? endif; ?>
                <? if (0 && isset($showMailButton) && $showMailButton): ?>
                <a class="mail" href="<?=$recipeId?>/mailto">
                    <span class="icon icon_mail"></span>
                </a>
                <? endif; ?>

                <ul class="breadcrumbs">
                    <?php foreach ($breadcrumbs as $key => $item): ?>
                        <li>
                            <?php if ($icon_house == $item['caption']): ?>
                            <a href="<?=$item['url']?>"><span class="icon icon_house"></span></a>
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

            <? etpl('oe24.oe24.adition.adSlot', array('channel' => $channel, 'id' => 'ArticleLeft1')); ?>


            <div class="clearfix">

                <div class="recipeBodyLeft">
                    <div id="addthisSharingToolbox" class="addthis_sharing_toolbox"></div>
                    <div class="recipeIngredients">
                    <? if (!empty($personenCounter)) { ?>
                        <p itemprop="recipeYield">Zutaten für <span class="recipeIngredientsPerson"><?=$personenCounter?></span> <?=$personenText?></p>
                    <? } else { ?>
                        <p itemprop="recipeYield"><?=$personenText?></p>
                    <? } ?>
                    </div>
                    <? foreach ($recipeIngredients as $recipeIngredientList) { ?>
                        <? if (!empty($recipeIngredientList['title'])): ?>
                            <div class="recipeListTitle"><?= $recipeIngredientList['title']; ?></div>
                        <? endif; ?>
                        <ul class="recipeIngredientsList">
                        <? foreach ($recipeIngredientList as $key => $recipeIngredient) { ?>
                            <? if ('title' === $key) { continue; } ?>
                            <li itemprop="ingredients">
                                <? if ($recipeIngredient['amount']) { ?>
                                <span class="recipeIngredientsAmount"><?=$recipeIngredient['amount']?></span>
                                <? } ?>
                                <? if ($recipeIngredient['unit']) { ?>
                                <span class="recipeIngredientsUnit"><?=$recipeIngredient['unit']?></span>
                                <? } ?>
                                <? if ($recipeIngredient['ingredient']) { ?>
                                <span class="recipeIngredientsIngedient"><?=$recipeIngredient['ingredient']?></span>
                                <? } ?>
                            </li>
                        <? } ?>
                        </ul>
                    <? } ?>
                </div>

                <div class="recipeBodyRight">
                    <div class="defaultbox recipeInfoBox">
                        <div class="defaultbox_header">
                            <span class="defaultbox_header_icon icon icon_layout"></span>
                            <span class="defaultbox_header_caption">Rezeptinfo</span>
                        </div>
                        <div class="defaultbox_body clearfix">
                            <? if ($classDuration) { ?>
                            <p class="recipeInfo <?=$classDuration?>">Zubereitungszeit: <span class="values" itemprop="totalTime"><?=$durationISO?></span></p>
                            <? } ?>
                            <? if ($classEffort) { ?>
                            <p class="recipeInfo <?=$classEffort?>">Schwierigkeitsgrad: <span class="values"><?=$effort?></p>
                            <? } ?>
                            <? if ($classPrice) { ?>
                            <p class="recipeInfo <?=$classPrice?>">Preiskategorie: <span class="values"><?=$price?></p>
                            <? } ?>
                        </div>
                        <? if ($author) { ?>
                        <div class="defaultbox_footer clearfix">
                            <span>Rezept von <em class="recipeAuthor"><?=$author?></em></span>
                        </div>
                        <? } ?>
                    </div>
                    <? if(count($similarChannels)>0) { ?>
                    <div class="defaultbox similarCategories">
                        <div class="defaultbox_header">
                            <span class="defaultbox_header_icon icon icon_layout"></span>
                            <span class="defaultbox_header_caption">Ähnliche Kategorien</span>
                        </div>
                        <div class="defaultbox_body clearfix">
                            <ul>
                                <? foreach($similarChannels as $sc) { ?>
                                <li itemprop="recipeCategory"><a href="<?=$sc[1]?>"><?=$sc[0]?></a></li>
                                <? } ?>
                            </ul>
                        </div>
                    </div>
                    <? } ?>
                </div>

            </div>


            <div class="recipeBodyWrapper">
                <strong class="recipeBodyTeaser">Zubereitung</strong>
                <div class="recipeBody" itemprop="recipeInstructions">
                    <?=$recipeBodyText?>
                </div>
            </div>


        </div>

        <? if(!$hideSocialButtons): ?>
            <div class="article_share">
                <? tpl('oe24.oe24.__splitArea.article.socialInline', array('content' => $object, 'layout' => $layout)); ?>
            </div>
        <? endif; ?>

        <? /*comment-anker für Facebook "Posten Sie"-Button */ ?>
        <? if (isset($showComments) && $showComments): ?>
            <a name='comments'></a>
        <? endif ?>
        
        <?
        // if (in_array($layout, $oe2016layouts)) {
            // (pj) 2015-12-14 niki wuenscht sich an dieser position links das "News TV"-Video und rechts ein Contentad
            //tpl('oe24.oe24.__splitArea.article.videoAndContentAd', array('channel' => $channel));
            // (pj) 2015-12-14 end
            $relatedArticles = $object->getRelatedStories();
            $relatedSlideshows = $object->getRelatedSlideshows();
            if ($relatedSlideshows && count($relatedSlideshows > 0)) {
                $relatedArticles = array_merge($relatedArticles, $relatedSlideshows);
            }
            
            if ($relatedArticles && count($relatedArticles) > 0) {
                tpl('oe24.oe24.__splitArea.article.oe2016relatedStories', array(
                    'relatedArticles' => $relatedArticles,
                    'layout'          => $layout,
                ));
            }
        // }
        ?>

        <?
        if (!empty($relatedContentsByTags)) {
            // etpl('oe24.oe24.__splitArea.article.relatedStories', array(
            //     'contents' => $relatedContentsByTags,
            //     'boxHeadline' => 'Ähnliche Rezepte',
            //     'showNumbers' => false,
            //     'showImages' => true,
            // ));
             tpl('oe24.oe24.__splitArea.article.oe2016relatedStories', array(
                    'relatedArticles' => $relatedContentsByTags,
                    'boxHeadline'     => 'Ähnliche Rezepte',  
                    'layout'          => $layout,
                ));
        }
        ?>

        <?
        etpl('oe24.oe24.adition.adSlot', array('channel' => $channel, 'id' => 'ArticleLeft2'));
        etpl('oe24.oe24.adition.adSlot', array('channel' => $channel, 'id' => 'ArticleLeft3'));
        ?>

        <? if (isset($showComments) && $showComments): ?>
            <? if ('Facebook' === $object->getOptions(true, true)->get('postingType')): ?>
                <section id="fbComment" class="fbComments comments clearfix">
                    <h2 id="commentCounter" itemprop="interactionCount">Posten Sie Ihre Meinung</h2>

                    <div class="hide_postings">
                        <span>Kommentare ausblenden</span>
                        <div class="hidePostingDiv icon icon_arrow3_up"></div>
                    </div>
                    <div class="container_postings fb-comments" data-href="<?= $object->getUrl(); ?>" data-numposts="10" data-colorscheme="light"></div>
                </section>

            <? else: ?>
                <section id="comments" class="comments <?= $commentsNoBorders; ?> clearfix">
                    <? tpl('oe24.oe24.__splitArea.article.comments', array('object' => $object, 'articleCommentsCount' => $articleCommentsCount)); ?>
                </section>
            <? endif; ?>
        <? endif ?>

        <?
        etpl('oe24.oe24.adition.adSlot', array('channel' => $channel, 'id' => 'ArticleLeft4'));
        etpl('oe24.oe24.adition.adSlot', array('channel' => $channel, 'id' => 'ArticleLeft5'));
        etpl('oe24.oe24.story.plistaAd', array('text' => $recipe));
        ?>

    </div>

    <div class="sidebar">
   
    <? tpl('oe24.oe24.__splitArea.article.articleDetailSidebar',array('channel' => $channel)); ?>
   
    <? tpl('oe24.oe24.adition.adSlot',array('channel' => $channel, 'id' => 'Contentad2')); ?>

    <?

    // (ws) 2014-11-27 - laut Florian brauchen wir diese Box nicht
    // etpl('oe24.oe24._contentBoxes.rl2014sidebarRezeptsuche', array(
    //     // ...
    // ));

    // (db) 2017-03-17 related stories jetzt unter recipes
    // etpl('oe24.oe24.__splitArea.article.relatedStories', array(
    //     'contents' => $recipe->getRelatedStories(),
    //     'boxHeadline' => 'Zum Thema',
    //     'showNumbers' => false,
    //     'showImages' => true,
    // ));
    // etpl('oe24.oe24.__splitArea.article.relatedStories', array(
    //     'contents' => $recipe->getRelatedSlideshows(),
    //     'boxHeadline' => 'Mehr Bilder',
    //     'showNumbers' => false,
    //     'showImages' => true,
    // ));
    // (db) 2017-03-17 end
    /*

    etpl('oe24.oe24.__splitArea.article.relatedStories', array(
        'contents' => $recipe->getRelatedRecipes(),
        'boxHeadline' => 'Ähnliche Rezepte',
        'showNumbers' => false,
        'showImages' => true,
    ));
    */
    // (ws) 2014-11-27 - laut Florian brauchen wir diese Box ebenfalls nicht
    // etpl('oe24.oe24.__splitArea.article.relatedStories', array(
    //     'contents' => $recipe->getUserRecipes(5),
    //     'boxHeadline' => 'Weitere Autor-Rezepte',
    //     'showNumbers' => false,
    //     'showImages' => true,
    // ));
    //$relatedContentsByTags = $channel->getRelatedContentsByTags(5, 0, array("oe24.core.Recipe"),true);
    
    // (db) 2017-03-17
    // if (!empty($relatedContentsByTags)) {
    //     etpl('oe24.oe24.__splitArea.article.relatedStories', array(
    //         'contents' => $relatedContentsByTags,
    //         'boxHeadline' => 'Ähnliche Rezepte',
    //         'showNumbers' => false,
    //         'showImages' => true,
    //     ));
    // }
    // etpl('oe24.oe24.__splitArea._page.standardColumnsSplitArea', array(
    //     'columnName' => 'Split-Story-Teaser Area',
    //     'channel' => $channel,
    //     'object' => $recipe,
    //     'hide' => array()
    // ));
    // (db) 2017-03-17 end
    ?>
    </div>

</div>

<? tpl('oe24.oe24.__splitArea.tpl.row.row_margin', array('position' => 'bottom')); ?>
