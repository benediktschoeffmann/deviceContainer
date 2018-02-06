<?php
/**
 *  Editors Comment Box
 *
 * @var portal oe24.core.Portal
 * @var box oe24.core.TemplateBox
 * @var category string
 * @var device       any
 * @var oewaPath     any
 * @nodevmodecomments
 */

$keyValue = "firstBox_$category";
$firstBox = $device->getConfig($keyValue);
if (!$firstBox) {
    $device->setConfig($keyValue, true);
}

$articlesPerCategory = $device->getConfig('articlesPerCategory');
if ($category != 'frontpage' && $articlesPerCategory >= 18) {
    return;
}

$validEditors = array(
    'bauernebel_herbert' => array(
        'firstname' => 'Herbert',
        'lastname'  => 'Bauernebel',
    ),
    'daniel_isabelle' => array(
        'firstname' => 'Isabelle',
        'lastname'  => 'Daniel',
    ),
    'fellner_niki' => array(
        'firstname' => 'Niki',
        'lastname'  => 'Fellner',
        'useData'   => true,
        'href'      => 'http://www.oe24.at/newsletter/oe24-morgen',
        'title'     => 'Die Top-News des Tages im Überblick',
    ),
    'fellner_wolfgang' => array(
        'firstname' => 'Wolfgang',
        'lastname'  => 'Fellner',
    ),
    'krankl_hans' => array(
        'firstname' => 'Hans',
        'lastname'  => 'Krankl',
    ),
    'polster_toni' => array(
        'firstname' => 'Toni',
        'lastname'  => 'Polster',
    ),
    'fink_thorsten' => array(
        'firstname' => 'Thorsten',
        'lastname'  => 'Fink',
    ),
    'hofmann_steffen' => array(
        'firstname' => 'Steffen',
        'lastname'  => 'Hofmann',
    ),
    'huetter_adi' => array(
        'firstname' => 'Adi',
        'lastname'  => 'Hütter',
    ),
    'linz_roland' => array(
        'firstname' => 'Roland',
        'lastname'  => 'Linz',
    ),
    'klammer_franz' => array(
        'firstname' => 'Franz',
        'lastname'  => 'Klammer',
    ),
    'sykora_thomas' => array(
        'firstname' => 'Thomas',
        'lastname'  => 'Sykora',
    ),
    'riesch_maria' => array(
        'firstname' => 'Maria',
        'lastname'  => 'Höfl-Riesch',
    ),
    'unterweger_walter' => array(
        'firstname' => 'Walter',
        'lastname'  => 'Unterweger',
    ),
    'schima_werner' => array(
        'firstname' => 'Werner',
        'lastname'  => 'Schima',
    ),
    'schroeder_guenther' => array(
        'firstname' => 'Günther',
        'lastname'  => 'Schröder',
    ),
);

$defaultTopTitle = 'Kommentar';

$templateOptionsArray = $box->getTemplateOptions()->toAssociativeArray();
$temp = array();
foreach ($templateOptionsArray as $key => $value) {
    $posImageUrl  = strpos($key, 'RedakteurIn');
    $posArtikelId = strpos($key, 'ArtikelID');
    $posTopTitel  = strpos($key, 'TopTitel');

    // check only interesting values
    if (false === $posImageUrl &&
        false === $posArtikelId &&
        false === $posTopTitel) {
        continue;
    }

    if (false !== $posImageUrl) {
        $itemKey = substr($key, strrpos($key, '-') + 1);
        $temp[$itemKey]['imageUrl'] = trim($value);
    }
    if (false !== $posArtikelId) {
        $itemKey = substr($key, strrpos($key, '-') + 1);
        $temp[$itemKey]['articleId'] = trim($value);
    }
    if (false !== $posTopTitel) {
        $itemKey = substr($key, strrpos($key, '-') + 1);
        $temp[$itemKey]['topTitle'] = trim($value);
    }


}


$editors = array();
foreach ($temp as $item) {

    if (false == isset($item['imageUrl']) || false == isset($item['articleId'])) {
        continue;
    }

    $pathParts = pathinfo($item['imageUrl']);

    $filename = $pathParts['filename'];
    if (false == array_key_exists($filename, $validEditors)) {
        continue;
    }

    $editors[] = array(
        'imageUrl'  => $item['imageUrl'],
        'articleID' => $item['articleId'],
        'firstname' => $validEditors[$filename]['firstname'],
        'lastname'  => $validEditors[$filename]['lastname'],
        'topTitle'  => empty($item['topTitle']) ? $defaultTopTitle : $item['topTitle'],
        'useData'   => isset($validEditors[$filename]['useData']) ? $validEditors[$filename]['useData'] : false,
        'href'      => isset($validEditors[$filename]['href']) ? $validEditors[$filename]['href'] : '#!',
        'preTitle'  => isset($validEditors[$filename]['preTitle']) ? $validEditors[$filename]['preTitle'] : '&nbsp;',
        'title'     => isset($validEditors[$filename]['title']) ? $validEditors[$filename]['title'] : '&nbsp;',
    );

}

$returnValue = array(
    'typ'   => 'topGelesenBox',
    'topGelesenBox'     => array(
        'hasNumbers'    => false,
    ),
);

// (bs) 2017-11-30 wenn anzahl ungerade, letzen wegschneiden
if ((count($editors) % 2) != 0) {
    $dummy = array_pop($editors);
}

$stories = array();

foreach ($editors as $key => $editor) {
    $article = db()->getById($editor['articleID'], 'oe24.core.TextualContent', false);
    if (!$article) {
        continue;
    }

    $articlesPerCategory = $device->getConfig('articlesPerCategory');
    if ($category != 'frontpage' && $articlesPerCategory >= 19) {
        break;
    }
    $device->setConfig('articlesPerCategory', ($articlesPerCategory+1));


    $id = (string) $article->getId();
    // (bs) 2017-11-30 pretitle weglassen, titel des artikels anzeigen.
    // $preTitle       = $device->sanitize($editor['firstname'] . ' ' . $editor['lastname']);
    // $title          = $device->sanitize($editor['topTitle']);
    $preTitle       = '';
    $title          = $device->sanitize($article->getTitle(true, $box));

    $postTitle      = '';
    $leadText       = $device->sanitize($article->getLeadText(true, true, $box));
    $articleUrl     = $article->getUrl(true, $box);
    $articleUrlOwn  = $article->getUrl();
    $publishDate    = $article->getFrontendDate();

    $imageUrl       = 'http://www.oe24.at';
    $imageUrlTmp = $editor['imageUrl'];
    $idx = strrpos($imageUrlTmp, '/');
    $imageUrlTmp = substr($imageUrlTmp, 0, $idx) . '/app/'.substr($imageUrlTmp, $idx+1);
    $imageUrl .= $imageUrlTmp;

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

// (bs) 2017-12-01 Niki wünscht eine Überschrift
$headline = 'Kommentare des Tages';
$headlineArray = array(
    'typ'       => 'headline',
    'headline'  => array(
        'title' => $device->sanitize($headline),
        'color' => $device->getColorFromCategory($category),
    ),
);
$device->addData($category, $headlineArray, 'articles', true);
$device->addData($category, $returnValue, 'articles', true);
