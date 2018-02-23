<?
/**
* Story Site - Comments
*
* @var text oe24.core.TextualContent
* @var options spunQ_Map
* @var channel oe24.core.Channel
*/
?>
<a id="comment"></a>
<section class="postings">
<h2>Postings <span>(<?= count($text->getComments())?>)</span></h2>
<h3>
<?
	if(isset($_GET['answerTo'])){
?>
Posten Sie Ihre Antwort
<?}else{?>
Posten Sie Ihre Meinung
<?}?>
</h3>
<form method="post" action="#commentForm" name="oe24_oe24_story__postingTemplates_Kommentare" id="oe24_oe24_story__postingTemplates_Kommentare">
<div class="row">
<div class="six columns">
	<?
		$user = user();
		if($user->getUsername() == 'guest'){
	?>
	<input type="text" placeholder="Angezeigter Name" name="username" />
	<?}else{?>
	<h4><a href="/user">Hallo <?= $user->getUsername() ?></a></h4>
	<?}?>
</div>
<div class="six columns">
	<?
		$parentChannels=$channel->getParentChannels();;
		if($user->getUsername() == 'guest'){
	?>
	<a href="/<?=$parentChannels[1]->getUrlSlug()?>/user?redirect=<?= $text->getUrl() ?>#comment">Login</a> | <a href="/<?=$parentChannels[1]->getUrlSlug()?>/user?redirect=<?= $text->getUrl() ?>#comment">Neu anmelden</a>
	<?}else{?>
	<a href="/user/logout?redirect=<?= $text->getUrl() ?>">Logout</a>
	<?}?>
</div>
</div>
<textarea placeholder="Schreiben Sie hier Ihren Kommentar" name="text"></textarea>
<input class="button" type="submit" value="Posten" />
<div class="clear"></div>
</form>
<?
if(isset($_GET['commentSuccess'])){
?>
<h5>Kommentar erfolgreich versendet.</h5>
<?
}
$objects = db()->getByCondition("strg.comment.Comment","storableObject = {0} AND status = {1}", array(0=> $text, 1 => 2));
$objects = array_reverse($objects);
$comments = array();

if($objects){
	foreach($objects as $object){
		$user = $object->getUser();
		if($user){
			$Oe24User = $user->getOe24User();
			if($Oe24User){
				if(!$Oe24User->inPortal(Portal::getPortalByName('oe24'))){
					continue;
				}
			}
		}
		$c = count($comments);
		$comments[$c] = $object;
		$comments[$c]->haveParent = 0;
		$answers = db()->getByCondition("strg.comment.Comment","storableObject = {0} AND status = {1}", array(0 => $object, 1 => 2));
		$answers = array_reverse($answers);
		foreach($answers as $answer){
			if(!$answer instanceof strg_Comment){
				continue;
			}
			$c = count($comments);
			$comments[$c] = $answer;
			$comments[$c]->haveParent = 1;
		}
	}

$i=0;
$postsPerSite=3;?>
<div class="commentsContainer">
<?
foreach($comments as $comment){
	$commentText = $comment->getText();
	$commentUsername = $comment->getUsername();
	
	//dont show guest-postings containing string "href" (possibly SPAM)
	if(
		(preg_match( "/GAST/", $commentUsername))and
		(preg_match( "/(href|http)/", strtolower($commentText)))
	) {
		$commentText = getStaticTextMsg('splitArea.story.comments.removed',"--KOMMENTAR WURDE ENTFERNT (SPAM)-- ");
	}

	$i++;
	$ups = count(
		db()->getByCondition(
			"strg.rating.Rating",
			"storableObject = {0} AND ratingValue = {1}",
			array(0 => $comment, 1 => 5)
		)
	);
	$downs = count(
		db()->getByCondition(
			"strg.rating.Rating",
			"storableObject = {0} AND ratingValue = {1}",
			array(0 => $comment, 1 => 1)
		)
	);
	if($i > $postsPerSite){
		//$class = " hide";
		$class = "";
	}else{
		$class = "";
	}
	// check if username is in 'moderatorList'
	$isMod = false;
	$mods = explode(';', $options->getByKey('moderatorList'));
	foreach($mods as $mod){
		if($mod === $commentUsername){
			$isMod = true;
			continue;
		}
	}
	?>
	<article <?= ($comment->haveParent) ? 'class="entry antwort ' . $class . '"' : 'class="entry ' . $class . '"'; ?> >
	<span class="name"><? s($commentUsername) ?></span>
	<div class="trenner">>></div>
	<span class="datum"><? s(formatDateUsingIntlLangKey('datetime.medium', $comment->getDate())) ?></span>
	<a class="answerComment right" href="?answerTo=<?= $comment->getId() ?>#comment">Antworten</a>
	<div class="clear"></div>
	<p><? nl2br(s($commentText)) ?></p>
	</article>
<?}?>
</div>
</section>   
<script type="text/javascript">

if(typeof readyCallbacks !== 'object')
	var readyCallbacks = [];
readyCallbacks.push(function(){
	var paginator = new Paginator();
	paginator.setContainerClass('commentsContainer');
	paginator.setItemsPerPage(<?=$postsPerSite?>);
	paginator.init();
});

</script>
<?}?>