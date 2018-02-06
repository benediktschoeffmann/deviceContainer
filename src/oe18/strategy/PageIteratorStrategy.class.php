<?php

class PageIteratorStrategy implements IStrategy {

    public function getComponent($config) {

        if ($config['isArticle']) {
            $component = new ChannelIteratorComponent($config);
        } else {
            $component = new ArticleIteratorComponent($config);
        }

        return $component;
    }
}
