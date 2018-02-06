<?
/**
 * xml box money ticker
 * @var channel oe24.core.Channel
 * @var box oe24.core.XmlBox
 */

// return;

$templateOptions = $box->getTemplateOptions();

// -------------------------------------------

// $countColumns = $templateOptions->get('Anzahl-Spalten');
// $countColumns = ($countColumns && ctype_digit($countColumns) && $countColumns >= 3 && $countColumns <= 5) ? $countColumns : 4;
$countColumns = 2;

// -------------------------------------------

$distanceTop = $templateOptions->get('Abstand-Oben');
$distanceBottom = $templateOptions->get('Abstand-Unten');

$classDistanceTop = ($distanceTop) ? 'distanceTop' : '';
$classDistanceBottom = ($distanceBottom) ? 'distanceBottom' : '';
$classDistance = $classDistanceTop.' '.$classDistanceBottom;

// -------------------------------------------

$layoutIdentifier = $templateOptions->get('Layout-Identifier');
$layoutIdentifier = ($layoutIdentifier) ? $layoutIdentifier : 'business';

// -------------------------------------------

$showheaderIcon = $templateOptions->get('Show-Header-Icon');
$showheaderIcon = ($showheaderIcon) ? true : false;

// -------------------------------------------

$boxTitle = trim($box->getTitle());
$boxTitle = ($boxTitle) ? $boxTitle : '';

// -------------------------------------------

$html = $box->getHtml();
$html = str_replace('<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">', '', $html);

// -------------------------------------------

?>



<? if (1): ?>
    

    <div class="boerseTickerBox <?= $layoutIdentifier; ?> <?= $classDistance; ?> <?//= $classDisabled; ?>" data-count-columns="<?= $countColumns; ?>">

        <? if ($boxTitle): ?>
            <div class="boerseTickerBoxHeader">
                <span class="boerseTickerBoxHeaderCaption">
                    <span class="boerseTickerBoxTitle"><?= $boxTitle; ?></span>
                </span>
            </div>
        <? endif; ?>

        <div class="boerseTickerBoxSlider">
            <?= $html; ?>
        </div>

    </div>


<? endif; ?>


<? if (0): ?>
    <div class="boerseTicker">
        <?= $box->getHtml(); ?>
    </div>
    
    <script>

    function boerseTicker() {

        "use strict";

        function BoerseTicker(ticker, footer) {

            this.footer = footer;

            // this.ticker = $(ticker);
            this.ticker = ticker;

            this.defaults = {
                interval: 20,
                movement: 1 // Pixel
            };

            this.init();
        }

        BoerseTicker.prototype.init = function() {

            var self = this, tickerClone, atxEntries;

            // this.tickerWidth = this.ticker.width();
            // this.ticker.append(this.ticker.html());

            this.intervalID = null;
            this.tickerLeft = 0;
            this.tickerWidth = this.ticker.offsetWidth;

            tickerClone = this.ticker.cloneNode(true);
            atxEntries = this.ticker.querySelectorAll('.atxEntry');
            atxEntries.forEach(function(el, i) {
                self.ticker.appendChild(el);
            });

            this.footer.style.paddingBottom = '32px';

            // ---------------------------------------

            // this.ticker.addEventListener('touchstart', function(e) {
            //     e.preventDefault();
            //     console.log('touchstart', e);
            //     self.stop();
            // });

            // this.ticker.addEventListener('touchend', function(e) {
            //     e.preventDefault();
            //     console.log('touchend', e);
            //     self.start();
            // });

            // this.ticker.addEventListener('click', function(e) {
            //     var href = (e.target.href) | '';
            //     console.log('click', e.target, e.target.href);
            //     e.preventDefault();
            // });

            // ---------------------------------------

            this.start();
        };

        BoerseTicker.prototype.start = function() {

            var self = this;

            self.stop();

            self.intervalID = setInterval(function() {
                self.tickerLeft -= self.defaults.movement;
                // self.ticker.css('transform', 'translate3d(' + self.tickerLeft + 'px, 0, 0)');
                self.ticker.style.transform = 'translate3d(' + self.tickerLeft + 'px, 0, 0)';
                if (self.tickerLeft < (self.tickerWidth * (-1))) {
                    self.tickerLeft = 0;
                }
            }, self.defaults.interval);
        }

        BoerseTicker.prototype.stop = function() {
            clearInterval(this.intervalID);
        }

        // ---------------------------------------

        var tickers = document.querySelectorAll('.boerseTicker .atxEntryContent');
        var footer = document.querySelector('.footer');

        // ---------------------------------------

        for (var i = 0, ticker; ticker = tickers[i]; ++i) {
            new BoerseTicker(ticker, footer);
        }
    }

    </script>

    <script>

    // /var/www/oe24_oe24/tpl/__splitArea/js/v3/moneyTicker.js

    // ;(function($, win, doc, undefined){

    //     "use strict";

    //     function MoneyTicker(element, opts) {

    //         this.element = $(element);

    //         this.defaults = {
    //             interval: 60,
    //             movement: 1 // Pixel
    //         };

    //         this.opts = $.extend(this.defaults, opts);
    //         this.init();
    //     }

    //     MoneyTicker.prototype.init = function() {

    //         var self = this;

    //         this.intervalID = null;

    //         this.elementLeft = 0;
    //         this.elementWidth = this.element.width();
    //         this.element.append(this.element.html());

    //         this.element.on('mouseenter', function(e){
    //             self.stop();
    //         });

    //         this.element.on('mouseleave', function(e){
    //             self.start();
    //         });

    //         this.start();
    //     };

    //     MoneyTicker.prototype.start = function() {

    //         var self = this;

    //         self.stop();
    //         self.intervalID = setInterval(function() {
    //             self.elementLeft -= self.defaults.movement;
    //             // self.element.css("left", self.elementLeft + 'px');
    //             self.element.css('transform', 'translate3d(' + self.elementLeft + 'px, 0, 0)');
    //             if (self.elementLeft < (self.elementWidth * (-1))) {
    //                 self.elementLeft = 0;
    //             }
    //         }, self.defaults.interval);
    //     }

    //     MoneyTicker.prototype.stop = function() {
    //         clearInterval(this.intervalID);
    //     }

    //     $.fn.moneyTicker = function(opts) {
    //         return this.each(function() {
    //             new MoneyTicker(this, opts);
    //         });
    //     };

    // })(jQuery, window, document);

    // $('.moneyTicker .atxEntryContent').moneyTicker({
    //     interval: 20
    // });

    </script>
<? endif; ?>