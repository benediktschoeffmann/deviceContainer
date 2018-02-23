<?php

class Oe24Desktop extends Component {
    private $strategies = array();
    private $components = array();
    private $config = array();
    private $configFile;


    public function __construct($config) {
        $this->config = $config;
        $this->config['Oe24Desktop'] = $this;
    }

    public function setStrategy(IStrategy $strategy, $componentName) {
        $this->strategies[$componentName] = $strategy;
    }

    public function getComponent($componentName) {
        if (isset($this->components[$componentName])) {
            return $this->components[$componentName];
        }

        if (isset($this->strategies[$componentName])) {
            $this->components[$componentName] = $this->strategies[$componentName]->getComponent($this->config);
        } else {
            $this->strategies[$componentName] = new DefaultStrategy($config, $componentName);
            $this->components[$componentName] = $this->strategies[$componentName]->getComponent($this->config);
        }
        return $this->components[$componentName];

        throw new Exception("No Strategy for Component: $componentName");
    }

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

    public function getConfig($key = null) {

        if (isset($this->config[$key])) {
            return $this->config[$key];
        } else {
            return $this->getConfigFromConfigFile($key);
        }
        return null;

    }

    private function getConfigFromConfigFile($key) {
        $value = $configFile->getStringValue($key);
        if ($value === null) {
            $key = $key . '.' . $this->getConfig('layoutOverride');
            $value = $configFile->getStringValue($key);
        }

        return $value;
    }

    public function setConfigFile($file) {
        $this->configFile = $file;
    }


}
