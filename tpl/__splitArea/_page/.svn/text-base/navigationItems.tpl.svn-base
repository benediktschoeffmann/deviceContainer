<?php
/**
 * output navigation for specific types
 * @var portal oe24.core.Portal
 * @var channel oe24.core.Channel
 * @var type string
 * @var uri string
 */

$allNavigationItems = $portal->getNavigationItems();
if(!$allNavigationItems){
    return NULL;
}

# check navi items name match with url
$rootNaviItem = NULL;
$baseNaviItem = NULL;
foreach($allNavigationItems as $naviItem){
    $text = $naviItem->getLink()->getText();
    if($text == "/"){
        $rootNaviItem = $naviItem;
    }
    if(!$baseNaviItem && (preg_match("~^$text$|^$text/(.*?)$~i", $uri))){
        $baseNaviItem = $naviItem;
    }
}

# no base and/or root navi item found
if( (!$baseNaviItem && !$rootNaviItem) or !$rootNaviItem){
    return NULL;
}

# fill root navi items to have a fallback
$rootNaviItems = $rootNaviItem->getChildren();

# if only root navi item is found, take that
if(!$baseNaviItem){
    $baseNaviItem = $rootNaviItem;
}

# base/root navi item have no childrens
$baseNaviItems = $baseNaviItem->getChildren();
if(!$baseNaviItems){
    return NULL;
}

switch($type){

    case 'top_2014':
    case 'tabs_2014':
    case 'main_2014':

        $navigationItems = NavigationItem::getChildrensByTextName($baseNaviItems, $type);
        // debug($navigationItems);

        // fallback to root navigation
        if (empty($navigationItems)) {
            $navigationItems = NavigationItem::getChildrensByTextName($rootNaviItems, $type);
        }

        foreach ($navigationItems as $key => $item) {

            $class = '';

            if ($channel && $channel->getUrl() == $item->getLink()->toUrl()) {
                // debug($channel.', '.$type.', '.$channel->getUrl().', '.$item->getLink()->toUrl());
                $class = ' class="active"';
            }

            if($type == 'tabs_2014' && $class == ''){
                $channels = $channel->getParentChannels(true);
                foreach($channels as $chan){
                    if($chan->getUrl() == $item->getLink()->toUrl() && $chan->getName() != 'frontpage'){
                        $class = ' class="active"';
                    }
                }
            }

            if($type == 'main_2014' && $class == ''){
                $link = $item->getLink();
                $htmlLink = oe24link($link, __FILE__);
                if($link instanceOf ChannelLink){
                    $url = $link->getChannel()->getRawUrl();
                }else{
                    $url = str_replace(array('http://','https://'),'',strtolower($link->toUrl()));
                }
                if(strpos($url,'/sport/olympiacenter') !== false && (strpos(strtolower($channel->getRawUrl()), '/sport/olympia-2014/center') !== false || strpos(strtolower($channel->getRawUrl()), '/sport/olympia-2014') !== false)){
                    $class = ' class="active"';
                }elseif($url && (strpos(strtolower($channel->getRawUrl()), $url) !== false)){
                    $class = ' class="active"';
                }
            }

            $htmlLink = oe24link($item->getLink());
            echo '<li'.$class.'>'.$htmlLink.'</li'.$class.'>';
        }

        break;

    case 'sub_2014':

        $navigationItems = NavigationItem::getChildrensByTextName($baseNaviItems, 'main_2014');

        // fallback to root navigation
        if (empty($navigationItems)) {
            $navigationItems = NavigationItem::getChildrensByTextName($rootNaviItems, 'main_2014');
        }

        foreach ($navigationItems as $key => $item) {

            $children = $item->getChildren();

            if (empty($children)) {
                ?>
                <nav class="subnavi_container"><ul class="navi subchannel" style="xdisplay:none"><li></li></ul></nav>
                <?
                continue;
            }

            ?>
            <nav class="subnavi_container">
                <ul class="navi subchannel">
                    <?
                    foreach ($children as $subItem) {
                        $link = $subItem->getLink();
                        $htmlLink = oe24link($subItem->getLink(), __FILE__);
                        echo '<li>'.$htmlLink.'</li>';
                    }
                    ?>
                </ul>
            </nav>
            <?
        }
        break;
}
?>
