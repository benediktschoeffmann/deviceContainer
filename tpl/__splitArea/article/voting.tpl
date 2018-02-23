<?
/**
* Story Site
*
* @var channel oe24.core.Channel
* @var images array<oe24.core.Image>
* @var slideshow oe24.core.TextualContent
* @var sidebarVoting string
* @default sidebarVoting false
*/

// debug("sidebarVoting: $sidebarVoting");

if (isset($_GET['result'])) {
    return;
}
// debug("2-voting");
if (isset($_GET['voting']) || $sidebarVoting == 'true') {
    $options = $slideshow->getOptions(true, true);

    $imgUrls = '[';
    $counter = 0;
    foreach($images as  $key => $image){
        if ($counter) $imgUrls = $imgUrls.',';

        if ($sidebarVoting == 'true') {
            debug($image);
            debug("title: ".$image->getTitle());
            $current = $image->getTitle();
        }
        else{
            $current = urlencode($image->getFileUrl('140x70NoStretch'));
            if (spunQ::inMode(spunQ::MODE_DEVELOPMENT)) {
                // debug($current);
                $current = str_replace('oe24dev','images01',$current);
                // debug($current);
            }
        }

        $imgUrls = $imgUrls.'"'.$current.'"';
        $counter++;
    }
    $imgUrls = $imgUrls.']';
    debug($imgUrls);
    $votingPrefix = spunQ::getConfiguration()->getStringValue('oe24.oe24.votingPrefix', '');
    $template = ($options->get('hideSlideshowResults')) ? 'spunq_noresult' : 'spunq';
    $voteKey = $votingPrefix.$slideshow->getId(); // votingprefix ist sv-
    $customType = $slideshow->getCustomType();
    if($customType && $customType->getName() == 'SlideshowVotingOptions'){
        if($options->get('overrideVoteKey')){
            $voteKey = $votingPrefix.$options->get('overrideVoteKey');
        }
    }

    if(isOverride('madonna', $channel)){
        $template = ($options->get('hideSlideshowResults')) ? 'madonna_noresult' : 'madonna';
        // $template = ($sidebarVoting=='true')
    }
    $pollType = ($sidebarVoting == 'true') ? 'textVotePanel' : 'votePanel';
    $iframeWidth = ($sidebarVoting == 'true') ? '100%' : '600px';
    $scrolling = ($sidebarVoting == 'true') ? 'yes' : 'no';
    ?>
    <script type="text/javascript">
    //<![CDATA[
      document.domain = 'oe24.at';
    //]]>
    </script>
    <iframe id="votingFrame" class="votingFrame" width="<?= $iframeWidth; ?>" height="160px" scrolling="<?= $scrolling; ?>" frameborder="no"></iframe>
    <script type="text/javascript">
    <!--
        if (typeof votingBoxes == "undefined") {
            votingBoxes = new Array();
        }
        tmpArr = new Array();
        tmpArr['imgUrls'] = <?=$imgUrls?>;
        tmpArr['voteKey'] = '<?=$voteKey;?>';
        tmpArr['template'] = '<?=$template;?>';
        tmpArr['pollType'] = '<?=$pollType;?>';
        votingBoxes[votingBoxes.length] = tmpArr;
    -->
    </script>
<?}?>
