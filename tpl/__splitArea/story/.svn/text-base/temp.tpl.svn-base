<?
/**
* Three Columns Template for Story Site
*
**/
?>
<script type="text/javascript">
<!--
function openBrWindow(url,windowName,features) {
    var newWindow = window.open(url,windowName,features);
    if (window.focus) {
        newWindow.focus();
    }
}
-->
</script>
<?
if($channel->getName() == "autoshop"){
    etpl("oe24.oe24.story.autoshopArticle", array("text" => $text,"channel" => $channel));
}else{
?>
<div class="articleContainer">
    <div class="articleMain" id="storymain">
        <div class="articleMainInner"><div class="storybox"><div class="main">
            <div class="date"><? s(formatDateUsingIntlLangKey('date.long', $text->getFrontendDate())) ?> <? s(formatDateUsingIntlLangKey('time.short', $text->getFrontendDate())) ?></div>
            <h2 class="preTitle"><?=$text->getPreTitle()?>&nbsp;</h2>
            <h1 class="texttitle"><?=$text->getTitle()?></h1>
            <h3 class="leadText"><?=$text->getLeadText(true)?></h3>
            <div class="image" id="articleImages">
                <div class="inlineDiashow_1">
                    <a href="javascript:void(0)" class="js-oewaLink btnLeft" onclick="<?=eventTracking(array("content" => $text, "action" => "articleImagePrev", "channel" => $channel))?>"></a>
                    <a href="javascript:void(0)" class="js-oewaLink btnRight" onclick="<?=eventTracking(array("content" => $text, "action" => "articleImageNext", "channel" => $channel))?>"></a>
                </div>
                <?
                $images = $text->getRelatedImages();
                if($images){
                    foreach($images as $key => $image){?>
                        <div class="img img<?=$key?>">
                            <img src="<? s($image->getFileUrl($imageVersion)) ?>" alt="<? s($text->getTitle()) ?>"/>
                            <?if($image->getCopyright()){?>
                                <div class="credits">&copy; <?s($image->getCopyright())?></div>
                            <?}?>
                        </div>
                    <?
                    }
                }
                ?>
            </div>
            <script type="text/javascript">
            enableArticleImageSlideshow();
            </script>
            <?
            if(!$options->getByKey("hideSocialButtons")){
                etpl("oe24.oe24.story.social", array("content" => $text));
            }
            if($options->getByKey("showGoogleAds")){
                etpl("oe24.oe24.story.adsense");
            }
            etpl("oe24.oe24.story.bodyText", array("text" => $text));
            if($options->getByKey("showGoogleAds")){
                etpl("oe24.oe24.story.adsense2");
            }
            if($options->getByKey("allowPosting")){
                $postingTemplate = ($options->getByKey("postingTemplate")) ? $options->getByKey("postingTemplate") : "Kommentare";
                etpl("oe24.oe24.story._postingTemplates.{$postingTemplate}_form", array("text" => $text, "channel" => $channel));
                etpl("oe24.oe24.story._postingTemplates.{$postingTemplate}", array("text" => $text, "channel" => $channel));
            }
            if($options->getByKey("facebookPostings")){
                etpl("oe24.oe24.story._postingTemplates.Kommentare_FB", array("text" => $text, "channel" => $channel));
            }
            etpl("oe24.oe24.story.top3Ad",array("text" => $text, "channel" => $channel));
            etpl("oe24.oe24.story.plistaAd", array("text" => $text));
            ?>
            <div class="clear"></div>
        </div></div></div>
        <div class="clear"></div>
    </div>
    <div class="clear"></div>
</div>