<?
/**
 * AMP spunQ_SlideShow Tag
 *
 * @var spunqTag array<any>
 * @var imageIds array<any>
 * @var class string
 * @default class null
 * @var layout string
 * @default layout responsive
 * @var width integer
 * @default width 400
 * @var height integer
 * @default height 400
 */

if (isset($spunqTag['attributes'])) {

    $id = $spunqTag['attributes']['id'];
    $selectQuery = new spunQ_SelectQuery();
    $selectQuery->setProperties(array(
        'relatedContent._value.id',
    ));
    $selectQuery->setType('oe24.core.SlideShow');
    $selectQuery->setConditions(array(
        'id = {id}',
    ));
    $selectQuery->setReturnType(spunQ_SelectQuery::RETURN_SINGLE_PROPERTY);
    $slideShowRelatedContent = $selectQuery->execute(array(
        'id' => $id,
    ));

    $selectQuery = new spunQ_SelectQuery();
    $selectQuery->setProperties(array(
        'id',
    ));
    $selectQuery->setType('oe24.core.Image');
    $selectQuery->setConditions(array(
        'id IN {ids}',
    ));
    $selectQuery->setReturnType(spunQ_SelectQuery::RETURN_SINGLE_PROPERTY);
    $images = $selectQuery->execute(array(
        'ids' => $slideShowRelatedContent,
    ));

} else {
    $images = $imageIds;
}

if (empty($images)) {
    return;
}

$heightCarousel = $height + 14;

?>
<div class="carousel">
<amp-carousel width="<?= $width; ?>" height="<?= $heightCarousel; ?>" layout="<?= $layout; ?>" class="<?= $class; ?>" type="slides" controls loop>

<? foreach ($images as $key => $image): ?>
<?
    $spunqTag = array(
        'attributes' => array(
            'id' => $image,
        ),
    );
    tpl('oe24.oe24.mobile.article.amp.tagging.Image', array(
        'spunqTag' => $spunqTag,
        'width' => $width,
        'height' => $height,
    ));
?>
<? endforeach; ?>

</amp-carousel>
</div>
