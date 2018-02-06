<?php

function isParamsTemplateLeftValid($templateName) {

    // -------------------------------------------
    // Einbindung von Dritt-Templates auf der Artikelseite
    // -------------------------------------------
    $validTemplates = array(
        'oe24.oe24.story.oldLayout.mailTo'          => 'oe24.oe24.__splitArea.story.mailto',
        'oe24.oe24.popup.mailTo'                    => 'oe24.oe24.__splitArea.story.slideShowMailTo',
        'oe24.oe24.search.index'                    => 'oe24.oe24.__splitArea.search.index',
        'oe24.oe24.__splitArea.user.user'           => 'oe24.oe24.__splitArea.user.user',
        'oe24.oe24.__splitArea.user.login'          => 'oe24.oe24.__splitArea.user.login',
        'oe24.oe24.__splitArea.user.lostPassword'   => 'oe24.oe24.__splitArea.user.lostPassword',
        'oe24.oe24.__splitArea.user.lostUsername'   => 'oe24.oe24.__splitArea.user.lostUsername',
        'oe24.oe24.__splitArea.user.changePass'     => 'oe24.oe24.__splitArea.user.changePass',
        'oe24.oe24.money.stock'                     => 'oe24.oe24.__splitArea.money.stock',
        'oe24.oe24.money.stocksearch'               => 'oe24.oe24.__splitArea.money.stocksearch',
        'oe24.oe24.__splitArea._page.channelTag'    => 'oe24.oe24.__splitArea._page.channelTag',

        // (bs) 2016-11-24 Video Suche
        'dummy.videoSearch'  => 'oe24.oe24._templateBoxes.oe24tvVideoSearch',
    );

    return (isset($validTemplates[$templateName]) && array_key_exists($templateName, $validTemplates))
            ? $validTemplates[$templateName]
            : null;

}
