<?php

/**
 * Index Datei Desktop
 *
 * @var portal oe24.core.Portal
 * @var channel oe24.core.Channel
 * @var article any
 **/

$isArticle = ($article && $article instanceof TextualContent);
$options = ($isArticle)
                ? $article->getOptions(true, true)
                : $channel->getOptions(true, true);

