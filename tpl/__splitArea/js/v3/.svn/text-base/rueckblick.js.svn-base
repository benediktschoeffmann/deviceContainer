<?php
/**
 * @collector noauto
 */
?>
 /** @collector footerSplitArea*/
$('.rueckblick select').change(function(event){
    if($(event.target).val() != "x"){
        location.href = "http://"+rueckblickLinks[$(event.target).val()];
    }
});
function initRueckblick(){
    $('.rueckblick select').each(function(){
        ($(this).val() == "x")?$(this).attr('selected', true):$(this).attr('selected', false);
    });
}
$(document).ready(function(){
    initRueckblick();
    $(window).unload(function(){
        initRueckblick();
    });
});
