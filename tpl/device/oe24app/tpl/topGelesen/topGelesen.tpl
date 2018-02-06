<?php
/**
 * Oe24App TopGelesenBox
 * @var portal       oe24.core.Portal
 * @var category     string
 * @var box          oe24.core.FrontendBox
 * @var oewaPath     any
 * @var device       any
 * @nodevmodecomments
 */

$keyValue = "firstBox_$category";
$firstBox = $device->getConfig($keyValue);
if (!$firstBox) {
    $device->setConfig($keyValue, true);
}

$templateOptions = $box->getTemplateOptions();

$articles = $box->getContentOfAllDropAreas(true);

if (count($articles) < 2) {
    return;
}

// damit mindestens 2 angezeigt werden.
$articlesPerCategory = $device->getConfig('articlesPerCategory');
if ($category != 'frontpage' && $articlesPerCategory >= 18) {
    return;
}

$returnValue = array(
    'typ'   => 'topGelesenBox',
    'topGelesenBox'     => array(
            'hasNumbers'    => true,
        ),
    );

foreach ($articles as $key => $article) {

    $articlesPerCategory = $device->getConfig('articlesPerCategory');
    if ($category != 'frontpage' && $articlesPerCategory >= 19) {
        break;
    }

    $device->setConfig('articlesPerCategory', ($articlesPerCategory+1));

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
    // $imageUrl       = ($image) ? $image->getFileUrl('bigStoryCrop') : lp('image', 'empty.gif');

    // --------------------------------------------------------------------------------

    $bodyText   = templateAsString(
            'oe24.oe24.device.oe24app.tpl.article.article',
            array('device' => $device,
                  'article'=> $article,
                  'portal' => $portal,
                  'layout' => 'smartphone'
                  )
            );

    // remove html comment tags
    $bodyText = preg_replace('/<!--(.*)-->/Uis', '', $bodyText);

    // and encode it
    $bodyText = $device->encodeBodyText($bodyText);
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
        $articleArray['article']['media'] = $media;
    }
    $returnValue['topGelesenBox']['articles'][] = $articleArray;
}

if ($box->getTemplate() === 'oe24.oe24._contentBoxes.oe2016businessSlider') {
    $color = $device->getColorFromCategory($category);

    $headline = $box->getTemplateOptions()->get('Headline');
    if ($headline) {
        $headlineArray = array(
            'typ'       => 'headline',
            'headline'  => array(
                'title' => $device->sanitize($headline),
                'color' => $color,
            ),
        );
        $device->addData($category, $headlineArray, 'articles', true);
    }
} else {
    tpl('oe24.oe24.device.oe24app.tpl.boxHeadline.boxHeadline', array(
        'device'              => $device,
        'category'            => $category,
        'box'                 => $box,
        'useLayoutIdentifier' => true,
    ));
}

$device->addData($category, $returnValue, 'articles', true);
