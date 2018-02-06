<?

function getProfessionNavigationItems($relatedBoxId) {
    return professionItems($relatedBoxId, true);
}

function getProfessionStories($relatedBoxId) {
    return professionItems($relatedBoxId, false);
}

function professionItems($relatedBoxId, $getNavigationItems = true) {

    if (!ctype_digit($relatedBoxId)) {
        return null;
    }

    $tagPrefix = 'profession-';

    $navigationItems = array_fill_keys(range('a', 'z'), array());
    $navigationItems['ae']       = array();
    $navigationItems['oe']       = array();
    $navigationItems['ue']       = array();
    $navigationItems['sonstige'] = array();

    $request = request();
    $requestKey = $request->getGetValue('key');
    $requestKey = (array_key_exists($requestKey, $navigationItems)) ? $requestKey : 'a';
    $requestUri = $request->getUri(true);

    // ------------------------------------------

    $relatedBox = db()->getById($relatedBoxId, 'oe24.core.ContentBox', false);
    if (!$relatedBox) {
        return;
    }

    $content = $relatedBox->getContentOfAllDropAreas(true, false);
    if (!$content || !is_array($content)) {
        return;
    }

    // ------------------------------------------

    $stories = array();
    $tagsFromStories = array();

    foreach ($content as $story) {

        if (!($story instanceof TextualContent)) {
            continue;
        }

        $tags = $story->getTags();
        if (!is_array($tags)) {
            continue;
        }

        foreach ($tags as $tag) {

            $tagName = $tag->getName();

            $tagsFromStories[] = $tagName;

            // debug($tagName.' == '.$tagPrefix.$requestKey.', '.$story->getId().', '.var_export($getNavigationItems, true));

            if (false == $getNavigationItems && $tagName == $tagPrefix.$requestKey) {
                $stories[] = $story;
            }

        }
    }

    // debug($tagsFromStories);

    // ------------------------------------------

    foreach ($navigationItems as $key => $item) {

        $tagName = $tagPrefix.$key;

        $navigationEnabled = (in_array($tagName, $tagsFromStories)) ? true : false;

        $classCurrent = ($requestKey == $key) ? 'navigationCurrent' : '';

        $classDisabled = ($navigationEnabled) ? '' : 'navigationDisabled';
        // $classDisabled = ('navigationCurrent' == $classCurrent) ? '' : $classDisabled;

        $class = $classDisabled.' '.$classCurrent;

        $href = ($navigationEnabled) ? $requestUri.'?key='.$key : '#!';
        $onClick = ($navigationEnabled) ? '' : 'onclick="return false;"';

        $navigationItems[$key] = array(
            'class'   => $class,
            'href'    => $href,
            'onClick' => $onClick,
        );
    }

    // debug($navigationItems);

    // ------------------------------------------

    if ($getNavigationItems) {
        return $navigationItems;
    } else {
        return $stories;
    }
}
