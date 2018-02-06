<?
function amp_ldjson($article, $jsonData) {

$headline = $article->getTitle();
$leadText = $article->getLeadText();
$leadText = str_replace(array('<br />', '<br/>'), '', $leadText);
$author = 'redaktion@oe24.at';
// $author = $article->getFrontendAuthor();
// laut georg immer die Redaktionsemail verwenden.

// (ws) 2016-06-30, 2016-07-04
// Ein Json-String wird durch doppelte Hochkomma begrenzt.
// Einfache und doppelte Hochkommata in den Texten werden in Entities umgewandelt
// $headline = htmlspecialchars($headline, ENT_QUOTES, 'UTF-8');
// $leadText = htmlspecialchars($leadText, ENT_QUOTES, 'UTF-8');
$headline = addcslashes($headline, '"\\');
$leadText = addcslashes($leadText, '"\\');

$image = $article->getFirstRelatedImage();

if ($image) {
  $imageUrl = $image->getFileUrl('960x480');
  // $copyright = $image->getCopyright();
} else {
  $imageUrl = lp('image', 'empty_2x1.png');
}

$publishDate = $article->getPublishDate();
$frontendDate = $article->getFrontendDate();

// $logoUrl = lp('image', 'mobile/amp/amp-logo-oe24.png');
// $logoWidth = 161;
// $logoHeight = 60;

// if (isOverride('sport', $article->getHomeChannel())) {
//   $logoUrl = lp('image', 'mobile/amp/amp-logo-sport24.png');
//   $logoWidth = 185;
//   $logoHeight = 60;
// }

// (ws) 2016-06-29
$logoUrl = $jsonData['logoUrl'];
$logoWidth = $jsonData['logoWidth'];
$logoHeight = $jsonData['logoHeight'];


$ldJson =
'<script type="application/ld+json">
{
  "@context": "http://schema.org",
  "@type": "NewsArticle",
  "mainEntityOfPage": {
    "@type": "WebPage",
    "@id": "'.$jsonData['canonicalUrl'].'"
  },
  "headline": "'.$headline.'",
  "image": {
    "@type": "ImageObject",
    "url": "'.$imageUrl.'",
    "width": 960,
    "height": 480
  },
  "datePublished": "'.$publishDate.'",
  "dateModified": "'.$frontendDate.'",
  "author": {
    "@type": "Person",
    "name": "'.$author.'"
  },
   "publisher": {
    "@type": "Organization",
    "name": "Oe24 GmbH",
    "logo": {
      "@type": "ImageObject",
      "url": "'.$logoUrl.'",
      "width": '.$logoWidth.',
      "height": '.$logoHeight.'
    }
  },
  "description": "'.$leadText.'"
}
</script>';

return $ldJson;
}
