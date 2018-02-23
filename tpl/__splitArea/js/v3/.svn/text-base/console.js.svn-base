<?php
/**
 * @collector noauto
 * @collector footerSplitArea
 */
?>

/**
 * Oe24Console Function, Multi Instance Ready
 * @author Roland Eigelsreiter
 * @example  var console = new oe24Console({
                ownObjName:"console",
                id : "consoleElementId"
            });
 * @version 1.1
 * @since 06/2010
 * @link r.eigelsreiter@oe24.at
 */

/*!
 * Oe24Console Function, Multi Instance Ready
 * @author Roland Eigelsreiter
 * @example  var console = new oe24Console({
                ownObjName:"console",
                id : "consoleElementId"
            });
 * @version 1.1
 * @since 06/2010
 * @link r.eigelsreiter@oe24.at
 */

function oe24Console(param){

    this.leftClick = function(clearIv){
        if(typeof clearIv != "undefined"){
            clearInterval(this.iv);
        }
        this.prev();
    }

    this.rightClick = function(clearIv){
        if(typeof clearIv != "undefined"){
            clearInterval(this.iv);
        }
        this.next();
    }

    this.prev = function(){
        var currIndex = this.getTinyIndex();
        if(currIndex == 0){
            currIndex = this.count-1;
        }else{
            currIndex--;
        }
        this.open(currIndex);
    }

    this.next = function(){
        var currIndex = this.getTinyIndex();
        if(currIndex == (this.count-1)){
            currIndex = 0;
        }else{
            currIndex++;
        }
        this.open(currIndex);
    }

    this.tinyJump = function(element){
        var i = $(element).parent().prevAll().length;
        if(i >= this.count){
            i = i - this.count;
        }
        this.open(i, true);
    }

    this.open = function(index, clearIv){
        if(typeof clearIv != "undefined"){
            clearInterval(this.iv);
        }
        this.box.find(".counterText").html(
            (index+1) + "/"+this.count
        );
        this.box.find(".bigStory").hide();
        this.box.find(".tinyStory").removeClass("active");
        this.box.find(".tinyStory.lastShown").removeClass("lastShown");
        this.box.find(".bigStory:eq("+index+")").show();
        this.box.find(".tinyStory:eq("+index+")").addClass("active");
        this.box.find(".tinyStory:eq("+(index + this.showMaxItems - 1)+")").addClass("lastShown");
        var w = this.box.find(".tinyStory").outerWidth();
        var l = ( w * index + 1) * (-1) + 30;
        l++;
        this.box.find(".tinyStorys .moveBox").css({left : l+"px"});
    }

    this.getTinyIndex = function(){
        return this.box.find(".active").prevAll().length;
    }

    this.showMaxItems = 4;
    this.box = $("#"+param.id);
    var html =  this.box.find(".tinyStorys .moveBox").html();
    this.count = this.box.find(".tinyStorys .moveBox .tinyStory").length;
    this.box.find(".tinyStorys .moveBox").append(html);
    this.open(0);
    param.interval = param.interval < 1000 ? 1000 : param.interval;
    this.iv = setInterval(function(){
        eval(param.ownObjName+".next()");
    }, param.interval);
}


if (typeof consoleBoxes != "undefined") {

    for (c=0; c<consoleBoxes.length; c++)
    {
        window['console' + consoleBoxes[c]] = new oe24Console({
            ownObjName: "console"+consoleBoxes[c],
            id : "console"+consoleBoxes[c],
            interval : 5000
        });
    }

}
