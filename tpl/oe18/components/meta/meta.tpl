<?php
/**
 * @var oe24Desktop any
 */

$meta = $oe24Desktop->getComponent(Component::META);
debug($meta);

$isArticle = $oe24Desktop->getConfig('isArticle');
?>

<meta name="description" content="<?=$meta->getMetaDescription();?>" />
<meta name="description" content="<?=$meta->getRobotDescription();?>" />
<link rel="canonical" content="<?=$meta->getCanonicalUrl();?>" />

<!-- article -->
<? if ($isArticle) : ?>
    <meta name="news_keywords" content="<?=$meta->getMetaNewsKeywords();?>" />

    <? foreach ($meta->getTwitterTags() as $key => $tag) : ?>
        <meta property="<?=$key;?>" content="<?=$tag;?>" />
    <? endforeach; ?>

    <? foreach ($meta->getOpenGraphTags() as $key => $tag) : ?>
        <meta property="<?=$key;?>" content="<?=$tag;?>" />
    <? endforeach; ?>

<? endif; ?>

<? foreach ($meta->getFacebookPages() as $key => $tag) : ?>
    <meta property="fb:pages" content="<?=$tag;?>" />
<? endforeach; ?>

<? $fb = $meta->getFacebookAdminsOrAppId(); ?>
<? if (is_array($fb[0])) : ?>
    <? foreach ($fb[0] as $fbAdminId) : ?>
        <meta property="fb:admins" content="<?= $fbAdminId; ?>" />
    <? endforeach; ?>
<? else : ?>
     <meta property="fb:app_id" content="<?= $fb[0]; ?>" />
<? endif;?>


<link rel="shortcut icon" href="<?slp('image', 'layout/favicons/'.$meta->getFavicon().'.ico');?>" />
