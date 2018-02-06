<?
/**
 * article slideshow voting
 * @var article oe24.core.Content
 */

if ( ! $article instanceof SlideShow ) {
	return;
}

if (isset($_GET['result'])) {
    // return;
}

if (!isset($_GET['voting'])) {
	return;
}

// ------------------------------------------------------

$images = $article->getRelatedImages();

// config variablen für js
$aImgUrls = array();
$firstImgUrl = "";
foreach($images as  $key => $image){

    $fileUrl = urlencode($image->getFileUrl("140x70NoStretch"));
    if (spunQ::inMode(spunQ::MODE_DEVELOPMENT)) {
        $fileUrl = str_replace('oe24dev','images01',$fileUrl);
    }
    $aImgUrls[] = '"'.$fileUrl.'"';

    $firstImgUrl = (mb_strlen($firstImgUrl)<1) ? $fileUrl : $firstImgUrl;
}
$imgUrls = "[" . implode(",",$aImgUrls) . "]";

// votekey
$options = $article->getOptions(true, true);
$votingPrefix = spunQ::getConfiguration()->getStringValue("oe24.oe24.votingPrefix", '');
$voteKey = $votingPrefix.$article->getId(); // votingprefix ist sv-
$customType = $article->getCustomType();
if($customType && $customType->getName() == "SlideshowVotingOptions"){
    if($options->get("overrideVoteKey")){
        $voteKey = $votingPrefix.$options->get("overrideVoteKey");
    }
}

$votingUrl = spunQ::getConfiguration()->getStringValue("oe24.oe24.votingUrl", '');

// template
$template = ($options->get("hideSlideshowResults")) ? "spunq_noresult" : "spunq";
$channel = $article->getHomeChannel();
if(isOverride("madonna", $channel)){
    $template = ($options->get("hideSlideshowResults")) ? "madonna_noresult" : "madonna";
}

?>

<? if (isset($_GET['result'])): ?>

    <script type="text/javascript">
    //<![CDATA[
      document.domain = 'oe24.at';
    //]]>
    </script>
    <iframe id="vresultframe" name="vresultframe" src="<?=$votingUrl?>voteResult.do?key=<?=$voteKey?>&template=<?=$template?>&imgUrl=<?=urlencode($firstImgUrl)?>" frameborder="no" scrolling="yes" width="100%" height="400px" ></iframe>

<? else: ?>

    <script type="text/javascript">
    	//<![CDATA[
    	  document.domain = 'oe24.at';
    	//]]>
    </script>

    <iframe id="votingFrame" height="160px" scrolling="no" frameborder="no"></iframe>

    <script type="text/javascript">
    <!--
        if (typeof votingBoxes == "undefined") {
            votingBoxes = new Array();
        }
        tmpArr = new Array();
        tmpArr['imgUrls'] = <?=$imgUrls?>;
        tmpArr['voteKey'] = '<?=$voteKey;?>';
        tmpArr['template'] = '<?=$template?>';
        votingBoxes[votingBoxes.length] = tmpArr;
    -->
    </script>

<? endif; ?>
