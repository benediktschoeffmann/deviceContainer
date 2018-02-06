<?php

function getObjectsByIds($ids = array(), $type = null, $throw = false) {
    $query = new spunQ_SelectQuery();
    $query->addCondition('id IN { ids }');
    $result = $query->execute(array('ids' => $ids));
    return $result;
}
