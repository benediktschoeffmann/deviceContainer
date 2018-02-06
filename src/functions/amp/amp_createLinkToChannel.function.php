<?php
function amp_createLinkToChannel($id, $linkText) {

    $url = '#!';
    $title = (NULL === $linkText) ? NULL : $linkText;

    $content = db()->getById($id, 'oe24.core.Channel', false);
    if (NULL !== $content) {
        $url = $content->getUrl();
        $title = (NULL === $linkText) ? $content->getPageTitle() : $linkText;
    }

    if (NULL === $title) {
        return '';
    }

    $buffer[] = '<a href="';
    $buffer[] = $url;
    $buffer[] = '" target="_self">';
    $buffer[] = $title;
    $buffer[] = '</a>';

    $link = implode('', $buffer);

    return $link;
}
