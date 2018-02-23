<?
/**
 * template box Madonna Voting
 * @var channel oe24.core.Channel
 * @var box oe24.core.TemplateBox
 */

$templateOptions = $box->getTemplateOptions();

// -------------------------------------------

$display = trim($templateOptions->get('Display'));
$display = ($display) ? $display : '';

if ('nur Desktop' == $display) {
    return;
}

// -------------------------------------------

$headline = trim($templateOptions->get('Headline'));
$headline = ($headline) ? $headline : '';

$votingKey = trim($templateOptions->get('Voting'));
$votingKey = ($votingKey) ? $votingKey : '';

if (!$votingKey) {
    return;
}

// -------------------------------------------

$distanceTop = trim($templateOptions->get('Abstand-Oben'));
$distanceTop = ($distanceTop) ? $distanceTop : '';

$distanceBottom = trim($templateOptions->get('Abstand-Unten'));
$distanceBottom = ($distanceBottom) ? $distanceBottom : '';

$classDistanceTop = ($distanceTop) ? 'distanceTop' : '';
$classDistanceBottom = ($distanceBottom) ? 'distanceBottom' : '';

$classDistance = trim($classDistanceTop . ' ' . $classDistanceBottom);

// -------------------------------------------

// $votingUrl = 'http://192.168.5.46:9090/polls/textVotePanel.do?key=' . $votingKey;
$votingUrl = 'http://app.oe24.at/polls/textVotePanel.do?key=' . $votingKey;

$randNummer = (isset($_SESSION['madonna_blogger_textVote_box'])) ? $_SESSION['madonna_blogger_textVote_box'] + 500 : 500;
$_SESSION['madonna_blogger_textVote_box'] = $randNummer;
?>

<div class="madonnaSidebarVoting <?= $classDistance; ?>">

    <? if ($headline): ?>
        <div class="headlineBox layout_madonna">
            <h2 class="headline defaultChannelBackgroundColor">
                <a href="#!"><?= $headline; ?></a>
            </h2>
        </div>
    <? endif; ?>

    <iframe id="<?=$votingKey;?>" width="100%" height="320" scrolling="yes" frameborder="no" src="">

    </iframe>

</div>

<script type="text/javascript">

    setTimeout(function(){

        var iframe = document.getElementById('<?= $votingKey; ?>');
        iframe.src = '<?= $votingUrl; ?>';

    }, <?= $randNummer; ?>);

</script>
