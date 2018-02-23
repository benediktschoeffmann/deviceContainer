<?php
/**
 * @collector noauto
 */
?>

// /Volumes/www/oe24_oe24/page/slideShowVoting.page
// * @url /_slideShowVoting/(?<slideshowId>.*)/(?<votings>.*)
// * @url /_slideShowVoting/(?<slideshowId>.*)/(?<votings>.*)/(?<voter>.*)
// debug($slideshowId);
// debug($votings);
// debug($voter);
// 2017-10-30 12:10:43: [  DEBUG  ] oe24.oe24.slideShowVoting.page:require() [15]: 161624401
// 2017-10-30 12:10:43: [  DEBUG  ] oe24.oe24.slideShowVoting.page:require() [16]: 161624405;jsOption1|161624423;jsOption2|161624426;jsOption3
// 2017-10-30 12:10:43: [  DEBUG  ] oe24.oe24.slideShowVoting.page:require() [17]: a|b|c

;(function() {

    "use strict";

    var SlideshowVoting = function(container) {

        var temp;

        // ------------------------

        // Status, ob schon abgestimmt wurde
        this.hasAlreadyVoted = false;

        // ------------------------

        this.votingContainer = container.querySelector('.votingContainer');
        this.modalContainer  = container.querySelector('.modalContainer');
        this.hintContainer   = container.querySelector('.hintContainer');

        // ------------------------

        this.votingOptions = container.dataset.votingOptions;
        this.votingOptions = JSON.parse(this.votingOptions);

        // ------------------------

        // Voting-Buttons NodeList
        temp = this.votingContainer.querySelectorAll('.votingButton');

        // Voting-Buttons Array
        this.votingButtons = Array.prototype.slice.call(temp, 0);

        // ------------------------

        // Play-Buttons NodeList
        temp = this.votingContainer.querySelectorAll('.playButton');

        // Play-Buttons Array
        this.playButtons = Array.prototype.slice.call(temp, 0);

        // ------------------------

        this.modalButtonSubmit = this.modalContainer && this.modalContainer.querySelector('.modalButtonSubmit');
        this.modalButtonCancel = this.modalContainer && this.modalContainer.querySelector('.modalButtonCancel');
        this.hintButtonClose   = this.hintContainer  && this.hintContainer.querySelector('.hintButtonClose');

        // ------------------------

        // console.log(this.votingOptions.showCompetiton, this.votingOptions.competitionUrl);

        // ------------------------

        this.init();
    }

    SlideshowVoting.prototype.init = function() {

        var that = this;

        this.votingContainer && this.votingContainer.addEventListener('click', function(event) {

            var temp, columnPosition, activeVotingButtons, position;

            position = that.votingButtons.indexOf(event.target);

            if (position < 0) {
                // Es wurde keiner der Voting-Buttons geklickt
                return;
            }

            if (that.hasAlreadyVoted) {
                // Falls nur einmal abgestimmt werden soll, Kommentar vor den folgenden Zeilen entfernen
                that.hintContainer.querySelector('.' + that.votingOptions.classAlreadyVoted).classList.add('active');
                that.hintContainer.classList.add('active');
                return;
            }

            // ------------------------

            // https://developer.mozilla.org/de/docs/Web/API/Element/classList
            // if (event.target.classList.contains('disabled')) {
            //     return;
            // }

            // https://stackoverflow.com/questions/5898656/test-if-an-element-contains-a-class
            // Fuer alle Browser + aeltere Versionen
            if (that.hasClass(event.target, that.votingOptions.classNameDisabled)) {
                // Button ist disabled
                return;
            }

            // ------------------------

            // Spaltenposition des geklickten Buttons
            columnPosition = position % that.votingOptions.maxButtons;

            // ------------------------

            // Von Voting-Buttons wird die Markierung entfernt
            that.removeClassActiveFromSiblings(event.target);

            // In allen Voting-Buttons die Markierung suchen und gegebenenfalls entfernen
            that.removeClassActiveFromPosition(columnPosition);

            // ------------------------

            // Der angeklickte Voting-Button wird jetzt marktiert
            event.target.classList.add(that.votingOptions.classNameActive);

            // ------------------------

            // Wenn die Voting-Punkte vergeben sind, dann den modalen Dialog zeigen

            temp = that.votingContainer.querySelectorAll('.votingButton.' + that.votingOptions.classNameActive);
            that.activeVotingButtons = Array.prototype.slice.call(temp, 0);

            if (that.activeVotingButtons.length >= that.votingOptions.maxButtons) {
                // Modal-Container einblenden
                that.modalContainer && that.modalContainer.classList.add(that.votingOptions.classNameActive);
            }

            event.preventDefault();
        });

        // ------------------------

        this.modalButtonSubmit && this.modalButtonSubmit.addEventListener('click', function(event) {

            that.modalSubmit(that.activeVotingButtons);
            that.hasAlreadyVoted = true;

            that.modalReset();

            if (that.votingOptions.resetAlreadyVoted) {
                // Die ausgewaehlten Votings sollen zurueckgesetzt werden
                that.votingReset();
            }
        });

        this.modalButtonCancel && this.modalButtonCancel.addEventListener('click', function(event) {
            that.modalReset();
            that.votingReset();
        });

        // ------------------------

        this.hintButtonClose && this.hintButtonClose.addEventListener('click', function(event) {
            // Aktiven Text finden und ausblenden
            that.hintContainer.querySelector('.' + that.votingOptions.classNameActive).classList.remove(that.votingOptions.classNameActive);
            // Container ausblenden
            that.hintContainer.classList.remove(that.votingOptions.classNameActive);
        });
    }

    // --------------------------------------------------

    SlideshowVoting.prototype.modalReset = function() {

        var modalDataName    = this.modalContainer.querySelector('.modalDataName');
        var modalDataTelefon = this.modalContainer.querySelector('.modalDataTelefon');
        var modalDataEmail   = this.modalContainer.querySelector('.modalDataEmail');

        if (modalDataName !== null && modalDataTelefon !== null && modalDataEmail !== null) {
            // Eingabefelder zuruecksetzen
            modalDataName.value = '';
            modalDataTelefon.value = '';
            modalDataEmail.value = '';
        }

        // Modal-Container ausblenden
        this.modalContainer.classList.remove(this.votingOptions.classNameActive);
    };

    // --------------------------------------------------

    SlideshowVoting.prototype.votingReset = function() {

        // Alle Voting-Buttons zuruecksetzen
        this.votingButtons.forEach(function(element, index) {
            element.classList.remove(this.votingOptions.classNameActive);
        }, this);

        // Test, ob die active-Buttons zurueckgesetzt wurden
        // var temp = this.votingContainer.querySelectorAll('.votingButton.' + this.votingOptions.classNameActive);
        // console.log(temp);
    };

    // --------------------------------------------------

    SlideshowVoting.prototype.modalSubmit = function(activeVotingButtons) {

        var temp, votingUrl, votingData = [];

        var modalDataName    = this.modalContainer.querySelector('.modalDataName');
        var modalDataTelefon = this.modalContainer.querySelector('.modalDataTelefon');
        var modalDataEmail   = this.modalContainer.querySelector('.modalDataEmail');

        // Wenn das Eingabefeld zwar gueltig ist, also gezeigt wurde, aber keine Eingabe gemacht wurde ...
        modalDataName    = (null !== modalDataName && '' === modalDataName.value) ? null : modalDataName;
        modalDataTelefon = (null !== modalDataTelefon && '' === modalDataTelefon.value) ? null : modalDataTelefon;
        modalDataEmail   = (null !== modalDataEmail && '' === modalDataEmail.value) ? null : modalDataEmail;

        // ------------------------

        activeVotingButtons.forEach(function(element, index) {
            votingData.push(element.dataset.itemInfo);
        }, this);

        votingUrl = this.votingOptions.votingUrl + '/' + this.votingOptions.votingId + '/' + votingData.join('|');

        // ------------------------

        if (modalDataName !== null && modalDataTelefon !== null && modalDataEmail !== null) {
            temp = modalDataName.value + '|' + modalDataTelefon.value + '|' + modalDataEmail.value;
            // Telefonnummer wird gerne mit Slash geschrieben, beispielsweise 01/2367452.
            // Der Slash wuerde allerdings ein URL-Segment hinzufuegen!!!
            // Daher wird der Slash ersetzt durch ein Leerzeichen.
            // So ist die Telefonnummer für Redaktion/Marketing immer noch "lesbar"
            temp = temp.replace(/\//g, ' ');
            votingUrl += '/' + temp;
        }

        // ------------------------

        // Daten abschicken
        this.modalSend(votingUrl);
    };

    // --------------------------------------------------

    SlideshowVoting.prototype.modalSend = function(votingUrl) {

        var that = this;
        var xhttp = new XMLHttpRequest();

        xhttp.onreadystatechange = function() {
            that.modalResponse(that, this);
        };

        xhttp.open('GET', votingUrl, true);
        xhttp.send();
    }

    // --------------------------------------------------

    SlideshowVoting.prototype.modalResponse = function(that, xhttp) {

        // https://www.w3schools.com/js/js_ajax_http.asp
        // readyState  Holds the status of the XMLHttpRequest.
        //     0: request not initialized
        //     1: server connection established
        //     2: request received
        //     3: processing request
        //     4: request finished and response is ready

        // XMLHttpRequest.DONE = 4

        if (xhttp.readyState == XMLHttpRequest.DONE) {
            switch (xhttp.status) {
                case 200:
                    // OK
                    that.hintContainer.querySelector('.' + that.votingOptions.classThanksVoted).classList.add('active');
                    that.hintContainer.classList.add('active');
                    break;
                case 403:
                    // Forbidden
                    break;
                case 404:
                    // Not Found
                    break;
                default:
                    break;
            }
        }
    }

    // --------------------------------------------------

    SlideshowVoting.prototype.removeClassActiveFromSiblings = function(target) {

        var temp, siblings, selector, closestParent;

        selector = '.' + this.votingOptions.classVotingItem;
        closestParent = this.getClosest(target.parentNode, selector);

        temp = closestParent.querySelectorAll('.' + this.votingOptions.classNameButton);
        siblings = Array.prototype.slice.call(temp, 0);

        siblings.forEach(function(element, index) {
            element.classList.remove(this.votingOptions.classNameActive);
        }, this);
    };

    // --------------------------------------------------

    SlideshowVoting.prototype.removeClassActiveFromPosition = function(columnPosition) {

        // Die Voting-Buttons in einer bestimmten Spalte zuruecksetzen
        this.votingButtons.forEach(function(element, index) {
            if ((index % this.votingOptions.maxButtons) == columnPosition) {
                element.classList.remove(this.votingOptions.classNameActive);
            }
        }, this);
    };

    // --------------------------------------------------

    // https://gomakethings.com/climbing-up-and-down-the-dom-tree-with-vanilla-javascript/

    // // usage:
    // var elem = document.querySelector('#example');
    // var closestElem = getClosest(elem, '.sample-class');

    // // usage from parent on:
    // var elem = document.querySelector('#example');
    // var closestElem = getClosest(elem.parentNode, '#sample-id');

    /**
     * Get the closest matching element up the DOM tree.
     * @private
     * @param  {Element} elem     Starting element
     * @param  {String}  selector Selector to match against
     * @return {Boolean|Element}  Returns null if not match found
     */
    SlideshowVoting.prototype.getClosest = function(elem, selector) {

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

    SlideshowVoting.prototype.hasClass = function(element, searchClassName) {
        var pos = (' ' + element.className + ' ').indexOf(' ' + searchClassName + ' ');
        return  pos > -1;
    }

    // --------------------------------------------------
    // --------------------------------------------------


    var element, votingBox = document.querySelector('.votingBox');

    if (null !== votingBox && typeof votingBox === 'object') {
        element = new SlideshowVoting(votingBox);
    }


})();
