<?php
/**
 * Social Sharing for Oe24App Article
 * @var portal       oe24.core.Portal
 * @var article      oe24.core.TextualContent
 * @var device       any
 * @var layout       string
 */


$url = urlencode($article->getUrl());
$title = urlencode($article->getTitle());

$mailUri = 'https://api.addthis.com/oexchange/0.8/forward/email/offer?url='.$url.'&pubid=ra-42fed1e187bae420&title='.$title;
$fbUri = 'https://api.addthis.com/oexchange/0.8/forward/facebook/offer?url='.$url.'&pubid=ra-42fed1e187bae420&title='.$title.'&ct=1';
$twitterUri = 'https://api.addthis.com/oexchange/0.8/forward/twitter/offer?url='.$url.'&pubid=ra-42fed1e187bae420&title='.$title.'&ct=1';

?>
<div class="socialSharing">
    <div class="entry">
        <a href="<?=$fbUri;?>">
            <img src="<?= slp('image', 'mobile/app/facebook.png') ?>">
        </a>
    </div>
    <div class="entry">
        <a href="whatsapp://send?text=<?= $url;?>" data-action="share/whatsapp/share">
            <img src="<?= slp('image', 'mobile/app/whatsapp.png') ?>">
        </a>
    </div>
     <div class="entry">
        <a href="<?=$twitterUri;?>">
              <img src="<?= slp('image', 'mobile/app/twitter.png'); ?>">
        </a>
    </div>
    <div class="entry">
        <a href="<?= $mailUri; ?>">
            <img src="<?= slp('image', 'mobile/app/mail.png'); ?>">
        </a>
    </div>
</div>
