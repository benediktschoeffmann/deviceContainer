<?php
/**
 * @var relatedArticles array<oe24.core.TextualContent>
 * @var layout string
 * @var boxHeadline string
 * @default boxHeadline Mehr zum Thema
 */

if (false == is_array($relatedArticles) || count($relatedArticles) < 1) {
    return;
}

$listData = array();

foreach ($relatedArticles as $key => $content) {

    if (!$content instanceof TextualContent) {
        continue;
    }

    $urlAttr = getContentUrlAttributesArray($content, false, true, true, true);

    $image = $content->getFirstRelatedImage(true, false);
    if ($image) {
        $imageUrl = $image->getFileUrl("92x46NoStretch");
    } else {
        $imageUrl = 'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7';
    }

    $title = $content->getTitle();
    $preTitle = $content->getPreTitle();

    $listData[] = array(
        'urlHref' => (isset($urlAttr['href'])) ? $urlAttr['href'] : '#',
        'urlTarget' => (isset($urlAttr['target'])) ? $urlAttr['target'] : '',
        'urlTitle' => (isset($urlAttr['title'])) ? $urlAttr['title'] : '',
        'imageUrl' => $imageUrl,
        'title' => $title,
        'preTitle' => $preTitle,
    );
}

?>

<div class="relatedArticles">
    <h2 class="relatedArticlesHeadline"><?= $boxHeadline; ?></h2>
    <ul>
    <? foreach ($listData as $key => $item): ?>
        <li class="relatedArticlesItem">
            <a class="clearfix" href="<?= $item['urlHref']; ?>" <?= $item['urlTarget']; ?> title="<?= $item['urlTitle']; ?>">
                <span class="relatedArticlesImage">
                    <img src="<?=$item['imageUrl']?>" alt="">
                </span>
                <? if ('' != $item['preTitle']) : ?>
                <span class="relatedArticlesPreTitle"><?= $item['preTitle']; ?></span>
                <? endif; ?>
                <? if ('' != $item['title']) : ?>
                <span class="relatedArticlesTitle"><?= $item['title']; ?></span>
                <? endif; ?>
            </a>
        </li>
    <? endforeach; ?>
    </ul>
</div>
