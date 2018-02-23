<?php

interface IAdHandler {

    const LOADADS = 1;
    const HIDEADS = 0;

    function areAdsEnabled();
    function isAlwaysVisible($adPosition);
    function prepareAds();
}

