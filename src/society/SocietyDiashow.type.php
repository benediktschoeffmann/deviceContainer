<?php
/**
* Society Diashow
*/
class SocietyDiashow extends spunQ_DataObject{

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
    * Society Performance
    *
    * @type oe24.oe24.society.SocietyPerformance
    * @optional
    */
    protected $performance;

    /**
    * Array of Society Fotos
    *
    * @type array<oe24.oe24.society.SocietyFoto>
    * @optional
    */
    protected $fotos;

    /**
    * count of all fotos
    *
    * @type integer
    */
    protected $fotoCount;

    /**
    * Link
    *
    * @type string
    */
    protected $link;

    /**
    * Diashow confirmed by a administrator
    *
    * @type integer
    */
    protected $checked;

    /**
    * Map of Options
    *
    * @type map<string, string>
    */
    protected $options;

    /**
    * SEO URL Parameter
    *
    * @type string
    */
    protected $seoUrl;
    
    /**
    * get url for first foto
    *
    * @param string $baseUrl
    * @return string
    */
    public function getFirstFotoUrl($baseUrl){
        $fotos = $this->getFotos();
        if($fotos){
            $foto = reset($fotos);
            return $foto->getUrl($baseUrl, $this);
        }
    }

    /**
    * get url for first thumb foto
    *
    * @param string $baseUrl
    * @return string
    */
    public function getFirstFotoThumbUrl($baseUrl){
        $fotos = $this->getFotos();
        if($fotos){
            $foto = reset($fotos);
            return $foto->getThumbUrl($baseUrl, $this);
        }
    }
}
?>
