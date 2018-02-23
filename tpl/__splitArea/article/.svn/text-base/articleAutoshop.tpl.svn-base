<?php
/**
* Three Columns Template for Story Site
*
* @var text oe24.core.Content
* @var channel oe24.core.Channel
*/

$image = $text->getFirstRelatedImage();
$imageFormatBig = "292x146NoStretch";
$imageFormatSmall = "92x46NoStretch";
$images = $text->getRelatedImages();


$showCarData = false;
$carData = $text->getLeadText(true);
$carDataParts = explode("|", $carData);
if (count($carDataParts > 1)) {
    $showCarData = true;
    $carDataArray = array();
    foreach ($carDataParts as $carDataPart) {
        $parts = explode(" ", $carDataPart, 2);
        if (2 == count($parts)) {
            $carDataArray[] = array(0 => strip_tags($parts[0]), 1 => strip_tags($parts[1]));
        }
    }
}

$pages = array();
$extras = array();
$vorteile = array();
$finanzierungsDetails = array();
$legende = array();
$preis = array();
$content = array(
    'PREIS' => false,
    'TEXT' => '',
    'RECHTSTEXT' => '',
);
$pagesCount = $text->getTotalBodyPages();
if ($pagesCount >= 3) {
    $pages[3] = true;
    $pageBodyText = $text->getPagedBodyText(true, true);
    if (preg_match("/\bTEXT: \B|\bTEXT: \b/",$pageBodyText[0])) {
       $content['TEXT'] = (substr($pageBodyText[0], strpos($pageBodyText[0]," "), -1));
    }
    if ($pagesCount >= 5) {
        if(preg_match("/\bID: \B|\bID: \b/",$pageBodyText[4])) {
            $pages[5] = true;
            $winKey = strip_tags(substr($pageBodyText[4], strpos($pageBodyText[4], " ") + 1, -1));;
        }
    }
    if (preg_match("/\bEXTRAS: \B|\bEXTRAS: \b/",$pageBodyText[1])) {
        $extras = explode("|", substr($pageBodyText[1], strpos($pageBodyText[1], " "), -1));
        if ($pagesCount >= 7) {
            $pages[7] = true;
            if (preg_match("/\bVORTEIL: \B|\bVORTEIL: \b/", $pageBodyText[6])) {
                $vorteile = explode("|", substr($pageBodyText[6], strpos($pageBodyText[6], " "), -1));
            }
        }
    }
    if (preg_match("/\bFINANZIERUNG: \B|\bFINANZIERUNG: \b/", $pageBodyText[2])) {
        $details = array();
        $details = explode("|", substr($pageBodyText[2], strpos($pageBodyText[2], " ") + 1, -1));
        if (count($details > 1)) {
            foreach ($details as $detail) {
                $detailPart = explode(":", $detail, 2);
                if (2 == count($detailPart)) {
                    $finanzierungsDetails[] = array(0 => strip_tags($detailPart[0]), 1 => strip_tags($detailPart[1]));
                }
            }
        }
    }
    if ($pagesCount >= 4) {
        if(preg_match("/\bLEGENDE: \B|\bLEGENDE: \b/",$pageBodyText[3])) {
            $pages[4] = true;
            $legende = explode("|", substr($pageBodyText[3], strpos($pageBodyText[3], " "), -1));
        }
    }

    if ($text->getPreTitle()) {
        $preTitleParts = explode("€", $text->getPreTitle());
        if (count($preTitleParts) > 2) {
            $content['PREIS'] = true;
            if(isset($preTitleParts[0]) && preg_match("/\bpro [A-Z][a-z]* nur/", $preTitleParts[0])) {
                $preis[] =  $preTitleParts[0];
            }
            if(isset($preTitleParts[1]) && preg_match("/\b[0-9]+(?:\.[0-9]*)?,-/", $preTitleParts[1])) {
                $preis[] = $preTitleParts[1];
                $price = $preTitleParts[1];     // wird im js verwendet !
            }
            if(isset($preTitleParts[2]) && preg_match("/\b[0-9]+(?:\.[0-9]*)?,-\s[A-Za-z]*/", $preTitleParts[2])) {
                if (strpos($preTitleParts[2], 'Anzahlung') !== false) {
                    $preis[] = $preTitleParts[2];
                }
            }
        }
    }

    if ($pagesCount >= 6) {
        if (preg_match("/\bRECHTSTEXT: \B|\bRECHTSTEXT: \b/", $pageBodyText[5])) {
            $pages[6] = true;
            $content['RECHTSTEXT'] = substr($pageBodyText[5], strpos($pageBodyText[5], " "));
        }
    }
}
?>

<div class="row">
    <div class="asContent">
        <div class="articleContainer">
            <div class="articleMain" id="storymain">
                <div class="articleMainInner">
                    <div class="storybox">
                        <div class="article-headline">
                            <?= $text->getTitle(); ?>
                        </div>
                        <div class="main">

                            <div class="aSSTop clearfix">

                                <div class="articleSlideShow">

                                    <div class="js-oewaLink aSSMain">
                                        <img src="<?= s($image->getFileUrl($imageFormatBig)) ?>"alt="<?=s($text->getTitle())?>">
                                    </div>

                                    <? if (count($images) > 1): ?>
                                    <div class="aSSSlider">
                                        <div class="js-oewaLink aSSLeftBtn" onclick="sliderGoBackward();<?=eventTracking(array("content" => $text, "action" => "articleSlideShowLeft", "channel" => $channel))?>"></div>
                                        <div class="js-oewaLink aSSRightBtn" onclick="sliderGoForward();<?=eventTracking(array("content" => $text, "action" => "articleSlideShowRight", "channel" => $channel))?>"></div>
                                        <div class="aSSEntrys">
                                            <?
                                            if ($images) :
                                                foreach ($images as $key => $image) : ?>
                                                <div class="js-oewaLink aSSEntry" value="<?=$key?>" onclick="<?=eventTracking(array("content" => $text, "action" => "openLightbox", "channel" => $channel))?>">
                                                <img src="<? s($image->getFileUrl("92x46NoStretch")) ?>" alt="<? s($text->getTitle()) ?>" link="<?s($image->getFileUrl("consoleMadonnaNoStretch2"))?>" link2="<?s($image->getFileUrl("190x95NoStretch"))?>" mainpic="<?s($image->getFileUrl("292x146NoStretch"))?>"/>
                                                </div>
                                                <?
                                                endforeach;
                                            endif;
                                            ?>
                                        </div> <!-- end of aSSEntrys-->
                                    </div> <!-- end of aSSSlider -->
                                    <? endif; ?>

                                </div> <!-- end of articleSlideShow -->

                                <? if ($showCarData) : ?>
                                <div class="autoDetails">
                                   <table>
                                    <? foreach ($carDataArray as $carData) : ?>
                                        <? if (2 === count($carData)) : ?>
                                        <tr>
                                            <td class="a"><?=$carData[0]?></td>
                                            <td class="b"><?=$carData[1]?></td>
                                        </tr>
                                        <? endif; ?>
                                    <? endforeach; ?>
                                   </table>
                                </div>
                                <? endif; ?>

                            </div>

                            <? if (isset($pages[3]) && $pages[3]) : ?>

                            <!-- <div class=""> </div> -->

                            <div class="bodyText">
                                <? if (isset($pages[5]) && $pages[5])  : ?>
                                    <?= strip_tags($content['TEXT'])?>
                                    <div class="autoshopButton">
                                        <div class="buttonBgTop"></div>
                                        <div class="buttonBgBottom"></div>
                                        <div class="js-oewaLink buttonOverlay" onclick="<?=eventTracking(array("content" => $text, "action" => "getCarButton", "channel" => $channel))?>">
                                            <span class="buttonArrow"></span>
                                            <span class="buttonLabel" value="<?=$winKey?>">JA, ich will das Fahrzeug bestellen!</span>
                                        </div> <!-- end of buttonOverlay -->
                                    </div> <!-- end of autoshopButton -->
                                <? endif; ?>
                            </div> <!-- end of bodyText -->

                            <div class="bodyTextAdditionals">

                                <div class="bodyTextExtras">
                                    <? if (!empty($extras)) : ?>
                                        <h3> EXTRAS </h3>
                                        <ul>
                                        <? foreach ($extras as $extra) : ?>
                                            <li><?= $extra ?> </li>
                                        <? endforeach; ?>
                                        </ul><br/>
                                    <? endif; ?>
                                    <? if (isset($pages[7]) && $pages[7]) : ?>
                                        <h3> IHR VORTEIL </h3>
                                        <ul>
                                        <? foreach ($vorteile as $vorteil) : ?>
                                            <li> <?= $vorteil ?> </li>
                                        <? endforeach; ?>
                                        </ul>
                                    <? endif; ?>
                                </div> <!-- end of bodyTextExtras -->

                                <? if (!empty($finanzierungsDetails)) : ?>
                                <div class="bodyTextDetails">
                                    <h3> FINANZIERUNG</h3>
                                    <table>
                                    <? foreach ($finanzierungsDetails as $detail) : ?>
                                        <tr>
                                            <td class="a"><?=$detail[0]?></td>
                                            <td class="b"><?=$detail[1]?></td>
                                        </tr>
                                    <? endforeach; ?>
                                    </table>
                                    <? if (!empty($legende)) : ?>
                                        <div class="legende">
                                            <ul>
                                                <? foreach ($legende as $legend) : ?>
                                                    <li><?=$legend?></li>
                                                <? endforeach; ?>
                                            </ul>
                                        </div> <!-- end of legende -->
                                    <? endif; ?>
                                    <? if ($content['PREIS']) :?>
                                    <div class="priceContainer" id="price">
                                        <div class="price">
                                            <span class="price_title"><?= $preis[0]?></span>
                                            <span class="price_value">€ <?= $preis[1]?></span>
                                        </div>
                                        <? if (isset($preis[2])) : ?>
                                            <span class="price_post">€ <?= $preis[2]?></span>
                                        <? else: ?>
                                            <span class="price_post"> </span>
                                        <? endif; ?>
                                    </div> <!-- end of priceContainer -->
                                    <? endif;?>
                                    <? if (isset($pages[6]) && $pages[6]) : ?>
                                        <? if ($content['RECHTSTEXT']) : ?>
                                        <div class="rechtstext">
                                            <?= $content['RECHTSTEXT'] ?>
                                        </div>
                                        <? endif; ?>
                                    <? else: ?>
                                        <div class="rechtstext">
                                        </div>
                                    <? endif; ?>
                                </div> <!-- end of bodyTextDetails -->
                            <? endif; ?>

                            </div>
                           <? endif; ?>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="sidebar">
        <?
        etpl('oe24.oe24.__splitArea._page.standardColumnsSplitArea', array(
            'columnName' => 'Split-Story-Teaser Area',
            'channel' => $channel,
            'object' => $text,
            'hide' => array()
        ));
        ?>
    </div>
</div>
<script src="http://app.oe24.at/oe24win/default/assets/js/jquery/jquery-1.11.1.min.js"></script>
<script type="text/javascript">

mainindex = 0;
index = 0;
lightboxSlideShowIndex = 0;
lightboxPage = 1;
i = 0;
images = 0;

$(".aSSEntrys .aSSEntry").each(function(){
    images++;
    if(i > 2) {
        $(this).hide();
    }
    i++;
});

function sliderGoForward(){
    mainindex++;
    if(mainindex > images-1){
        mainindex=0;
    }
    index++;
    if(index > images-3){
        index=0;
    }
    goTo(index);
}

function sliderGoBackward(){
    mainindex--;
    if(mainindex < 0){
        mainindex = images-1;
    }
    index--;
    if(index < 0){
        index= images-3;
    }
    goTo(index);
}

function goTo(value){
    $(".aSSEntrys .aSSEntry").each(function(){
        if($(this).attr("value") == value || $(this).attr("value") == value+1 || $(this).attr("value") == value+2){
            $(this).show();
        }else{
            $(this).hide();
        }
        if($(this).attr("value") == mainindex){
            $("img",".aSSMain").attr("src", $(this).find("img").attr("mainpic"));
        }
    });
}
// Lightbox Code
$(document).ready(function() {
    var lightboxHTML = '<div id="lightboxOverlay" class="js-oewaLink"></div><div id="lightbox"><div id="close" class="js-oewaLink">X</div><div class="headline"><span class="title"></span></div><div class="lightboxContent"><div class="imageContainer"><img/></div><div class="js-oewaLink left_btn"></div><div class="js-oewaLink right_btn"></div><div class="slider">';
    i=0;
    page=1;
    c=0;
    $(".aSSEntrys .aSSEntry").each(function(){
        lightboxHTML = lightboxHTML+'<div class="js-oewaLink entry" value="'+i+'" page="'+page+'"';
        if(i > 2){
            lightboxHTML = lightboxHTML+' style="display: none; "';
        }
        lightboxHTML = lightboxHTML+'><img src='+$(this).find("img").attr("link2")+'></div>';
        i++;
        c++;
        if(c > 2){
            page++;
            c=0;
        }
    });
    lightboxHTML = lightboxHTML+'</div><div class="pages"><span class="label">Seite</span>';
    for(i=0;i<page;i++){
        lightboxHTML = lightboxHTML+'<span class="js-oewaLink page" value="'+(i+1)+'">'+(i+1)+'</span>';
        if(i<(page-1)){
            lightboxHTML = lightboxHTML+'<span class="break">|</span>';
        }
    }
    lightboxHTML = lightboxHTML+'</div></div></div><div id="lightboxRequest" class="js-oewaLink"></div>';
    $(lightboxHTML).appendTo('body').hide();
    $('#lightboxOverlay').css('opacity', '0.8');
    i=0;
    $("#lightbox .pages .page").each(function(){
        if(i==0){
            $(this).addClass("active");
        }
        i++;
    });

    updatePositions();


    // bind Clicks
    $("#lightboxOverlay, #lightbox, #lightboxRequest").hide();
    $("#lightbox .left_btn").click(function(event){
        <?=eventTracking(array("content" => $text, "action" => "lightboxPrev", "channel" => $channel))?>
        lightboxSlideShowIndex--;
        if(lightboxSlideShowIndex < 0){
            lightboxSlideShowIndex = images-1;
        }
        lightboxGoToImage(lightboxSlideShowIndex);
    });
    $("#lightbox .right_btn").click(function(event){
        <?=eventTracking(array("content" => $text, "action" => "lightboxNext", "channel" => $channel))?>
        lightboxSlideShowIndex++;
        if(lightboxSlideShowIndex >= images){
            lightboxSlideShowIndex = 0;
        }
        lightboxGoToImage(lightboxSlideShowIndex);
    });
    $("#lightbox .pages .page").each(function(){
        $(this).click(function(event){
            lightboxGoToPage($(this).attr("value"));
            <?=eventTracking(array("content" => $text, "action" => "lightBoxPage", "channel" => $channel))?>
        });
    });
    $(".aSSEntrys .aSSEntry").each(function(){
        $(this).click(function(event){
            lightboxGoToImage($(this).attr("value"));
            $("#lightboxOverlay, #lightbox").show();

            event.preventDefault();
        });
    });
    $(".aSSMain").click(function(event){
        lightboxGoToImage(0);
        $("#lightboxOverlay, #lightbox").show();
        <?=eventTracking(array("content" => $text, "action" => "openLightbox", "channel" => $channel))?>
        event.preventDefault();
    });
    $("#lightbox .entry").each(function(){
        $(this).click(function(){
            lightboxGoToImage($(this).attr("value"));
            <?=eventTracking(array("content" => $text, "action" => "lightboxThumb", "channel" => $channel))?>
        });
    });
    $(".storybox .autoshopButton .buttonOverlay").click(function(){
        $("#lightboxRequest .lightboxContent").html('<iframe class="anmeldung" src="http://app.oe24.at/oe24win/'+winKey+'.do?do=authenticate&car='+carname+'&price='+preis+'" width="418" height="625" frameborder="0" style="overflow:hidden;"></iframe>');
        $("#lightboxOverlay, #lightboxRequest").show();
    });

    agbs = "Der Rechtsweg ist ausgeschlossen. Dieser Finanzierungsvorschlag basiert auf den derzeit geltenden Geld- bzw Kapitalverhältnissen und unterliegt deren Schwankungen. Das anteilige Nutzungsentgelt vom Tag der Übernahme bis zum folgenden Monatsersten(Leasingbeginn) wird separat verrechnet. Die Bearbeitungsgebühr in Höhe von EUR 139,00 und die Bonitätsprüfungsgebühr in Höhe von EUR 60,00 werden mit der ersten Teilzahlung vorgeschrieben. Die Rechtsgeschäftsgebühr in Höhe von EUR 72,27 wird mitder ersten Teilzahlung vorgeschrieben. * Die Finanzierung ist ein Angebot der Denzel Leasing GmbH. 60 Monate Laufzeit, EUR 0,00 Anzahlung, EUR 5.200,00 Restwert, 15000 km p.a., Rechtsgeschäftsgebühr EUR 72,27, Bearbeitungsgebühr EUR 139,00, BereitstellungsgebührEUR 0,00, Bonitätsprüfungsgebühr EUR 60,00, effektiver Jahreszins 5,02%, Sollzinsen variabel 4,25%, Gesamtleasingbetrag EUR 13.900,00, Gesamtbetrag EUR 16.210,39. Alle Beträge inkl. Nova und MwSt. Symbolfoto.";
    carname = "<? s(urlencode($text->getTitle())) ?>";
    preis = "<? s(isset($price)?urlencode("&euro; ".$price):"") ?>";
    winKey = "<?isset($winKey)?s($winKey):"" ?>";
    /*formHTML = '<div id="close" onclick="closeRequestLightbox();">X</div><div class="headline"><span class="title">ANFRAGE</span></div><div class="lightboxContent"><span class="title">Ja, ich interessiere mch für den '+carname+' zum Preis von '+preis+' pro Monat.</span><span class="info">Gerne werden Sie unter folgender Hotline beraten: 01-601 66 777</span><div class="requestForm"><form action="" method="post" target="_blank"><label id="vorname_label" for="vorname">*Vorname:</label><input id="vorname" name="vorname" value="" maxlength="64" /><label id="nachname_label" for="nachname">*Nachname:</label><input id="nachname" name="nachname" value="" maxlength="64" /><label id="email_label" for="email">*E-Mail:</label><input id="email" name="email" value="" maxlength="64" /><label id="telefon_label" for="telefon">*Telefon:</label><input id="telefon" name="telefon" value="" maxlength="64" /><label id="adresse_label" for="adresse">*Wohnadresse:</label><input id="adresse" name="adresse" value="" /><label id="birthday_label" for="birthday">*Geburtsdatum:</label><input id="birthday" name="birthday" value="" maxlength="64" /><div class="autoshopButton"><div class="buttonBgTop"></div><div class="buttonBgBottom"></div><a href class="buttonOverlay"><span class="buttonArrow"></span><span class="buttonLabel">Anfrage absenden</span></a></div></form></div><span class="info2">Mit dem Absenden Ihrer Anfrage akzeptieren Sie die folgenden AGBs:</span><span class="agbs">'+agbs+'</span></div>';*/
    formHTML = '<div id="close" onclick="closeRequestLightbox();">X</div><div class="headline"><span class="title">ANFRAGE</span></div><div class="lightboxContent"></div>';
    $(formHTML).appendTo($("#lightboxRequest"));

    $("#lightbox #close, #lightboxOverlay").click(function(event){
        $("#lightbox, #lightboxOverlay, #lightboxRequest").hide();
        <?=eventTracking(array("content" => $text, "action" => "closeLightbox", "channel" => $channel))?>

        event.preventDefault();
    });
});
// bind scroll event to reposition the lightbox
//20150512 MH: Causes Problem with zoom at mobile devices
/*$(window).scroll(function(){
    updatePositions();
});*/
/*$(window).resize(function(){
    updatePositions();
});*/

function updatePositions(){
    //20150512 MH: lightbox should be in site center not screen ceneter
    if($(window).width() > 960) {
        $width = 960;
    } else {
        $width = $(window).width();
    }
    //MH End
    $("#lightbox").css("top",$(window).scrollTop()+$(window).height()/2-$("#lightbox").height()/2-50);
    $("#lightbox").css("left",$(window).scrollLeft()+$width/2-$("#lightbox").width()/2);
    $("#lightboxRequest").css("top",($(window).scrollTop()+$(window).height()/2-$("#lightboxRequest").height()/2));
    $("#lightboxRequest").css("left",$(window).scrollLeft()+$width/2-$("#lightboxRequest").width()/2);

}

function lightboxGoTo(value){
    $("#lightbox .entry").each(function(){
        if($(this).attr("value") == value || $(this).attr("value") == value+1 || $(this).attr("value") == value+2){
            $(this).show();
        }else{
            $(this).hide();
        }
    });
}
function lightboxGoToPage(value){
    $("#lightbox .entry").each(function(){
        if($(this).attr("page") == value){
            $(this).show();
        }else{
            $(this).hide();
        }
    });
    $("#lightbox .pages .page").each(function(){
        $(this).removeClass("active");
        if($(this).attr("value") == value){
            $(this).addClass("active");
        }
    });
}

function lightboxGoToImage(value){
    lightboxSlideShowIndex = value;
    $(".aSSEntrys .aSSEntry").each(function(){
        if($(this).attr("value") == value){
            src = $(this).find("img").attr("link");
            alt = $(this).find("img").attr("alt");

            $("img", "#lightbox .imageContainer").attr("src",src);

            $(".title", "#lightbox .headline").text("FOTOGALERIE: "+alt);

            $("#lightbox .entry").each(function(){
                $(this).removeClass("active");
                if($(this).attr("value") == value){
                    $(this).addClass("active");
                }
            });

            lightboxGoToPage(parseInt(value/3)+1);
        }
    });
}

function closeRequestLightbox(){
    $("#lightboxOverlay, #lightboxRequest").hide();
    <?=eventTracking(array("content" => $text, "action" => "closeLightbox", "channel" => $channel))?>
}

</script>
