<?
/**
 * article facebook comments
 */

$device = DeviceContainer::getDevice();

$article = $device->getConfig('article');
$articleOptions = $article->getOptions(false, true);

if (('Facebook' != $articleOptions->get('postingType')) ||
    (false      == $articleOptions->get('allowPosting')) ||
    (false      == $articleOptions->get('facebookPostings'))) {
    return;
}

$desktopUrl = $article->getUrl();
$host = parse_url($desktopUrl, PHP_URL_HOST);
if (count(explode('.', $host)) > 3) {
    $desktopUrl = str_replace("http://m.", "http://", $desktopUrl);
} else {
    $desktopUrl = str_replace("http://m.", "http://www.", $desktopUrl);
}
?>


<div class="fbComments">

    <div class="fbCommentsHeader">
        <h2 id="commentCounter" itemprop="interactionCount">Posten Sie Ihre Meinung</h2>
    </div>

    <div class="fbCommentsBody">
        <div class="container_postings fb-comments" data-width="100%" data-href="<?= $desktopUrl; ?>" data-numposts="10"></div>
    </div>

</div>



<? if (0): ?>
<section id="fbComment" class="fbComments comments clearfix" role="main">
    <div class="row">
        <div class="small-12">
            <div class="box channel title">
                <div class="row">
                    <div class="small-12 columns">
                        <h2 id="commentCounter" itemprop="interactionCount">Posten Sie Ihre Meinung</h2>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="box inner">
            <div class="container_postings fb-comments" data-href="<?= $desktopUrl; ?>" data-numposts="10"></div>
        </div>
    </div>
</section>
<? endif; ?>
