<?
/**
 *  Oe24 App Initialisierungs Template
 *
 * @var params array<any>
 * @default params 0
 * @nodevmodecomments
 */


$isDev = spunQ::inMode(spunQ::MODE_DEVELOPMENT);

$emptyImage1x1   = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABAQAAAAA3bvkkAAAAAnRSTlMAAQGU/a4AAAAKSURBVHgBY2gAAACCAIFMF9ffAAAAAElFTkSuQmCC';
$emptyImage2x1   = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAIAAAABAQAAAADcWUInAAAAAnRSTlMAAQGU/a4AAAAKSURBVHgBYzgAAADCAMFphPI4AAAAAElFTkSuQmCC';
$emptyImage16x9  = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAJAQAAAAATUZGfAAAAAnRSTlMAAQGU/a4AAAANSURBVHgBY/j/HxcCAPIoEe+JMKgiAAAAAElFTkSuQmCC';
$emptyImage16x10 = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAKAQAAAACVxeMxAAAAAnRSTlMAAQGU/a4AAAANSURBVHgBY/j/Hw8CACsBE+1t+fJZAAAAAElFTkSuQmCC';


/* Konfiguration laden */
$appDir = realpath(dirname(__FILE__));
$confFilename = $appDir . '/categories.conf';
$appConf = spunQ_SectionedConfigFile::get($confFilename)->create();

$keyPrefix      = 'oe24app.'. (($isDev) ? 'dev' : 'prod');

/* Keys Bestimmen */
$nameKey        = $keyPrefix . '.categories.name';
$idKey          = $keyPrefix . '.categories.id';
$oewaKey        = $keyPrefix . '.categories.oewa';

$maxArticlesContentBoxKey = $keyPrefix . '.const.contentBox.maxArticles';
$maxArticlesConsoleBoxKey = $keyPrefix . '.const.consoleBox.maxArticles';
$maxArticlesCollectionKey = $keyPrefix . '.const.collection.maxArticles';
$maxBoxesKey              = $keyPrefix . '.const.maxBoxes';
$maxBoxesFrontpageKey     = $keyPrefix . '.const.maxBoxesFrontpage';
$maxBoxesSpecialKey       = $keyPrefix . '.const.maxBoxesSpecial';
$livestreamKey            = $keyPrefix . '.livestream.id';

$collectionNameKey = $keyPrefix .'.collections.name';
$collectionIdsKey  = $keyPrefix .'.collections.id';

/* ---------- */
$categoryNames     = array();
$categoryIds       = array();
$categoryOewaPaths = array();

$collectionNames   = array();
$collectionIds     = array();
$maxBoxesSpecial   = array();

/* Werte für die Keys laden */
$categoryNames     = $appConf->getMultipleStringValues($nameKey);
$categoryIds       = $appConf->getMultipleStringValues($idKey);
$categoryOewaPaths = $appConf->getMultipleStringValues($oewaKey);

$collectionNames   = $appConf->getMultipleStringValues($collectionNameKey);
$collectionIds     = $appConf->getMultipleStringValues($collectionIdsKey);
$maxBoxesSpecial   = $appConf->getMultipleStringValues($maxBoxesSpecialKey);

$categories = array();
foreach ($categoryNames as $key => $name) {
    $categories[] = array(
        'name'  => $name,
        'id'    => $categoryIds[$key],
        'oewa'  => $categoryOewaPaths[$key],
    );
}

$collections = array();
foreach ($collectionNames as $key => $name) {
    $collections[] = array(
        'name'  => $name,
        'id'    => $collectionIds[$key]
        );
}
/* ---------- */

$adStrings = $appConf->getStringsForPrefix('oe24app.ads');
$interstitial = $appConf->getStringValue('oe24app.interstitial.id');

$maxArticlesContentBox = $appConf->getStringValue($maxArticlesContentBoxKey, 5);
$maxArticlesConsoleBox = $appConf->getStringValue($maxArticlesConsoleBoxKey, 10);
$maxArticlesCollection = $appConf->getStringValue($maxArticlesCollectionKey, 10);
$maxBoxes              = $appConf->getStringValue($maxBoxesKey, 10);
$maxBoxesFrontpage     = $appConf->getStringValue($maxBoxesFrontpageKey, 30);
$livestreamId          = $appConf->getStringValue($livestreamKey);


$impressum = $appConf->getStringValue('oe24app.links.impressum');
$ePaperUrl = $appConf->getStringValue('oe24app.links.ePaper');


$deviceType = 'oe24app';
$emtpyImages = array(
    'emptyImage1x1' => 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABAQAAAAA3bvkkAAAAAnRSTlMAAQGU/a4AAAAKSURBVHgBY2gAAACCAIFMF9ffAAAAAElFTkSuQmCC'
    );

$config = array(
    'deviceType'     => $deviceType,
    'isDev'          => $isDev,

    'categories'     => $categories,
    'collections'    => $collections,
    'validColumn'    => 'Split Area 2016',

    'defaultOewaTag' => 'RedCont/Nachrichten/Nachrichtenueberblick/moewa',

    'maxArticlesContentBox'   => $maxArticlesContentBox,
    'maxArticlesConsoleBox'   => $maxArticlesConsoleBox,
    'maxArticlesCollection'   => $maxArticlesCollection,
    'maxBoxes'                => $maxBoxes,
    'maxBoxesFrontpage'       => $maxBoxesFrontpage,
    'maxBoxesSpecial'         => $maxBoxesSpecial,
    'livestreamId'            => $livestreamId,

    'ids'           => $params['ids'],

    'impressum'     => $impressum,
    'ePaperUrl'     => $ePaperUrl,

    'adStrings'     => $adStrings,
    'interstitial'  => $interstitial,

    'emptyImages'     => array(
        'emptyImage1x1'   => $emptyImage1x1,
    //     'emptyImage2x1'   => $emptyImage2x1,
    //     'emptyImage16x9'  => $emptyImage16x9,
    //     'emptyImage16x10' => $emptyImage16x10,
    ),

);

try {

    $deviceContainer = DeviceContainer::initialize($config);
    $device = DeviceContainer::getDevice();
    $device->processDevice();
    // $device->start();

} catch (DeviceInitialisationException $e) {

    error('DeviceInitialisationException in `'.$e->getFile().' Zeile '.$e->getLine().'` wurde ausgeloest: `'.$e->getMessage().'`');
    return;
}
// } catch (Exception $e) {

//     error('Allgemeine Exception in `'.$e->getFile().' Zeile '.$e->getLine().'` wurde ausgeloest: `'.$e->getMessage().'`');
//     return;
// }

return;
