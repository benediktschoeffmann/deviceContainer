<?php
/**
* Society Event
*/
class SocietyEvent extends spunQ_DataObject{
    
    /**
    * the id from the external php app
    * 
    * @type integer
    */
    protected $formerId;
    
    /**
    * ID for Import from Oeticket
    * Indexed cause its a performance improvement on import
    *
    * @type integer
    * @indexed
    */
    protected $oeticketEventId;

    /**
    * Name of event
    *
    * @type string
    */
    protected $name;

    /**
    * Priority
    *
    * @type integer
    */
    protected $priority = 0;

    /**
    * Event Starttime
    * Indexed cause we search for
    *
    * @type datetime
    * @indexed
    */
    protected $dateFrom;

    /**
    * Event Endtime
    * Indexed cause we search for
    *
    * @type datetime
    * @indexed
    */
    protected $dateTo;

    /**
    * Sales Starttime
    *
    * @type datetime
    * @optional
    */
    protected $dateSalesFrom;

    /**
    * Sales Endtime
    *
    * @type datetime
    * @optional
    */
    protected $dateSalesTo;

    /**
    * Society Description
    *
    * @type oe24.oe24.society.SocietyDescription
    * @optional
    */
    protected $description;

    /**
    * Image Url
    *
    * @type string
    * @optional
    */
    protected $imageUrl;

    /**
    * Society Location
    *
    * @type oe24.oe24.society.SocietyLocation
    * @optional
    */
    protected $location;

    /**
    * Society Performance
    *
    * @type oe24.oe24.society.SocietyPerformance
    */
    protected $performance;

    /**
    * Society Category
    *
    * @type oe24.oe24.society.SocietyCategory
    */
    protected $category;

    /**
    * Society Organizer
    *
    * @type oe24.oe24.society.SocietyOrganizer
    * @optional
    */
    protected $organizer;

    /**
    * Oeticket url
    * Url to oeticket sale
    *
    * @type string
    * @optional
    */
    protected $oeticketUrl;

    /**
    * Extern url
    * E.g. a Url to a Content Partner
    *
    * @type string
    * @optional
    */
    protected $externUrl;

    /**
    * Some Tags
    *
    * @type string
    * @optional
    */
    protected $tags;

    /**
    * Internal Comment
    *
    * @type string
    * @optional
    */
    protected $commentIntern;

    /**
    * Some Flags for this event
    *
    * @type map<string, any>
    */
    protected $flags;
    
    /**
    * get flag value
    * 
    * @param mixed $name
    */
    public function getFlagValue($name){
        $flags = $this->getFlags();
        return $flags->get($name);
    }
}
?>
