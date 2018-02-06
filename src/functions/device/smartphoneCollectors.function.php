<?
/**
 * collectHeadCss
 **/

function smartPhoneGetAliases($type, $position) {
    $css = array(); $js = array();

    $alias = 'oe24.oe24.device.smartphone.tpl._urls' . $position;
    $file = spunQ_Module::aliasToTemplateFile($alias, 'php', false);

    if (!$file) {
        return array();
    }

    $includeFile = $file->getPrettyPath();

    if (!file_exists($includeFile)) {
        return array();
    }
    include ($includeFile);
    return ($type === 'css') ? $css : $js;
}

function smartPhoneGenerateLinks($type, $position, $layout = 'oe24') {
    $allAliases = array();
    $allAliases = smartPhoneGetAliases($type, $position);

    if ('css' === $type && 'head' === $position && 'oe24' !== $layout) {
        $cssAlias = "oe24.oe24.device.smartphone.assets.css.override.$layout";
        $cssFile = spunQ_Module::aliasToTemplateFile($cssAlias, 'css', false);

        // das layout override an die vorletzte Stelle
        if ($cssFile) {
            $override = array_pop($css);
            $css[] = array(1, $cssAlias);
            $css[] = $override;
        }
    }

    $links = array();
    $maxTime = 0;
    $lastChanged = 0;
    foreach ($allAliases as $key => $temp) {
        $alias = $temp[1];
        $file = spunQ_Module::aliasToTemplateFile($alias, $type, false);
        if (!$file) {
            error("Das $type File $alias wurde nicht gefunden. ");
            continue;
        }

        $lastChanged = max($lastChanged, $file->getLastModificationTime());

        $pageAlias = l('oe24.oe24.wormhole.smartphoneCollector',
            array(
                'alias'     => $alias,
                'type'      => $type,
                'position'  => $position,
                'layout'    => $layout,
                'time'      => $lastChanged,
                )
        );

        // am Devserver sollen die Files immer einzeln ausgespielt werden.
        if (spunQ::inMode(spunQ::MODE_DEVELOPMENT)) {
            $links[] = $pageAlias;
        }
    }

    // am Echtserver soll immer alle Files zusammengefasst werden.
    if (!spunQ::inMode(spunQ::MODE_DEVELOPMENT)) {
        $pageAlias = l('oe24.oe24.wormhole.smartphoneCollector',
            array(
                'alias'     => '_all',
                'type'      => $type,
                'position'  => $position,
                'layout'    => $layout,
                'time'      => $lastChanged
            )
        );

        $links[] = $pageAlias;
    }

    return $links;
}


function smartPhoneGetHeadCssAliases($layout = 'oe24') {

    $alias = 'oe24.oe24.device.smartphone.tpl._urlsHead';
    $file = spunQ_Module::aliasToTemplateFile($alias, 'php', false);

    if (!$file) {
        return array();
    }

    $includeFile = $file->getPrettyPath();

    if (!file_exists($includeFile)) {
        return array();
    }

    // es wird nur die $css variable verwendet
    include ($includeFile);

    if ($layout != 'oe24') {
        $cssAlias = "oe24.oe24.device.smartphone.assets.css.override.$layout";
        $cssFile = spunQ_Module::aliasToTemplateFile($cssAlias, 'css', false);
        if ($cssFile) {
            $override = array_pop($css);
            $css[] = array(1, $cssAlias);
            $css[] = $override;
        }
    }

    return $css;
}

function smartPhoneGetHeadJsAliases() {
    $alias = 'oe24.oe24.device.smartphone.tpl._urlsHead';
    $file = spunQ_Module::aliasToTemplateFile($alias, 'php', false);

    if (!$file) {
        return array();
    }

    $includeFile = $file->getPrettyPath();

    if (!file_exists($includeFile)) {
        return array();
    }

    // es wird nur die $js variable verwendet
    include ($includeFile);

    return $js;
}

function smartPhoneGetBottomJsAliases() {
    $alias = 'oe24.oe24.device.smartphone.tpl._urlsBottom';
    $file = spunQ_Module::aliasToTemplateFile($alias, 'php', false);

    if (!$file) {
        return array();
    }

    $includeFile = $file->getPrettyPath();

    if (!file_exists($includeFile)) {
        return array();
    }

    // es wird nur die $js variable verwendet
    include ($includeFile);
    return $js;
}

function smartphoneGetBottomCssAliases($layout = 'oe24') {
    return array();
}

