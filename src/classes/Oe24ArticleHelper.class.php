<?php

class Oe24ArticleHelper {

    static $instance = null;
    private $config = null;

    private function __construct() {
        $this->config = new spunQ_Map();
    }

    public function getInstance() {
        if (self::$instance == null) {
            self::$instance = new self();
        }
        return self::$instance;
    }

    public function createParams(array $keys) {
        $params = array();
        foreach ($keys as $key) {
            $params[$key] = $this->get($key);
        }
        return $params;
    }

    public function update(array $arr) {
        foreach ($arr as $key => $value) {
            $this->set($key, $value);
        }
    }

    protected function get($key) {
        return $this->config->get($key);
    }

    protected function set($key, $value) {
        return $this->config->add($key, $value);
    }

    protected function getAll() {
        return $this->config;
    }

}
