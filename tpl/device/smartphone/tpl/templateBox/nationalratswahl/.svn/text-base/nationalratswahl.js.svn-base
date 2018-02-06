<?php
/**
 * @collector noauto
 */
?>

;(function() {

    var myContainer = document.querySelector('.nationalratswahl');
    var myButton = document.querySelector('.nationalratswahlNavButton');

    if (myContainer != null && myButton != null) {
        var classMyContainer = myContainer.className;
        var classActive = 'nationalratswahlActive';

        function toogleContainerClass(container, testClass) {
            var found = (' ' + container.className + ' ').indexOf(' ' + testClass + ' ') > -1;
            myContainer.className = (true === found) ? classMyContainer : classMyContainer + ' ' + classActive;
        };

        myButton.addEventListener('click', function(e) {
            e.preventDefault();
            toogleContainerClass(myContainer, classActive);
        });
    }

})();
