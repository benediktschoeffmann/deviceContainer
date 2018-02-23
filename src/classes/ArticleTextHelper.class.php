<?php

class ArticleTextHelper {


    public static function getBodyTextWithAdInserted(Channel $channel, TextualContent $article, $overrideFolder = 'gesund24', $position = 'ArticleLeft2') {

        $bodyText = $article->getBodyText();

        $oldBodyText = $bodyText;   // using this extra variable for clarification.
        $explodeTag = '</p>';

        $modifiedBodyText = '';
        $stringLengthSum  = 0;
        $adAdded = false;
        $limit = 1000;

        $pTagsArray = explode($explodeTag, $bodyText);
        $bodyTextArr = array();
        foreach ($pTagsArray as $key => $pTag) {
            $pTagLength = mb_strlen($pTag);
            $stringLengthSum += $pTagLength;
            if ($stringLengthSum > $limit && !$adAdded) {
                $adAdded = true;
                $modifiedBodyText .=
                    templateAsString('oe24.oe24.adition.adSlot',
                        array(
                            'channel' => $channel,
                            'id' => 'ArticleLeft2'
                            ));

            }

            $modifiedBodyText .= $pTag . $explodeTag;
        }

        $article->setBodyText($modifiedBodyText);

        $bodyTextArr[] = $article->getBodyText(true, true, $overrideFolder);

        $article->setBodyText($oldBodyText);

        return $bodyTextArr;
    }

    public static function transformTextSections(TextualContent $article, array $bodyTextArray, array $articlePages, $overrideFolder = 'gesund24') {

        $pageBodyText = $article->getPagedBodyText(true, true, $overrideFolder);

        $articlePages[] = 'Seiten: ';
        $page = 1;

        // BodyText Seiten durchgehen, mind. 1x
        foreach ($pageBodyText as $bodyText) {
            $style = (0 === count($bodyTextArray)) ? '' : 'style="display: none;"';
            $class = (0 === count($bodyTextArray)) ? 'active' : '';
            $bodyTextArray[] = '<div class="article_page_body" ' . $style .'>' . $bodyText . '</div>';
            $articlePages[] = '<a class="' . $class . ' js-oewaLink" onclick="pager.gotoPage(' . $page . '); oe24Tracking.loadOewa(); oe24Tracking.googleAnalyticsRefreshTracking();" href="#textBegin">' . $page . '</a>';
            ++$page;
        }

        // TextSection Seiten hinzufuegen, falls vorhanden
        while ($pages >= $page) {
            $articlePages[] = '<a class="js-oewaLink" onclick="pager.gotoPage(' . $page . '); oe24Tracking.loadOewa(); oe24Tracking.googleAnalyticsRefreshTracking();" href="#textBegin">' . $page . '</a>';
            ++$page;
        }

            // Wenn Artikel ein Newsticker/Liveticker ist
        if ($article->isNewsticker()) {

            $liveTickerHtml = templateAsString(
                'oe24.oe24.__splitArea.article.articleNewsticker',
                array(
                    'article' => $article
                )
            );

            // Regex fuer TextSectionen, erstes Paging-Element suchen (<div class="article_page_body article_ticker").
            $textSectionRegex = '/<div\sclass="article_page_body\sarticle_ticker".*$/s';
            preg_match_all($textSectionRegex, $liveTickerHtml, $matches);

            // die oberen TextSections rausfiltern, die noch zum bodyText dazugehoeren sollen
            if (0 < count($matches) && 0 < count($matches[0])) {
                $pageTicker = strpos($liveTickerHtml, $matches[0][0]);
                $firstTickerPart = substr($liveTickerHtml, 0, $pageTicker);

                // firstTickerPart auf vorige Seite schreiben und den rest (matches[0][0]) dranhaengen, hier kommt das paging schon aus der articleNewsticker.tpl
                $bodyTextCount = count($bodyTextArray)-1;
                $bodyTextArray[$bodyTextCount] = '<div class="article_page_body" ' . $style .'>' . $bodyText . $firstTickerPart . '</div>';
                $bodyTextArray[] = $matches[0][0];

            } else {
                $bodyTextCount = count($bodyTextArray)-1;
                $bodyTextArray[$bodyTextCount] = '<div class="article_page_body" ' . $style .'>' . $bodyText . $liveTickerHtml . '</div>';
            }

        }
            // $bodyTextArr und ArticlePages werden per Referenz geändert.
            return;
    }

}
