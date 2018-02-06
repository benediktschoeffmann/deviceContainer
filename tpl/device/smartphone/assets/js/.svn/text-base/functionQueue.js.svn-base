<?php
/**
 * @collector noauto
 */
?>

"use strict";

var FunctionQueue = function(reverse) {

    if (typeof reverse == "undefined") {
        this.reverse = false;
    } else {
        this.reverse = true;
    }

    this.queue = new Array();
    this.elements = 0;
};

FunctionQueue.prototype = {

    add : function(functionObject) {
        this.queue.push(functionObject);
        this.elements++;
    },

    run : function() {
        // console.log('Function Queue runs');
        if (typeof(this.onStart) == "function") {
            this.onStart();
        }

        var i = 0;
        while (i < this.elements) {
            var func = (this.reverse == true) ? this.queue.pop() : this.queue.shift();
            func.call();
            i++;
        }

        if (typeof(this.onEnd) == "function") {
            this.onEnd();
        }
    }
};
