<?php
/**
 * @var oe24Desktop any
 */
#$headerComponent = $oe24Desktop->getComponent(Component::HEADER);
#$navigationComponent = $oe24Desktop->getComponent(Component::NAVIGATION);
?>

<div class="headerNav">
    <?
    tpl('oe24.oe24.oe18.components.header.headerNavTop',
        array(
            'oe24Desktop'     => $oe24Desktop,
            'headerComponent' => $headerComponent,
            'navigationComponent' => $navigationComponent,
        )
    );
    ?>

    <div class="headerNavContainer">
        <?
        tpl('oe24.oe24.oe18.components.header.headerNavLogo',
            array(
                'oe24Desktop'     => $oe24Desktop,
                'headerComponent' => $headerComponent,
                'navigationComponent' => $navigationComponent,
            )
        );
        ?>

        <?
        // tpl('oe24.oe24.oe18.components.header.headerNavMain',
        //     array(
        //         'oe24Desktop'     => $oe24Desktop,
        //         'headerComponent' => $headerComponent,
        //         'navigationComponent' => $navigationComponent,
        //     )
        // );
        ?>
    </div>

    <?
    tpl('oe24.oe24.oe18.components.header.headerThemenDerWoche',
        array(
            'oe24Desktop'     => $oe24Desktop,
            'headerComponent' => $headerComponent,
        )
    );
    ?>

    <?
    tpl('oe24.oe24.oe18.components.header.headerSocial',
        array(
            'oe24Desktop'     => $oe24Desktop,
            'headerComponent' => $headerComponent,
        )
    );
    ?>



</div>
