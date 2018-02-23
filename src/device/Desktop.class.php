<?php

class Desktop extends Device {
    private static $instance = null;

    private function __construct() {}


    // ---------------------------------------------------


    public static function getInstance() {

        if (null === self::$instance) {
            self::$instance = new Desktop();
        }

        return self::$instance;
    }

    public function init($config = array()) {

        $this->config = $config;
        $tplAnnotationFromConfig = $this->getConfig('tplAnnotation');
        $this->tplAnnotation = ($tplAnnotationFromConfig) ? $tplAnnotationFromConfig.'Tpl' : null;

        $this->prepareComponents();
    }

    private function prepareComponents() {

    }


    /**
     * Set a config value
     * @param string  $key
     * @param any     $value
     * @param boolean $override
     */
    public function setConfig($key, $value, $override = true) {

        if ($override) {
            $this->config[$key] = $value;
            return true;
        } elseif (!isset($this->config[$key])) {
            $this->config[$key] = $value;
            return true;
        } else {
            return false;
        }
    }

    /**
     * Retrieves a Config Value
     * @param  [type] $key [description]
     * @return the value or null
     */
    public function getConfig($key = null) {
        if (null == $key) {
            return $this->config;
        }

        if (isset($this->config[$key])) {
            return $this->config[$key];
        } else {
            return null;
        }
    }

    /**
     * Returns Device::DESKTOP
     * @return Device::DESKTOP
     */
    public function getDeviceType() {
        return Device::DESKTOP;
    }
}
