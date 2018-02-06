<?
/**
 * chartbeat
 */

$device = DeviceContainer::getDevice();

$channel = $device->getConfig('channel');
$article = $device->getConfig('article');
$object = ($article) ? $article : $channel;

$options = $object->getOptions(true, true);
?>

<!-- BEGIN ChartBeat -->
<?
    $canonicalUrl = ($article instanceof TextualContent)
        ? stripDomainFromString($article->getUrl())
        : stripDomainFromString($channel->getUrl()).'/';

    $channelDomain = (null === $channel->getDomain(true))
        ? "oe24.at"
        : $channel->getDomain(true);
        if ($options->get('layoutOverride') === 'business'){
            $channelDomain = 'businesslive.at';
        } 
?>
<script type='text/javascript'>

    var _sf_async_config = {};

    /** CONFIGURATION START **/
    _sf_async_config.uid = 57858;
    _sf_async_config.domain = '<?= $channelDomain; ?>';
    _sf_async_config.useCanonical = true;
    _sf_async_config.sections = '<?= $channel->getName(); ?>';
    _sf_async_config.path = '<?= $channelDomain . $canonicalUrl; ?>';

<?
    // JAVASCRIPT-CODE
    // _sf_async_config.title = ''; // angedacht war "TITEL - ARTIKEL-ID"
    // _sf_async_config.authors = 'Change this to your Author name';    //CHANGE THIS
?>

    /** CONFIGURATION END **/
    (function(){
        function loadChartbeat() {
            window._sf_endpt = (new Date()).getTime();
            var e = document.createElement('script');
            e.setAttribute('language', 'javascript');
            e.setAttribute('type', 'text/javascript');
            e.setAttribute('src', '//static.chartbeat.com/js/chartbeat_video.js');
            document.body.appendChild(e);
        }
        var oldonload = window.onload;
        window.onload = (typeof window.onload != 'function')
            ? loadChartbeat
            : function() { oldonload(); loadChartbeat(); };
    })();
</script>
<!-- END ChartBeat -->
