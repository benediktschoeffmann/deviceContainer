<?

function getChannelColor($key) {

    $filename = realpath(dirname(__FILE__).'/..').'/channelColors/channelColors.php';

    if (!is_readable($filename)) {
        return null;
    }

    include $filename;

    return (isset($channelColors[$key])) ? $channelColors[$key]['colorLeft'] : null;
}

function getBusinessChannelColor($key) {

    $filename = realpath(dirname(__FILE__).'/..').'/channelColors/businessChannelColors.php';

    if (!is_readable($filename)) {
        return null;
    }

    include $filename;

    return (isset($channelColors[$key])) ? $channelColors[$key]['colorLeft'] : null;

}
