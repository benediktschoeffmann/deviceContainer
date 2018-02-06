<?
/**
 * AMP spunQ_Video Tag
 *
 * @var spunqTag array<any>
 */

// ATTENTION: 
// IF IT IS A APA VIDEO PLATFORM, DIFFERENT HANDLING IS REQUIRED !! 

$id = $spunqTag['attributes']['id'];
$linkText = (isset($spunqTag['linkText'])) ? $spunqTag['linkText'] : NULL;

$url = '#!';
$title = (NULL === $linkText) ? NULL : $linkText;

$video = (is_numeric($id)) ? db()->getById($id, 'oe24.core.Video', false) : NULL;
if (NULL !== $video) {
    $url = $video->getUrl();
    $title = (NULL === $linkText) ? $video->getTitle() : $linkText;

    $mp4ID = $video->getVideoId();
    if (strpos($mp4ID, '://') > 0) {
        $videoSrc = $mp4ID;
    } else {
        // $videoSrc = 'http://media.oe24.at/' . $mp4ID . '/' . $mp4ID . '.mp4'; // OE24
        // $videoSrc = 'http://oe24.sf.apa.at/oe24/smil:' . $mp4ID . '.smil/playlist.m3u8'; // APA FLASH M3U8
        $videoSrc = 'http://vs-pd10.sf.apa.at/vs_oe24/' . $mp4ID . '.mp4'; // APA MP4
    }

    $image = $video->getFirstRelatedImage();
    $imgSrc = (NULL === $image) ? '' : $image->getFileUrl('624x351');
}

if (NULL === $title) {
    return;
}

?>
<? if (NULL !== $linkText): ?>
    <a href="<?= $url; ?>"><?= $title; ?></a>
<? else: ?>
    <amp-video src="<?= $videoSrc; ?>" width="480" height="270" poster="<?= $imgSrc; ?>" layout="responsive" controls></amp-video>
<? endif; ?>
