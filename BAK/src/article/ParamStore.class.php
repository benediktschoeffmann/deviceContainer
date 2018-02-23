<?php

class ParamStore {

    private $params = array();

    public function __construct($params = array()) {
        foreach ($params as $key => $value) {
            $this->params[$key] = $value;
        }
    }

    public function push($key, $value) {
        debug($key);
        debug($value);
        if (isset($this->params[$key])) {
            if (is_array($this->params[$key])) {
                $this->params[$key][] = $value;
                return $this->params[$key];
            }
        }

        $this->params[$key] = $value;

        return $this->params[$key] = $value;
    }

    public function pull($key) {
        if (isset($this->params[$key])) {
            return $this->params[$key];
        }
        if ($key === 'paramStore') {
            return $this;
        }
        return null;
    }
}
