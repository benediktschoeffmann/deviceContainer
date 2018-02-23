<?php
/**
 * @var channel oe24.core.Channel
 * @var content any
 */


$channelOptions = $channel->getOptions(true, true);

if ($content instanceof Content) {
    $contentOptions = $content->getOptions(true, true);
} else {
    $content = null;
}


debug($content && ($content instanceof TextualContent));

$layoutOverride = $channelOptions->get('layoutOverride');

$config = array(
    'layoutOverride' => $layoutOverride,
    'channel'        => $channel,
    'channelOptions' => $channelOptions,
    'content'        => $content,
    'contentOptions' => $channelOptions,
    'isArticle'      => ($content && ($content instanceof TextualContent)),
    'portal'         => Portal::getPortalByName('oe24', true),
);

/* Konfiguration laden */
$appDir = realpath(dirname(__FILE__));
$confFilename = $appDir . '/oe18.conf';
$appConf = spunQ_SectionedConfigFile::get($confFilename);

$confKey = 'oe18.'.$layoutOverride;
$confFromFile = $appConf->getStringsForPrefix($confKey);

debug($confFromFile);


$oe24Desktop = new Oe24Desktop($config);
#$oe24Desktop->setConfigFile($appConf);
$oe24Desktop->setStrategy(new MetaStrategy(), Component::META);
$oe24Desktop->setStrategy(new HeaderStrategy(), Component::HEADER);
$oe24Desktop->setStrategy(new CollectorStrategy(), Component::COLLECTOR);
$oe24Desktop->setStrategy(new NavigationStrategy(), Component::NAVIGATION);
# $oe24Desktop->setStrategy(new AdHandlerStrategy(), Component::ADHANDLER);
$oe24Desktop->setStrategy(new FooterStrategy(), Component::FOOTER);


debug('oe24desktop init done.');

tpl('oe24.oe24.oe18.page',
    array(
        'oe24Desktop' => $oe24Desktop
    )
);
