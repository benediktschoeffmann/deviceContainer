<?php

class Oe24Header extends AbstractHeader implements IHeader {
    private $config;
    private $weatherId;

    // private $weatherJSON;

    public function __construct($config) {
        $this->config       = &$config;
        // TODO: FIXME
        // $this->weatherId    = $this->config['options']->get('weatherId');
        $this->weatherId = '123';
    }

    /**
     * @implements IHeader
     */
    public function getLogoUrl() {
        return lp('image', 'oe2016/logo-oe24.svg');
    }

    /**
     * @implements IHeader
     */
    public function getLogoLink() {
        return 'http://www.oe24.at';
    }

    /**
     * @implements IHeader
     */
    public function getPortalText() {
        return 'Das Internet-Portal von';
    }

    /**
     * @implements IHeader
     */
    public function hasWeatherInformation() {
        return true;
    }

    public function getWeatherJson() {
        $showWeather = false;
        $weatherDomain = 'http://www.wetter.at';
        $weatherJson = array();

        if(!empty($this->weatherId)) {
            $requestString = $weatherDomain . '/json/weatherData?id='.$weatherId.'&f=0';
            $weatherJson = jsonCache::getjsonData($requestString, null, true);

            if(!empty($weatherJson) &&
                isset($weatherJson['places']) &&
                isset($weatherJson['places'][0]) &&
                isset($weatherJson['places'][0]['name']) &&
                isset($weatherJson['places'][0]['icon']) &&
                isset($weatherJson['places'][0]['temp'])) {

                    // TODO: ??????
                    $rc = array_walk($weatherJson['places'], function(&$item){
                        unset($item['iconLink']);
                    });
                    $showWeather = true;
            } else {
                $showWeather = false;
                $weatherJson = array();
            }
        }
    }
}

