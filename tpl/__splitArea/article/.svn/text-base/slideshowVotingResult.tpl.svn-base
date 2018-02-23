<?php
/**
 * SlideShowVoting Result
 *
 * @var slideshow oe24.core.SlideShowVoting
 */
$orderType = $slideshow->getOrderType();
$slideshow->setOrderType(SlideShowVoting::ORDER_TYPE_ORDERED);
$votingInfos = $slideshow->getVotingInformation(true, 'original', false, 10, true);
$slideshow->setOrderType($orderType);
?>
<div class="votingResult" style="display: none;">
    <? foreach ($votingInfos as $key => $vote) : ?>
        <div class="voteEntry clearfix">
            <span class="number"><?=$key+1;?></span>
            <span class="title"><?=$vote['title'];?></span>
            <span class="description"><?=$vote['description'];?></span>
            <span class="percentInfo"><?=$vote['percent'];?> %</span>
            <div class="percentWrapper">
                <span class="percentBar" style="width: <?=$vote['percent']?>%;">_</span>
            </div>
        </div>
    <? endforeach; ?>
</div>


