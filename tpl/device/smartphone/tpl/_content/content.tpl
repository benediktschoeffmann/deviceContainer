<?
/**
 * content
 */


$device = DeviceContainer::getDevice();
$article = $device->getConfig('article');


// channel content
if (null == $article) {
    // search
    $q = request()->getGetValue("q");
    $q = (mb_strlen($q)) ? $q : false;
    if ($q) {
        $channel = $device->getConfig('channel');
        $name = $channel->getName();

        $params = array();
        switch ($name) {
            case 'rezepte':
                $params = array(
                    'allowedTypes' => array('oe24.core.Recipe'),
                );
                break;
        }

        tpl('oe24.oe24.device.smartphone.tpl._content.search.index', array('channel' => $channel, 'params' => $params));
        return;
    }


    tpl('oe24.oe24.device.smartphone.tpl._content.channel.standardChannel', array('device' => $device));
    return;
}


// article content

switch (true) {

    case $article instanceof Recipe:
        // debug('Article Recipe');
        tpl('oe24.oe24.device.smartphone.tpl._content.article.tpl.articleRecipe', array('article' => $article));
        break;

    case $article instanceof SlideShow:
        // debug('Article SlideShow');
        tpl('oe24.oe24.device.smartphone.tpl._content.article.tpl.articleSlideshow', array('article' => $article));
        break;

    case $article instanceof Video:
        // debug('Article Video');
        tpl('oe24.oe24.device.smartphone.tpl._content.article.tpl.articleVideo', array('article' => $article));
        break;

    case $article->isNewsTicker():
        tpl('oe24.oe24.device.smartphone.tpl._content.article.tpl.articleNewsticker', array('article' => $article));
        break;

    default:
        tpl('oe24.oe24.device.smartphone.tpl._content.article.tpl.articleDefault', array('article' => $article));
        break;
}

// (bs) 2017-09-08 DAILY-855
tpl('oe24.oe24.device.smartphone.assets.vendor.facebook.facebookReferrerTvTeaser');

