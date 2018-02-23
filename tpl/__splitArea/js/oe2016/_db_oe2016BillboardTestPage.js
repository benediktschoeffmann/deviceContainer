<?php
/**
 * @collector noauto
 */
?>


var _db_oe24BillboardAdsTestClass = {

    load: function(type, height) {


        var aBody = document.body;
        aBody.classList.add('fullpageAds');

        switch (type) {
            case 'billboard':

                var wrap = document.getElementById('wrap');
                wrap.style.top = height+'px';

                // top
                document.write( '<div class="fullpageAdTop"><iframe src="https://streaming.ad-balancer.at/referenzen-website/kampagnen/double-bridge-ad/top/Bigisze_tma_top.html" width="100%" height="90" style="overflow: hidden; max-width: 960px;" scrolling="no"></iframe></div>' );
                // left
                document.write('<div class="fullpageAdLeft"><iframe src="https://streaming.ad-balancer.at/referenzen-website/kampagnen/double-bridge-ad/left/index.html" width="150" height="850" style="overflow: hidden;" scrolling="no"></iframe></div></div>');
                // right
                document.write('<div class="fullpageAdRight"><iframe src="https://streaming.ad-balancer.at/referenzen-website/kampagnen/double-bridge-ad/right/130x850_skyscraper_right.html" width="130" height="850" style="overflow: hidden;" scrolling="no"></iframe></div></div>');

                // background-color
                aBody.style.backgroundColor = '#000000';

            break;

            case 'fullpageCinematic':

                aBody.classList.add('fullpageCinematic');

                var wrap = document.getElementById('wrap');
                // wrap.style.top = height+'px';

                //top
                document.write( '<div class="fullpageAdMiddle"><iframe src="https://streaming.ad-balancer.at/referenzen-website/kampagnen/cinematic/index.html" width="100%" height="100%" style="overflow: hidden; max-width: 100%;" scrolling="no"></iframe></div>' );

                var headerBox = document.getElementsByClassName('headerBox');
                // headerBox[0].style.marginBottom = '400px';


                window.onscroll = function() {

                    var currentPosition = (document.body.scrollTop) ? document.body.scrollTop : document.documentElement.scrollTop;
                    var middle = document.getElementsByClassName('fullpageAdMiddle');
                    var headerBox = document.getElementsByClassName('headerBox');


                    if(currentPosition>60) {
                        // var className = 'fullpageAdHide';
                        // var hasClass = middle[0].className && new RegExp("(^|\\s)" + className + "(\\s|$)").test(middle[0].className);
                        // console.log(currentPosition+' - '+className+' - '+hasClass);

                        middle[0].classList.add('fullpageAdHide');
                        headerBox[0].classList.add('fullpageAdNormal');
                    }
                    else {
                        if(currentPosition<=1) {
                            middle[0].classList.remove('fullpageAdHide');
                            headerBox[0].classList.remove('fullpageAdNormal');
                        }
                    }
                };

            break;

            case 'doublebridge':
                var headerBoxMarginBottom = '279px';
                aBody.classList.add('doublebridge');

                var wrap = document.getElementById('wrap');
                wrap.style.top = height+'px';

                // top
                document.write( '<div class="fullpageAdTop"><iframe src="https://streaming.ad-balancer.at/referenzen-website/kampagnen/double-bridge-ad/top/Bigisze_tma_top.html" width="100%" height="90" style="overflow: hidden; max-width: 100%;" scrolling="no"></iframe></div>' );
                // left
                document.write('<div class="fullpageAdLeft"><iframe src="https://streaming.ad-balancer.at/referenzen-website/kampagnen/double-bridge-ad/left/index.html" width="150" height="850" style="overflow: hidden;" scrolling="no"></iframe></div></div>');
                // right
                document.write('<div class="fullpageAdRight"><iframe src="https://streaming.ad-balancer.at/referenzen-website/kampagnen/double-bridge-ad/right/130x850_skyscraper_right.html" width="130" height="850" style="overflow: hidden;" scrolling="no"></iframe></div></div>');
                // middle
                document.write('<div class="fullpageAdMiddle"><iframe src="https://streaming.ad-balancer.at/referenzen-website/kampagnen/double-bridge-ad/billboard/index.html" width="100%" height="100%" style="overflow: hidden;" scrolling="no"></iframe></div></div>');

                var headerBox = document.getElementsByClassName('headerBox');
                headerBox[0].style.marginBottom = headerBoxMarginBottom;

                // headerBox[0].insertAdjacentHTML('afterend', '<div class="fullpageAdMiddle" style="height:250px;"><iframe src="https://streaming.ad-balancer.at/referenzen-website/kampagnen/double-bridge-ad/billboard/index.html" width="100%" height="100%" style="overflow: hidden;" scrolling="no"></iframe></div></div>');

                aBody.style.backgroundColor = '#000000';

                window.onscroll = function() {

                    var currentPosition = (document.body.scrollTop) ? document.body.scrollTop : document.documentElement.scrollTop;
                    var middle = document.getElementsByClassName('fullpageAdMiddle');
                    var headerBox = document.getElementsByClassName('headerBox');


                    if(currentPosition>80) {
                        middle[0].classList.add('fullpageAdHide');
                        headerBox[0].classList.add('fullpageAdNormal');
                        headerBox[0].style.marginBottom = 0;
                    }
                    else {
                        if(currentPosition<=1) {
                            middle[0].classList.remove('fullpageAdHide');
                            headerBox[0].classList.remove('fullpageAdNormal');
                            headerBox[0].style.marginBottom = headerBoxMarginBottom;
                        }
                    }
                };

            break;

            case 'bridgemiddle':
                var headerBoxMarginBottom = '279px'; // frontpage
                var headerBoxMarginBottom = '310px'; // channel
                var middleBoxTop = '172px';

                aBody.classList.add('bridgemiddle');

                var wrap = document.getElementById('wrap');
                // wrap.style.top = height+'px';

                // $('#Superbanner').html('<iframe src="https://streaming.ad-balancer.at/referenzen-website/kampagnen/fireplace/mid/index.html" width="100%" height="250px" style="overflow: hidden;" scrolling="no"></iframe>');

                // left
                document.write('<div class="fullpageAdLeft"><iframe src="https://streaming.ad-balancer.at/referenzen-website/kampagnen/bridge-ad/left/index.html" width="150" height="850" style="overflow: hidden;" scrolling="no"></iframe></div></div>');
                // right
                document.write('<div class="fullpageAdRight"><iframe src="https://streaming.ad-balancer.at/referenzen-website/kampagnen/bridge-ad/right/130x850_skyscraper_right.html" width="130" height="850" style="overflow: hidden;" scrolling="no"></iframe></div></div>');
                // middle
                document.write('<div class="fullpageAdMiddle"><iframe src="https://streaming.ad-balancer.at/referenzen-website/kampagnen/bridge-ad/billboard/index.html" width="100%" height="100%" style="overflow: hidden;" scrolling="no"></iframe></div></div>');

                var header = document.getElementsByClassName('headerBox');
                header[0].style.marginBottom = headerBoxMarginBottom;

                var bridgeMiddle = document.getElementsByClassName('fullpageAdMiddle');
                bridgeMiddle[0].style.top = middleBoxTop;

                // var headerBox = document.getElementsByClassName('headerBox');
                // headerBox[0].style.marginBottom = '280px';

                // var middle = document.getElementsByClassName('fullpageAdMiddle');
                // middle[0].style.top = '180px';

                var lastBillBoardScroll = 0;

                setBillBoardOpenAllowed = null;
                window.onscroll = function() {

                    var currentPosition = (document.body.scrollTop) ? document.body.scrollTop : document.documentElement.scrollTop;
                    var middle = document.getElementsByClassName('fullpageAdMiddle');
                    var headerBox = document.getElementsByClassName('headerBox');

                    if(currentPosition>20) {
                        middle[0].classList.add('fullpageAdHide');
                        headerBox[0].classList.add('fullpageAdNormal');

                        headerBox[0].style.marginBottom = '0';

                        if (setBillBoardOpenAllowed === null){
                            setBillBoardOpenAllowed = false;
                        }

                        if(currentPosition>90){
                            setBillBoardOpenAllowed = true;
                        }

                    }
                    else {
                        if(currentPosition<1 && setBillBoardOpenAllowed) {
                            middle[0].classList.remove('fullpageAdHide');
                            headerBox[0].classList.remove('fullpageAdNormal');
                            headerBox[0].style.marginBottom = headerBoxMarginBottom;
                            setBillBoardOpenAllowed = null;
                        }
                    }


                };

                break;

            case 'fullpageAdSidebar':

                aBody.classList.add('fullpageAdSidebar');
                var wrap = document.getElementById('wrap');
                // wrap.style.top = height+'px';

                // left
                document.write('<div class="fullpageAdLeft"><iframe src="https://streaming.ad-balancer.at/referenzen-website/kampagnen/double-bridge-ad/left/index.html" width="160" height="850" style="overflow: hidden;" scrolling="no"></iframe></div></div>');
                // right
                document.write('<div class="fullpageAdRight"><iframe src="https://streaming.ad-balancer.at/referenzen-website/kampagnen/double-bridge-ad/right/130x850_skyscraper_right.html" width="160" height="850" style="overflow: hidden;" scrolling="no"></iframe></div></div>');



                break;

            case 'fullPageAdSkalier':

                aBody.classList.add('fullPageAdSkalier');
                var wrap = document.getElementById('wrap');

                // left
                document.write('<div class="fullpageAdLeft"><iframe src="https://streaming.ad-balancer.at/referenzen-website/kampagnen/Flagship/sitebar/index.html" width="100%" height="100%" style="overflow: hidden;" scrolling="no"></iframe></div></div>');
                // right
                document.write('<div class="fullpageAdRight"><iframe src="https://streaming.ad-balancer.at/referenzen-website/kampagnen/Flagship/sitebar/index.html" width="100%" height="100%" style="overflow: hidden;" scrolling="no"></iframe></div></div>');


                break;

        }

        // sticky-header
        var headerContainer = document.getElementsByClassName('headerNavContainer');
        headerContainer[0].classList.add('headerNavCenterSticky');

    }
}

switch (window.location.href) {
    case 'http://oe24dev.oe24.at/test/db/adload':
    case 'http://oe24dev.oe24.at/test/ws/adload':
    // case 'http://www.oe24.at/test/db/adload':
    case 'http://www.oe24.at/xzz/testwerbemittel/adload':
    // case 'http://oe24dev.oe24.at/digital/Dem-iPhone-droht-ein-Verkaufsstopp/161609187':
        _db_oe24BillboardAdsTestClass.load('fullpageAdSidebar',0);
        break;

    //case 'http://oe24dev.oe24.at/test/db/adload2':
    // case 'http://www.oe24.at/test/db/adload2':
    case 'http://www.oe24.at/xzz/testwerbemittel/adload2':
    case 'http://oe24dev.oe24.at/import/Kleine-Kuchen-ganz-gross/161583425':

        _db_oe24BillboardAdsTestClass.load('billboard',90);
        break;

    case 'http://oe24dev.oe24.at/test/db/adload3':
    // case 'http://www.oe24.at/test/db/adload3':
    case 'http://www.oe24.at/xzz/testwerbemittel/adload3':
        _db_oe24BillboardAdsTestClass.load('bridgemiddle',0);
        break;

    case 'http://oe24dev.oe24.at/test/db/adload4':
    case 'http://www.oe24.at/test/db/adload4':
    case 'http://www.oe24.at/xzz/testwerbemittel/adload4':
    case 'http://oe24dev.oe24.at/import/Das-sagt-Vettel-zur-Rambo-Attacke/161599782':
        _db_oe24BillboardAdsTestClass.load('doublebridge',90);
        break;

    case 'http://oe24dev.oe24.at/test/db/adload5':
    // case 'http://www.oe24.at/test/db/adload5':
    case 'http://www.oe24.at/xzz/testwerbemittel/adload5':

        _db_oe24BillboardAdsTestClass.load('fullPageAdSkalier',0);
        break;

    case 'http://oe24dev.oe24.at/test/db/adload6':
    // case 'http://www.oe24.at/test/db/adload6':
    case 'http://www.oe24.at/xzz/testwerbemittel/adload6':

    case 'http://oe24dev.oe24.at/':
    case 'http://oe24dev.oe24.at/sport':
    case 'http://oe24dev.oe24.at/sport/fussball':
    case 'http://oe24dev.oe24.at/gesund24':
    case 'http://oe24dev.oe24.at/gesund24/medizin':
    case 'http://oe24dev.oe24.at/gesund24/lexikon/Husten/135853945':
    case 'http://oe24dev.oe24.at/cooking24':
    case 'http://oe24dev.oe24.at/cooking24/suesse-kueche/Die-oesterreichischen-Eissalons-starten-in-die-Saison/161585415':
    case 'http://oe24dev.oe24.at/leute':
    case 'http://oe24dev.oe24.at/leute/oesterreich/Lugner-Paris-war-ein-teurer-Spass/161165012':
    case 'http://oe24dev.oe24.at/businesslive':
    case 'http://oe24dev.oe24.at/businesslive/aktienkurs':
    case 'http://oe24dev.oe24.at/businesslive/auto/Harley-Davidson-will-sich-VW-Tochter-Ducati-einverleiben/161600107':
    case 'http://oe24dev.oe24.at/tv':
    case 'http://oe24dev.oe24.at/tv/news/Gernot-Bluemel-ueber-die-neuen-Wege-der-OeVP/161596550':
    case 'http://oe24dev.oe24.at/oesterreich/politik/Arnold-Schwarzenegger-trifft-morgen-VdB-und-Kurz/161632303':

        _db_oe24BillboardAdsTestClass.load('fullpageCinematic',380);
        break;
}


