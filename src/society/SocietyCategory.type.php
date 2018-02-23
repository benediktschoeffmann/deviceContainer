<?php
/**
* Society Category
*/
class SocietyCategory extends spunQ_DataObject{
    
    /**
    * the id from the external php app
    * 
    * @type integer
    */
    protected $formerId;

    /**
    * Child Categories
    *
    * @type array<oe24.oe24.society.SocietyCategory>
    * @optional
    */
    protected $childrens;

    /**
    * Name
    *
    * @type string
    */
    protected $name;
}
?>
