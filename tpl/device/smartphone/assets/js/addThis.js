<?php
/**
 * @collector noauto
 */
?>

var oe24AddThis = function() {

    (function (elementClass) {

        /* (bs) 2017-03-27 DAILY-711 Niki will in der App jetzt doch den add-This button haben. 
        if (isApp()) {
            return;
        }
        */ 

        var isArticle = document.getElementsByClassName('articleBox').length > 0;
        if (isArticle) {
            var head = document.getElementsByTagName("head")[0];
            var script = document.createElement("script");
            var footer = document.querySelector("footer.footer");

            script.type = 'text/javascript';
            script.onload = function () {
                var hasAddThis = document.getElementsByClassName("oe24AddThis").length > 0;
                if (hasAddThis) {
                    addthis.addEventListener("addthis.ready", function () {
                        var theDiv = document.getElementsByClassName(elementClass);
                        if (theDiv.length > 0 )  {
                            theDiv = theDiv[0];
                        }
                        theDiv.classList.add("loaded");
                        footer.style.marginBottom = "48px";
                    });
                }
            };

            script.src = "//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-5588330e86d91978";
            head.appendChild(script);
        }

    })("storySocialMedia");
}

functionQueue.add(oe24AddThis);

