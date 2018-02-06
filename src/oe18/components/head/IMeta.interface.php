<?php

interface IMeta {
    function getMetaDescription();
    function getRobotDescription();
    function getMetaKeywords();
    function getMetaNewsKeywords();
    function getFavicon();
    function getCanonicalUrl();
    function getOpenGraphTags();
    function getTwitterTags();
    function getFacebookAdminsOrAppId();
    function getArticleTags();
}
