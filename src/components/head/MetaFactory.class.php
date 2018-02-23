<?php

class MetaFactory {

    public static function createMeta($config) {

        switch ($config['deviceType']) {

            case Device::DESKTOP :
                if ($config['isArticle'] === true) {
                    return new ArticleMeta($config);
                }
                return new ChannelMeta($config);
                break;
            default:
                throw new Exception('MetaFactory::createMeta. ');
        }
    }
}
