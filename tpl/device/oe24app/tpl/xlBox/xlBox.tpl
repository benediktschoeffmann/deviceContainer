<?php
/**
 * xlBox representation
 * @var portal       oe24.core.Portal
 * @var box          oe24.core.ContentBox
 * @var articles     array<oe24.core.TextualContent>
 * @var category     string
 * @var device       any
 * @var oewaPath     any
 * @nodevmodecomments
 */

$showHeadline = true;

$keyValue = "firstBox_$category";
$firstBox = $device->getConfig($keyValue);
if (!$firstBox) {
    $device->setConfig($keyValue, true);
    // $showHeadline = false;
}

$articlesPerCategory = $device->getConfig('articlesPerCategory');
if ($category != 'frontpage' && $articlesPerCategory >= 19) {
    return;
}


// (bs) 2018-02-21 Aufforderung von Niki - bei ALLEN Xl-Boxen Headlines drucken.
$templateOptions = $box->getTemplateOptions();
if ($templateOptions->get('showHeadline') && $showHeadline) {
    $headline = $templateOptions->get('Headline');
    if ($headline) {
        tpl('oe24.oe24.device.oe24app.tpl.boxHeadline.boxHeadline', array(
            'device'    => $device,
            'category'  => $category,
            'box'       => $box,
            'headline'  => $device->sanitize($headline),
            'useLayoutIdentifier' => true,
        ));
    }
}


// (bs) siehe oben.
// (bs) 2018-02-14 Anforderung von Niki ....
// bei der Split-Column XLBox auf jeden Fall die Headline andrucken.
// if ($templateOptions->get('showHeadline') && $templateOptions->get('Headline') &&
//     $templateOptions->get('Columns') == 2) {
//     tpl('oe24.oe24.device.oe24app.tpl.boxHeadline.boxHeadline', array(
//             'device'    => $device,
//             'category'  => $category,
//             'box'       => $box,
//             'headline'  => $device->sanitize($templateOptions->get('Headline')),
//             'useLayoutIdentifier' => true,
//         ));
// }

$boxTemplateString = $box->getTemplate();

$isXLBox = ($boxTemplateString === 'oe24.oe24._contentBoxes.oe2016XLBox');
$articleOptions = json_decode($templateOptions->get('articleOptions'), true);

$mobileBigStories = $templateOptions->get('Mobile-Big-Stories');

if ((!$isXLBox && $mobileBigStories) || (count($articles) == 1)) {
    tpl('oe24.oe24.device.oe24app.tpl.subarticlesAsArticle.subarticlesAsArticle',
        array(
            'portal'   => $portal,
            'box'      => $box,
            'articles' => $articles,
            'category' => $category,
            'device'   => $device,
            'oewaPath' => $oewaPath,
        )
    );
    return;
}

$mobileAsDesktop = $templateOptions->get('Mobile-as-Desktop') ? true : false;

$returnValue = array(
    'typ'   => 'subArticles',
    'subArticles' => array(
        // 'is1610'  => true,

        ),
    );

foreach ($articles as $key => $article) {

    $id             = (string) $article->getId();

    if ($key == 0) {
        $showTitle      = (isset($articleOptions[$id]['showTitle'])) ? $articleOptions[$id]['showTitle'] : false;
        $hasText        = (!$mobileAsDesktop) ? true : $showTitle;
        $hasTextInImage = $showTitle;
        $is1610         = !($mobileAsDesktop && $isXLBox) && $mobileBigStories;
    }

    $articlesPerCategory = $device->getConfig('articlesPerCategory');
    if ($category != 'frontpage' && $articlesPerCategory >= 19) {
        break;
    }

    // $imageFormatBig   = ($key == 0 && $mobileAsDesktop) ? 'XL-Konsole' : '620x388';
    $imageFormatBig   = ($key == 0 && $mobileAsDesktop) ? 'Oe24AppXL-Konsole' : 'Oe24App1610';
    $imageFormatBig   = ($key > 0) ? '190x95Crop' : $imageFormatBig;
    //$imageFormatBig   = ($key == 0 && $mobileAsDesktop) ? 'bigStoryCrop' : $imageFormatBig;
    $imageFormatBig   = ($key == 0 && $mobileAsDesktop) ? 'Oe24AppBigStoryCrop' : $imageFormatBig;
    $useOverrideImage = $mobileAsDesktop && ($key == 0);

    $preTitle       = $device->sanitize($article->getPretitle(true, $box));
    $title          = $device->sanitize($article->getTitle(true, $box));
    $postTitle      = $device->sanitize($article->getPostTitle(true, $box));
    $leadText       = $device->sanitize($article->getLeadText(true, true, $box));
    $articleUrl     = $article->getUrl(true, $box);
    $articleUrlOwn  = $article->getUrl();
    $publishDate    = $article->getFrontendDate();

    $image          = $article->getFirstRelatedImage($useOverrideImage, $box);
    $imageUrl       = ($image) ? $image->getFileUrl($imageFormatBig) : null;

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
    $articleInfo = array(
        'id'            => $id,
        'pre_headline'  => $preTitle,
        'headline'      => $title,
        'sub_headline'  => $postTitle,
        'abstract'      => $leadText ? strip_tags($leadText) : '',
        'articleUrl'    => $articleUrl,
        'publishDate'   => $publishDate->__toString(),
        'oewaPath'      => $oewaPath,
        'image'         => $imageUrl,
        'advertorial'   => $advertorial,
        'bodyText'      => $bodyText,
        'pre_ad'           => $device->getAdUrl($category, 'artikel_top'),
        'post_ad'          => $device->getAdUrl($category, 'artikel_bottom'),
        'link'          => ($articleUrl != $articleUrlOwn),
    );

    // $imageFormat = ($key == 0) ? null : '190x95Crop';

    // $imageFormat = 'bigStory';
    $imageFormat = 'Oe24AppBigStory';
    $media = $device->getMediaData($article, $imageFormat);

    if ($media) {
        $articleInfo['media'] = $media;
    }

    if ($key == 0) {
        $returnValue['subArticles']['is1610']         = $is1610;
        $returnValue['subArticles']['hasText']        = $hasText;
        $returnValue['subArticles']['hasTextInImage'] = $hasTextInImage;
        $returnValue['subArticles']['mainArticle']    = $articleInfo;
    } else {
        $articleInfoTmp = array(
            'typ'       => 'article',
            'article'   => $articleInfo,
            );
        $returnValue['subArticles']['articles'][] = $articleInfoTmp;
    }
}


$device->addData($category, $returnValue, 'articles', true);

