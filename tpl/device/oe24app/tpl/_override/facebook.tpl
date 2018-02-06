<?php
/**
 * Facebook Representation
 * @var post string
 */

$frameId = uniqid();
$data = array(
    'url'       => $post,
    'id'        => $frameId,
);

$json = json_encode($data);
$base64String = base64_encode($json);

$host = 'http://' . (spunQ::inMode(spunQ::MODE_DEVELOPMENT) ? 'oe24dev.oe24.at' : 'www.oe24.at');

$iFrameSrc = $host . l('oe24.oe24.oe24app.getFacebookPost',
    array(
        'base64' => $base64String,
        )
    );


?>
<div class="storyFbIframe">
    <iframe id="<?=$frameId;?>" src="<?=$iFrameSrc;?>" width="100%" seamless></iframe>
</div>

