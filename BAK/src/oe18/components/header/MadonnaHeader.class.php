<?php

class MadonnaHeader extends Component implements IHeader {

    /**
     * @implements IHeader
     */
    public function getLogoUrl() {
        return lp('image', 'layout/antenne/logo_salzburg.jpg');
    }

    /**
     * @implements IHeader
     */
    public function getPortalText() {
        return '';
    }

    /**
     * @implements IHeader
     */
    public function hasWeatherInformation() {
        return false;
    }
}

