<?php
/**
* Society Performance
*/
class SocietyPerformance extends spunQ_DataObject{

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
    protected $oeticketPerformanceId;

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
    * Society Location
    *
    * @type oe24.oe24.society.SocietyLocation
    * @optional
    */
    protected $location;

    /**
    * Society Category
    *
    * @type oe24.oe24.society.SocietyCategory
    * @optional
    */
    protected $category;

    /**
    * Oeticket url
    * Url to oeticket sale
    *
    * @type string
    * @optional
    */
    protected $oeticketUrl;

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
}
?>
