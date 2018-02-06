<?php
function amp_createLinkToArticle($id, $linkText) {
    // try {
       // $content = db()->getById($id, 'oe24.core.Text');
    // } catch (Exception $e) {
    //     return '';
    // }

    $url = '#!';
    $title = (NULL === $linkText) ? NULL : $linkText;

    $content = db()->getById($id, 'oe24.core.Text', false);
    if (NULL !== $content) {
        $url = $content->getUrl();
        $title = (NULL === $linkText) ? $content->getTitle() : $linkText;
    }

    if (NULL === $title) {
        return '';
    }

    $buffer[] = '<a href="';
    // $buffer[] = $content->getUrl();
    $buffer[] = $url;
    $buffer[] = '" target="_self">';
    // $buffer[] = $content->getTitle();
    $buffer[] = $title;
    $buffer[] = '</a>';

    $link = implode('', $buffer);

    return $link;
}
