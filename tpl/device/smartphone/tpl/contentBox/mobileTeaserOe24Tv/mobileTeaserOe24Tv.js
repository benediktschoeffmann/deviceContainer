<?php
/**
 * @collector noauto
 */
?>

// var mobileTeaserOe24TvInit = function() {

//     var navigationMain = document.querySelector('.smartphone .navigationMain');
//     var footer = document.querySelector('.smartphone .wrapper .footer');

//     var teaser = document.querySelector('.smartphone .mobileTeaserOe24Tv');
//     var teaserControl = teaser.querySelector('.teaserControl');
//     var teaserClassName = teaser.className;

//     var teaserFigure = teaser.querySelector('.teaserFigure');
//     var teaserVideo = teaserFigure.querySelector('.teaserFigure video');
//     var teaserFigureClassName = teaserFigure.className;

//     var cookieIsApp = isApp();
//     var cookieMobileTeaserOe24Tv = getCookie('mobileTeaserOe24Tv');

//     // ----------------------------------------------------------

//     if ('collapsed' === cookieMobileTeaserOe24Tv) {
//         teaser.className = teaserClassName + ' collapsed';
//     } else {
//         teaser.className = teaserClassName;
//     }

//     // ----------------------------------------------------------

//     teaserControl.addEventListener('click', function(e) {
//         e.preventDefault();
//         teaserClickHandler(e);
//     });

//     function teaserClickHandler(e) {
//         if (Utilities.hasClass(teaser, 'collapsed')) {
//             teaser.className = teaser.className.replace(' collapsed', '');
//             setCookie('mobileTeaserOe24Tv', 'expanded', 365);
//             if (typeof teaserVideo !== 'undefined' && null !== teaserVideo) {
//                 teaserVideo.play();
//             }
//         } else {
//             teaser.className = teaserClassName + ' collapsed';
//             setCookie('mobileTeaserOe24Tv', 'collapsed', 365);
//             if (typeof teaserVideo !== 'undefined' && null !== teaserVideo) {
//                 teaserVideo.pause();
//             }
//         }
//     }

//     // ----------------------------------------------------------

//     window.addEventListener('load', function(e) {
//         windowLoadHandler(e);
//     });

//     function windowLoadHandler(e) {
//         var cookieMobileTeaserOe24Tv = getCookie('mobileTeaserOe24Tv');
//         if (typeof teaserVideo !== 'undefined' && null !== teaserVideo) {
//             if ('collapsed' === cookieMobileTeaserOe24Tv) {
//                 teaserVideo.pause();
//             } else {
//                 teaserVideo.play();
//             }
//         }
//     }

//     // ----------------------------------------------------------

//     // Auf kleinen Smartphones ist der Viewport so niedrig, dass
//     // die Box zu viel Platz einnimmt, wenn sie "expanded" ist

//     window.addEventListener('resize', function(e) {
//         teaserResizeHandler(e);
//     });

//     function teaserResizeHandler(e) {

//         var cookieMobileTeaserOe24Tv = getCookie('mobileTeaserOe24Tv');

//         if (window.innerHeight > window.innerWidth) {
//             // Portrait
//             if ('collapsed' === cookieMobileTeaserOe24Tv) {
//                 teaser.className = teaserClassName + ' collapsed'
//             } else {
//                 teaser.className = teaserClassName;
//             }

//         } else {
//             // Landscape
//             teaser.className = teaserClassName + ' collapsed';
//         }
//     }

//     // teaserResizeHandler();

//     // ----------------------------------------------------------

//     if (cookieIsApp) {
//         if (null !== teaser) { teaser.style.display = 'none'; }
//         if (typeof teaserVideo !== 'undefined' && null !== teaserVideo) {
//             teaserVideo.pause();
//         }
//     } else {
//         if (null !== teaser && null !== navigationMain) { navigationMain.style.paddingBottom = '150px'; }
//         if (null !== teaser && null !== footer) { footer.style.padding = '3px 5% 150px'; }
//         if (null !== teaser) { teaser.style.display = 'block'; }
//     }

//     // ----------------------------------------------------------

//     // Hier sollte ueber die Events ein "Loading-Indikator" gezeigt bzw. entfernt werden
//     // Eine Klasse '.loading' im .teaserFigure Element wird gesetzt und per CSS wird ein
//     // videoLoading.gif gezeigt bzw. versteckt.

//     // http://stackoverflow.com/questions/8230748/how-to-add-loader-image-to-html5-video
//     // https://www.w3.org/2010/05/video/mediaevents.html

//     // Schwer zu testen.
//     // Im Chrome wird gar keiner der beiden Events ausgeloest
//     // Im Safari Desktop im Modus "Responsive Design" wird 'canplay' ausgeloest
//     // Im Safari am iPhone sehe ich gar keinen der beiden Events
//     // ...

//     // teaserVideo.addEventListener('loadstart', function(e) {
//     //     var teaserFigure = Utilities.getClosest(this.parentNode, '.teaserFigure');
//     //     console.log('loadstart', e, teaserFigure);
//     // }, false);

//     // teaserVideo.addEventListener('canplay', function(e) {
//     //     var teaserFigure = Utilities.getClosest(this.parentNode, '.teaserFigure');
//     //     console.log('canplay', e, teaserFigure);
//     // }, false);

// }

// functionQueue.add(mobileTeaserOe24TvInit);

