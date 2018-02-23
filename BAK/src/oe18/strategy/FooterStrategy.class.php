<?php

class FooterStrategy implements IStrategy {

    public function getComponent($config) {
        // switch ($config['layoutOverride']) {
        //     case 'antenne' :
        //     case 'antenne_wien' :
        //         break;
        //     case 'spiele' :
        //         break;
        // }
        return new Oe24Footer($config);
    }

}
