<?php
/**
 * Show ContentBox as Single Article
 * @var portal       oe24.core.Portal
 * @var box          oe24.core.ContentBox
 * @var articles     array<oe24.core.TextualContent>
 * @var category     string
 * @var device       any
 * @var oewaPath     any
 * @nodevmodecomments
 */

if (!is_array($articles) || (count($articles) == 0)) {
    return;
}

$showHeadline = true;

$keyValue = "firstBox_$category";
$firstBox = $device->getConfig($keyValue);
if (!$firstBox) {
    $device->setConfig($keyValue, true);
    $showHeadline = false;
}

$articlesPerCategory = $device->getConfig('articlesPerCategory');
if ($category != 'frontpage' && $articlesPerCategory >= 19) {
    return;
}


$article = reset($articles);
$templateOptionsOfOriginalBox = $box->getTemplateOptions();
if ($templateOptionsOfOriginalBox->get('Headline') && $showHeadline) {
    $headline = $templateOptionsOfOriginalBox->get('Headline');
    $color = $device->getColorFromCategory($category);
    tpl('oe24.oe24.device.oe24app.tpl.boxHeadline.boxHeadline', array(
        'device'              => $device,
        'category'            => $category,
        'box'                 => $box,
        'headline'            => $device->sanitize($headline),
        'color'               => $color,
        'useLayoutIdentifier' => false,
        )
    );
}

$id             = $article->getId();
$preTitle       = $device->sanitize($article->getPretitle(true, $box));
$title          = $device->sanitize($article->getTitle(true, $box));
$postTitle      = $device->sanitize($article->getPostTitle(true, $box));
$leadText       = $device->sanitize($article->getLeadText(true, true, $box));
$articleUrl     = $article->getUrl(true, $box);
$articleUrlOwn  = $article->getUrl();
$publishDate    = $article->getFrontendDate();

$image          = $article->getFirstRelatedImage(true, $box);
$imageUrl       = ($image) ? $image->getFileUrl('Oe24AppBigStoryCrop') : lp('image', 'empty.gif');
//$imageUrl       = ($image) ? $image->getFileUrl('bigStoryCrop') : lp('image', 'empty.gif');

// --------------------------------------------------------------------------------

$bodyText   = templateAsString(
        'oe24.oe24.device.oe24app.tpl.article.article',
        array('device' => $device,
              'article'=> $article,
              'portal' => $portal,
              'layout' => 'smartphone')
        );

$searchString = 'apaOuterFrame';
if (strpos($bodyText, $searchString) !== FALSE) {
    continue;
}

$device->setConfig('articlesPerCategory', ($articlesPerCategory+1));



// remove html comment tags
$bodyText = preg_replace('/<!--(.*)-->/Uis', '', $bodyText);

// and encode it
$bodyText = $device->encodeBodyText($bodyText);

$advertorial = ($article->getOptions(true, true)->get('EntgeltlicherContent')) ? true : false;

$returnValue = array(
    'typ'              => 'article',
    'article'          => array(
        'id'               => (string) $id,
        'pre_headline'     => $preTitle,
        'article_headline' => $title,
        'sub_headline'     => $postTitle,
        'abstract'         => $leadText ? strip_tags($leadText) : '',
        'articleUrl'       => $articleUrl,
        'publishDate'      => $publishDate->__toString(),
        'oewaPath'         => $oewaPath,
        'image'            => $imageUrl,
        'advertorial'      => $advertorial,
        'bodyText'         => $bodyText,
        'pre_ad'           => $device->getAdUrl($category, 'artikel_top'),
        'post_ad'          => $device->getAdUrl($category, 'artikel_bottom'),
        'link'             => ($articleUrl != $articleUrlOwn),
    )
);

$pre_ad = $device->getAdUrl($category, 'artikel_top');
$post_ad = $device->getAdUrl($category, 'artikel_bottom');

if ($pre_ad !== false) {
    $returnValue['article']['pre_ad'] = $pre_ad;
}

if ($post_ad !== false) {
    $returnValue['article']['post_ad'] = $post_ad;
}

$media = $device->getMediaData($article, 'bigStory');

if (!empty($media)) {
    $returnValue['article']['media'] = $media;
}

$device->addData($category, $returnValue, 'articles', true);

