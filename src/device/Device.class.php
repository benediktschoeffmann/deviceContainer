<?php

abstract class Device {
    const DESKTOP    = 'desktop';
    const OE24APP    = 'oe24app';
    const SMARTPHONE = 'smartphone';

    abstract public function getDeviceType();
}
