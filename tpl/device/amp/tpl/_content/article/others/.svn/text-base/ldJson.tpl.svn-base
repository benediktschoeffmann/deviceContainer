<?
/**
 * AMP ld + json Tag
 *
 * @var content oe24.core.Content
 * @var jsonData array<any>
 */

// ---------------------------------------------------------------------
$headline = $content->getTitle();
$leadText = $content->getLeadText();
$leadText = str_replace(array('<br />', '<br/>'), '', $leadText);

$headline = addcslashes($headline, '"\\');
$leadText = addcslashes($leadText, '"\\');

// ---------------------------------------------------------------------

$author = 'redaktion@oe24.at';

// ---------------------------------------------------------------------

$image = $content->getFirstRelatedImage();

if ($image) {
  $imageUrl = $image->getFileUrl('960x480');
  // $copyright = $image->getCopyright();
} else {
  $imageUrl = lp('image', 'empty_2x1.png');
}

// ---------------------------------------------------------------------

$publishDate = $content->getPublishDate();
$frontendDate = $content->getFrontendDate();

// ---------------------------------------------------------------------

$canonicalUrl = $jsonData['canonicalUrl'];
$logoUrl = $jsonData['logoUrl'];
$logoWidth = $jsonData['logoWidth'];
$logoHeight = $jsonData['logoHeight'];

// ---------------------------------------------------------------------

?>
<script type="application/ld+json">
{
  "@context": "http://schema.org",
  "@type": "NewsArticle",
  "mainEntityOfPage": {
    "@type": "WebPage",
    "@id": "<?= $canonicalUrl; ?>"
  },
  "headline": "<?= $headline; ?>",
  "image": {
    "@type": "ImageObject",
    "url": "<?= $imageUrl; ?>",
    "width": 960,
    "height": 480
  },
  "datePublished": "<?= $publishDate; ?>",
  "dateModified": "<?= $frontendDate; ?>",
  "author": {
    "@type": "Person",
    "name": "<?= $author; ?>"
  },
   "publisher": {
    "@type": "Organization",
    "name": "Oe24 GmbH",
    "logo": {
      "@type": "ImageObject",
      "url": "<?= $logoUrl; ?>",
      "width": <?= $logoWidth; ?>,
      "height": <?= $logoHeight; ?>
    }
  },
  "description": "<?= strip_tags($leadText); ?>"
}
</script>
