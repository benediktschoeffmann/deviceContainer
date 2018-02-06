<?
/**
 * article recipe
 * @var article oe24.core.Content
 */

// Beispiele am Dev:

// für besseres verständnis - es werden rezepte abgebildet
$recipe = $article;
if ( ! $recipe) {
    return;
}

$device = DeviceContainer::getDevice();
$contents = $device->getArticleContents($recipe);

$classVideo = (true == $contents['isVideoStory']) ? 'videoStory' : '';

$jwplayerTplName = '_shared.1_0.jwplayer.jwplayerSetupProxy';

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


?>

<div class="articleBox articleRecipe">

    <div class="story">

        <? if ($contents['video']): ?>

            <div class="storyVideo">
                <? tpl($jwplayerTplName, array('video' => $contents['video'], 'events' => array())); ?>
            </div>

        <? else: ?>

            <div class="storyImage <?= $classVideo; ?>">
                <?
                tpl('oe24.oe24.device.smartphone.tpl._content.image.articleImages', array(
                    'relatedImages' => $contents['relatedImages'],
                ));
                ?>
            </div>

        <? endif; ?>

        <div class="storyText">
            <div class="storyTextTop clearfix">
                <strong class="storyPreTitle defaultChannelColor"><?= $contents['preTitle']; ?></strong>
                <span class="storyDateTime"><?= $contents['dateTime']; ?></span>
            </div>
            <h1 class="storyTitle"><?= $contents['title']; ?></h1>
        </div>

        <div class="recipeIngredients">
        <? if (!empty($personenCounter)) { ?>
            <p itemprop="recipeYield">Zutaten für <span class="recipeIngredientsPerson"><?=$personenCounter?></span> <?=$personenText?></p>
        <? } else { ?>
            <p itemprop="recipeYield"><?=$personenText?></p>
        <? } ?>

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
        <div class="defaultbox recipeInfoBox">
            <div class="headlineBox layout_kochen">
                <h2 class="headline defaultChannelBackgroundColor">
                	Rezeptinfo
                </h2>
            </div>
            <div class="defaultbox_body clearfix">
            	<ul class="recipeIngredientsList">
	                <? if ($classDuration) { ?>
		                <li>
		                	<div class="recipeInfo <?=$classDuration?>">Zubereitungszeit: <span class="values" itemprop="totalTime"><?=$durationISO?></span></div>
		                </li>
	                <? } ?>

	                <? if ($classEffort) { ?>
		                <li>
		                	<div class="recipeInfo <?=$classEffort?>">Schwierigkeitsgrad: <span class="values"><?=$effort?></span></div>
		                </li>
	                <? } ?>

	                <? if ($classPrice) { ?>
		                <li>
		                	<div class="recipeInfo <?=$classPrice?>">Preiskategorie: <span class="values"><?=$price?></span></div>
		                </li>
	                <? } ?>

		            <? if ($author) { ?>
			            <li>
			                <span>Rezept von <em class="recipeAuthor"><?=$author?></em></span>
			            </li>
		            <? } ?>
	            </ul>
            </div>
        </div>


        <div class="storyText">
         	<div class="headlineBox layout_kochen">
                <h2 class="headline defaultChannelBackgroundColor">
                	Zubereitung
                </h2>
            </div>
            <p class="storyLeadText"><?= $contents['leadText']; ?></p>
        </div>

        <? if (1): ?>
            <div class="storyAd">
                <? tpl('oe24.oe24.device.smartphone.tpl._adition.adition', array(
                        'channel' => $device->getConfig('channel'),
                        'object'  => $recipe,
                        'banner'  => 'MobileArtikelTop',
                )); ?>
            </div>
        <? endif; ?>

        <div class="storySocialMedia">
            <? tpl('oe24.oe24.device.smartphone.tpl._content.article.tpl.articleSocialMedia'); ?>
        </div>

        <div class="storyBodyText">
            <?= $contents['bodyText']; ?>
        </div>

        <div class="storyAd">
            <? tpl('oe24.oe24.device.smartphone.tpl._adition.adition', array(
                    'channel' => $device->getConfig('channel'),
                    'object'  => $recipe,
                    'banner'  => 'MobileArtikelBottom',
            )); ?>
        </div>

        <?
        // <div class="storyComments">
        //     <? tpl('oe24.oe24.device.smartphone.tpl._content.article.tpl.articleComments');
        // </div>
        ?>

        <div class="storyBottom storyAdditionalBoxes">
            <? tpl('oe24.oe24.device.smartphone.tpl._content.article.tpl.articleAdditionalBoxes'); ?>
        </div>

        <div class="storyBottom storyRelatedArticles">
            <? tpl('oe24.oe24.device.smartphone.tpl._content.article.tpl.articleRelatedArticles'); ?>
        </div>

        <?
        // <div class="storyBottom storyChannelTopStories">
        //     <? tpl('oe24.oe24.device.smartphone.tpl._content.article.tpl.articleChannelTopStories');
        // </div>
        ?>

        <? // bs 2017-07-10 DAILY-811 ?>
        <? // <div class="storyBottom storyAditionBox"> ?>
            <? // tpl('oe24.oe24.device.smartphone.tpl._adition.storyAditionBox'); ?>
        <? // </div> ?>


    </div>  <!-- end of story -->



</div>

