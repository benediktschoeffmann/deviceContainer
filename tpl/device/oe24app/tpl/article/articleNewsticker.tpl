<?php
/**
 * Article Newsticker representation
 * @var portal       oe24.core.Portal
 * @var article      oe24.core.TextualContent
 * @var device       any
 * @var layout       string
 */

try {
  $bodyText = TextualProcessor::getProcessedBodyText($article, $portal, $layout);
} catch (Exception $e) {
  $bodyText = $article->getBodyText();
  // $bodyText = preg_replace('/<spunQ:(.)*\/>/m', '', $bodyText);
  error('oe24app, article.tpl: there is a problem extracting spunqTags in article '. $article->getId());
}

$searchTag = 'script async defer src="//platform.instagram.com/';
$replaceTag = 'script async defer src="https://platform.instagram.com/';

$bodyText = str_replace($searchTag, $replaceTag, $bodyText);

// filter out non-printable characters
$bodyText = preg_replace("/[^[:print:] | ^[öäüÖÄÜß]]/u", "", $bodyText);

$textSections = $article->getTextSections();
$articleUrl = $article->getUrl();
$dataNumPosts = 5;
$dataColorscheme = 'light';
?>

<body>
  <body>
    <script>
    window.addEventListener('message', function (e) {
      if (e && (e.origin == "http://www.oe24.at") && e.data && Array.isArray(e.data) && (e.data[0] != 'undefined') && (e.data[1] != 'undefined') && (e.data[0] == 'setHeight')) {
            var height = parseInt(e.data[1]);
            var frameName = 'fbCommentFrame';
            if (e.data[2] != 'undefined') {
                frameName = e.data[2];
            }

            var frame = document.getElementById(frameName);

            if (frame) {
                var currentFrameHeight = window.getComputedStyle(frame, null).getPropertyValue('height');
                var cssHeight = (height).toString() + 'px';
                if (currentFrameHeight != cssHeight) {
                    frame.style.height = cssHeight;
                }
            }
      }
    }, false);
</script>
<div id="fb-root"></div>
<script>
    window.fbAsyncInit = function() {
        FB.init({
          appId            : '203583476343648',
          autoLogAppEvents : true,
          xfbml            : true,
          version          : 'v2.11'
        });
        FB.AppEvents.logPageView();
      };
    (function(d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s); js.id = id;
        js.src = 'https://connect.facebook.net/de_DE/sdk.js#xfbml=1&version=v2.11';
        fjs.parentNode.insertBefore(js, fjs);
        }(document, 'script', 'facebook-jssdk')
    );
</script>
<div id="pageBodyTop" class="oe24app layout_oe24 articleBody">
    <div id="debug"></div>
    <div class="wrapper">
        <div class="contentContainer">
            <div class="container">
                <div class="articleBox articleDefault">
                    <div class="story">
                        <div class="storyBodyText">
                            <?= $bodyText; ?>
                        </div>

                        <div class="newsTickerWrapper">
                            <div class="buttonWrapper">
                                <div class="reloadButton defaultChannelBackgroundColor" onclick="window.location.reload();">
                                    Liveticker aktualisieren
                                </div>
                            </div>
                            <?
                                foreach ($textSections as $section) {
                                    tpl('oe24.oe24.device.smartphone.tpl._content.article.tpl.articleTextSection', array('section' => $section));
                                }
                            ?>
                        </div>

                        <?
                            tpl('oe24.oe24.device.oe24app.tpl.socialSharing.socialSharing', array(
                               'portal'  => $portal,
                               'article' => $article,
                               'device'  => $device,
                               'layout'  => $layout,
                                )
                            );
                        ?>

                       <!-- <div class="storyBottom">
                          <div class="OUTBRAIN" data-src="<?= $articleUrl; ?>" data-widget-id="APP_1" data-ob-template="AT_Oe24.at" ></div>
                        </div> -->

                    </div>
                </div>

            </div>
        </div>
    </div>

    <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
    <!-- <script async type="text/javascript" src="http://widgets.outbrain.com/outbrain.js"></script> -->
</div>
</body>
