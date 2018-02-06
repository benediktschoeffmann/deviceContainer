<?php
class MetaStrategy implements IStrategy {
    public function getComponent($config) {
        $component = new DefaultMetaComponent($config);

        return $component;
    }
}
