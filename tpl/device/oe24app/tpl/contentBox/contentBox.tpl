<?php
/**
 * Standard ContentBox representation
 * @var portal       oe24.core.Portal
 * @var box          oe24.core.ContentBox
 * @var articles     array<oe24.core.TextualContent>
 * @var category     string
 * @var device       any
 * @var oewaPath     any
 * @nodevmodecomments
 */

$maxArticles = (in_array($category, $device->getConfig('maxBoxesSpecial'))) ? 3 : $device->getConfig('maxArticlesContentBox');

$useTopStories = false;
$templateOptionsOfOriginalBox = $box->getTemplateOptions();
if ($templateOptionsOfOriginalBox->get('With-Top-Stories')) {
    $useTopStories = true;
}

if ($useTopStories) {
    $boxHomeChannel = $box->getHomeChannel();
    $homeChannelTopStories = (NULL === $boxHomeChannel) ? array() : $boxHomeChannel->getTopContents(true, true);
    $articles = array_merge($homeChannelTopStories, $articles);
}

$isFirstBox = false;

$keyValue = "firstBox_$category";
$firstBox = $device->getConfig($keyValue);
if (!$firstBox) {
    $device->setConfig($keyValue, true);
    $isFirstBox = true;
}

if ($box->getTemplate() === 'oe24.oe24._contentBoxes.oe2016teaserStoryBox' && !$isFirstBox) {
    if ($templateOptionsOfOriginalBox->get('Show-Mobile-Box')) {
        $headline = $templateOptionsOfOriginalBox->get('Headline');
        if ($headline && !empty($headline)) {
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
        else {
            return;
        }
    } else {
        return;
    }
}

if ($box->getTemplate() === 'oe24.oe24._contentBoxes.oe2016standardContentBoxFullwide' && !$isFirstBox) {

    if ($templateOptionsOfOriginalBox->get('Show-Headline')) {
        $headline = $templateOptionsOfOriginalBox->get('Big-Headline');
        if (!$headline) {
            $headline = $templateOptionsOfOriginalBox->get('Small-Headline');
        }
        if ($headline) {
            tpl('oe24.oe24.device.oe24app.tpl.boxHeadline.boxHeadline', array(
                'device'              => $device,
                'category'            => $category,
                'box'                 => $box,
                'useLayoutIdentifier' => true,
                'headline'            => $device->sanitize($headline),
                )
            );
        }
    }
}

if ($box->getTemplate() === 'oe24.oe24._contentBoxes.oe2016standardContentBoxFullwideBusiness' && !$isFirstBox) {
    if ($templateOptionsOfOriginalBox->get('Show-Headline')) {
        $headline = $templateOptionsOfOriginalBox->get('Gewerbe-Headline');
        $gewerbeCounter = $templateOptionsOfOriginalBox->get('Farbe-Links');
        $gewerbeCounter = ($gewerbeCounter) ? $gewerbeCounter : '01';
        $color = $device->getColorFromLayoutIdentifier('businessFullwide'.$gewerbeCounter, true);

        if ($headline && $color) {
            tpl('oe24.oe24.device.oe24app.tpl.boxHeadline.boxHeadline', array(
                    'device'              => $device,
                    'category'            => $category,
                    'box'                 => $box,
                    'useLayoutIdentifier' => true,
                    'headline'            => $device->sanitize($headline),
                    )
                );
        }
    }
}

$counter = 1;

$adPositions = array(
    0 => 'interval',
    1 => 'interval2',
    2 => 'interval3',
);

foreach ($articles as $key => $article) {
    if (($counter > 1) && ($counter % 3 == 0)) {

        $lastAd = $device->getConfig("interval_ad_$category");
        if (!$lastAd) {
            $lastAd = 0;
        }

        if ($lastAd < 3) {
            $ad = $device->getAdUrl($category, $adPositions[$lastAd % 3]);

            if ($ad) {

                $adArray = array(
                    'typ' => 'ad',
                    'url' => $ad,
                    );

                $device->setConfig("interval_ad_$category", ($lastAd + 1));
                $device->addData($category, $adArray, 'articles', true);
            }
        }

    }
    if ($key >= $maxArticles) {
        break;
    }

    $articlesPerCategory = $device->getConfig('articlesPerCategory');
    if ($category != 'frontpage' && $articlesPerCategory >= 19) {
        break;
    }

    $counter++;

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
        // 'is1610'           => false,
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
}
