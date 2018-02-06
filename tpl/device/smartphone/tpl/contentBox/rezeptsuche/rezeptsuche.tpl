<?
/**
 * Smartphone XLKonsole Box
 *
 * @var channel oe24.core.Channel
 * @var box oe24.core.ContentBox
*/

// (db) 2017-03-22 entfernt bis mobil GET-Parameter wieder aktiviert werden
return;

// ------------------------------------------

$device = DeviceContainer::getDevice();

// ------------------------------------------

$templateOptions = $box->getTemplateOptions();

// ------------------------------------------

?>

<div class="recipeSearch">
	<div class="headlineBox layout_kochen">
		<h2 class="headline defaultChannelBackgroundColor">Rezeptsuche</h2>
	</div>

	<div class="recipeSearch">
	    <div class="defaultbox_body">
	        <div class="search_box">
	            <form class="form_search" action="<?=l('oe24.oe24.recipe.search')?>" method="GET" name="search">
	                <input class="textfield" type="input" name="q" value="" placeholder="Bitte geben Sie hier ihre Suche ein...">
	                <input class="button" type="submit" value="Suche starten">
	            </form>
	        </div>
	    </div>
	</div>
</div>