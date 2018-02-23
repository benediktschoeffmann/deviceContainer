<?php
/**
 * headerNavSocial
 *
 * @var channel oe24.core.Channel
 * @var layout string
 */

// 2017-09-20 (db) - laut keywan bei games24 Navigation nicht andrucken - da keine Rückmeldung von Niki, vorab aufgrund von zuviel Freiraum nicht andrucken, da bei Games24 ThemenDerWocheCollection nicht angedruckt wird
if ('games24' == $layout) {
    return;
}

// -----------------------------------------------------------------------------

$channelOptions = $channel->getOptions(true, true);

// -----------------------------------------------------------------------------

// 2017-09-20 (db) da von Niki nicht definiert und es "großen" Freiraum schafft - vorab, social-Icons nicht andrucken, wenn ThemenDerWocheCollection nicht angedruckt wird
// definiert in tpl/__splitArea/_page/oe2016/headerNavTopics.tpl
$collectionId = $channelOptions->get('ThemenDerWocheCollection');
if (!ctype_digit($collectionId)) {
    return;
}

$collection = db()->getById($collectionId, 'oe24.core.ContentCollection', false);
if (null == $collection) {
    return;
}

if (false == $collection->isPublished()) {
    return;
}

// -----------------------------------------------------------------------------

?>

<div class="headerNavSocial">
	
	<a href="https://www.facebook.com/oe24.at/" title="oe24 auf Facebook" class="socialIcon socialFacebook"></a>

	<a href="https://twitter.com/oe24at?lang=de" title="oe24 auf Twitter" class="socialIcon socialTwitter"></a>

	<a href="http://www.oe24.at/digital/service/Die-Top-News-des-Tages-im-Ueberblick/227144488" title="oe24-Newsletter" class="socialIcon socialNewsletter"></a>

	<a href="http://www.oe24.at/digital/service/Nichts-mehr-verpassen-mit-dem-WhatsApp-Service-von-oe24/192695397" title="oe24 WhatsApp Nachrichten" class="socialIcon socialWhatsApp"></a>

	<a href="https://www.instagram.com/oe24.at/" title="oe24 auf Instagram" class="socialIcon socialInstagram"></a>

	<div class="clearfix"></div>
	
</div>
