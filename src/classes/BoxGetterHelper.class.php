<?

class BoxGetterHelper {

    public static function getBoxesFromChannelColumn (Channel $channel, string $columnName = 'Split-Story-Teaser Area') {

        $otherColumn = $channel->getColumnByName($columnName);
        if (!$otherColumn) {
            return array();
        }

        return $otherColumn->getBoxes();
    }

    public static function filterBoxesByType(array $boxes, array $types) {
        $filtered = array();
        $filteredTypes = array_filter($types, function ($entry) {
            return class_exists($entry);
        });

        $filteredBoxes = array_filter($boxes, function ($entry) use ($filteredTypes) {
            return ($entry instanceof FrontendBoxTemplate) &&
                    (in_array(get_class($entry), $types));
        });

        return $filteredBoxes;
    }

    public static function filterBoxesByTemplate(array $boxes, array $templates) {
        $filtered = array();
        $filtered = array_filter($boxes, function ($entry) use ($templates) {
            return ($entry instanceof FrontendBoxTemplate) &&
                    in_array($entry->getTemplate(), $templates);
        });
        return $filtered;
    }

    public static function getArticleTeaserBoxes(Channel $channel, array $validFullWidthBoxes = array(), array $validArticleWidthBoxes = array(), string $columnName = 'Split-Story-Teaser Area') {

        $boxes = BoxGetterHelper::getBoxesFromChannelColumn($channel, $columnName);
        if (empty($boxes)) {
            return array();
        }

        $tabbedBoxes = BoxGetterHelper::filterBoxesByType($boxes, array()) {
        if (empty($tabbedBoxes)) {
            return array();
        }

        if (empty($validTemplatesFullWidth)) {
            $validTemplatesFullWidth = array(
                'oe24.oe24._contentBoxes.rl2014oe24TvDefaultContentBox',
                'oe24.oe24._contentBoxes.oe2016standardContentSlider',

                // 'oe24.oe24._templateBoxes.oe2016meinJobTopJobs',
                // 2018-01-03 (db) Tob-Jobs meinJob - Testphase, nicht online stellen!!!
            );
        }

        if (empty($validTemplatesArticleWidth)) {

            $validTemplatesArticleWidth = array(
                'oe24.oe24._htmlBoxes.defaultHtmlBox',

                // 2017-11-28 (db) Reiseangebote im Artikeldetail joe24
                'oe24.oe24._templateBoxes.oe2016joe24ReiseAngebot',
            );
        }

        $boxesFullWidth = array();
        $boxesArticleWidth = array();

        foreach ($boxes as $key => $box) {

            $tabItems = $box->getTabbedBoxItems();
            if (empty($tabItems)) {
                continue;
            }

            // wir wollen nur die Boxen der linken Seite
            $leftTabBoxes = $tabItems[0]->getBoxes();
            if (empty($leftTabBoxes)) {
                continue;
            }

            $fullWidthBoxes = BoxGetterHelper::filterBoxesByTemplate($leftTabBoxes, $validTemplatesFullWidth);

            $articleWidthBoxes = BoxGetterHelper::filterBoxesByTemplate($leftTabBoxes, $validTemplatesArticleWidth);

            $boxesFullWidth = array_merge($boxesFullWidth, $fullWidthBoxes);
            $boxesArticleWidth = array_merge($boxesArticleWidth, $articleWidthBoxes);
        }

        return array(
            'fullWidth'    => $boxesFullWidth,
            'articleWidth' => $boxesArticleWidth
        );
    }

}
