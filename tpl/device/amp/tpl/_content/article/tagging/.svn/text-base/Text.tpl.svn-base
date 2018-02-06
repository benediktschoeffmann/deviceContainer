<?
/**
 * AMP spunQ_Text Tag
 *
 * @var spunqTag array<any>
 */

$id = $spunqTag['attributes']['id'];
$linkText = (isset($spunqTag['linkText'])) ? $spunqTag['linkText'] : NULL;

$url = '#!';
$title = (NULL === $linkText) ? NULL : $linkText;

$content = (is_numeric($id)) ? db()->getById($id, 'oe24.core.Text', false) : NULL;
if (NULL !== $content) {
    $url = $content->getUrl();
    $title = (NULL === $linkText) ? $content->getTitle() : $linkText;
}

if (NULL === $title) {
    return;
}

?>
<a href="<?= $url; ?>"><?= $title; ?></a>
