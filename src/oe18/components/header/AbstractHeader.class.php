<?php

abstract class AbstractHeader extends Component {
    private $collection = null;
    private $collectionOfTheWeekTitle = null;

    public function getThemenDerWocheCollection(Channel $channel) {
        if (false === $this->collection) {
            return false;
        }
        $id = $channel->getOptions(true, true)->get('ThemenDerWocheCollection');

        if ($id) {
            $this->collection = db()->getById($id, 'oe24.core.ContentCollection', false);
        }

        if (!$this->collection) {
            $this->collection = false;
        }
        return $this->collection;
    }

    public function getThemenDerWocheTitle(Channel $channel) {

        if ($collectionOfTheWeekTitle != null) {
            return $this->collectionOfTheWeekTitle;
        }

        $title = $channel->getOptions(true, true)->get('ThemenDerWocheTitel');
        $this->collectionOfTheWeekTitle = $title ? $title : $channel->getPageTitle();
        return $this->collectionOfTheWeekTitle;
    }

}
