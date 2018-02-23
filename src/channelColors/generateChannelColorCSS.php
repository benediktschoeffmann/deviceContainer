<?

// Usage:
//
// $ php generateChannelColorCSS.php
//
// Backup der channelColors.css machen (channelColors_backup_yyyymmdd.css)
// Die Ausgabe des Scripts in die channelColors.css kopieren, erste und letzte Zeile löschen (das sind Ausgaben des Terminals)

$header = "<?php
/**
 * @collector noauto
 */
?>\n
";

$rules = array(
    array(
        'selectors' => array(
            '.oe2016 .{channel} .defaultChannelColor',
            '.oe2016 .{channel} .defaultChannelHoverColor:hover',

            '.oe2016 .{channel} .content .storyWrapper:hover .story_pretitle',
            '.oe2016 .{channel} .content .storyWrapper:hover .story_pagetitle',
            // '.oe2016 .{channel} .content .storyWrapper:hover .story_leadtext',

            '.oe2016 .{channel} .content .column a:hover .storyPreTitle',
            '.oe2016 .{channel} .content .column a:hover .storyTitle',
            // '.oe2016 .{channel} .content .column a:hover .storyLeadText',
            '.oe2016 .{channel} .content .column .storyPreTitle.withMarker:before',

            '.oe2016 .{channel} .sidebar .teasers a:hover .storyTitle',

            '.oe2016 .{channel} .videoEntry a:hover .videoPreTitle',
            '.oe2016 .{channel} .videoEntry a:hover .videoTitle',

            '.oe2016 .{channel} .slide a:hover .storyPreTitle',
            '.oe2016 .{channel} .slide a:hover .storyTitle',
            // '.oe2016 .{channel} .slide a:hover .storyLeadText',

            '.oe2016.layout_{channel} .article_box .spunQRelatedArticles .link:hover .preTitle',
            '.oe2016.layout_{channel} .article_box .spunQRelatedArticles .link:hover .title',

            '.oe2016 .{channel} .teaserStoryBox:hover .teaserStoryBoxPreTitle',
            '.oe2016 .{channel} .teaserStoryBox:hover .teaserStoryBoxTitle',
        ),
        'properties' => array(
            'color: {colorLeft}',
        ),
    ),
    array(
        'selectors' => array(
            '.oe2016 .{channel} .defaultChannelBackgroundColor',
            '.oe2016 .{channel} .sidebar .defaultChannelBackgroundColor',
            '.oe2016 .headerNav .headerNavMainItem.{channel}:hover:after',
            '.oe2016 .headerNav .headerNavMainItem.{channel}.active:after',

            '.oe2016.layout_{channel} .article_body .spunQRelatedArticlesHeadline',

            '.oe2016 .{channel} .videoEntry .topVideoCircle',
        ),
        'properties' => array(
            'background-color: {colorLeft}',
        ),
    ),
    // array(
    //     'selectors' => array(
    //         '.oe2016 .{channel} .videoEntry a:hover .videoPreTitle',
    //         '.oe2016 .{channel} .videoEntry a:hover .videoTitle',
    //     ),
    //     'properties' => array(
    //         'color: {colorLeft}',
    //     ),
    // ),
    // array(
    //     'selectors' => array(
    //         '.oe2016 .{channel} .videoEntry .topVideoCircle',
    //     ),
    //     'properties' => array(
    //         'background-color: {colorLeft}',
    //     ),
    // ),
    array(
        'selectors' => array(
            '.oe2016 .{channel}.standardHeadline h2',
            // '.oe2016 .{channel} .commentLineLink',
            '.oe2016 .{channel}.bigHeadline .bigHeadlineText',
            '.xlHeadLineBox.{channel} .xlHeadLine',
        ),
        'properties' => array(
            'background-color: {colorLeft}',
            'background-image: linear-gradient(to right, {colorLeft} 65%, {colorRight})',
        ),
    ),
    array(
        'selectors' => array(
            '.oe2016 .{channel} .commentLineLink',
        ),
        'properties' => array(
            'border-bottom: 1px solid {colorLeft}',
        ),
    ),
    array(
        'selectors' => array(
            '.oe2016 .{channel} .commentLineLink:hover',
        ),
        'properties' => array(
            'border-bottom: 1px solid {colorLeft}',
            'text-decoration: none',
            'color: #fff',
            'background-color: {colorLeft}',
            'background-image: linear-gradient(to right, {colorLeft}, {colorRight})',

        ),
    ),
    array(
        'selectors' => array(
            '.oe2016 .{channel} .content .storyWrapper:hover',
            '.oe2016 .{channel} .content .column a:hover',
        ),
        'properties' => array(
            'border-top: 6px solid {colorLeft}',
        ),
    ),


    // xlKonsoleExtended SVG
    //
    // array(
    //     'selectors' => array(
    //         '.oe2016 .{channel} .svgCaptionBox',
    //         '.oe2016 .{channel} .svgTriangle',
    //     ),
    //     'properties' => array(
    //         'fill: {colorLeft}',
    //     ),
    // ),
    // array(
    //     'selectors' => array(
    //         '.oe2016 .{channel} .xlKonsoleExtendedStory:hover .svgTriangle',
    //     ),
    //     'properties' => array(
    //         'fill: #fff',
    //         'stroke: {colorLeft}',
    //     ),
    // ),
);

// ------------------------------------------------------------------------

include dirname(__FILE__).'/channelColors.php';
// ksort($channels);

// ------------------------------------------------------------------------

$styles = array();

foreach ($channelColors as $channel => $colors) {

    foreach ($rules as $rule) {

        $temp = implode(",\n", $rule['selectors']);
        $temp = str_replace('{channel}', $channel, $temp);

        $styles[] = $temp;
        $styles[] = " {\n";

        $temp = "\t".implode(";\n\t", $rule['properties']).';';
        $temp = str_replace('{colorLeft}', $colors['colorLeft'], $temp);
        $temp = str_replace('{colorRight}', $colors['colorRight'], $temp);

        $styles[] = $temp."\n";
        $styles[] = "}\n";
    }
}


/* (ws) 2016-03-07 */
/* Ausnahme: Die Verlaufsfarben fuer den society-Channel werden hier festgelegt */
/* (ws) 2016-03-07 */


$exception = array(

"
/* (ws) 2016-03-07 Ausnahmen */
",

"
.oe2016 .society.standardHeadline h2 {
    background-color: #ffca49;
    background-image: linear-gradient(to right, #ffca49 65%, #ff746e);
}
",

"
.oe2016 .society .defaultChannelBackgroundColor,
.oe2016 .society .sidebar .defaultChannelBackgroundColor,
.oe2016 .headerNav .headerNavMainItem.society:hover::after,
.oe2016 .headerNav .headerNavMainItem.society.active::after,
.oe2016 .society .videoEntry .topVideoCircle {
    background-color: #ffca49;
}
",

"
/* (pj) 2016-04-26 Ausnahmen Stars24 */
",

"
.oe2016 .society .storyTime.defaultChannelBackgroundColor {
    /* (ws) 2017-09-06 background-color: #ff2b22; */
    background-color: #d0113a;
}
",

"
.oe2016 .stars-oesterreich.standardHeadline h2 {
    background-color: #ffca49;
    background-image: linear-gradient(to right, #ffca49 65%, #ff776e);
}
",

"
.oe2016 .stars-international.standardHeadline h2 {
    background-color: #ffca49;
    background-image: linear-gradient(to right, #ffca49 65%, #0052b3);
}
",

"
.oe2016 .stars-deutschland.standardHeadline h2 {
    background-color: #ffca49;
    background-image: linear-gradient(to right, #ffca49 65%, #d0113a);
}
",

"
.oe2016 .stars-royals.standardHeadline h2 {
    background-color: #ffca49;
    background-image: linear-gradient(to right, #ffca49 65%, #313b69);
}
",

"
.oe2016 .stars-partys.standardHeadline h2 {
    background-color: #ffca49;
    background-image: linear-gradient(to right, #ffca49 65%, #b1167f);
}
",

"
.oe2016 .stars-mode.standardHeadline h2 {
    background-color: #ffca49;
    background-image: linear-gradient(to right, #ffca49 65%, #ec5a9d);
}
",

"
.oe2016 .stars-beauty.standardHeadline h2 {
    background-color: #ffca49;
    background-image: linear-gradient(to right, #ffca49 65%, #cd0849);
}
",



"
.oe2016 .stars-musik.standardHeadline h2 {
    background-color: #ffca49;
    background-image: linear-gradient(to right, #ffca49 65%, #f89845);
}
",
"
.oe2016 .stars-kultur.standardHeadline h2 {
    background-color: #ffca49;
    background-image: linear-gradient(to right, #ffca49 65%, #52aada);
}
",
"
.oe2016 .stars-tv.standardHeadline h2 {
    background-color: #ffca49;
    background-image: linear-gradient(to right, #ffca49 65%, #5272da);
}
",
"
.oe2016 .stars-kino.standardHeadline h2 {
    background-color: #ffca49;
    background-image: linear-gradient(to right, #ffca49 65%, #c9542f);
}
",



"
.oe2016 .stars-oesterreich .defaultChannelColor,
.oe2016 .stars-oesterreich .defaultChannelHoverColor:hover,
.oe2016 .stars-oesterreich .content .storyWrapper:hover .story_pretitle,
.oe2016 .stars-oesterreich .content .storyWrapper:hover .story_pagetitle,
.oe2016 .stars-oesterreich .content .column a:hover .storyPreTitle,
.oe2016 .stars-oesterreich .content .column a:hover .storyTitle,
.oe2016 .stars-oesterreich .content .column .storyPreTitle.withMarker:before,
.oe2016 .stars-oesterreich .sidebar .teasers a:hover .storyTitle,
.oe2016 .stars-oesterreich .videoEntry a:hover .videoPreTitle,
.oe2016 .stars-oesterreich .videoEntry a:hover .videoTitle,
.oe2016 .stars-oesterreich .slide a:hover .storyPreTitle,
.oe2016 .stars-oesterreich .slide a:hover .storyTitle {
    color: #ff2b22;
}
",

"
.oe2016 .stars-oesterreich .defaultChannelBackgroundColor,
.oe2016 .stars-oesterreich .sidebar .defaultChannelBackgroundColor,
.oe2016 .headerNav .headerNavMainItem.stars-oesterreich:hover:after,
.oe2016 .headerNav .headerNavMainItem.stars-oesterreich.active:after,
.oe2016 .stars-oesterreich .videoEntry .topVideoCircle {
        background-color: #ff2b22;
}
",

"
.oe2016 .stars-oesterreich .content .storyWrapper:hover,
.oe2016 .stars-oesterreich .content .column a:hover {
        border-top: 6px solid #ff2b22;
}
",

"
.oe2016 .stars-deutschland .defaultChannelColor,
.oe2016 .stars-deutschland .defaultChannelHoverColor:hover,
.oe2016 .stars-deutschland .content .storyWrapper:hover .story_pretitle,
.oe2016 .stars-deutschland .content .storyWrapper:hover .story_pagetitle,
.oe2016 .stars-deutschland .content .column a:hover .storyPreTitle,
.oe2016 .stars-deutschland .content .column a:hover .storyTitle,
.oe2016 .stars-deutschland .content .column .storyPreTitle.withMarker:before,
.oe2016 .stars-deutschland .sidebar .teasers a:hover .storyTitle,
.oe2016 .stars-deutschland .videoEntry a:hover .videoPreTitle,
.oe2016 .stars-deutschland .videoEntry a:hover .videoTitle,
.oe2016 .stars-deutschland .slide a:hover .storyPreTitle,
.oe2016 .stars-deutschland .slide a:hover .storyTitle {
    color: #000;
}
",

"
.oe2016 .stars-deutschland .defaultChannelBackgroundColor,
.oe2016 .stars-deutschland .sidebar .defaultChannelBackgroundColor,
.oe2016 .headerNav .headerNavMainItem.stars-deutschland:hover:after,
.oe2016 .headerNav .headerNavMainItem.stars-deutschland.active:after,
.oe2016 .stars-deutschland .videoEntry .topVideoCircle {
        background-color: #000;
}
",

"
.oe2016 .stars-deutschland .content .storyWrapper:hover,
.oe2016 .stars-deutschland .content .column a:hover {
        border-top: 6px solid #000;
}
",
"
/* (mh) 2016-11-22 antennesalzburg.oe24.at // */
.oe2016 .antenne .defaultChannelColor,
.oe2016 .antenne .defaultChannelHoverColor:hover,
.oe2016 .antenne .content .storyWrapper:hover .story_pretitle,
.oe2016 .antenne .content .storyWrapper:hover .story_pagetitle,
.oe2016 .antenne .content .column a:hover .storyPreTitle,
.oe2016 .antenne .content .column a:hover .storyTitle,
.oe2016 .antenne .content .column .storyPreTitle.withMarker:before,
.oe2016 .antenne .sidebar .teasers a:hover .storyTitle,
.oe2016 .antenne .videoEntry a:hover .videoPreTitle,
.oe2016 .antenne .videoEntry a:hover .videoTitle,
.oe2016 .antenne .slide a:hover .storyPreTitle,
.oe2016 .antenne .slide a:hover .storyTitle {
        color: #E3001D;
}
.oe2016 .antenne .defaultChannelBackgroundColor,
.oe2016 .antenne .sidebar .defaultChannelBackgroundColor,
.oe2016 .headerNav .headerNavMainItem.antenne:hover:after,
.oe2016 .headerNav .headerNavMainItem.antenne.active:after,
.oe2016 .antenne .videoEntry .topVideoCircle {
        background-color: #F8EC00;
        color: #000;
}
.oe2016 .antenne.standardHeadline h2,
.oe2016 .antenne.bigHeadline .bigHeadlineText {
        background-color: #F8EC00;
        background-image: linear-gradient(to right, #F8EC00 65%, #fff);
}
.oe2016 .antenne .commentLineLink {
        border-bottom: 1px solid #F8EC00;
}
.oe2016 .antenne .commentLineLink:hover {
        border-bottom: 1px solid #F8EC00;
        text-decoration: none;
        color: #fff;
        background-color: #F8EC00;
        background-image: linear-gradient(to right, #F8EC00, #fff);
}
.oe2016 .antenne .content .storyWrapper:hover,
.oe2016 .antenne .content .column a:hover {
        border-top: 6px solid #F8EC00;
}
.oe2016 .antenne.standardHeadline h2 a {
        color:#000;
}
.oe2016 .antenne .contentSliderBoxHeadline {
        color: #000;
}
/* (mh) 2016-11-22 antennesalzburg.oe24.at // */
",

);


// passthru('clear');
// echo $header.implode("", $styles)."\n";
echo $header.implode("", $styles)."\n".implode("", $exception)."\n";
