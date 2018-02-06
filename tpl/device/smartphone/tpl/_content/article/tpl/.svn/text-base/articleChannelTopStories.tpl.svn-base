<?
/**
 * Channel Top Stories
 */

$device = DeviceContainer::getDevice();
$channel = $device->getConfig('channel');
$stories = $channel->getTopContents(true, true);

// (db) 2017-02-23 - aktueller Artikel nicht unter "Mehr" anzeigen; mit neuesten Artikel aus dem Channel auffüllen
$max_stories = 10;
$article = $device->getConfig('article');
// eigenen artikel nicht andrucken
$temp = array();
foreach($stories as $story){
    if (count($temp) >= $max_stories) {
        break;
    }
    
    $isNotSameArticle = ($story->getId() != $article->getId());

    if (($isNotSameArticle) && ($story instanceof TextualContent)) {
        if(!$story->getExcludeFromGeneratedLists()) {
            $frontendDate = (string) $story->getFrontendDate();
            $timeSpanAgo = date('Y-m-d', mktime(0, 0, 0, date('m'), date('d') - 7, date('Y')));
            if($frontendDate >= $timeSpanAgo){
                $index = $frontendDate . ' ' . $story->getId();
                $temp[$index] = $story;
            }   
        }
    }
}

//zu wenige aktuelle Topstories, restliche Positionen mit News belegen
if (count($temp) < $max_stories) {
    if($channel->getParent() instanceof Channel){
        $arrayNewStories = $channel->getPublishedTextualContents(($max_stories+2), null, new spunQ_DateTime('-1 month'),false);
    
        $tempNew=array();
        foreach ($arrayNewStories as $story) {

            $isNotSameArticle = ($story->getId() != $article->getId());

            if (($isNotSameArticle) && ($story instanceof TextualContent)) {
                // nur news nehmen, die nicht von Listen ausgenommen sein sollen
                if(!$story->getExcludeFromGeneratedLists()){

                    $frontendDate = (string) $story->getFrontendDate();

                    // keine news, die bereits via top-news kommen
                    $index = $frontendDate.' '.$story->getId();
                    if(!isset($temp[$index])){
                        $tempNew[$index] = $story;
                    }
                }
            }
        }
        // sortieren und die neuesten Artikel als Auffüller zur Ausgabe hinzufügen
        krsort($tempNew);
        $tempNew = array_slice($tempNew, 0, ($max_stories-count($temp)));
        $temp = array_merge($temp, $tempNew);
    }
}

krsort($temp);
$temp2 = array_slice($temp, 0, $max_stories);
$stories = array();
foreach($temp2 as $sKey => $story){
    $stories[] = $story;
}
// (db) 2017-02-23 end

if (0 === count($stories)) {
    return;
}

$headline = 'Mehr ' . $channel->getName() . '-News';
$layoutIdentifier = $channel->getOptions(true, true)->get('layoutOverride');
if ('' == $layoutIdentifier) {
    $layoutIdentifier = 'oe24';
}
$layoutClass = ' layout_' . $layoutIdentifier;

$box = new ContentBox();
$showStoryTime = false;
$overlay = '';


// ------------------------------------------

?>
<div class="headlineBox<?= $layoutClass; ?>">
    <h2 class="headline defaultChannelBackgroundColor">
        <span><?= $headline;?></span>
    </h2>
</div>

<?
    tpl('oe24.oe24.device.smartphone.tpl.contentBox.contentBoxStories', array(
        'channel'          => $channel,
        'box'              => $box,
        'stories'          => $stories,
        'showStoryTime'    => $showStoryTime,
        'overlay'          => $overlay,
        'layoutIdentifier' => $layoutIdentifier,
    ));
?>

