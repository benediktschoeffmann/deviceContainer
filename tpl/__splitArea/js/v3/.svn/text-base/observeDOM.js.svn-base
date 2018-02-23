<?php
/**
 * @collector noauto
 * @collector footerSplitArea
 */
?>

// http://stackoverflow.com/questions/3219758/detect-changes-in-the-dom

var observeDOM = (function(){

    var MutationObserver = window.MutationObserver || window.WebKitMutationObserver,
        eventListenerSupported = window.addEventListener;

    return function(obj, callback) {
        if (MutationObserver) {
            // define a new observer
            var observer = new MutationObserver(function(mutations, observer) {
                if (mutations[0].addedNodes.length || mutations[0].removedNodes.length) {
                    callback();
                }
            });
            // have the observer observe foo for changes in children
            observer.observe( obj, {
                childList:true,
                subtree:true
            });
        }
        else if (eventListenerSupported) {
            obj.addEventListener('DOMNodeInserted', callback, false);
            obj.addEventListener('DOMNodeRemoved', callback, false);
        }
    }
})();
