<?php
ob_start();
/**
* Society API Requests
* Convert Request to Spunq Objects
*/
class SocietyApiRequest{

    static $urlCache = array();

    /**
    * get the api url
    *
    * @return string
    */
    static function getApiUrl(){
        $oe24Config = spunQ::getConfiguration()->getStringsForPrefix("oe24.oe24");
        $url = trim($oe24Config["societyIncludeUrl"], " /");
        $url .= "/api.php";
        return $url;
    }

    /**
    * get ximple xml data from a url
    * result is cached to save further request
    *
    * @param string $url
    * @return string
    */
    static function getSimpleXmlFromUrl($url){
        $hash = md5($url);
        if(isset(self::$urlCache[$hash])){
            return self::$urlCache[$hash];
        }
        debug("Request Society API: ".$url);
        $browser = spunQ_HttpBrowser::sendRequest($url, 5, false);
        if(!$browser){
            return;
        }
        $xmlData = $browser->getBody();
        try{
            self::$urlCache[$hash] = new SimpleXMLElement($xmlData, LIBXML_NOCDATA);
        }catch(Exception $e){
            self::$urlCache[$hash] = NULL;
        }
        return self::$urlCache[$hash];
    }

    /**
    * get events for a search query
    *
    * @param array $queryParams
    * @return array or NULL
    */
    static function getEvents(array $queryParams){
        $queryParams["action"] = "getEvents";
        $urlQuery = http_build_query($queryParams);
        $requestUrl = self::getApiUrl()."?".$urlQuery;
        $xml = self::getSimpleXmlFromUrl($requestUrl);
        $array = array("events");
        if($xml){
            $events = $xml->xpath("/data/event");
            if($events){
                foreach($events as $event){
                    $array["events"][] = self::eventToObject($event);
                }
            }
            $array["allRowsCount"] = $xml->xpath("/data/allRowsCount");
            $array["allRowsCount"] = (int)$array["allRowsCount"][0];
            $array["xml"] = $xml;
        }
        return $array;
    }

    /**
    * get tipps for a search query
    *
    * @param array $queryParams
    * @return array or NULL
    */
    static function getTipps(array $queryParams){
        $queryParams["action"] = "getTipps";
        $urlQuery = http_build_query($queryParams);
        $requestUrl = self::getApiUrl()."?".$urlQuery;
        $xml = self::getSimpleXmlFromUrl($requestUrl);
        $array = array("events");
        if($xml){
            $events = $xml->xpath("/data/event");
            if($events){
                foreach($events as $event){
                    $array["events"][] = self::eventToObject($event);
                }
            }
            $array["xml"] = $xml;
        }
        return $array;
    }

    /**
    * get diashows for a search query
    *
    * @param array $queryParams
    * @return array or NULL
    */
    static function getDiashows(array $queryParams){
        $queryParams["action"] = "getDiashows";
        $urlQuery = http_build_query($queryParams);
        $requestUrl = self::getApiUrl()."?".$urlQuery;
        $xml = self::getSimpleXmlFromUrl($requestUrl);
        $array = array("diashows");
        if($xml){
            $diashows = $xml->xpath("/data/diashow");
            if($diashows){
                foreach($diashows as $diashow){
                    $array["diashows"][] = self::diashowToObject($diashow);
                }
            }
            $array["allRowsCount"] = $xml->xpath("/data/allRowsCount");
            $array["allRowsCount"] = (int)$array["allRowsCount"][0];
            $array["xml"] = $xml;
        }
        return $array;
    }

    /**
    * get data for searchbox
    *
    * @return array<string, array<any>> or NULL
    */
    static function getDataForSearchbox(){
        $queryParams["action"] = "getDataForSearchbox";
        $urlQuery = http_build_query($queryParams);
        $requestUrl = self::getApiUrl()."?".$urlQuery;
        $xml = self::getSimpleXmlFromUrl($requestUrl);
        $array = array(
            "states" => array(),
            "categories" => array(),
            "locations" => array()
        );
        if($xml){
            $lands = $xml->xpath("/data/lands/land");
            if($lands){
                foreach($lands as $land){
                    $data = $land->{"table_lands"};
                    $array["states"][] = self::stateToObject($data);
                }
            }
            $locations = $xml->xpath("/data/locations/location");
            if($locations){
                foreach($locations as $location){
                    $data = $location->{"table_locations"};
                    $array["locations"][] = self::locationToObject($data);
                }
            }
            $categories = $xml->xpath("/data/categories");
            if($categories){
                $categories = array_shift($categories);
                $childrens = $categories->children();
                foreach($childrens as $category){
                    $array["categories"][] = self::categoryToObject($category);
                }
            }
            $events = $xml->xpath("/data/priorityEvents/event");
            if($events){
                foreach($events as $event){
                    $array["events"][] = self::eventToObject($event);
                }
            }
        }
        return $array;
    }

    /**
    * convert diashow to object
    *
    * @param SimpleXMLElement $diashowXml
    * @return SocietyEvent
    */
    static function diashowToObject(SimpleXMLElement $diashowXml){
        $diashow = new SocietyDiashow();

        # fetch performance
        $xmlPerformanceData = $diashowXml->xpath("table_performance");
        if($xmlPerformanceData){
            $performance = self::performanceToObject(array_shift($xmlPerformanceData));
            # fetch categories
            $xmlCategoryData = $diashowXml->xpath("table_main_categorys");
            $xmlMiddleCategoryData = $diashowXml->xpath("table_middle_categorys");
            $xmlSubCategoryData = $diashowXml->xpath("table_sub_categorys");
            $category = NULL;
            if($xmlCategoryData){
                $category = new SocietyCategory();
                $category->setName(self::convertXmlDataToSpunqType($xmlCategoryData[0]->category_name));
                $category->setFormerId(self::convertXmlDataToSpunqType($xmlMiddleCategoryData[0]->main_category_id));
                if($xmlMiddleCategoryData){
                    $middleCategory = new SocietyCategory();
                    $middleCategory->setName(self::convertXmlDataToSpunqType($xmlMiddleCategoryData[0]->category_name));
                    $middleCategory->setFormerId(self::convertXmlDataToSpunqType($xmlMiddleCategoryData[0]->middle_category_id));
                    $category->setChildrens(array($middleCategory));
                }
            }
            if($category){
                $performance->setCategory($category);
            }
            # fetch place informations
            $xmlPlaceData = $diashowXml->xpath("table_citys");
            $xmlStateData = $diashowXml->xpath("table_lands");
            $xmlCountryData = $diashowXml->xpath("table_countrys");
            $place = NULL;
            if($xmlPlaceData){
                $place = self::placeToObject(array_shift($xmlPlaceData), array_shift($xmlStateData), array_shift($xmlCountryData));
            }

            # fetch locations
            $xmlLocationData = $diashowXml->xpath("table_locations");
            if($xmlLocationData){
                $location = self::locationToObject(array_shift($xmlLocationData), $place);
                $performance->setLocation($location);
            }
            $diashow->setPerformance($performance);
        }

        # fotos
        $xmlFotosData = $diashowXml->xpath("table_fotos");
        if($xmlFotosData){
            $fotos = array();
            foreach($xmlFotosData as $fotoData){
                $foto = self::fotoToObject($fotoData);
                $fotos[(int)$fotoData->sorting] = $foto;
            }
            ksort($fotos);
            $diashow->setFotos($fotos);
        }

        # diashow data
        $keyMapping = array(
            "diashow_id" => "formerId",
            "titel" => "title",
            "link" => "link",
            "checked" => "checked",
            "seo_url" => "seoUrl"
        );
        $xmlDiashowData = $diashowXml->xpath("table_diashows");
        $xmlDiashowData = array_shift($xmlDiashowData);
        self::setPropertiesByKeyMapping($diashow, $xmlDiashowData, $keyMapping);
        # additional data
        $xmlAddData = $diashowXml->xpath("table_");
        if($xmlAddData){
            $diashow->setFotoCount(self::convertXmlDataToSpunqType($xmlAddData[0]->fotoCount));
        }
        # Options
        $options = unserialize(self::convertXmlDataToSpunqType($xmlDiashowData->options));
        $options = !$options ? array() : $options;
        $optionMap = new spunQ_Map();
        $optionMap->setKeysAndValues(array_keys($options), array_values($options));
        $diashow->setOptions($optionMap);
        return $diashow;
    }

    /**
    * convert event to object
    *
    * @param SimpleXMLElement $eventXml
    * @return SocietyEvent
    */
    static function eventToObject(SimpleXMLElement $eventXml){
        $event = new SocietyEvent();
        # fetch categories
        $xmlCategoryData = $eventXml->xpath("table_main_categorys");
        $xmlMiddleCategoryData = $eventXml->xpath("table_middle_categorys");
        $xmlSubCategoryData = $eventXml->xpath("table_sub_categorys");
        $category = NULL;
        if($xmlCategoryData){
            $category = new SocietyCategory();
            $category->setName(self::convertXmlDataToSpunqType($xmlCategoryData[0]->category_name));
            $category->setFormerId(self::convertXmlDataToSpunqType($xmlMiddleCategoryData[0]->main_category_id));
            if($xmlMiddleCategoryData){
                $middleCategory = new SocietyCategory();
                $middleCategory->setName(self::convertXmlDataToSpunqType($xmlMiddleCategoryData[0]->category_name));
                $middleCategory->setFormerId(self::convertXmlDataToSpunqType($xmlMiddleCategoryData[0]->middle_category_id));
                $category->setChildrens(array($middleCategory));
            }
            $event->setCategory($category);
        }
        # fetch place informations
        $xmlPlaceData = $eventXml->xpath("table_citys");
        $xmlStateData = $eventXml->xpath("table_lands");
        $xmlCountryData = $eventXml->xpath("table_countrys");
        $place = NULL;
        if($xmlPlaceData){
            $place = self::placeToObject(array_shift($xmlPlaceData), array_shift($xmlStateData), array_shift($xmlCountryData));
        }

        # fetch locations
        $xmlLocationData = $eventXml->xpath("table_locations");
        if($xmlLocationData){
            $location = self::locationToObject(array_shift($xmlLocationData), $place);
            $event->setLocation($location);
        }

        # fetch performance
        $xmlPerformanceData = $eventXml->xpath("table_performance");
        if($xmlPerformanceData){
            $performance = self::performanceToObject(array_shift($xmlPerformanceData));
            $event->setPerformance($performance);
        }

        # fetch organizer
        $xmlOrganizerData = $eventXml->xpath("table_organizer");
        if($xmlOrganizerData){
            $organizer = self::organizerToObject(array_shift($xmlOrganizerData));
            $event->setOrganizer($organizer);
        }
        # event data
        $keyMapping = array(
            "event_id" => "formerId",
            "oeticket_event_id" => "oeticketEventId",
            "name" => "name",
            "priority" => "priority",
            "date_from" => "dateFrom",
            "date_to" => "dateTo",
            "date_sales_from" => "dateSalesFrom",
            "date_sales_to" => "dateSalesTo",
            "image_url" => "imageUrl",
            "url_oeticket" => "oeticketUrl",
            "extern_url" => "externUrl",
            "comment_intern" => "commentIntern",
            "tags" => "tags"
        );
        $xmlEventData = $eventXml->xpath("table_events");
        $xmlEventData = array_shift($xmlEventData);
        self::setPropertiesByKeyMapping($event, $xmlEventData, $keyMapping);
        $flagMap = new spunQ_Map();
        foreach($xmlEventData as $key => $value){
            if(substr($key, -2) == "_b"){
                $flagMap->add(substr($key, 0, -2), ((int)$value) ? true : false);
            }
        }
        $event->setFlags($flagMap);

        # fetch description data
        $descriptionDE = self::convertXmlDataToSpunqType($xmlEventData->description_de);
        $descriptionEN = self::convertXmlDataToSpunqType($xmlEventData->description_en);
        if($descriptionDE or $descriptionEN){
            $descriptionMap = new spunQ_Map();
            $description = new SocietyDescription();
            $description->setDescriptionDE($descriptionDE);
            $description->setDescriptionEN($descriptionEN);
            $event->setDescription($description);
        }
        return $event;
    }

    /**
    * convert performance to object
    *
    * @param SimpleXMLElement $performanceXml
    * @return SocietyPerformance
    */
    static function performanceToObject(SimpleXMLElement $performanceXml){
        $keyMapping = array(
            "performance_id" => "formerId",
            "oeticket_performance_id" => "oeticketPerformanceId",
            "name" => "name",
            "priority" => "priority",
            "date_from" => "dateFrom",
            "date_to" => "dateTo",
            "date_sales_from" => "dateSalesFrom",
            "date_sales_to" => "dateSalesTo",
            "comment_intern" => "commentIntern",
            "url_oeticket" => "oeticketUrl",
            "tags" => "tags"
        );
        $object = new SocietyPerformance();
        self::setPropertiesByKeyMapping($object, $performanceXml, $keyMapping);
        return $object;
    }

    /**
    * convert foto to object
    *
    * @param SimpleXMLElement $fotoXml
    * @return SocietyFoto
    */
    static function fotoToObject(SimpleXMLElement $fotoXml){
        $keyMapping = array(
            "foto_id" => "formerId",
            "titel" => "title",
            "txt" => "description",
            "copyright" => "copyright",
            "extension" => "extension"
        );
        $object = new SocietyFoto();
        self::setPropertiesByKeyMapping($object, $fotoXml, $keyMapping);
        return $object;
    }

    /**
    * convert category to object
    *
    * @param SimpleXMLElement $category
    * @return SocietyCategory
    */
    static function categoryToObject(SimpleXMLElement $category){
        $childs = array();
        $object = new SocietyCategory();
        $object->setFormerId(self::convertXmlDataToSpunqType($category->id));
        $object->setName(self::convertXmlDataToSpunqType($category->name));
        if($category->childrens){
            $childrens = $category->childrens->children();
            foreach($childrens as $child){
                $childs[] = self::categoryToObject($child);
            }
        }
        if($childs){
            $object->setChildrens($childs);
        }
        return $object;
    }

    /**
    * convert location to object
    *
    * @param SimpleXMLElement $locationXml
    * @param mixed $place
    * @return SocietyLocation
    */
    static function locationToObject(SimpleXMLElement $locationXml, $place = NULL){
        $keyMapping = array(
            "location_id" => "formerId",
            "oeticket_venue_id" => "oeticketVenueId",
            "location_name" => "name",
            "address" => "address",
            "latitude" => "latitude",
            "longitude" => "longitude"
        );
        $object = new SocietyLocation();
        self::setPropertiesByKeyMapping($object, $locationXml, $keyMapping);
        if($place){
            $object->setPlace($place);
        }
        return $object;
    }

    /**
    * convert organizer to object
    *
    * @param SimpleXMLElement $organizerXml
    * @return SocietyOrganizer
    */
    static function organizerToObject(SimpleXMLElement $organizerXml){
        $keyMapping = array(
            "organizer_id" => "formerId",
            "name" => "name",
            "comment" => "comment",
            "comment_intern" => "commentIntern",
            "email" => "email",
            "phone" => "phone",
            "fax" => "fax"
        );
        $object = new SocietyOrganizer();
        self::setPropertiesByKeyMapping($object, $organizerXml, $keyMapping);
        return $object;
    }

    /**
    * convert place to object
    *
    * @param SimpleXMLElement $cityXml
    * @param SimpleXMLElement $stateXml
    * @param SimpleXMLElement $countryXml
    * @return SocietyPlace
    */
    static function placeToObject(SimpleXMLElement $cityXml, SimpleXMLElement $stateXml, SimpleXMLElement $countryXml){
        $keyMapping = array(
            "city_id" => "formerId",
            "city_name" => "name",
            "zip" => "zip"
        );
        $place = new SocietyPlace();
        self::setPropertiesByKeyMapping($place, $cityXml, $keyMapping);

        $state = self::stateToObject($stateXml);
        $country = self::countryToObject($countryXml);

        $place->setState($state);
        $state->setCountry($country);

        return $place;
    }

    /**
    * convert state to object
    *
    * @param SimpleXMLElement $stateXml
    * @return SocietyState
    */
    static function stateToObject(SimpleXMLElement $stateXml){
        $keyMapping = array(
            "land_id" => "formerId",
            "land_name" => "name"
        );
        $state = new SocietyState();
        self::setPropertiesByKeyMapping($state, $stateXml, $keyMapping);
        return $state;
    }

    /**
    * convert country to object
    *
    * @param SimpleXMLElement $countryXml
    * @return SocietyCountry
    */
    static function countryToObject(SimpleXMLElement $countryXml){
        $keyMapping = array(
            "country_id" => "formerId",
            "country_name" => "name",
            "country_code" => "countryCode"
        );
        $country = new SocietyCountry();
        self::setPropertiesByKeyMapping($country, $countryXml, $keyMapping);
        return $country;
    }

    /**
    * set properties by key mapping
    *
    * @param mixed $object
    * @param SimpleXMLElement $data
    * @param mixed $keyMapping
    */
    static function setPropertiesByKeyMapping(&$object, SimpleXMLElement &$data, array &$keyMapping){
        foreach($keyMapping as $oldKey => $newKey){
            $value = self::convertXmlDataToSpunqType($data->{$oldKey});
            if($oldKey == "country_code"){
                $value = mb_substr($value, 0, 2);
            }
            $object->{"set".ucfirst($newKey)}($value);
        }
    }

    /**
    * convert simple xml value to spunq values
    *
    * @param SimpleXMLElement $data
    * @return mixed
    */
    static function convertXmlDataToSpunqType(SimpleXMLElement $data){
        $type = "string";
        if($data->attributes() && isset($data->attributes()->type)){
            $type = $data->attributes()->type;
        }
        $value = $data;
        switch($type){
            case "int":
                $value = (int)$value;
            break;
            case "real":
                $value = (real)$value;
            break;
            case "datetime":
                $value = new spunQ_DateTime($value);
            break;
            default:
                $value = (string)$value;
        }
        return $value;
    }
}