<?php
/**
 * Standard ConsoleBox representation
 * @var portal       oe24.core.Portal
 * @var box          oe24.core.FrontendBox
 * @var device       any
 * @var articles     array<oe24.core.TextualContent>
 * @var category     string
 * @var oewaPath     any
 * @nodevmodecomments
 */


// (bs) 2018-02-14
if (count($articles) == 0 || $category != 'frontpage') {
    return;
}

$templateOptions = $box->getTemplateOptions();
$showHeadline = $templateOptions->get('Show-Headline');
$headline = $templateOptions->get('Headline');

$color = $device->getColorFromLayoutIdentifier($category);
if (!$color) {
    $color = '#d0113a';
}

$keyValue = "firstBox_$category";
$firstBox = $device->getConfig($keyValue);
if (!$firstBox) {
    $device->setConfig($keyValue, true);
    $showHeadline = false;
}

if ($showHeadline && !empty($headline)) {
    tpl('oe24.oe24.device.oe24app.tpl.boxHeadline.boxHeadline', array(
        'device'              => $device,
        'category'            => $category,
        'box'                 => $box,
        'color'               => $color,
        'headline'            => $device->sanitize($headline),
        'useLayoutIdentifier' => false,
        )
    );
}

$articleOptions = json_decode($box->getTemplateOptions()->get('articleOptions'), true);

$returnValue = array(
    'typ'       => 'console',
    'console'   => array(
        'is1610'    => false,
        'articles'  => array(
            ),
        ),

    );

$isMadonna = ($box->getTemplate() === 'oe24.oe24._consoleBoxes.oe2016ConsoleMadonna');

$maxArticles = $device->getConfig('maxArticlesConsoleBox');
foreach ($articles as $key => $article) {

    if ($key >= $maxArticles) {
        break;
    }

    $articlesPerCategory = $device->getConfig('articlesPerCategory');
    if ($category != 'frontpage' && $articlesPerCategory >= 19) {
        break;
    }



    $id             = $article->getId();
    $hasText        = (isset($articleOptions[$id]['showTitle'])) ? $articleOptions[$id]['showTitle'] : false;

    if ($isMadonna) {
        $hasText = !$hasText;
    }

    $preTitle       = $device->sanitize($article->getPretitle(true, $box));
    $title          = $device->sanitize($article->getTitle(true, $box));
    $postTitle      = $device->sanitize($article->getPostTitle(true, $box));
    $leadText       = $device->sanitize($article->getLeadText(true, true, $box));
    $articleUrl     = $article->getUrl(true, $box);
    $articleUrlOwn  = $article->getUrl();
    $publishDate    = $article->getFrontendDate();

    $image          = $article->getFirstRelatedImage(true, $box);
    $imageUrl       = ($image) ? $image->getFileUrl() : lp('image', 'empty.gif');

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

    // entgeltlicher Content
    $advertorial = ($article->getOptions(true, true)->get('EntgeltlicherContent')) ? true : false;


    $articleEntry = array(
        'typ'              => 'article',
        'article'          => array(
            'id'               => (string) $id,
            'hasText'          => $hasText,
            'hasTextInImage'   => $hasText,
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

    $media = $device->getMediaData($article, 'bigStoryCrop');

    if (!empty($media)) {
        $articleEntry['article']['media'] = $media;
    }

    $returnValue['console']['articles'][] = $articleEntry;
 }

$device->addData($category, $returnValue, 'articles', true);
