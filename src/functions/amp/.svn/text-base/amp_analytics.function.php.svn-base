<?

function amp_analytics($channel) {

    $cp = $channel->getOewaTag(true)->getUrlSchemaName();
    $cp .= '/moewa/AMP/';

    $ampAnalytics =
        '
        <amp-analytics type="oewa">
        <script type="application/json">
        {
            "vars": {
                "s": "oe24",
                "cp": "'.$cp.'"
            },
            "requests": {
                "url": "https://fbia.oe24.at/amp-analytics-oewa.html"
            }
        }
        </script>
        </amp-analytics>
        ';

    return $ampAnalytics;
}
