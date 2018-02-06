<?php

class DesktopAdHandler extends Component implements IAdHandler {
    private $object;
    private $options;
    private $adsEnabled;
    private $adSlots;

    public function __construct($config) {
        $this->object = ($config['isArticle']) ? $config['content'] : $config['channel'];
        $this->options = $object->getOptions(true, true);
        $this->adsEnabled = ("Keine Werbung Laden" === $options->get('AditionAdTags')) ?
                                    IAdHandler::HIDEADS : IAdHandler::LOADADS;
        if ($this->adsEnabled === IAdHandler::LOADADS) {
            $this->prepareAds();
        }
    }


    function areAdsEnabled() {
        return $this->adsEnabled;
    }

    // TODO:
    function isAlwaysVisible($adPosition) {

    }

    function getAdSlot($id) {
        return array_filter($this->adSlots, function ($entry) use ($id) {
            return $entry['id'] === $id;
        });
    }

    function prepareAds() {
        // es gibt anscheinend unterschiedliche Positionen für Artikel / Channel #
        // die überschneiden sich zwar tw, aber nnicht bei allen/m

        $allAdSlots = json_decode($options->get('AditionAdSlots'), true);

        $validBanners = array();

        $objectType = ($this->object instanceof Channel) ? 'channel' : 'artikel';

        $adSlots = array();
        $adSlots = array_filter($allAdSlots, function ($entry) use ($objectType, $validBanners) {
            $bannerName = (str_replace(array(')', '(', ' '), '', $entry['banner']));
            return (in_array($bannerName, $validBanners) && ($entry[$objectType]));
        });

        $this->adSlots = $adSlots;
    }

    // TODO: richtige Positionen von Jessy rausfinden.
    private function getValidBannerNames() {
        if ($object instanceof Channel) {
            return array();

        }

        if ($object instanceof Content) {
            return array();
        }
    }



}
