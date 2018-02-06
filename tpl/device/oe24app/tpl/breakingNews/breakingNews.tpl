<?php
/**
 * Oe24App BreakingNewsBox
 * @var portal       oe24.core.Portal
 * @var device       any
 * @var category     string
 * @var box          oe24.core.FrontendBox
 * @var oewaPath     any
 * @nodevmodecomments
 */

$contents = $box->getContentOfAllDropAreas(true);

if (empty($contents)) {
    return;
}

$returnValue = array(
    'typ'  =>  'breakingNewsBox',
    'breakingNewsBox' => array(
        'articles'  => array(
            ),
        ),
    );

$article = reset($contents);

$id             = $article->getId();
$preTitle       = $device->sanitize($article->getPretitle(true, $box));
$title          = $device->sanitize($article->getTitle(true, $box));
$postTitle      = $device->sanitize($article->getPostTitle(true, $box));
$leadText       = $device->sanitize($article->getLeadText(true, true, $box));
$articleUrl     = $article->getUrl(true, $box);
$articleUrlOwn  = $article->getUrl();
$publishDate    = $article->getFrontendDate();

$image          = $article->getFirstRelatedImage();
$imageUrl       = ($image) ? $image->getFileUrl() : lp('image', 'empty.gif');

$bodyText   = templateAsString(
        'oe24.oe24.device.oe24app.tpl.article.article',
        array('device' => $device,
              'article'=> $article,
              'portal' => $portal,
              'layout' => 'smartphone')
        );

// remove html comment tags
$bodyText = preg_replace('/<!--(.*)-->/Uis', '', $bodyText);

// and encode it
$bodyText = $device->encodeBodyText($bodyText);

// entgeltlicher Content
$advertorial = ($article->getOptions(true, true)->get('EntgeltlicherContent')) ? true : false;

$articleArray = array(
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

$media = $device->getMediaData($article);

if (!empty($media)) {
    $articleArray['article']['media'] = $media;
}

$returnValue['breakingNewsBox']['articles'][] = $articleArray;

$device->addData($category, $returnValue, 'articles', true);
