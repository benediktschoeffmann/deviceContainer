<?php
/**
 * @collector noauto
 */
?>

// https://developer.mozilla.org/de/docs/Web/JavaScript/Reference/Global_Objects/String/Trim
if (!String.prototype.trim) {
    (function() {
        // Make sure we trim BOM and NBSP
        var rtrim = /^[\s\uFEFF\xA0]+|[\s\uFEFF\xA0]+$/g;
        String.prototype.trim = function() {
            return this.replace(rtrim, '');
        };
    })();
}

// // jQuery-2.1.3 line 7297 ff; modified
// function hasClass(element, selector) {
//     var rclass = /[\t\r\n\f]/g;
//     var className = " " + selector + " ";
//     if ( element.nodeType === 1 && (" " + element.className + " ").replace(rclass, " ").indexOf( className ) >= 0 ) {
//         return true;
//     }
//     return false;
// }


// https://modernweb.com/45-useful-javascript-tips-tricks-and-best-practices/
// String.prototype.trim = function(){return this.replace(/^s+|s+$/g, "");};

// ---------------------------------------------------------------------------------

function Utilities() {}

// Test if an element contains a class (modified (ws))
// http://stackoverflow.com/questions/5898656/test-if-an-element-contains-a-class
Utilities.hasClass = function(element, classToTest) {
    if (document.documentElement.classList) {
        return element.classList.contains(classToTest);
    } else {
        return (' ' + element.className + ' ').indexOf(' ' + classToTest + ' ') > -1;
    }
};

// https://modernweb.com/45-useful-javascript-tips-tricks-and-best-practices/
Utilities.isNumber = function(n) {
    return !isNaN(parseFloat(n)) && isFinite(n);
};

// https://modernweb.com/45-useful-javascript-tips-tricks-and-best-practices/
Utilities.isArray = function(obj) {
    return Object.prototype.toString.call(obj) === '[object Array]' ;
};

// ---------------------------------------------------------------------------------

Utilities.loadScript = function (src, callback) {

    if (typeof(callback) != 'function') {
        callback = null;
    }

    var s = document.createElement('script');
    s.type = 'text/javascript';

    s.onload = function() {
        if (callback) {
            callback();
        }
    };

    s.src = src;
    document.getElementsByTagName('head')[0].appendChild(s);
}

// ---------------------------------------------------------------------------------

// https://gomakethings.com/climbing-up-and-down-the-dom-tree-with-vanilla-javascript/

/**
 * Get the closest matching element up the DOM tree.
 * @private
 * @param  {Element} elem     Starting element
 * @param  {String}  selector Selector to match against
 * @return {Boolean|Element}  Returns null if not match found
 */
Utilities.getClosest = function ( elem, selector ) {

    // Element.matches() polyfill
    if (!Element.prototype.matches) {
        Element.prototype.matches =
            Element.prototype.matchesSelector ||
            Element.prototype.mozMatchesSelector ||
            Element.prototype.msMatchesSelector ||
            Element.prototype.oMatchesSelector ||
            Element.prototype.webkitMatchesSelector ||
            function(s) {
                var matches = (this.document || this.ownerDocument).querySelectorAll(s),
                    i = matches.length;
                while (--i >= 0 && matches.item(i) !== this) {}
                return i > -1;
            };
    }

    // Get closest match
    for ( ; elem && elem !== document; elem = elem.parentNode ) {
        if ( elem.matches( selector ) ) return elem;
    }

    return null;
};

// ---------------------------------------------------------------------------------

// https://github.com/jfriend00/docReady/blob/master/docready.js
(function(funcName, baseObj) {
    "use strict";
    // The public function name defaults to window.docReady
    // but you can modify the last line of this function to pass in a different object or method name
    // if you want to put them in a different namespace and those will be used instead of
    // window.docReady(...)
    funcName = funcName || "docReady";
    baseObj = baseObj || window;
    var readyList = [];
    var readyFired = false;
    var readyEventHandlersInstalled = false;

    // call this when the document is ready
    // this function protects itself against being called more than once
    function ready() {
        if (!readyFired) {
            // this must be set to true before we start calling callbacks
            readyFired = true;
            for (var i = 0; i < readyList.length; i++) {
                // if a callback here happens to add new ready handlers,
                // the docReady() function will see that it already fired
                // and will schedule the callback to run right after
                // this event loop finishes so all handlers will still execute
                // in order and no new ones will be added to the readyList
                // while we are processing the list
                readyList[i].fn.call(window, readyList[i].ctx);
            }
            // allow any closures held by these functions to free
            readyList = [];
        }
    }

    function readyStateChange() {
        if ( document.readyState === "complete" ) {
            ready();
        }
    }

    // This is the one public interface
    // docReady(fn, context);
    // the context argument is optional - if present, it will be passed
    // as an argument to the callback
    baseObj[funcName] = function(callback, context) {
        if (typeof callback !== "function") {
            throw new TypeError("callback for docReady(fn) must be a function");
        }
        // if ready has already fired, then just schedule the callback
        // to fire asynchronously, but right away
        if (readyFired) {
            setTimeout(function() {callback(context);}, 1);
            return;
        } else {
            // add the function and context to the list
            readyList.push({fn: callback, ctx: context});
        }
        // if document already ready to go, schedule the ready function to run
        // IE only safe when readyState is "complete", others safe when readyState is "interactive"
        if (document.readyState === "complete" || (!document.attachEvent && document.readyState === "interactive")) {
            setTimeout(ready, 1);
        } else if (!readyEventHandlersInstalled) {
            // otherwise if we don't have event handlers installed, install them
            if (document.addEventListener) {
                // first choice is DOMContentLoaded event
                document.addEventListener("DOMContentLoaded", ready, false);
                // backup is window load event
                window.addEventListener("load", ready, false);
            } else {
                // must be IE
                document.attachEvent("onreadystatechange", readyStateChange);
                window.attachEvent("onload", ready);
            }
            readyEventHandlersInstalled = true;
        }
    };
})("docReady", Utilities);
// modify this previous line to pass in your own method name
// and object for the method to be attached to

// ---------------------------------------------------------------------------------
