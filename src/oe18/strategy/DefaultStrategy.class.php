<?php

class DefaultStrategy implements IStrategy {

    public function getComponent($config, $componentName = 'header') {
        $layoutOverride = $config['layoutOverride'];

        $className = ucfirst($layoutOverride) . ucfirst($componentName);

        if (class_exists($className)) {
            return new $className($config);
        }

        $className = 'Oe24' . ucfirst($componentName);

        if (class_exists($className)) {
            return new $className($config);
        }

        throw new Exception("The class $className does not exist");
    }
}
