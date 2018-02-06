<?
/**
 * AdContainer Class for oe24TV
 *
 * Nur zum hochzaehlen fuer die Adcontainer in Verwendung
 */

class Oe24TvAdContainer {

	private static $instance = null;

	public static function getInstance() {
        if (self::$instance === NULL) {
            self::$instance = new self();
        }
        return self::$instance;
	}

	private static $adContainerNumber = 0;

	public static function getAdContainerNumber() {
		return ++self::$adContainerNumber;
	}

}
