<?php

class DeviceFactory {

    private static $instance = null;

    private function __construct() {}

    static function getInstance() {

        if (null === self::$instance) {
            self::$instance = new self();
        }

        return self::$instance;
    }

    function createDevice($config = array()) {
        // debug('DeviceFactory :: create');
        if (!isset($config['deviceType'])) {
            throw new DeviceInitialisationException('Device type not set');
        }

        $device = null;

        switch ($config['deviceType']) {

            case Device::SMARTPHONE:
                $device = Smartphone::getInstance();

                break;

            case Device::OE24APP:
                $device = Oe24App::getInstance();

                break;

            case Device::DESKTOP:
                $device = Desktop::getInstance();

                break;

            default:
                throw new DeviceInitialisationException('Unrecognized device type' . $config['deviceType']);
                break;
        }

        $device->init($config);

        return $device;
    }
}
