<?
/**
 * AMP spunQ_IFrame Tag
 *
 * @var spunqTag array<any>
 */

$protocol = $spunqTag['attributes']['protocol'];
switch ($protocol) {
    case 'Youtube':
        tpl('oe24.oe24.mobile.article.amp.tagging.Youtube', array(
            'id' => $spunqTag['attributes']['id'],
        ));
        break;

    case 'Facebook':
        tpl('oe24.oe24.mobile.article.amp.tagging.Facebook', array(
            'href' => $spunqTag['attributes']['id'],
        ));
        break;

    default:
        break;
}
