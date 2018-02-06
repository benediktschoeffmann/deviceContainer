<?php

class Oe24NewsletterApi
{
    private static $_username;
    private static $_secret;
    private static $_suiteApiUrl;

    private static $instance = null;

    private static $_newsletterEmail = null;

    public static function getInstance() {
        if (self::$instance === NULL) {
            self::$instance = new self();

            self::$_username = 'oe24002';
            self::$_secret = 'cCG3BeRkEQiKH0Q6WIUy';
            self::$_suiteApiUrl = 'https://api.emarsys.net/api/v2/';
        }
        return self::$instance;
    }

    /**
     * Send a request to Emarsys-Newsletter System
     * @param string requestType - GET, POST, PUT or DELETE
     * @param string endPoint - path to emmarsys script, based on https://documentation.emarsys.com
     * @param string requestBody - data to transmit (JSON)
     */
     public function send($requestType, $endPoint, $requestBody = '') {

        if (!in_array($requestType, array('GET', 'POST', 'PUT', 'DELETE'))) {
            throw new Exception('Send first parameter must be "GET", "POST", "PUT" or "DELETE"');
        }

        // if ( empty( $requestBody ) ) {
        //     throw new Exception('No content to deliver - requestBody is empty');
        // }


        // json
        $requestBody = json_encode( $requestBody );

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        switch ($requestType)
        {
            case 'GET':
                curl_setopt($ch, CURLOPT_HTTPGET, 1);
                break;
            case 'POST':
                curl_setopt($ch, CURLOPT_POST, 1);
                curl_setopt($ch, CURLOPT_POSTFIELDS, $requestBody);
                break;
            case 'PUT':
                curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "PUT");
                curl_setopt($ch, CURLOPT_POSTFIELDS, $requestBody);
                break;
            case 'DELETE':
                curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "DELETE");
                curl_setopt($ch, CURLOPT_POSTFIELDS, $requestBody);
                break;
        }
        curl_setopt($ch, CURLOPT_HEADER, true);

        $requestUri = self::$_suiteApiUrl . $endPoint;
        curl_setopt($ch, CURLOPT_URL, $requestUri);

        /**
         * We add X-WSSE header for authentication.
         * Always use random 'nonce' for increased security.
         * timestamp: the current date/time in UTC format encoded as
         *   an ISO 8601 date string like '2010-12-31T15:30:59+00:00' or '2010-12-31T15:30:59Z'
         * passwordDigest looks sg like 'MDBhOTMwZGE0OTMxMjJlODAyNmE1ZWJhNTdmOTkxOWU4YzNjNWZkMw=='
         */
        $nonce = 'd36e356272951b1bbe8cba51497a717f';
        $timestamp = gmdate("c");
        $passwordDigest = base64_encode(sha1($nonce . $timestamp . self::$_secret, false));
        curl_setopt($ch, CURLOPT_HTTPHEADER, array(
            'X-WSSE: UsernameToken ' .
                'Username="'.self::$_username.'", ' .
                'PasswordDigest="'.$passwordDigest.'", ' .
                'Nonce="'.$nonce.'", ' .
                'Created="'.$timestamp.'"',
            'Content-type: application/json;charset=\"utf-8\"',
            )
        );

        $output = curl_exec($ch);
        curl_close($ch);

        // nur json berücksichtigen
        $firstPosition = mb_strpos($output, '{');
        if ( false !== $firstPosition ) {
            $output = mb_substr($output, $firstPosition);
        }
        // return object
        $output = json_decode($output, true, 512);

        return $output;
    }

    /**
     * Get a Contact-Info for specific user(s)
     * @param array aUser
     * @param string key-feld aufgrund dessen geprüft wird ... 3 = emailfeld
     * @param bool get All Fields
     */
    public function getContactInfo ( $aUsers = array(), $keyField = 'uid', $getAllFields = false ) {
        if ( count($aUsers) > 0 ) {
            /*
                fields:
                1 ... Firstname
                2 ... Lastname
                3 ... E-Mail
                31 ... Opt-In
            */
            $requestBody = array (
                'keyId' => $keyField,
                'keyValues' => $aUsers,
                //'fields' => array('1','2','3','31', '15826'),
                // 'fields' => array(3),
                // 'fields' => array(),
            );
            $requestBody['fields'] = ($getAllFields) ? array() : array('1','2','3','31', '15826');

            $output = self::send('POST', 'contact/getdata', $requestBody);
            return $output;
        }

        return false;
    }


    /**
     * Update contact
     * @param string unique value of the contact
     * @param string key-field
     * @param array fields to update - key: fieldname, value: new values to set
     */
    public function updateContact ( $userKeyValue, $keyField = 'uid', $update = array() ) {
        if ( count($update) > 0 ) {

            $requestBody = array (
                'key_id' => $keyField,
                $keyField => $userKeyValue,
                'create_if_not_exists' => 0,
            );

            // update an request anhängen
            $requestBody = $requestBody + $update;

            $output = self::send('PUT', 'contact/?create_if_not_exists=0', $requestBody);

            return $output;
        }

        return false;
    }

    /**
     * Create a new contact
     * @param string email
     * @param string firstname
     * @param string lastname
     * @param integer gender
     * @param string companyname
     * @param array interests
     * @param bool newsletter
     */
    public function createContact ( $email, $firstName = '', $lastName = '', $gender = '', $companyname = '', $interests = array(), $newsletter = false ) {
        if (mb_strlen($email)) {

            // emarsys-id for field 'email' = 3 ... this is the unique keyfield
            $requestBody = array (
                'key_id' => '3',
                '3' => $email,
            );

            // emarsys-id for field 'firstname' = 1
            if ($firstName) {
                $requestBody['1'] = $firstName;
            }
            // emarsys-id for field 'lastname' = 2
            if ($lastName) {
                $requestBody['2'] = $lastName;
            }
            // emarsys-id for field 'gender' = 5
            if ($gender) {
                $requestBody['5'] = $gender; // gender
                $requestBody['46'] = $gender; // salutation
            }
            // emarsys-id for field 'companyname' = 18
            if ($companyname) {
                $requestBody['18'] = $companyname; // companyname
            }

            if ($interests) {
                $requestBody['15826'] = $interests;
            }

            if ($newsletter) {
                $requestBody['17117'] = 'formularRegistrierung ' . $newsletter;
            }

            $output = self::send('POST', 'contact', $requestBody);

            return $output;
        }

        return false;
    }

    /**
     * start registration process at emarsys (= emarsys form)
     * @param string newsletter - right now only for oe24, joe24, meinjob, gewinn and fellner!live possible
     */
    public function triggerRegistrationForm ( $contactEmail, $newsletter ) {

        // externes event bei emarsys - Registrierung joe24 - 3371; Registrierung oe24 - 4045, meinjob - 4103, gewinn - 4140, fellner!live - 4153
        $validNewsletterForms = array(
            'joe24'        => 3371,
            'oe24'         => 4045,
            'meinjob'      => 4103,
            'gewinn'       => 4140,
            'fellner'      => 4153,
            'mediamonitor' => 4265,
        );
        if (!isset($validNewsletterForms[$newsletter])) return false;

        $eventId = $validNewsletterForms[$newsletter];

        $requestBody = array (
            'key_id' => '3',
            'external_id' => $contactEmail,
        );

        $endPoint = 'event/' . $eventId . '/trigger';
        $output = self::send('POST', $endPoint, $requestBody);

        return $output;
    }

    public function getExternalEvents(){

        $output = self::send('GET', 'event');

        return $output;
    }



    /**
     * Get Campaign Data for a specific email-id
     * @param integer email-id
     */
    public function getCampaignData ( $emailId ) {
        if ( $emailId > 0 ) {

            $requestBody = array (
                'id' => $emailId,
            );

            $output = self::send('GET', 'email/'.$emailId);

            return $output;
        }

        return false;
    }

    /**
     * Get Sections for a specific email-id
     * @param integer email-id
     */
    public function getEmailSections ( $emailId ) {
        if ( $emailId > 0 ) {

            $requestBody = array (
                'email_id' => $emailId,
            );

            $output = self::send('GET', 'email/'.$emailId.'/sections', $requestBody);

            return $output;
        }

        return false;
    }


    /**
     * Get all existing segments
     */
    public function getSegments () {
        $output = self::send('GET', 'email/filter');

        return $output;
    }

    /**
     * unsubscribe an User from a specific newsletter-launch
     * This way it is included in the stats.
     * @param launchListId integer
     * @param emailId integer
     * @param contactId string
     *
    */
    public function unsubscribeFromLaunch($launchListId, $emailId, $contactId) {
        $requestBody = array (
            'launch_list_id' => $launchListId, //'158871',
            'email_id' => $emailId,
            'contact_uid' => $contactId,
        );

        $output = self::send('POST', 'email/unsubscribe', $requestBody);

        return $output;


    }

    /**
     * Get all existing segments
     * @param string email-address
     * @param array newsletter to unsubscribe eg: array('oe24','marketing')
     */
    public function unsubscribe ($email, $lists = array()) {

        $segmentFieldInContact = array();
        foreach ($lists as $key => $segment) {

            // get segment field-id in contact-object and add to update-array
            $segmentInContact = self::_getSegmentField($segment);

            $segmentFieldInContact = $segmentFieldInContact + $segmentInContact;

        }

        if ($segmentFieldInContact) {
            // update contact
            $update = self::updateContact ( $email, '3', $segmentFieldInContact );

            return $update;
        }

        // Unsubscribe nicht ausgeführt
        return false;
    }

    /**
     * get email of an user
     * @param userid string
     */
    public function getUserEmail ($userid) {
        if (mb_strlen($userid)) {
            $userData = self::getContactInfo ( array($userid) , 'uid');

            if (isset($userData['replyCode'])) {
                if ($userData['replyCode'] === 0) {

                    if (isset($userData['data']['result'][0][3])) {
                        if (mb_strlen($userData['data']['result'][0][3])){
                            return $userData['data']['result'][0][3];
                        }
                    }
                }
            }

        }

        return false;
    }

    /**
     * is an user registered for a specific newsletter
     * @param string email
     * @param string newsletter
     */
    public function isUserActivated($email, $newsletter) {
        $userIsRegistered = false;

        if ($segments = self::_getSegmentField($newsletter)){
            if ($user = self::getContactInfo ( array($email), '3', true ) ) {

                // valid user only replyCode == 0 and if field 'errorcode' is empty (= 0)
                if (isset($user['replyCode']) && $user['replyCode'] == 0 && !$user['data']['errors']){

                    // generell opt-in
                    $optIn = ($user['data']['result'][0][5]) ? true : false;

                    // newsletter opt-in
                    $newsletterOptIn = false;
                    foreach($segments as $segment => $value) {
                        $newsletterOptIn = ($user['data']['result'][0][$segment] == '1') ? true : false;
                        // stop sobald ein feld nicht aktiviert wurde -> Registrierung notwendig
                        if (!$newsletterOptIn) break;
                    }

                    $userIsRegistered = ($optIn && $newsletterOptIn) ? true : false;
                }

            }
        }

        return $userIsRegistered;
    }

    /**
    * get Emarsys field definitions for our segments ("translation"-helper)
    * @param string segment
    * @param boolean emarsys-fieldname or newslettername
    * @param boolean get subscribe (1) or unsubscribe (2) emarsys-value
    */
    private function _getSegmentField ($segment, $field = true, $subscribe = false) {

        $contactFields = false;
        $newsletter = false;

        // emarsys-values: 1 ... ja | 2 ... nein
        $fieldValue = ($subscribe) ? 1 : 2;

        switch ($segment) {

            // meinjob
            case '25998': // user die bei meinjob-registriert
            case '109419': // mein-job wien emarsys
            case '109425': // mein-job niederösterreich emarsys
            case '109407': // alle mein-job user (inklusive gewinnspiele)
            case '122604': // meinjob aus Marketingliste nur NÖ und Wien PLZ
            case '122605': // meinjob aus Marketingliste nur Niederösterreich und Wien Ema
            case '122404': // meinjob aus Marketingliste nur NÖ PLZ
            case '122381': // meinjob aus Marketingliste nur Wien PLZ

            // Kombinierte Segmente
            case '1000508760': // Meinjob User plus Meinjobliste aus Marketingliste - kombinierte segment-id: 7544
            case '1000516209': // Meinjob aus (Marketing nur Wien Emarsys+PLZ)+User - kombinierte segment-id: 8759
            case '1000516213': // Meinjob aus (Marketing nur NÖ Emarsys+PLZ)+User - kombinierte segment-id: 8761
            case '1000516300': // meinjob aus Marketingliste Wien und NÖ PLZ und Emarsys - kombinierte segment-id: 8788
            case '1000544674': // meinjob aus (Marketing Wien/NÖ Emarsys)+User - kombinierte segment-id: 17375
            case '1000525429': // Meinjob aus (Marketing nur Salzburg Emarsys+PLZ)+User - kombinierte segment-id: 11600
            case '1000525430': // Meinjob aus (Marketing nur OÖ Emarsys+PLZ)+User - kombinierte segment-id: 11602
            case '1000525431': // Meinjob aus Marketing Trol/VBG Emarsys+PLZ+User - kombinierte segment-id: 11605

            // neu seit 2017-03-10 lt. Mail Hartl
            case '145475': // meinjob aus marketingliste nur Tirol/Vbg Emarsys
            case '145474': // meinjob aus marketingliste nur Tiro/Vbg PLZ
            case '145473': // meinjob aus Marketingliste nur OÖ PLZ
            case '145471': // meinjob aus Marketingliste nur OÖ Emarsys
            case '145459': // meinjob aus Marketingliste nur Salzburg Emarsys
            case '145460': // meinjob aus Marketingliste nur Salzburg PLZ
            case '11605': // Meinjob aus Marketingliste nur Tirol/Vbg Emarsys und PLZ
            case '11602': // meinjob aus Marketingliste nur OÖ Emarsys und PLZ
            case '11600': // meinjob aus Marketingliste nur Salzburg Emarsys und PLZ

            case 'meinjob':
                $contactFields = array(
                    '6714' => $fieldValue, // meinjob
                    '14362' => $fieldValue, // meinjob-Gewinnspielteilnahme
                );
                $newsletter = 'MeinJob';
                break;

            // oe24
            case '36507': // d-berger testsegment
            case '25999': // Testliste Online Technik
            case '44009': // Testliste Redaktion
            // oe24-klein - egal ob "oe24-klein" oder "oe24-groß", wenn user sich von einem abmeldet, Abmeldung gilt für beide
            // 6715 = oe24-erweitert | 6716 = oe24
            case '25997':
            // oe24-groß
            case '25993':
            case 'oe24':
                $contactFields = array(
                   '6715' => $fieldValue, // oe24 groß
                   '6716' => $fieldValue, // oe24 klein
                );
                $newsletter = 'OE24';
                break;

            case '154095': // OE24 TV
            case 'oe24tv':
                $contactFields = array('16202' => $fieldValue ); //Feld 'oe24_tv'
                $newsletter = 'oe24 TV';
                break;

            // joe24
            case '25992': // joe24-Mailliste
            case '44013': // Testliste Joe24
            case '117784': // joe24-Kreuzfahrer
            case '1000534162': // kombiniertes joe24-Dummy-Segment - joe24 kann diesem Segment eigene Segmente zuordnen und abmelden funktioniert trotzdem
            case 'joe24':
                $contactFields = array('6712' => $fieldValue );
                $newsletter = 'Joe24';
                break;

            // marketing
            // (db) 2017-06-02 mail von Matthias - bei Abmeldung von Segment 'Marketing' oder 'marketing ohne JOE24' von Marketing und JOE24 abmelden
            case 'marketing':
            case '51853': // marketing ohne joe24
            case '110392': // oe24-marketing plus joe24
            case '110420': // oe24-marketing
                $contactFields = array(
                    '6713' => $fieldValue, // marketing
                    '6712' => $fieldValue, // joe24
                );
                $newsletter = 'Marketing';
                break;
            // nur marketing und nicht joe24 abmelden
            case '25991': // marketing-mailliste
            case '126878': // temporäre Kontaktliste für Marketing
                $contactFields = array(
                    '6713' => $fieldValue, // marketing
                );
                $newsletter = 'Marketing';
                break;

            // additional
            case '112046': // oe24-Kunden und Agenturen
            case '112047': // MGÖ Kunden und Agenturen
                $contactFields = array(
                    '14502' => $fieldValue, // oe24-Agenturen
                    '14503' => $fieldValue, // mediengruppe österreich
                );
                // $newsletter = 'OE24';
                break;

            case '112048': // Einladungen
                $contactFields = array('14504' => $fieldValue ); // Einladungen
                break;

            case '117329': // Antenne-Kunden
                $contactFields = array('14740' => $fieldValue ); // Antenne Kunden
                break;

            // Gewinnspielteilnahme via Tomcat
            case 'gewinn': // Gewinnspieluser -> für oe24, oe24-erweitert, marketing, meinjob
            case 'gew':
                $contactFields = array(
                   '6715' => $fieldValue, // oe24 groß
                   '6716' => $fieldValue, // oe24 klein
                   '6713' => $fieldValue, // marketing
                   '6714' => $fieldValue, // meinjob
                );
                break;

            // FELLNER! LIVE Newsletter
            case 'fellner': // FELLNER! LIVE Newsletter
            case '195559': // Fellner! Live - Segment
                $contactFields = array('17461' => $fieldValue); // fellnerlive - Segment
                break;
            // Kombinierte Segmente, verwendet für Fellner-Live versenden
            case '1000541558': // Oe24 Groß, TV Gewinnspielteilnehmer und Fellner! Live für oe24-Newsletter (FELLNER! LIVE)
                $contactFields = array(
                    '17461' => $fieldValue, // fellnerlive - Segment
                    '6715'  => $fieldValue, // oe24 groß
                    '6716'  => $fieldValue, // oe24 klein
                    '14362' => $fieldValue, // meinjob-gewinspielteilnehmer
                );
                break;

            // MediaMonitoring Newsletter
            case 'mediamonitor':
            case '224112': // Segment 'MediaMonitor'
                $contactFields = array('17968' => $fieldValue); // mediamonitor
                break;
        }

        // return emarsys-feldname oder newsletter-name
        if ($field) {
            return $contactFields;
        }
        return $newsletter;

    }

    /**
     * Unsubscribe an user via given email-id
     * @param string user-id
     * @param integer email-id
     * @param integer keyfield identifier in user-object, value in $userId
     */
    public function unsubscribeUser ($userId, $emailId, $keyField = 'id') {

        // $userInfo = $oNewsletterApi->getContactInfo ( array($userId), 'uid' );

        $emailData = self::getCampaignData($emailId);

        if (0 === $emailData['replyCode']) {
            if ( isset($emailData['data']['filter']) ){
                // Segmentdata ermitteln - technisch heißt es bei Emarsys "filter", in der Oberfläche "segment"!
                $segment = $emailData['data']['filter'];
                $segmentFieldInContact = self::_getSegmentField($segment);
                $newsletterAbgemeldet = self::_getSegmentField($segment,false);
                if ( !empty($segmentFieldInContact) ) {
                    // mittels user-id aus dem Segment abmelden -> Segment ist ein Feld im Userobjekt
                    $update = self::updateContact ( $userId, $keyField, $segmentFieldInContact );
                    if (0 === $update['replyCode']) {
                        // unsubscribe war erfolgreich - E-Mail Adresse des Kontakts ermitteln
                        $userData = self::getContactInfo ( array($userId) , $keyField );
                        $email = ( isset($userData['data']['result'][0][3]) ) ? $userData['data']['result'][0][3] : '';

                        return array(
                            'email' => $email,
                            'newsletter' => $newsletterAbgemeldet,
                        );
                    }
                }
            }
        }

        return false;
    }

    /**
     * Subscribe to oe24-Newsletter
     * @param string email
     * @param string emarsys-unique id
     * @param string newsletter
     */
    public function subscribeUser ($email, $uid, $newsletter = 'oe24') {
        // uid des Users ermitteln und überprüfen, ob diese übereinstimmt
        $contactData = self::getContactInfo ( array($email), '3' );

        if (isset($contactData['data']['result'][0]['uid'])) {
            $contactUid = $contactData['data']['result'][0]['uid'];
            if ($uid == $contactUid) {
                // activate given newsletter
                $segmentFieldInContact = self::_getSegmentField($newsletter, true, true);

                if ('oe24' == $newsletter) {
                    $segmentFieldInContactOe24Tv = self::_getSegmentField('oe24tv', true, true);

                    $segmentFieldInContact = $segmentFieldInContact + $segmentFieldInContactOe24Tv;
                }

                // set emarsys-field "opt-in" to true
                $segmentFieldInContact['31'] = 1;

                $update = self::updateContact ( $uid, 'uid', $segmentFieldInContact );

                return $update;
            }
        }

        return false;
    }


    /**
     * delete an user from - should not be done, all history will be deleted as well
     * @param string email
     */
    public function deleteUser ($email) {
        if (mb_strlen($email)) {
            // emarsys-id for field 'email' = 3 ... this is the unique keyfield
            $requestBody = array (
                'key_id' => '3',
                '3' => $email,
            );

            $output = self::send('POST', 'contact/delete', $requestBody);
            return $output;
        }

        return false;
    }
    /**
     * Send Registration Mail with activation-link
     * @param string email of existing customer
     * @param string firstname
     * @param string lastname
     */
    public function sendRegistrationMail ($email, $firstName = '', $lastName = '', $newsletter = 'oe24') {
        $contactData = self::getContactInfo ( array($email), $keyField = '3' );

        if (isset($contactData['data']['result'][0]['uid'])) {

            $uid = $contactData['data']['result'][0]['uid'];
            // $subscribeUrl = 'http://www.oe24.at/_api/service_newsletter/' . $newsletter . '/subscribe/' . urlencode($email) . '/' . urlencode($uid);
            $subscribeUrl = 'http://www.oe24.at/service/newsletter/subscribe/' . $newsletter . '/' . urlencode($email) . '/' . urlencode($uid);
            // $subscribeUrl = 'http://www.oe24.at/service/?nl=' . $newsletter . '&em=' . urlencode($email) . '&co=' . urlencode($uid);

            $name = trim($firstName . ' ' . $lastName);
            $salutation =  (0 < mb_strlen($name)) ? 'Hallo ' . $name . ',' : 'Hallo,';

            $teamname = ('joe24' == $newsletter) ? 'Ihr joe24-Team!' : 'Ihr oe24-Team!';

            // Mail an User mit Bestätigungslink senden
            $emailSubject = 'Anfrage zur ' . $newsletter . ' Newsletter Anmeldung';

            $emailMessage = $salutation . chr(10);
            $emailMessage .= 'Ihre Email Anmeldung zum ' . $newsletter . ' Newsletter ist fast abgeschlossen ...' . chr(10) . chr(10);

            $emailMessage .= 'Bitte klicken Sie auf den folgenden Link, um den Newsletter künftig zu erhalten: ' . $subscribeUrl . chr(10);
            $emailMessage .= 'oder kopieren Sie den Link und fügen Sie ihn in die Adresszeile Ihres Browsers ein.' . chr(10) . chr(10);

            $emailMessage .= 'Herzliche Grüße' . chr(10);
            $emailMessage .= $teamname . chr(10);

            $mail = strg_Mail::create($email, 'oe24.at <noreply@oe24.at>', 'oe24.oe24.mail.subject', 'oe24.oe24.mail.body', 'oe24.oe24.mail.bodyHTML_noHeadline');
            $mail->send(array('subject' => $emailSubject,  'text' => $emailMessage));

            return true;

            // mailing not possible on development/test
            if (spunQ::inMode(spunQ::MODE_DEVELOPMENT)) {
                return true;
            }
        }

        return false;
    }

    public function deleteEmail ($id) {
        if ($id) {
            $requestBody = array (
                'emailId' => $id,
            );

            $output = self::send('POST', 'email/delete', $requestBody);
            return $output;
        }

        return false;

    }

    public function updateEmail ($id, $requestBody = array()) {
        if ($id) {
            $requestBody['emailId'] = $id;

            $output = self::send('POST', 'email/' . $id . '/patch', $requestBody);

            return $output;
        }

        return false;

    }

    public function getEmail ($name) {
        // to get all emails from today we have to look for all from yesterday untill tomorrow
        $sYesterday = date('Y-m-d', mktime(0,0,0,date('m'),date('d')-1,date('Y')));
        $sTomorrow = date('Y-m-d', mktime(0,0,0,date('m'),date('d')+1,date('Y')));

        $answer = self::send('GET', 'email/?fromdate=' . $sYesterday . '&todate=' . $sTomorrow);
        if (0 === $answer['replyCode']) {
            if (0 < count($answer['data'])) {
                foreach ($answer['data'] as $key => $email) {

                    $emailName = $email['name'];
                    if ($emailName == $name) {
                        return $email;
                    }
                }
            }
        }

        return false;
    }

    /**
     * identifiy a newsletter-user by unique-id
     */
    public function getNewsletterUserEmail () {

        if (null !== self::$_newsletterEmail) {
            return self::$_newsletterEmail;
        }

        $email = false;

        // (db) 2017-05-17 emarsys-newsletter
        if ($emarsys_uid = request()->getGetValue('sc_uid')) {
            // email abfragen
            $contact = self::getContactInfo ( array($emarsys_uid), 'uid' );

            if (isset($contact['data']['result'][0][3])) {
                if (0 < mb_strlen($contact['data']['result'][0][3])) {
                    $email = $contact['data']['result'][0][3];
                    // in session speichern, um bei weiteren Klicks zu identifizieren
                    $return = response()->setSessionValue('emarsysUser', $email);
                }
            }
        }
        // vorläufig entfernt - würde sonst wege Vanish zu falschen Ergebnissen führen, da nur HTML ausgeliefert wird
        // else {
        //     if ($emarsysUserEmail = request()->getSessionValue('emarsysUser')) {
        //         $email = $emarsysUserEmail;
        //     }
        // }

        self::$_newsletterEmail = $email;

        return $email;
    }

    /**
     * set launchtime of an email
     * @param integer email-id
     * @param datetime launchtime
     */
    public function setLaunchTime ($emailId, $sendTime) {
        if ($emailId) {
            $requestBody = array(
                'schedule' => $sendTime,
                'timezone' => 'Europe/Vienna',
            );

            $output = self::send('POST', 'email/' . $emailId . '/launch', $requestBody);

            return $output;
        }

        return false;
    }

    /**
     * create an email at emarsys
     * @param string type of the newsletter, eg: oe24-morgen, joe24 etc.
     * @param string subject
     * @param integer segment (= emarsys-targetgroup, the email receivers)
     * @param string html-version of the newsletter
     * @param string text-version of the newsletter
     * @param string sender name
     */
    public function createEmail ($newsletterType, $subject, $segment, $html_source, $text_source = '', $sendFrom = '', $sendTime = '', $segmentType = 'segment' ) {

        $newsletterType = mb_strtolower($newsletterType);

        $name = '';
        $fromname = '';
        $fromemail = 'newsletter@reply.oe24.at';
        // $subject = '';
        // email-kategorie
        /*
            email-kategorie ids bei emarsys
            624 - DemoCampaign
            763 - joe24
            764 - marketing
            761 - meinjob
            762 - oe24
            755 - Testmails
        */
        $email_category = 762; // oe24
        $external_event_id = ''; //0;

        // $filter = 36507; // testliste danielberger
        // $filter = 25999; // testliste online-technik
        $administrator = 0;

        // $sendTime = '2017-05-18 13:50:00';
        $filter = $segment; //0;
        $combined_segment_id = ''; //0;
        if ($segmentType == 'kombiniert') {
            $filter = '';
            $combined_segment_id = $segment;
        }

        $contactlist = ''; //0;

        $fallbackTextSource = '';
        $html_source = trim(preg_replace('/<!--(.|\s)*?-->/', '', $html_source));

        switch ($newsletterType) {
            case 'oe24-morgen':
            case 'oe24':
                $name = 'oe24 am Morgen ' . date('d.m.Y H:i:s');
                $fromname = 'oe24 am Morgen';
                $email_category = 762; // oe24
                $administrator = 2633; // Admin-User online_redaktion
                $fromemail = 'newsletter@reply.oe24.at';

                $fallbackTextSource = 'Ihr Gerät kann den Newsletter leider nicht anzeigen. Um den oe24 am Morgen Newsletter lesen zu können, öffnen Sie bitte den folgenden Link in Ihrem Webbrowser: http://www.oe24.at/newsletter/oe24-morgen'.chr(10).chr(10);
                $fallbackTextSource .= 'oe24 GmbH • Friedrichstraße 10 • 1010 Wien • Gerichtsstand: Wien'.chr(10);
                $fallbackTextSource .= 'www.oe24.at'.chr(10).chr(10);
                $fallbackTextSource .= 'Wenn Sie keine weiteren Zusendungen erhalten möchten, dann öffenen Sie bitte den folgenden Link in Ihrem Webbrowser: http://www.oe24.at/service?email_id=$cid$&user_id=$uid$&db1000'.chr(10).chr(10);

                break;

            case 'oe24-mittag':
                $name = 'oe24 zu Mittag ' . date('d.m.Y H:i:s');
                $fromname = 'oe24 zu Mittag';
                $email_category = 762; // oe24
                $administrator = 2633; // Admin-User online_redaktion
                $fromemail = 'newsletter@reply.oe24.at';

                $fallbackTextSource = 'Ihr Gerät kann den Newsletter leider nicht anzeigen. Um den oe24 zu Mittag Newsletter lesen zu können, öffnen Sie bitte den folgenden Link in Ihrem Webbrowser: http://www.oe24.at/newsletter/oe24-mittag'.chr(10).chr(10);
                $fallbackTextSource .= 'oe24 GmbH • Friedrichstraße 10 • 1010 Wien • Gerichtsstand: Wien'.chr(10);
                $fallbackTextSource .= 'www.oe24.at'.chr(10).chr(10);
                $fallbackTextSource .= 'Wenn Sie keine weiteren Zusendungen erhalten möchten, dann öffenen Sie bitte den folgenden Link in Ihrem Webbrowser: http://www.oe24.at/service?email_id=$cid$&user_id=$uid$&db1000'.chr(10).chr(10);

                break;

            case 'oe24-abend':
                $name = 'oe24 am Abend ' . date('d.m.Y H:i:s');
                $fromname = 'oe24 am Abend';
                $email_category = 762; // oe24
                $administrator = 2633; // Admin-User online_redaktion
                $fromemail = 'newsletter@reply.oe24.at';

                $fallbackTextSource = 'Ihr Gerät kann den Newsletter leider nicht korrekt darstellen. Um den oe24 zu Mittag Newsletter lesen zu können, öffnen Sie bitte den folgenden Link in Ihrem Webbrowser: http://www.oe24.at/newsletter/oe24-abend'.chr(10).chr(10);
                $fallbackTextSource .= 'oe24 GmbH • Friedrichstraße 10 • 1010 Wien • Gerichtsstand: Wien'.chr(10);
                $fallbackTextSource .= 'www.oe24.at'.chr(10).chr(10);
                $fallbackTextSource .= 'Wenn Sie keine weiteren Zusendungen erhalten möchten, dann öffenen Sie bitte den folgenden Link in Ihrem Webbrowser: http://www.oe24.at/service?email_id=$cid$&user_id=$uid$&db1000'.chr(10).chr(10);

                break;

            case 'wolfgang fellner':
                $name = 'Wolfgang Fellner ' . date('d.m.Y H:i:s');
                $fromname = 'oe24';
                $email_category = 762; // oe24
                $administrator = 2633; // Admin-User online_redaktion
                $fromemail = 'newsletter@reply.oe24.at';

                $fallbackTextSource = 'Ihr Gerät kann den Newsletter leider nicht korrekt darstellen. Um den Newsletter lesen zu können, öffnen Sie bitte den folgenden Link in Ihrem Webbrowser: http://www.oe24.at/newsletter/fellner'.chr(10).chr(10);
                $fallbackTextSource .= 'oe24 GmbH • Friedrichstraße 10 • 1010 Wien • Gerichtsstand: Wien'.chr(10);
                $fallbackTextSource .= 'www.oe24.at'.chr(10).chr(10);
                $fallbackTextSource .= 'Wenn Sie keine weiteren Zusendungen erhalten möchten, dann öffenen Sie bitte den folgenden Link in Ihrem Webbrowser: http://www.oe24.at/service?email_id=$cid$&user_id=$uid$&db1000'.chr(10).chr(10);

                break;

            case 'breaking news':
                $name = 'BreakingNews ' . date('d.m.Y H:i:s');
                $fromname = 'oe24 BreakingNews';
                $email_category = 762; // oe24
                $administrator = 2633; // Admin-User online_redaktion
                $fromemail = 'newsletter@reply.oe24.at';

                $fallbackTextSource = 'Ihr Gerät kann den Newsletter leider nicht anzeigen. Um den oe24 Breaking News Newsletter lesen zu können, öffnen Sie bitte den folgenden Link in Ihrem Webbrowser: http://www.oe24.at/newsletter/oe24-breaking-news'.chr(10).chr(10);
                $fallbackTextSource .= 'oe24 GmbH • Friedrichstraße 10 • 1010 Wien • Gerichtsstand: Wien'.chr(10);
                $fallbackTextSource .= 'www.oe24.at'.chr(10).chr(10);
                $fallbackTextSource .= 'Wenn Sie keine weiteren Zusendungen erhalten möchten, dann öffenen Sie bitte den folgenden Link in Ihrem Webbrowser: http://www.oe24.at/service?email_id=$cid$&user_id=$uid$&db1000'.chr(10).chr(10);

                break;

            case 'willurlaub':
                return false;

                $name = 'Willurlaub ' . date('d.m.Y H:i:s');
                $fromname = 'Willurlaub';
                $email_category = 763; // joe24
                $administrator = 2735; // Admin-User joe24
                $fromemail = 'joe24@reply.oe24.at';

                // $fallbackTextSource = 'Ihr Gerät kann den Newsletter leider nicht anzeigen. Um den Newsletter lesen zu können, öffnen Sie bitte den folgenden Link in Ihrem Webbrowser: http://www.oe24.at/newsletter/oe24-breaking-news'.chr(10).chr(10);
                break;

            case 'joe24':
                $name = 'joe24 ' . date('d.m.Y H:i:s');
                $fromname = 'joe24';
                $email_category = 763; // joe24
                $administrator = 2735; // Admin-User joe24
                $fromemail = 'joe24@reply.oe24.at';

                $fallbackTextSource = 'Ihr Gerät kann den Newsletter leider nicht anzeigen. Um den joe24 Newsletter lesen zu können, öffnen Sie bitte den folgenden Link in Ihrem Webbrowser: http://j.oe24.at/index.php/service-news/newsletter'.chr(10).chr(10);
                $fallbackTextSource .= 'oe24 GmbH - Bereich Reisen • Friedrichstraße 10 • 1010 Wien • FN 269267g Gerichtsstand: Wien'.chr(10);
                $fallbackTextSource .= 'Tel: 01 96 000 • www.joe24.at'.chr(10).chr(10);
                $fallbackTextSource .= 'Wenn Sie keine weiteren Zusendungen erhalten möchten, dann öffenen Sie bitte den folgenden Link in Ihrem Webbrowser: http://www.oe24.at/service?email_id=$cid$&user_id=$uid$&db1000'.chr(10).chr(10);
                break;

            // no valid newslettertype
            default:
                return false;
                break;
        }

        // Textconten
        $text_source = (0 < mb_strlen($text_source)) ? $text_source : $fallbackTextSource;

        // sendFrom ?
        $fromname = (0 < mb_strlen(trim($sendFrom))) ? $sendFrom : $fromname;

        // email-parameters
        $requestBody = array (
            'language' => 'de',
            'name' => $name,
            // meinjob-mail: meinjob@reply.oe24.at
            'fromemail' => $fromemail,
            'fromname' => $fromname,
            'subject' => $subject,
            'email_category' => $email_category, // kann später via Schnittstelle nicht editiert werden
            'html_source' => $html_source,
            'text_source' => $text_source,

            // optional parameters
            'unsubscribe' => 0, // int The email contains an unsubscribe link. * 0: false; 1: true.
            'browse' => 0, //  int The email contains a link to an online version. * 0: false; 1: true.
            'text_only' => 0,  // kann später via Schnittstelle nicht editiert werden
            'administrator' => $administrator, // 1615 = danielberger // kann später via Schnittstelle nicht editiert werden

        );

        if ($filter) $requestBody['filter'] = $filter; // kann später via Schnittstelle nicht editiert werden
        elseif ($combined_segment_id) $requestBody['combined_segment_id'] = $combined_segment_id;

        // 'external_event_id' => $external_event_id,
        // 'contactlist' => $contactlist,

        $output = self::send('POST', 'email', $requestBody);

        // check if same email has already been transmitted today - if so update it
        if (10001 === $output['replyCode']) {
            // 10001 - emarsys code for 'An email with this name already exists.'
            if ($email = self::getEmail($name)) {
                $emailId = $email['id'];
                $status = $email['status'];

                // only update if state is 'In Design' (1) or 'Tested' (2)
                if ('1' === $status || '2' === $status) {
                    // update email
                    $output = self::updateEmail ($emailId, $requestBody);
                }
            }
        }

        // launch time - send time only if everything worded so far
        if (0 === $output['replyCode']) {
            if (0 < mb_strlen($sendTime)) {
                if ($email = self::getEmail($name)) {
                    $emailId = $email['id'];

                    $output = self::setLaunchTime($emailId, $sendTime);
                }
            }
        }

        return $output;

    }

    /**
     * get all contact-lists from emarsys
     */
    public function getContactLists () {
        $requestBody = array();

        $output = self::send('GET', 'contactlist', $requestBody);

        return $output;
    }

    /**
     * get all combined-segments from emarsys
     */
    public function getCombinedSegments () {
        $requestBody = array();

        $output = self::send('GET', 'combinedsegments', $requestBody);

        return $output;
    }

    /**
     * create a contact list
     * @param name string contactlist-name
     * @param contactemails array emails of contacts in this list
     */
    public function createContactList ($name, $contactEmails = array()) {
        if (mb_strlen($name) > 0 && count($contactEmails) > 0) {
            $requestBody = array(
                'key_id' => 3,
                'name' => $name,
                'external_ids' => $contactEmails,
            );

            $output = self::send('POST', 'contactlist', $requestBody);

            return $output;
        }

        return false;
    }

    /**
     * add a contact to a already existing contactlist
     * @param listId integer list-id
     * @param contactemails array emails of contacts to be added
     */
    public function addContact2ContactList ($listId, $contactEmails = array()) {
        if (mb_strlen($listId) > 0 && count($contactEmails) > 0) {
            $requestBody = array(
                'key_id' => 3,
                'external_ids' => $contactEmails,
            );

            $output = self::send('POST', 'contactlist/' . $listId . '/add', $requestBody);

            return $output;
        }

        return false;
    }

    /**
     * handle campaign management
     * @param email string email of campaign participant
     * @param campaign string name of the campaign
     */
    public function handleCampaignManagement($email, $campaign) {
        $campaign2handle = 'joe24_' . trim($campaign);
        $contactLists = self::getContactLists();

        $listEmarsys = false;
        if(isset($contactLists['replyCode'])){
            if ($contactLists['replyCode'] === 0) {

                foreach($contactLists['data'] as $iKey => $list) {
                    $id = $list['id'];
                    $name = $list['name'];

                    if($name == $campaign2handle) {
                        $listEmarsys = $id;
                        break;
                    }
                }
            }
        }

        if ($listEmarsys === false) {
            // campaignlist not in emarsys - create it
            $output = self::createContactList($campaign2handle, array($email));
            if (isset($output['replyCode'])) {
                if ($output['replyCode'] === 0) {

                    return $output;
                }
            }

            return false;
        }
        else {
            // add user to existing campainglist
            $output = self::addContact2ContactList($listEmarsys, array($email));
            if (isset($output['replyCode'])) {
                if ($output['replyCode'] === 0) {

                    return $output;
                }
            }
            return false;
        }


        return false;
    }

    public function registerUser($newsletter, $emailreq, $codereq) {

        $validNewsletter = array(
            'oe24',
            'oe24tv',
            'joe24',
            'meinjob',
            'marketing',
            'gewinn',
            'fellner',
            'mediamonitor',
        );

        $newsletter = (in_array($newsletter, $validNewsletter)) ? $newsletter : 'oe24';

        // -------------------------------------------------------------------------------------

        $validGender = array(
            'm' => 1, // 'Male',
            'f' => 2, // 'Female',
        );

        // -------------------------------------------------------------------------------------

        // fallback-url wenn Anfrage nicht bearbeitet werden kann
        $url = ('joe24' == $newsletter) ? 'http://j.oe24.at/index.php?option=com_content&view=article&id=1619&Itemid=228' : 'http://www.oe24.at/service/Newsletteranmeldung-nicht-erfolgreich/282120924';

        // -------------------------------------------------------------------------------------

        // oe24-anmeldungen auch via session überprüfen
        $sessionCheck = true;
        if ('oe24' == $newsletter) {
            //     $sessionCheck = ('RCahnedcokmtShtirsinnogw1' == response()->getSessionValue('newsletterEmarsysRegistration')) ? true : false;
            //     response()->setSessionValue('newsletterEmarsysRegistration','');
            // robots-check - wenn 'address'-Feld ausgefüllt wurde, nicht erlauben - Feld ist im html nicht sichtbar (display-none), Robot hat es ausgefüllt
            $address = request()->getGetValue('address');
            if (mb_strlen($address)>=1) {
                $sessionCheck = false;
            }

            // stop robot
            $firstname = request()->getGetValue('firstname');
            $lastname = request()->getGetValue('lastname');

            $aBadWords = array('www.lehu520.com');
            foreach ($aBadWords as $value) {
                $found = mb_strpos($firstname, $value) !== false ? true : false;
                $found = mb_strpos($lastname, $value) !== false ? true : $found;

                if ($found) {
                    $sessionCheck = false;
                    break;
                }
            }

        }

        // -------------------------------------------------------------------------------------

        // 1. Schritt Newsletter Anmeldung -> Mail an User mit Bestätigungslink schicken
        if ($email = request()->getGetValue('email')) {
            if ($sessionCheck) {
                // Get-Variablen
                $firstname = request()->getGetValue('firstname');
                $lastname = request()->getGetValue('lastname');
                $companyname = request()->getGetValue('companyname');

                $gender = request()->getGetValue('gender');
                $gender = (mb_strlen($gender) && isset($validGender[$gender])) ? $validGender[$gender] : '';
                // Spezialfall - bei joe24 wurde das 'Anrede'-Feld nicht auf name=gender geändert, stattdessen wird es als name=inp_46 übermittelt (alter Name als die Registrierung direkt an Emarsys geschickt wurde)
                $salutation = request()->getGetValue('inp_46');
                $useSalutation = (mb_strlen($gender)<1 && mb_strlen($salutation) && isset($validGender[$salutation])) ? true : false;
                $gender = ($useSalutation) ? $validGender[$salutation] : $gender;

                $endlink = request()->getGetValue('endlink');
                $interests = request()->getGetValue('interests');
                $campaign = request()->getGetValue('campaign');
                $campaign = ($campaign) ? mb_strtolower($campaign) : '';

                // nur Datensatz-Update und keine Newsletter-Anmeldung verschicken?
                $onlyUserUpate = request()->getGetValue('update');
                $onlyUserUpate = ('true' == $onlyUserUpate) ? true : false;

                // Anmeldung und übermittlung an emarsys erfolgreich
                $subscribeSuccessful = false;

                // Sonderfall: User ist schon angelegt und auch schon Opt-In, registriert sich aber wieder - muss nicht den ganzen Weg inklusive Registrierungsmail durchgehen
                // Update; User bekommt trotzdem wieder das Registrierungsmail mit Bestätigungslink, bleibt aber auf Opt-In - Fall ab Kommentar ("user already exists in database") auskommentiert
                $alreadyOptIn = false;

                if ($newsletter == 'gewinn' || $newsletter == 'oe24') {
                    $emailText = "email: $email - firstname: $firstname - lastname: $lastname";
                    $mail = strg_Mail::create("d.berger@oe24.at", "oe24.at <noreply@oe24.at>", "oe24.oe24.mail.subject", "oe24.oe24.mail.body", "oe24.oe24.mail.bodyHTML");
                    $mail->send(array("subject" => "Gewinnspielteilnahme - $newsletter",  "text" => $emailText, "html" => 1));
                }
                // email-überprüfung - emarsys nimmt jeden Text
                $email = trim($email);
                if (filter_var($email, FILTER_VALIDATE_EMAIL)) {
                    // kunde bei emarsys anlegen
                    $subscribe = self::createContact($email, $firstname, $lastname, $gender, $companyname, $interests, $newsletter);

                    if (isset($subscribe['replyCode'])) {
                        switch($subscribe['replyCode']) {

                            // registration was successfull
                            case 2009: // Emarsys-Code: User ist bereits angelegt
                                // Update Daten - Werte der emarsys-Felder
                                // 1 ... Firstname
                                // 2 ... Lastname
                                // 5 ... Gender
                                // 18 ... ComppanyName
                                // 46 ... Salutation
                                // 15826 ... interests

                                $updateContact = array();
                                if (mb_strlen($firstname)) $updateContact['1'] = $firstname;
                                if (mb_strlen($lastname)) $updateContact['2'] = $lastname;
                                if (mb_strlen($gender)){
                                    $updateContact['5'] = $gender;
                                    $updateContact['46'] = $gender;
                                }
                                if (mb_strlen($companyname)) $updateContact['18'] = $companyname;

                                if (count($interests)>0) $updateContact['15826'] = $interests;

                                if (self::updateContact ( $email, '3', $updateContact )) {
                                    $subscribeSuccessful = true;
                                }

                                // is user already registered for this newsletter? if so do not send an email again
                                if ($isRegistered = self::isUserActivated($email, $newsletter)){

                                    $alreadyOptIn = true;

                                    switch ($newsletter) {
                                        case 'joe24':
                                            $url = 'http://j.oe24.at/index.php?option=com_content&view=article&id=1620&Itemid=228';
                                            break;

                                        // todo - oe24 send to 'you are already registered and activated-url'
                                        case 'oe24':
                                        default:
                                            $url = 'http://www.oe24.at/service/Sie-sind-bereits-registriert/308533343';
                                            break;
                                    }



                                    break;
                                }

                            case 0: // neuer kunde

                                // send registration mail with confirmlink to user
                                // if (self::sendRegistrationMail($email, $firstname, $lastname, $newsletter)) {
                                //     $subscribeSuccessful = true;
                                // }
                                // trigger Registration-Form oe24, joe24

                                $handleRegistrationProcess = ($onlyUserUpate === true && $subscribe['replyCode'] == 2009) ? false : true;

                                if ($handleRegistrationProcess) {
                                    if (self::triggerRegistrationForm($email, $newsletter)) {
                                        $subscribeSuccessful = true;
                                    }
                                    else {
                                        // newsletter, die noch nicht via emarsys abgehandelt werden, zb: meinjob, marketing
                                        $subscribeSuccessful = false;
                                    }
                                }

                                if ($newsletter == 'joe24') {
                                    // add user to a campaign
                                    if (self::handleCampaignManagement($email, $campaign)) {
                                        $subscribeSuccessful = true;
                                    }
                                }

                                if (0) {
                                    if ($newsletter == 'joe24') {
                                        // do not start registration form, if 'onlyUserUpate' === true and user already exists in db
                                        $handleRegistrationProcess = ($onlyUserUpate === true && $subscribe['replyCode'] == 2009) ? false : true;

                                        if ($handleRegistrationProcess) {
                                            if (self::triggerRegistrationForm($email, $newsletter)) {
                                                $subscribeSuccessful = true;
                                            }
                                        }

                                        // add user to a campaign
                                        if (self::handleCampaignManagement($email, $campaign)) {
                                            $subscribeSuccessful = true;
                                        }
                                    }
                                    else {
                                        // right now only joe24 registration/campaigns will be handled via this registration-process - this is just a safety-net, should be rewritten once oe24 will be handled here as well (hopefully never ;-)
                                        $subscribeSuccessful = true;
                                    }
                                }
                                break;
                        }

                    }

                }


                if (!$alreadyOptIn) {
                    if ($subscribeSuccessful) {

                        // erfolgreich angemeldet - zum Bestätigungsartikel weiterleiten

                        switch ($newsletter) {
                            case 'joe24':
                                $url = 'http://j.oe24.at/index.php?option=com_content&view=article&id=1618&Itemid=228';
                                break;

                            default:

                                if (spunQ::inMode(spunQ::MODE_DEVELOPMENT)) {
                                    $host = $_SERVER['HTTP_HOST'];
                                    $url = 'http://'.$host.'/service/Vielen-Dank-fuer-Ihre-Anmeldung/161593828';

                                } else {
                                    $url = 'http://www.oe24.at/service/Vielen-Dank-fuer-Ihre-Anmeldung/116870030';
                                }

                                break;
                        }

                    }
                    else {

                        // Anmeldung hat nicht funktioniert
                        switch ($newsletter) {
                            case 'joe24':
                                $url = 'http://j.oe24.at/index.php?option=com_content&view=article&id=1619&Itemid=228';
                                break;

                            default:

                                if (spunQ::inMode(spunQ::MODE_DEVELOPMENT)) {
                                    $host = $_SERVER['HTTP_HOST'];
                                    $url = 'http://'.$host.'/service/Newsletteranmeldung-nicht-erfolgreich/161594093';

                                } else {
                                    $url = 'http://www.oe24.at/service/Newsletteranmeldung-nicht-erfolgreich/282120924';
                                }

                                break;
                        }

                    }

                }
                 // Wenn Endlink übergeben wird, zu diesem weiterleiten
                if(substr($endlink,0,4) == "http") {
                    $url = $endlink;
                }
            }
        }


        // 2. Schritt Newsletter Bestätigungslink aufgerufen -> bei Emarsys für OE24-Newsletter aktivieren
        if ( '0' != $emailreq && '0' != $codereq ) {

            $email = urldecode($emailreq);
            $uid = urldecode($codereq);

            // subscribe
            $subscribe = self::subscribeUser( $email, $uid, $newsletter );

            $text = "subscribeUser( $email, $uid, $newsletter ) " . print_r($subscribe,true);

            if (isset($subscribe['replyCode']) && 0 === $subscribe['replyCode']) {
                // Bestätigunsseite

                switch ($newsletter) {
                    case 'joe24':
                        $url = 'http://j.oe24.at/index.php?option=com_content&view=article&id=1620&Itemid=228';
                        break;

                    default:
                        if (spunQ::inMode(spunQ::MODE_DEVELOPMENT)) {
                            $host = $_SERVER['HTTP_HOST'];
                            $url = 'http://'.$host.'/service/Ihre-Anmeldung-war-erfolgreich/161593830';

                        } else {
                            $url = 'http://www.oe24.at/service/Ihre-Anmeldung-war-erfolgreich/116872842';
                        }
                        break;

                }
            }
            else {
                // Anmeldung hat nicht funktioniert

                switch ($newsletter) {
                    case 'joe24':
                        $url = 'http://j.oe24.at/index.php?option=com_content&view=article&id=1619&Itemid=228';
                        break;

                    default:
                        if (spunQ::inMode(spunQ::MODE_DEVELOPMENT)) {
                            $host = $_SERVER['HTTP_HOST'];
                            $url = 'http://'.$host.'/service/Newsletteranmeldung-nicht-erfolgreich/161594093';

                        } else {
                            $url = 'http://www.oe24.at/service/Newsletteranmeldung-nicht-erfolgreich/282120924';
                        }
                        break;
                }
            }
        }


        header('Location: ' . $url);
    }

    public function signOffUser() {
        $formValid = false;

        // fallback-url wenn Anfrage nicht bearbeitet werden kann
        // Abmeldung nicht erfolgreich - zum Artikel mit weiteren Hinweisen weiterleiten
        //Entschuldigung-es-gab-ein-Problem/116875013
        if (spunQ::inMode(spunQ::MODE_DEVELOPMENT)) {
            $host = $_SERVER['HTTP_HOST'];
            $url = 'http://'.$host.'/service/Newsletterabmeldung-nicht-erfolgreich/161594029';

        } else {
            $url = 'http://www.oe24.at/service/Newsletterabmeldung-nicht-erfolgreich/282081723';
        }

        if ($email = request()->getPostValue('email')) {
            if (filter_var($email, FILTER_VALIDATE_EMAIL)) {
                if ($lists = request()->getPostValue('lists')) {

                    // minimum email anpassung
                    $email = trim($email);

                    $formValid = true;

                    $unsubscribe = self::unsubscribe($email, $lists);

                    if (isset($unsubscribe['replyCode']) && 0 === $unsubscribe['replyCode']) {
                        // erfolgreich abgemeldet - zum Bestätigungsartikel weiterleiten
                        if (spunQ::inMode(spunQ::MODE_DEVELOPMENT)) {
                            $host = $_SERVER['HTTP_HOST'];
                            $url = 'http://'.$host.'/service/Sie-wurden-erfolgreich-abgemeldet/161593832';

                        } else {
                            $url = 'http://www.oe24.at/service/Sie-wurden-erfolgreich-abgemeldet/116873444';
                        }
                    }
                    else {

                    }

                    // marketing und joe24 werden noch nicht über emarsys gesendet, diese zusätzlich noch beim alten System abmelden
                    // http://newsletter-oe24.at/unsubform.php?form=9
                    // $transmit = array(
                    //     'email' => $email,
                    //     'lists' => array(),
                    // );

                    // foreach ($lists as $list) {
                    //     switch ($list) {
                    //         case 'marketing': $transmit['lists'][] = '231'; break;
                    //         case 'joe24': $transmit['lists'][] = '233'; break;
                    //         case 'oe24': $transmit['lists'][] = '296'; break;
                    //     }
                    // }

                    // if (!empty($transmit['lists'])) {
                    //     // an newsletter-oe24.at senden
                    //     $url = 'http://newsletter-oe24.at/unsubform.php?form=9';
                    //     $handle = curl_init($url);
                    //     curl_setopt($handle, CURLOPT_POST, true);
                    //     curl_setopt($handle, CURLOPT_POSTFIELDS, $transmit);
                    //     $response = curl_exec($handle);

                    //     curl_close($handle);
                    // }
                }
                else {
                    // keine Liste ausgewählt
                    $url = 'http://www.oe24.at/service?unsubscribeNoList=1';
                }
            }
        }

        // nicht gültiger Aufruf - zur Service-Seite weiterleiten
        // if (!$formValid) {
        header('Location: ' . $url);
        // }
    }
}
