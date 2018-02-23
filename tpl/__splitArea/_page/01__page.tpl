<?php

/**
 * main page template for splitArea mode.
 *
 * @var portal oe24.core.Portal
 * @var channel oe24.core.Channel
 * @var object any
 * @default object 0
 * @var params array<any>
 */

// -------------------------------------------

// ***** GET OPTIONS ETC. *****
$isArticle = ($object && $object instanceof TextualContent);
$useNewCollector = true;
$channelOptions = $channel->getOptions(true, true);

// da kann entweder null oder oe2016 drinstehen
$useNewLayout = $channelOptions->get('useNewLayout');

// wenn der Get-Parameter 'useSplitArea' mitkommt, soll auf jeden Fall das Oe2016-Layout gestartet werden.
$useSplitArea = request()->getGetValue('useSplitArea');
$useNewLayout = ($useSplitArea !== null) ? $useSplitArea : $useNewLayout;

$layout = $channelOptions->get('layoutOverride');
$layout = ($layout !== null) ? $layout : 'oe24';

$isValidOe2016Layout = isOe2016Layout($layout, $isArticle);
$useNewLayout  = ($isValidOe2016Layout) ? $useNewLayout : null;

$channelColumnName = 'Split Area';
$splitArea2016Name = 'Split Area 2016';

$ignoreLayoutValidity = false;
if ('oe2016' === $useNewLayout || 'oe2016' === $useSplitArea) {

    // wenn es die "neue" Spalte gibt, dann nimm den 2016-Namen.
    if (null !== $channel->getColumnByName($splitArea2016Name, true, true)) {
        $channelColumnName = $splitArea2016Name;
    }

    // wenn mittels Get-Parameter auf Oe2016 getrimmt wird, ist das Layout
    // kein Entscheidungskriterium mehr.
    $ignoreLayoutValidity = ('oe2016' === $useSplitArea) ? true : false;
}

$params['templateLeft'] = (isset($params['templateLeft']))
                                ? isParamsTemplateLeftValid($params['templateLeft'])
                                : null;

$showTemplateLeft = ($params['templateLeft'] !== null) ? true : false;


// *****  NAVIGATION  ********
// Ich lasse die Navigation in diesem Template, da die Navigation auch im
// Footer Template benötigt wird.
//
$navigationItemsConfig = array(
    'header' => array(
        'top' => 'top_2014',
        'tabs' => 'tabs_2014',
        'menue' => 'main',
    ),
    'footer' => array(
        'footerSub1',
        'footerSub2',
        'footerSub3',
    )
);
$navigation = new Navigation($portal, $channel, $layout, $navigationItemsConfig);

// ********** HEADER ************
etpl(
    'oe24.oe24.__splitArea._page.header',
    array(
        'portal'          => $portal,
        'channel'         => $channel,
        'object'          => $object,
        'layout'          => $layout,
        'navigation'      => $navigation,
        'useNewCollector' => true,
        'useNewLayout'    => $useNewLayout,
        'oe2016layouts'   => 1,
    )
);

// ich nehme zuerst die Channelansicht her, weil die kürzer ist.
if (!$isArticle) {

// *******   CHANNEL  *******

    // falls es ein left template gibt, zeig diese an
    if ($showTemplateLeft) {
        etpl(
            $params['templateLeft'],
                array(
                    'portal'  => $portal,
                    'channel' => $channel,
                    'params'  => $params,
                    'object'  => $object

                )
        );
    } else {

        // sonst iteriere die Boxen des Channels durch.
        // der ChannelColumnName wird ggf. in Zeile 32ff geändert.
        etpl(
            'oe24.oe24.__splitArea._page.standardColumns',
                array(
                    'portal'     => $portal,
                    'columnName' => $channelColumnName,
                    'channel'    => $channel,
                    'params'     => $params,
                    'object'     => $object,
                )
        );
    }

} else {
// *******   ARTIKEL  *******

    // falls es ein left template gibt, zeig dieses an
    if ($showTemplateLeft) {
        etpl(
            $params['templateLeft'],
                array(
                    'portal'  => $portal,
                    'channel' => $channel,
                    'params'  => $params,
                    'object'  => $object
                )
        );
    } else {

        if (!$isValidOe2016Layout) {

            // Lade Top-Content für den Artikel auf "Split-Story-Teaser Area"
            // Das passiert dann zusätzlich zum Video/Slideshow/Normalen Artikel.
            // ignoreLayoutValidity ist true wenn man mit getParameter
            // useSplitArea=oe2016 reinkommt.

            etpl('oe24.oe24.__splitArea._page.standardColumnsSplitArea', array(
                'columnName' => 'Split-Story-Teaser Area',
                'channel'    => $channel,
                'tabSide'    => 'top',
                'object'     => $object,
                'hide'       => array()
            ));

        }

        $isVideo = ($object instanceof Video || ($object instanceof Text && $object->getVideoOptions()));

        // hier werden die diversen Artikelarten geprüft.
        // ich nehme ein switch (true) zwecks der Übersichtlichkeit
        switch (true) {
            case ($object instanceof SlideShowVoting) :
                etpl(
                    'oe24.oe24.__splitArea.article.articleSlideshowVoting',
                    array(
                        'portal' => $portal,
                        'channel' => $channel,
                        'params' => $params,
                        'object' => $object,
                        'layout' => $layout,
                    )
                );
                break;
            case ($object instanceof SlideShow) :
                etpl(
                    'oe24.oe24.__splitArea.article.01_articleSlideshow',
                    array(
                        'portal' => $portal,
                        'channel' => $channel,
                        'params' => $params,
                        'object' => $object,
                        'layout' => $layout,
                        #'oe2016layouts' => $oe2016layouts,
                    )
                );
                break;
            case ($isVideo) :
                etpl(
                    'oe24.oe24.__splitArea.article.articleVideo',
                    array(
                        'portal'  => $portal,
                        'channel' => $channel,
                        'params'  => $params,
                        'object'  => $object,
                        'layout'  => $layout,
                    )
                );
                break;
            case ($object instanceof Recipe) :
                $recipeTemplate  = 'oe24.oe24.__splitArea.recipe.index';
                $recipeTemplate .= ('oe2016' === $useNewLayout) ? '2016' : '';

                etpl(
                    'oe24.oe24.__splitArea.recipe.index2016',
                    array(
                        'portal'  => $portal,
                        'channel' => $channel,
                        'params'  => $params,
                        'object'  => $object,
                        'layout'  => $layout,
                    )
                );
                break;
            case ('superbonus' === $layout) :
                etpl(
                    'oe24.oe24.__splitArea.article.articleAutoshop',
                    array(
                        'channel' => $channel,
                        'text' => $object,
                    )
                );
                break;

            // dieser fallthrough ist gewünscht
            case ('madonna' === $layout) :
            default:
                etpl(
                    'oe24.oe24.__splitArea.article.02_articleDefault',
                    array(
                        'portal' => $portal,
                        'channel' => $channel,
                        'params' => $params,
                        'object' => $object,
                        'layout' => $layout,
                        #'oe2016layouts' => $oe2016layouts,
                    )
                );
                break;
        }


        // ********     oe24TV Layer    *******
        // nur in (development) 'businesslive'-Channel, (produktiv) /test/db/video einbinden und produktive Startseite
        $validChannel = ( spunQ::inMode(spunQ::MODE_DEVELOPMENT) && '161591580' == $channel->getId() ) ? true : false;
        $validChannel = ( !spunQ::inMode(spunQ::MODE_DEVELOPMENT) && '317843947' == $channel->getId() ) ? true : $validChannel;
        $validChannel = ( !spunQ::inMode(spunQ::MODE_DEVELOPMENT) && '2846' == $channel->getId() ) ? true : $validChannel;

        if ($useNewLayout && $validChannel) {
            etpl(
                'oe24.oe24.__splitArea.tpl.content.oe24tvTopVideoLayer',
                array(
                    'channel'       => $channel,
                    'layout'        => $layout,
                    #'oe2016layouts' => $oe2016layouts,
                )
            );
        }
    }
}
// hier geht das if (!$isArticle) aus Z. 57 zu.
?>

<? // ****** ENTGELTLICHER CONTENT ******* ?>
<? if (!$isArticle && $channelOptions->get('EntgeltlicherContent')) :?>
    <div class="row paidContent">entgeltliche Einschaltung</div>
<? endif; ?>

<?

// ****** FOOTER  *******

etpl(
    'oe24.oe24.__splitArea._page.footer',
    array(
        'portal'            => $portal,
        'channel'           => $channel,
        'object'            => $object,
        'layout'            => $layout,
        'navigation'        => $navigation,

        // wird wohl in Zukunft nicht mehr gebraucht werden.
        'useNewCollector'   => $useNewCollector,
        'useNewLayout'      => $useNewLayout,

        // wird wohl in Zukunft nicht mehr gebraucht werden.
        'oe2016layouts'     => 'dummy',
    )
);

