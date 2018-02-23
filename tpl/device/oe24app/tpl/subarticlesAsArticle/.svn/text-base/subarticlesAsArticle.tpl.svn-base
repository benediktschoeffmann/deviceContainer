<?php
/**
 * subarticles as article reprensetation
 * @var portal       oe24.core.Portal
 * @var box          oe24.core.ContentBox
 * @var articles     array<oe24.core.TextualContent>
 * @var category     string
 * @var device       any
 * @var oewaPath     any
 * @nodevmodecomments
 */

$keyValue = "firstBox_$category";
$firstBox = $device->getConfig($keyValue);
if (!$firstBox) {
    $device->setConfig($keyValue, true);
}
$templateOptions = $box->getTemplateOptions();
$articleOptions  = json_decode($templateOptions->get('articleOptions'), true);
$mobileAsDesktop = ($templateOptions->get('Mobile-as-Desktop')) ? true : false;
$twoColumns = ($templateOptions->get('Columns') == 2) ? true : false;

$boxTemplate     = $box->getTemplate();
$isXlBox         = ($boxTemplate === 'oe24.oe24._contentBoxes.oe2016XLBox');
$isTwoToOne      = ($isXlBox && $mobileAsDesktop);

//$imageFormat2to1 = ($twoColumns) ? 'bigStoryCrop' : 'bigStory';
$imageFormat2to1 = ($twoColumns) ? 'Oe24AppBigStoryCrop' : 'Oe24AppBigStory';
//$imageFormat1610 = '620x388';
$imageFormat1610 = 'Oe24App1610';

$imageFormat = ($isTwoToOne || $twoColumns) ? $imageFormat2to1 : $imageFormat1610;

foreach ($articles as $article) {

    $articlesPerCategory = $device->getConfig('articlesPerCategory');
    if ($category != 'frontpage' && $articlesPerCategory >= 19) {
        break;
    }
    $device->setConfig('articlesPerCategory', ($articlesPerCategory+1));


    $articleArray = array();

    $id             = $article->getId();
    $preTitle       = $device->sanitize($article->getPretitle(true, $box));
    $title          = $device->sanitize($article->getTitle(true, $box));
    $postTitle      = $device->sanitize($article->getPostTitle(true, $box));
    $leadText       = $device->sanitize($article->getLeadText(true, true, $box));
    $articleUrl     = $article->getUrl(true, $box);
    $articleUrlOwn  = $article->getUrl();
    $publishDate    = $article->getFrontendDate();


    // if mobile as desktop, use override image
    $image          = $article->getFirstRelatedImage(($isTwoToOne || ($mobileAsDesktop && !$isXlBox)) , $box);
    $imageUrl       = ($image) ? $image->getFileUrl($imageFormat) : lp('image', 'empty.gif');

    $showText = (isset($articleOptions[$id]['showTitle'])) ? $articleOptions[$id]['showTitle'] : false;
    $hasText = (!$mobileAsDesktop) ? true : $showText;

    if ($isXlBox && !$showText) {
        $hasText = false;
    }

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

    $bodyText = preg_replace('/<!--(.*)-->/Uis', '', $bodyText);
    $bodyText = $device->encodeBodyText($bodyText);
    $advertorial = ($article->getOptions(true, true)->get('EntgeltlicherContent')) ? true : false;

    $returnValue = array(
        'typ'   => 'article',
        'article' => array(
            'id'               => (string) $id,
            'is1610'           => (!$isTwoToOne),
            'hasText'          => $hasText,
            'hasTextInImage'   => ($mobileAsDesktop) ? $showText : true,
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
            ),
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
}
