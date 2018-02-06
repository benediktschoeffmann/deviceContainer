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

            case 'smartphone':
                $device = Smartphone::getInstance();
                $device->init($config);
                break;

            case 'oe24app':
                $device = Oe24App::getInstance();
                $device->init($config);
                break;

            // case 'mobile2017':
            //     break;

            // case 'app':
            //     break;


            default:
                throw new DeviceInitialisationException('Unrecognized device type' . $config['deviceType']);
                break;
        }

        return $device;
    }
}
