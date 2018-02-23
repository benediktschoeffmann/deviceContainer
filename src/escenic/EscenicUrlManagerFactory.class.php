<?php

class EscenicUrlManagerFactory implements spunQ_IUrlManagerFactory {

    /**
     * Singleton instance.
     * @type EscenicUrl
     */
    private static $instance = NULL;

    /**
     * Singleton getter.
     * @return EscenicUrl
     */
    public static function getInstance() {
        if (self::$instance === NULL) {
            self::$instance = new self();
        }
        return self::$instance;
    }

    /**
     * Constructor.
     */
    private function __construct() {
    }

    /**
     * @implements spunQ_IUrlManagerFactory
     */
    public function create($entryPoint) {
        return new EscenicUrlManager($entryPoint);
    }

    /**
     * @implements spunQ_IUrlManagerFactory
     */
    public function getName() {
        return 'oe24.ece';
    }

}

