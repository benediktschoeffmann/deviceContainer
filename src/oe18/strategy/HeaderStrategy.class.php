<?php

class HeaderStrategy extends DefaultStrategy {

    public function getComponent($config) {
        $component = parent::getComponent($config, 'header');

        $isWM = false;
        if ($config['layoutOverride'] === 'sport' && $isWM) {
            /// ...
        }

        return $component;
    }
}
