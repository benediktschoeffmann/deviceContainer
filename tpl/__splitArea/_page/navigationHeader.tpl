<?php
/**
 * The header template for the oe24 project.
 *
 * @var portal oe24.core.Portal
 * @var channel oe24.core.Channel
 * @var object any
 * @default object 0
 */
 ?>
<header>
    <div class="row">
        <div class="twelve columns">
            <nav>
                <ul class="navi portal">
                    <? tpl("oe24.oe24.__splitArea._page.navigationItems", array(
                        "portal" => $portal,
                        "type" => "top_2014",
                        "channel" => $channel,
                        "uri" => $channel->getRawUrl(),
                    )); ?>
                </ul>
            </nav>
        </div>
    </div>
    <div class="row">
        <div class="twelve columns">
            <nav>
                <ul class="navi oe24">
                    <? tpl("oe24.oe24.__splitArea._page.navigationItems", array(
                        "portal" => $portal,
                        "type" => "tabs_2014",
                        "channel" => $channel,
                        "uri" => $channel->getRawUrl(),
                    )); ?>
                </ul>
            </nav>
        </div>
    </div>
    <div class="row channel">
        <div class="channel_inner">
            <div class="four columns">
                <h1 class="logo">
                    <a href="http://sport.oe24.at/">
                        <img src="<? slp('image', 'relaunch2014/sport24_logo.png') ?>" alt="">
                    </a>
                </h1>
            </div>
            <div class="eight columns channel_right">
                <div class="facebook search">
                    <div id="fb-root" class="facebook_container">
                        <fb:like href="http://www.facebook.com/Oe24.atSport" send="false" layout="button_count" width="150" show_faces="false" font="arial"></fb:like>
                        <script type="text/javascript">
                        (function(d, s, id) {
                            var js, fjs = d.getElementsByTagName(s)[0];
                            if (d.getElementById(id)) return;
                            js = d.createElement(s); js.id = id;
                            js.src = "//connect.facebook.net/de_DE/all.js#xfbml=1&appId=203583476343648";
                            fjs.parentNode.insertBefore(js, fjs);
                        }(document, 'script', 'facebook-jssdk'));
                        </script>
                    </div>
                    <div class="search_container">
                        <form name="headerSearch" method="get" action="http://www.oe24.at/search">
                            <input type="hidden" name="p" value="4">
                            <input type="text" name="q" placeholder="Ihr Suchbegriff ...">
                            <div class="send" onclick="document.headerSearch.submit()"></div>
                        </form>
                    </div>
                </div>
                <nav id="nav_main">
                    <ul class="navi channel">
                        <? tpl("oe24.oe24.__splitArea._page.navigationItems", array(
                            "portal" => $portal,
                            "type" => "main_2014",
                            "channel" => $channel,
                            "uri" => $channel->getRawUrl(),
                        )); ?>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="twelve columns">
            <div id="subnavi">
            <? tpl("oe24.oe24.__splitArea._page.navigationItems", array(
                "portal" => $portal,
                "type" => "sub_2014",
                "channel" => $channel,
                "uri" => $channel->getRawUrl(),
            )); ?>
            </div>
        </div>
    </div>
</header>
