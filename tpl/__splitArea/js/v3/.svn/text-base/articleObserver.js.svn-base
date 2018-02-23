<?php
/**
 * @collector noauto
 */
?>

 // * @collector footerSplitArea

var articleOffsetHight = [];

;(function() {

    var ArticleObserver = function() {

        var article = document.querySelector('.a2016 .content.article');
        var sidebarContainer = document.querySelector('.a2016 .sidebar.article .sidebarContainer');

        if (null === article || null === sidebarContainer) {
            return;
        }

        var observer = new MutationObserver(function(mutations) {

            // Sollte man die einzelnen "Mutationen" bearbeiten wollen, dann auf folgende Art:
            // (ist hier auskommentiert, weil's im Moment nicht gebraucht wird)

            // mutations.forEach(function(mutation) {
            //     for (var i = 0; i < mutation.addedNodes.length; i++) {
            //         articleOffsetHight = article.offsetHeight;
            //         sidebarContainer.style.height = articleOffsetHight + 'px';
            //         // sidebarContainer.style.backgroundColor = '#5ad';
            //     }
            // });

            // Nach Abspielen eines OutstreamAd-Videos wird der OutstreamAd-Container per padding: 0
            // verkleinert, allerdings "smooth" per transition: padding .5s
            // Die Hoehe des Artikels sollte also nach einer gewisssen Verzoegerungszeit berechnent werden
            setTimeout(function() {
                articleOffsetHight = article.offsetHeight;
                sidebarContainer.style.height = articleOffsetHight + 'px';
                // sidebarContainer.style.backgroundColor = '#5ad';
            }, 600);
        });

        if (null === article || null === sidebarContainer) {
            return;
        }

        observer.observe(article, {
            childList: true,
            attributes: true,
            characterData: true,
            subtree: true
        });
    }

    new ArticleObserver();

})();
