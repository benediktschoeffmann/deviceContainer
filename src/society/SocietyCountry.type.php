<?php
/**
* Society Country
*/
class SocietyCountry extends spunQ_DataObject{
    
    /**
    * the id from the external php app
    * 
    * @type integer
    */
    protected $formerId;
    
    /**
    * Name
    *
    * @type string
    */
    protected $name;

    /**
    * International Country Code
    *
    * @type string
    * @length.max 2
    */
    protected $countryCode;
}
?>
