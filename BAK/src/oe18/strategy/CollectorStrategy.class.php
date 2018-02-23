<?php

class CollectorStrategy extends DefaultStrategy {

    public function getComponent($config) {

        if ($config['isArticle'] === true) {
            return new ArticleCollector($config);
        }

        return new ChannelCollector($config);
    }
}
