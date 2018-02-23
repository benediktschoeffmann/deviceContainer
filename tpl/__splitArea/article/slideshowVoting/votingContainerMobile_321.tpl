<?
/**
 * override slideshow voting 3-2-1 voting container desktop
 * @var votingItems array<any>
 * @var maxButtons integer
 * @var classNameButton string
 */

$emptyImage = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABAQAAAAA3bvkkAAAAAnRSTlMAAQGU/a4AAAAKSURBVHgBY2gAAACCAIFMF9ffAAAAAElFTkSuQmCC';

$lazyLoadingClass = 'responsively-lazy';

?>

<? if (1): ?>

<div class="votingContainer maxButtons<?= $maxButtons; ?>">

    <? foreach ($votingItems as $key => $item): ?>

        <?
        // (ws) 2017-11-17 abstimmbar/nicht abstimmbar Ergaenzung
        $classButton = (isset($item['locked']) && $item['locked']) ? $classNameButton.' disabled' : $classNameButton;
        ?>

        <div class="votingItem clearfix ">

            <? if (1): ?>
            <div class="votingImage">
                <img class="<?= $lazyLoadingClass; ?>" src="<?= $emptyImage; ?>" data-srcset="<?= $item['imageUrl']; ?>" alt="" >
                <span class="votingImageCounter"><?= ($key + 1); ?></span>
            </div>
            <? endif; ?>

            <? if (1): ?>
            <div class="votingInfo clearfix">

                <h3 class="votingInfoTitle"><?= $item['title']; ?></h3>
                <p class="votingInfoDescription"><?= $item['description']; ?></p>

                <div class="votingInfoBottom">

                    <? if (1): ?>
                    <div class="votingInfoPlayButton">
                        <a class="playButton" href="<?= $item['link']; ?>" target="_blank">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 152 176" class="playButtonSymbol">
                                <path d="M150 86.6L0 173.2L0 0z"/>
                            </svg>
                        </a>
                    </div>
                    <? endif; ?>

                    <? if (1): ?>
                    <div class="votingInfoVoteButtons">
                        <? for ($k = $maxButtons; $k > 0; $k--): ?>
                            <div class="votingInfoCell">
                                <a href="#" class="<?= $classButton; ?>" onclick="return false;" data-item-info="<?= $item['id'].';jsOption'.$k; ?>">
                                    <?= $k; ?>
                                </a>
                            </div>
                        <? endfor; ?>
                    </div>
                    <? endif; ?>

                </div>

            </div>
            <? endif; ?>

        </div>

    <? endforeach; ?>

</div>

<? endif; ?>
