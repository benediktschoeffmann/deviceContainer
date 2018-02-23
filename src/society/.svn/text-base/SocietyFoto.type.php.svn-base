<?php
/**
* Society Foto
*/
class SocietyFoto extends spunQ_DataObject{

    /**
    * the id from the external php app
    *
    * @type integer
    */
    protected $formerId;

    /**
    * Title
    *
    * @type string
    */
    protected $title;

    /**
    * Description
    *
    * @type string
    */
    protected $description;

    /**
    * Copyright
    *
    * @type string
    */
    protected $copyright;

    /**
    * Foto Extension
    *
    * @type string
    * @length.max 4
    */
    protected $extension;

    /**
    * get url to foto
    *
    * @param string $baseUrl
    * @param SocietyDiashow $diashow
    * @return string
    */
    public function getUrl($baseUrl, SocietyDiashow $diashow){
        return $baseUrl."/fotos/".$diashow->getFormerId()."_".$this->getFormerId().".".$this->getExtension();
    }

    /**
    * get thumb url
    *
    * @param string $baseUrl
    * @param SocietyDiashow $diashow
    * @return string
    */
    public function getThumbUrl($baseUrl, SocietyDiashow $diashow){
        return $baseUrl."/fotos/thumbs/".$diashow->getFormerId()."_".$this->getFormerId().".".$this->getExtension();
    }
}
?>
