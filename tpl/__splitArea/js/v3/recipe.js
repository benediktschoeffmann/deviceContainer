call = "";

$(function () {
    $.fn.reverse = [].reverse;

    $(".recipe input[name=anzPersonen]").keyup(function () {
        calculateRecipe();
    })

    $(".recipe table.zutaten td.zutat input").keyup(function () {
        getIngredients($(this));
    })

    $(".recipe table.zutaten tr .del").click(function () {
        $(this).parent().parent().remove();
    })

    $(".recipe .del.img").click(function () {
        removeImage($(this));
    })

    $(".recipe .add.ingredient").click(function () {
        addIngredient();
    })
    $(".recipe .add.image").click(function () {
        addImage();
    })

    $(".recipe .speichern").click(function(){
        submitForm();
    })

    $(".kategorien .main .mainbox").change(function(){
        sub = $(this).parent().children(".sub");
        sub.toggle();
        sub.children(".checkbox").each(function(){
            $(this).children(".subbox").prop("checked",false);
        })
    })

});


function calculateRecipe() {
    anzPers = parseInt($(".recipe input[name=anzPersonen]").val());
    origAnzPersonen = parseInt($(".recipe input[name=anzPersonen]").data("value"));

    $(".recipe .zutaten tr td.menge").each(function () {
        data_val = parseFloat($(this).data("value"));
        if (data_val != 0 && data_val != "") {
            val = (Math.round(((data_val / origAnzPersonen) * anzPers) * 100)) / 100;
            switch (val % 1) {
                case 0.25:
                    val -= 0.25;
                    if (val == 0) {
                        val = "";
                    }
                    val += " &frac14";
                    break;
                case 0.5:
                    val -= 0.5;
                    if (val == 0) {
                        val = "";
                    }
                    val += " &frac12";
                    break;
                case 0.75:
                    val -= 0.75;
                    if (val == 0) {
                        val = "";
                    }
                    val += " &frac34";
                    break;
            }
            $(this).html(val);
        }
    })
}

function getIngredients(target) {
    if (typeof call.abort == 'function') {
        call.abort();
    }

    call = $.ajax({
        type: "POST",
        url: "/recipe/json/getAllIngredientsByName/" + target.val(),
        data: {}
    }).done(function (msg) {
        if (/^[\],:{}\s]*$/.test(msg.replace(/\\["\\\/bfnrtu]/g, '@').replace(/"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g, ']').replace(/(?:^|:|,)(?:\s*\[)+/g, ''))) {
            result = jQuery.parseJSON(msg);
            output = "";
            for (i = 0; i < result.length; i++) {
                output += '<a href="#">' + result[i] + '</a>';
            }
            $("div").remove(".ingredients_result");
            if (output != "") {
                target.after('<div class="ingredients_result">' + output + '</div>');
            }
            $(".recipe .ingredients_result a").each(function () {
                $(this).click(function () {
                    target.val($(this).text());
                    $("div").remove(".ingredients_result");
                })
            })
        }
    })
}

function addIngredient() {
    ingredients = $(".recipe table.zutaten tr").reverse();

    ingredients.each(function () {
        ingredientCount = parseInt($(this).data("id")) + 1;
        return false;
    });
    mass = $("td.mass select.einheitdd:last").clone();
    row = '<tr data-id="' + ingredientCount + '">' +
        '<td class="menge" data-value=""><div class="del"></div><input class="narrow" data-id ="' + ingredientCount + '" name="menge[]" type="text" /></td>' +
        '<td class="mass"></td>' +
        '<td class="zutat"><input class="semiwide" value="" data-id="' + ingredientCount + '" name="zutat[]" type="text"></td>' +
        '</tr>';
    $(".recipe table.zutaten tr:last").after(row);
    mass.appendTo("tr[data-id=" + ingredientCount + "] td.mass");
    $(("tr[data-id=" + ingredientCount + "] td.mass select")).prop("selectedIndex", 0);
    $(".recipe table.zutaten tr:last .del").click(function () {
        $(this).parent().parent().remove();
    })


    /*del funktionalität für img*/


}

function setKat(kat){
    for(i=0; i<kat.length; i++){
        $("input[value="+kat[i]+"]").prop("checked",true);
        $("input[value="+kat[i]+"]").parent().children(".sub").css("display","block");
    }
}

function addImage(){
    images = $(".imageinput").reverse();
    images.each(function () {
        imgCount = parseInt($(this).data("id")) + 1;
        return false;
    });

    $(".recipe .imageinput:last").after('<input type="file" class="imageinput" name="bild[]" data-id="'+imgCount+'" />');

}

function removeImage(target){
    $(".recipe .hidden_img"+target.data("id")).prop("name","delImg[]");
    $(".recipe #r_img"+target.data("id")).remove();
    target.remove();
}

function anzPersonenError(){
    errorText="Bitte geben Sie die Anzahl der Personen an<br />";
    $(".recipe table.zutaten").before("<div class='rezeptError anzPersonenError'>"+errorText+"</div>");
    $(".recipe .anzPersonen").keyup(function(){$(".anzPersonenError").remove();})

}

function zutatenError(){
    errorText="Bitte geben Sie Zutaten an<br />";
    $(".recipe table.zutaten").after("<div class='rezeptError zError'>"+errorText+"</div>");
    $(".recipe table.zutaten tr td.zutat input").each(function(){$(this).keyup(function(){$(".zError").remove();})});
}

function zubereitungszeitError(){
    errorText="Bitte geben Sie die Zubereitungszeit an.<br />";
    $(".recipe .zubereitungszeit_b").after("<div class='rezeptError zubereitungszeitError'>"+errorText+"</div>");
    $(".recipe .zubereitungszeit").keyup(function(){$(".zubereitungszeitError").remove();})

}

function schwierigkeitsgradError(){
    errorText="Bitte geben Sie den Schwierigkeitsgrad an.<br />";
    $(".recipe .schwierigkeitsgrad").after("<div class='rezeptError schwierigkeitsgradError'>"+errorText+"</div>");
    $(".recipe .schwierigkeitsgrad").change(function(){$(".schwierigkeitsgradError").remove();})
}

function preiskategorieError(){
    errorText="Bitte geben Sie die Preiskategorie an.<br />";
    $(".recipe .preiskategorie").after("<div class='rezeptError preiskategorieError'>"+errorText+"</div>");
    $(".recipe .preiskategorie").change(function(){$(".preiskategorieError").remove();})

}

function zubereitungError(){
    errorText="Bitte verraten Sie uns wie das Gericht zubereitet wird.<br />";
    $(".recipe .zubereitung").before("<div class='rezeptError zubereitungsError'>"+errorText+"</div>");
    $(".recipe .zubereitung").keyup(function(){$(".zubereitungsError").remove();})

}

function headlineError(){
    errorText="Bitte geben Sie einen Titel für das Rezept an<br />";
    $(".recipe .headline").before("<div class='rezeptError headlineError'>"+errorText+"</div>");
    $(".recipe .headline").keyup(function(){$(".headlineError").remove();})
}

function kategorieError(){
    errorText="Bitte geben Sie eine oder mehrere Kategorie für das Rezept an<br />";
    $(".recipe .kategorien").after("<div class='rezeptError kategorieError'>"+errorText+"</div>");
    $(".recipe .kategorien input[type=checkbox]").change(function(){$(".kategorieError").remove();})
}


function submitForm(){
    $(".recipe .rezeptError").remove();

    zutatError = 1;
    errorfield = "";
    $(".recipe table.zutaten tr td.zutat input").each(function(){if($(this).val() != ""){zutatError = 0; return false;}})
    if(zutatError == 1){
        zutatenError();
        if(errorfield==""){errorfield = "zError";}
    }

    katError = 1;
    $(".recipe .kategorien input[type=checkbox]").each(function(){if($(this).prop("checked")){katError = 0; return false;}})
    if(katError == 1){
        kategorieError();
        if(errorfield==""){errorfield = "kategorieError";}
    }

    if($(".recipe .anzPersonen").val() <1){
        anzPersonenError();
        if(errorfield==""){errorfield = "anzPersonenError";}
    }
    if($(".recipe input[name=zubereitungszeit]").val() == ""){
        zubereitungszeitError();
        if(errorfield==""){errorfield = "zubereitungszeitError";}
    }
    if($(".recipe select[name=schwierigkeitsgrad]").val() == ""){
        schwierigkeitsgradError();
        if(errorfield==""){errorfield = "schwierigkeitsgradError";}
    }

    if($(".recipe select[name=preiskategorie]").val() == ""){
        preiskategorieError();
        if(errorfield==""){errorfield = "preiskategorieError";}
    }

    if($(".recipe .zubereitung").val() == ""){
        zubereitungError();
        if(errorfield==""){errorfield = "zubereitungsError";}
    }

    if($(".recipe .headline").val() == ""){
        headlineError();
        if(errorfield==""){errorfield = "headlineError";}
    }

    if(errorfield!=""){
        $('html, body').animate({
            scrollTop: $("."+errorfield).offset().top - 150
        }, 500);
    }
    if(errorfield==""){
        $(".recipe form[name=articleform]").submit();
    }



}


<?php
/**
* @collector noauto
* @collector footerSplitArea
*/
?>