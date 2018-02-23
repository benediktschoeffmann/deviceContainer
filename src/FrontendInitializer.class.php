<?php

/**
 * Initializes the frontend objects while developing.
 */
class FrontendInitializer implements spunQ_IDatabaseInstantiationListener {

    /**
     * Singleton instance.
     * Initialized upon first call to getInstance().
     * @type FrontendInitializer
     */
    private static $instance = NULL;

    /**
     * Singleton provider.
     * @return FrontendInitializer
     */
    public static function getInstance() {
        if (self::$instance === NULL) {
            self::$instance = new self;
        }
        return self::$instance;
    }
    /**
     * Checks is the type storage for given type exists and has all members.
     * @see spunQ_IDatabaseConnection::getTypeStorage()
     * @param $connection Connection to use for the operation.
     * @param $typeNames Array of type names to be checked.
     * @return boolean Whether they were all found
     */
    private function storagesExist($connection, $typeNames) {
        foreach ($typeNames as $typeName) {
            $typeStorage = $connection->getTypeStorage($typeName, false);
            if ($typeStorage === NULL) {
                return false;
            }
            foreach (spunQ_UserType::getByName($typeName)->getOwnMembersRecursive() as $memberName => $member) {
                if ($memberName !== '_type' && $typeStorage->getMemberStorageRecursively($memberName, false) === NULL) {
                    return false;
                }
            }
        }
        return true;
    }

    /**
     * @implements spunQ_IDatabaseInstantiationListener
     */
    public function creatingDatabaseInstance($name) {
    }

    /**
     * @implements spunQ_IDatabaseInstantiationListener
     */
    public function createdDatabaseInstance($name, spunQ_IDatabaseConnection $connection) {
        if ($name === 'default') {
            if (!$this->storagesExist($connection, array('spunQ.user.User', 'spunQ.user.Group', 'oe24.core.User'))) {
                return NULL;
            }
            if (spunQ::inMode(spunQ::MODE_DEVELOPMENT) && !$this->requiredDataExists($connection)) {
                $this->createRequiredData($connection);
            }
        }
        return NULL;
    }
    /**
     * Checks if createRequiredData() needs to be run.
     * Verifies the existence of an object created by createRequiredData().
     * Called by createdDatabaseInstance().
     * @param $db Connection to use for the operation.
     * @return boolean Whether createRequiredData() needs to be called.
     */
    private function requiredDataExists($db) {
        $naviQuery = new spunQ_SelectQuery();
        $naviQuery->setType("oe24.core.NavigationItem");
        $naviQuery->setLimit(1);
        return $naviQuery->count() > 0;
    }
    /**
     * creates the required data
     * @param $connection
     */
    public function createRequiredData($connection) {
    }
}
