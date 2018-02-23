<?
/**
* content articleDefault
*
* @var channel oe24.core.Channel
* @var params array<any>
* @var object oe24.core.Text
* @var layout string
* @var oe2016layouts array<string>
*/

// {article-url}?content=2017

// Artikel mit Image im Artikel-Header
// http://oe24dev.oe24.at/import/So-viel-kassieren-Burger-und-Co-jetzt/161617131

// Artikel mit Video im Artikel-Header
// http://oe24dev.oe24.at/import/Liste-Das-sind-die-neuen-Pilz-Koepfe/161617266

// Artikel mit Image-Slideshow im Artikel-Header
// ...

?>

<div class="row content2017 articleDefault">

    <div class="articleContainer">

        <div class="articleContent">

            <?
            tpl($this->name.'Header', array(
                'channel' => $channel,
                'params' => $params,
                'object' => $object,
                'layout' => $layout,
                'oe2016layouts' => $oe2016layouts,
            ));
            ?>

        </div>

    </div>

    <div class="articleSidebar">
        Sidebar
    </div>

</div>
