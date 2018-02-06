<?

/**
 * use smartphone dir
 * @return boolean true || false
 * @author ws
 **/

// page/mobile/article/amp_index.page
// page/mobile/article/index.page
// page/mobile/channel/index.page
// page/mobile/slideshow.page

function useSmartPhoneDir($channel) {

    // (db) 2017-02-14 mobile - version2017 - backup um alte version sehen zu können

    // alte mobile Version
    // $useSmartPhoneDir = (isset($_GET['smartphone'])) ? true : false;

    // MOB2017-1 Version
    $useSmartPhoneDir = (isset($_GET['smartphone'])) ? false : true;

    // -----------------------------------------------------------------------------------

    $channelOptions = $channel->getOptions(true, true);

    $layout = $channelOptions->get('layoutOverride');
    $layout = ($layout) ? $layout : 'oe24';

    $useSplitArea = $channelOptions->get('useSplitArea');
    $useSplitArea = ($useSplitArea) ? true : false;

    $useNewLayout = ('oe2016' === $channelOptions->get('useNewLayout'));
    $useNewLayout = ($useNewLayout) ? true : false;

    // Folgende Channels sollen im MOB2017-1 Design dargestellt werden

    $validSmartphoneLayouts = array(
        'oe24',
        'society',
        'sport',
        'reise',
        // 'money',
        'gesund24',
        'cooking24',
        'madonna',
        'tv',
        'business',
        'games24',
    );

    $useSmartPhoneDir = (true == $useSmartPhoneDir && (in_array($layout, $validSmartphoneLayouts) && $useSplitArea && $useNewLayout));

    //
    $useSmartPhoneDir = $useSmartPhoneDir || (!in_array($layout, $validSmartphoneLayouts) && (isset($_GET['smartphone'])));

    return $useSmartPhoneDir;
}
