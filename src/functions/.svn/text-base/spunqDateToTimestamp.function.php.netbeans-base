<?php
/*
 * this function transforms the spunQ Date Format into UNIX-timestamp
 * this function is called by templates from with A1_LiveVideo components to create .ics files for download.
 */
 
function spunqDateToTimestamp($str){
    $str = str_replace(":", "-",$str);
    $str = str_replace(" ", "-",$str);
    $arr = explode("-", $str);
    $timestamp = mktime($arr[3],$arr[4],$arr[5],$arr[1],$arr[2],$arr[0]);
    return $timestamp;
}