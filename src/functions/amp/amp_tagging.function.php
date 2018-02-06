<?php
function amp_tagging(&$text) {
    $tags = TextualProcessor::extractSpunQTags($text);
    $usedTags = array();

    foreach ($tags as $tag) {
        $replacedTag = '';
        switch ($tag['name']) {
            case 'SlideShow':
                $replacedTag = amp_carousel($tag['attributes']['id']);
                $usedTags['Carousel'] = true;
                break;
            case 'Text':
                $linkText = (isset($tag['linkText'])) ? $tag['linkText'] : NULL;
                $replacedTag = amp_createLinkToArticle($tag['attributes']['id'], $linkText);
                break;
            case 'Channel':
                $linkText = (isset($tag['linkText'])) ? $tag['linkText'] : NULL;
                $replacedTag = amp_createLinkToChannel($tag['attributes']['id'], $linkText);
                break;
            case 'Video':
                $usedTags['Video'] = true;
                $replacedTag = amp_video($tag['attributes']['id']);
                break;
            case 'Image':
                $usedTags['Image'] = true;
                $replacedTag = amp_img(db()->getById($tag['attributes']['id'], 'oe24.core.Image'));
                break;
            

            // ignored Tags
            case 'Pdf' :
            case 'TextSlideshow' :
            case 'pagebreak' : 
            case 'SlideShowVoting' :
                $replacedTag = '';
                break;
            case 'IFrame':
                if ('Youtube' == $tag['attributes']['protocol']) {
                    $replacedTag = amp_youtube($tag['attributes']['id']);
                    $usedTags['Youtube'] = true;
                    break;
                } else if ('Facebook' == $tag['attributes']['protocol']) {
                    $replacedTag = amp_facebook($tag['attributes']['id']);
                    $usedTags['Facebook'] = true;
                    break;
                // ignored Tags    
                } else if ('Twitter' == $tag['attributes']['protocol'] ||
                           'Scoreboard' == $tag['attributes']['protocol'] ||
                           'Vimeo' == $tag['attributes']['protocol']) {
                    $replacedTag = '';
                    break;
                }
                // don't set a break here.
                // if the protocol of the IFrame is not recognized, an unknown tag "error"
                // will occur.
            default:

                $errorText = 'Unbekannter Tag "' . $tag['name'] . '" mit Original String "' . $tag['originalString'];
                if (spunQ::inMode(spunQ::MODE_DEVELOPMENT)) {
                    debug($errorText);
                } else {
                    error($errorText);
                }
                // debug('unknown tag');
                // debug($tag);
                break;
            }
        $text = str_replace($tag['originalString'], $replacedTag, $text);
    }

    return $usedTags;
}
