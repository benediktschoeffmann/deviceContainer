<?
/**
 * navigationMainJs
 */

// svn commit -m "DAILY-828" tpl/device/smartphone/tpl/_navigationMain/navigationMainJs.tpl tpl/device/smartphone/tpl/_urlsBottom.php tpl/device/smartphone/tpl/page.tpl

?>
<script>

;(function() {

    function toggleNavigationMain() {

        // var body  = document.querySelector('body');
        // var buttons = document.querySelectorAll('.headerNavButton a');

        // var classBody = body.className;
        // var classActive = 'navigationMainActive';

        // for (var i = buttons.length - 1; i >= 0; i--) {
        //     buttons[i].addEventListener('click', function(e) {
        //         e.preventDefault();
        //         if (body.classList.contains(classActive)) {
        //             body.className = classBody;
        //         } else {
        //             body.className = classBody + ' ' + classActive;
        //         }
        //         console.log(body.className);
        //     });
        // }

        var body  = document.querySelector('body');
        var button = document.querySelector('.headerNavButton a');

        var classBody = body.className;
        var classActive = 'navigationMainActive';

        button.addEventListener('click', function(e) {
            e.preventDefault();
            if (body.classList.contains(classActive)) {
                body.className = classBody;
            } else {
                body.className = classBody + ' ' + classActive;
            }
            console.log(body.className);
        });
    }

    console.log('toggleNavigationMain start');

    toggleNavigationMain();

    console.log('toggleNavigationMain end');

})();

</script>
