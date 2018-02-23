<?php

class DeviceContainer {

    static private $device   = null;
    static private $instance = null;

    private function __construct() {}

    public static function initialize($config = array()) {
        // debug('DeviceContainer :: initialize');
        self::$instance = new self();

        $deviceFactory  = DeviceFactory::getInstance();
        self::$device   = $deviceFactory->createDevice($config);

        if (self::$device) {
            return self::$instance;
        }

        throw new DeviceInitialisationException('Device initialisation failed. \n config is ' . $config);
    }

    /**
    @return Device
    */
    // public static function getDevice() {

    //     if (self::$device) {
    //         return self::$device;
    //     }

    //     throw new DeviceInitialisationException('Device not yet initialized');
    // }

    public static function getDevice($deviceType = null) {

        if (self::$device) {
            if ((self::$device && $deviceType === null) ||
                (self::$device && self::$device->getDeviceType() === $deviceType)) {

                return self::$device;

            } else {

                throw new DeviceInitialisationException('Wrong device type requested: ' . $deviceType);

            }

        }

        throw new DeviceInitialisationException('Device not yet initialized');
    }
}
