<?
/**
 * default Content Box - default view
 *
 * @var channel oe24.core.Channel
 * @var column oe24.core.ChannelColumn
 * @var box oe24.core.ContentBox
 * @var contents array<oe24.core.Content>
 * @var options spunQ_Map
 */

foreach($contents as $content){
    if($content instanceof TextualContent){?>
        <article>
            <a <?=getContentUrlAttributes($content, $box, true, true, true)?>>
                <header>
                    <h2><?s($content->getPreTitle(true, $box))?></h2>
                    <h1><?s($content->getTitle(true, $box))?></h1>
                </header>
                <p class="leadtext"><?s($content->getLeadText(true,true,$box))?></p>
            </a>
        </article>
    <?}?>
<?}?>