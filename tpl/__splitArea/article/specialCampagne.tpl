<?
/**
* Artikel Spezial Kampagne
*
* @var channel oe24.core.Channel
* @var params array<any>
*/

?>

<script>

;(function() {

    // var articleHeadline = document.querySelectorAll('.article_box h1');
    var articleParagraphs = document.querySelectorAll('.article_box .article_body > p, .article_box .article_body > #cke_pastebin');

    // console.log(articleHeadline);
    // console.log(articleParagraphs);

    var articleText, innerTextList = [];

    for (var n = 0; n < articleParagraphs.length; n++) {
        innerTextList.push(articleParagraphs[n].innerText);
    }

    articleText = '***' + innerTextList.join('***') + '***';

    // console.log(articleText);

    // // Uebergabe an AdServer
    // adition.srq.push(function(api) {
    //     if (typeof articleText !== 'undefined') {
    //         // api.setProfile('articleText', articleText);
    //         // api.configureRenderSlot('testArticleText').setContentunitId(parseInt(adSlots[adSlot].id))
    //         // api.load().completeRendering();
    //         // console.log(api);
    //     }
    // });

})();

</script>

<? if (0): ?>
<div id="testArticleText">
    <script type="text/javascript">
        var adition = adition || {};
        adition.srq = adition.srq || [];
        adition.srq.push(function(api) {
            api.renderSlot("<?= $id; ?>");
        });
    </script>
</div>
<? endif; ?>
