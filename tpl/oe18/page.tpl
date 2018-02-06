<?php
/**
 * @var oe24Desktop any
 */

?>
<!DOCTYPE html>
<html>
<head>
    <?
        tpl('oe24.oe24.oe18.components.head.meta', array(
            'oe24Desktop'       => $oe24Desktop
        ));

        tpl('oe24.oe24.oe18.components.head.collector', array(
            'oe24Desktop'       => $oe24Desktop
        ));
    ?>
</head>
<body>

    <? debug('page.tpl'); ?>

    <?
        tpl('oe24.oe24.oe18.components.header.header', array(
            'oe24Desktop'       => $oe24Desktop
        ));
    ?>
    <!-- CONTAINER -->
    <?
        tpl('oe24.oe24.oe18.components.footer.footer', array(
            'oe24Desktop'       => $oe24Desktop
        ));

    ?>


    <? debug('page.tpl end '); ?>
</body>
</html>
