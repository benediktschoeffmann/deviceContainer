<?php

class DefaultNavigation extends Navigation implements INavigation {

    private $topNavigation;
    private $mainNavigation;
    private $footerNavigation;

    private $homeLink;

    public function __construct($layout, Portal $portal, Channel $channel) {
        $this->prepareNavigation($layout, $portal, $channel);
    }

    public function getNavigationItems($position) {
        switch ($position) {
            case Navigation::TOP :
                return $this->getTopNavigationItems();
                break;
            case Navigation::MAIN :
                return $this->getMainNavigationItems();
                break;
            case NAVIGATION::FOOTER :
                return $this->getFooterNavigationItems();
                break;
            default:
                throw new Exception("Could not find Navigation Position `$position´ ");
        }
    }

    public function getHomeLink() {
        return $this->homeLink;
    }

    // ---------------------------------------------------------------------------------

    private function getTopNavigationItems() {
        return $this->topNavigation;
    }

    private function getMainNavigationItems() {
        return $this->mainNavigation;
    }

    private function getFooterNavigationItems() {
        return $this->footerNavigation;
    }

    private function prepareNavigation($layout, Portal $portal, Channel $channel) {
        $navigationItemsConfig = array(
            'header' => array(
                'top'   => 'top_2014',
                'tabs'  => 'tabs_2014',
                'menue' => 'main',
            ),
            'footer' => array(
                'footerSub1',
                'footerSub2',
                'footerSub3',
            )
        );

        $navigation = new Navigation($portal, $channel, $layout, $navigationItemsConfig);

        $tmp = $navigation->getHeaderNavigation(__FILE__);

        $this->topNavigation =  $tmp['top'];
        $this->mainNavigation = $tmp['menue'];

        $this->footerNavigation = $navigation->getFooterNavigation();

        $this->homeLink = $navigation->getImageUrl();
    }

}
