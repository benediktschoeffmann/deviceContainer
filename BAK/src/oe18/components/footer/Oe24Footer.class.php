<?php

class Oe24Footer extends Component implements IFooter {
    private $config;
    private $collector;

    public function __construct($config) {
        $this->config = &$config;
    }

    public function getFooterNavigation() {
        $oe24Desktop = $this->config['oe24Desktop'];
        $navigation = $oe24Desktop->getComponent(Component::NAVIGATION);

        return $navigation->getNavigationItems('footer');
    }


}
