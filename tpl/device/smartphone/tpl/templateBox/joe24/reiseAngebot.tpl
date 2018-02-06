<?
/**
 * joe24 Reise Angebot
 * @var channel oe24.core.Channel
 * @var box oe24.core.TemplateBox
 */

$templateOptions = $box->getTemplateOptions();

// ------------------------------------------

$boxTitle = trim($templateOptions->get('Boxtitle'));
$boxTitle = ($boxTitle && mb_strlen($boxTitle)) ? $boxTitle : 'Reiseangebote';
$boxTitle .= ' by';

// ------------------------------------------

$offers = getJoe24ReiseAngebote($templateOptions);

// ------------------------------------------

if (count($offers) < 1) {
    return;
}

$emptyImage = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAIAAAABAQAAAADcWUInAAAAAnRSTlMAAQGU/a4AAAAKSURBVHgBYzgAAADCAMFphPI4AAAAAElFTkSuQmCC';

?>

<div class="contentBox joe24ReiseAngebot">
    <div class="headlineBox layout_reise">

        <h2 class="headline defaultChannelBackgroundColor"><?= $boxTitle; ?> <img class="headlineLogo" src="<?= lp('image', 'oe2016/logo-joe24.png'); ?>" alt=""></h2>

    </div>

    <? foreach ($offers as $key => $offer): ?>

        <div class="contentBoxStory">
            <a class="story" href="<?= $offer['url']; ?>">

                <div class="storyImage">
                    <img class="responsively-lazy" src="<?= $emptyImage; ?>" data-srcset="<?= $offer['image']; ?>" srcset="<?= $offer['image']; ?>" alt="Reiseangebot <?= $offer['pretitle']; ?> <?= $offer['title']; ?>">
                </div>

                <div class="storyText">
                    <strong class="storyPreTitle defaultChannelColor"><?= $offer['pretitle']; ?></strong>

                    <h3 class="storyTitle">
                        <span><?= $offer['title']; ?></span>
                    </h3>
                </div>


            </a>
        </div>

    <? endforeach; ?>
</div>
