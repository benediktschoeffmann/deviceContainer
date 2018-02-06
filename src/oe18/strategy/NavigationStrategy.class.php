<?php

class NavigationStrategy extends DefaultStrategy {

    public function getComponent($config) {

        $layout = $config['layoutOverride'];
        $portal = $config['portal'];
        $channel = $config['channel'];

        $component = new DefaultNavigation($layout, $portal, $channel);

        return $component;
    }
}
