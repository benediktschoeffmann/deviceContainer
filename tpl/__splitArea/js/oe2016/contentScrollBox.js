<?php
/**
 * @collector noauto
 */
?>

$(document).ready(function() {

    function showContentScrollBox() {
        $(this).removeClass('js-invokeOnce');
        $(this).slick({
            slidesToShow: 3,
            slidesToScroll: 1,
            draggable: false,
            prevArrow: $(this).parent().find('.leftArrow'),
            nextArrow: $(this).parent().find('.rightArrow'),
            lazyLoad: 'ondemand',
            onInit: function() {
                this.$slider.parents('.oe2016contentScrollBox').css('display', 'block');
            }
        });
    }

    $('.oe2016contentScrollBox:in-viewport .contentScrollBoxBody.js-invokeOnce').each(showContentScrollBox);

    $(window).scroll(function() {
        $('.oe2016contentScrollBox:in-viewport .contentScrollBoxBody.js-invokeOnce').each(showContentScrollBox);
    });

});
