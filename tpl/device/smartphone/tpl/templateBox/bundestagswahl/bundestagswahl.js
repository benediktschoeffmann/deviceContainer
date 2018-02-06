<?php
/**
 * @collector noauto
 */
?>

;(function() {

    var myContainer = document.querySelector('.bundestagswahl');
    var myButton = document.querySelector('.bundestagswahlNavButton');

    if (myContainer != null) {
        var classMyContainer = myContainer.className;
        var classActive = 'bundestagswahlNavActive';

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
