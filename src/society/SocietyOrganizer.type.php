<?php
/**
* Society Organizer
*/
class SocietyOrganizer extends spunQ_DataObject{
    
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
    * Comment
    *
    * @type string
    */
    protected $comment;

    /**
    * Comment Intern
    *
    * @type string
    */
    protected $commentIntern;

    /**
    * Email
    *
    * @type string
    */
    protected $email;

    /**
    * Phone
    *
    * @type string
    */
    protected $phone;

    /**
    * Fax
    *
    * @type string
    */
    protected $fax;
}
?>
