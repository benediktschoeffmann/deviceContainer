<?php
/**
 * headerNavMainSubNav
 *
 * @var layout string
 * @var subnav_items array<any>
 * @default subnav_items 0
 * @var caption string
 */

if (false == is_array($subnav_items) || empty($subnav_items)) {
    return;
}

?>

<div class="headerNavMainSubNav">

    <div class="subNavContainerOuter">

        <div class="subNavContainer">


            <? //<img class="ajaxload" src="/images/oe2016/ajaxload-indicatior-big.gif" alt=""> ?>


            <ul class="subNavMenu clearfix">
                <?php foreach ($subnav_items as $key => $item): ?>
                <li>
                    <a onclick="<?= $item['onclick'];?>" data-jsonurl="<?= $item['json'];?>" href="<?= $item['href']; ?>" <?=$item['target'];?>>
                        <? if (array_key_exists('tag', $item['config']) && 'image' === $item['config']['tag'] && array_key_exists('path', $item['config'])): ?>
                            <img class="subNavMenuImage" src="<?=$item['config']['path'];?>" alt="" />
                        <? endif; ?>
                        <?= $item['caption']; ?>
                    </a>
                </li>
                <?php endforeach; ?>
            </ul>

            <? if ('madonna' !== $layout): ?>
            <div class="subNavContent clearfix">

                <div class="subNavSidebar">
                    <a class="subNavSidebarLatest" href="#!">
                        <span class="icon icon_clock"></span>
                        <span class="caption">Neueste</span>
                    </a>
                    <a class="subNavSidebarTopReaded" href="#!">
                        <span class="icon icon_list1"></span>
                        <span class="caption">Top gelesen</span>
                    </a>
                </div>

                <a class="subNavStory1" href="#!">
                    <img src="/images/empty.gif" alt="">
                    <span>&nbsp;</span>
                </a>
                <a class="subNavStory2" href="#!">
                    <img src="/images/empty.gif" alt="">
                    <span>&nbsp;</span>
                </a>

                <div class="subNavMore">
                    <a class="subNavStory3 clearfix" href="#!">
                        <img src="/images/empty.gif" alt="">
                        <span>&nbsp;</span>
                    </a>
                    <a class="subNavStory4 clearfix" href="#!">
                        <img src="/images/empty.gif" alt="">
                        <span>&nbsp;</span>
                    </a>
                    <a class="subNavStory5 clearfix" href="#!">
                        <img src="/images/empty.gif" alt="">
                        <span>&nbsp;</span>
                    </a>
                </div>

            </div>
            <? endif; ?>

        </div>

    </div>

</div>
