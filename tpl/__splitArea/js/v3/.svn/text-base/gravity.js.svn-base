<?php
/**
 * @collector noauto
 * @collector footerSplitArea
 */
?>

function GravityAd(options) {

    this.options = options;
    this.playerMajorVersion = globalPlayerMajorVersion;

    var rc = this.init();
    if (false === rc) {
        return;
    }

    this.addPlayerEventListener();
    this.player.setMute(true);
    // this.player.play(true);
}

// -------------------------------------------------------
// -------------------------------------------------------

GravityAd.prototype.addPlayerEventListener = function() {

    var self = this;

    function playerReady() {

        var timeoutId;

        self.bodyClass = self.bodyElement.className;
        self.bodyElement.className = [self.bodyClass, 'withGravityAd'].join(" ");

        self.addWindowEventListener();
        self.addMoveEventListener();
        self.addVolumeEventListener();

        window.scrollTo(0, 0);

        // jwplayer 6 braucht lange, bis die Hoehe des Containers angepasst ist
        function checkContainerHeight() {

            var containerHeight = document.querySelector('#gravityPlayerContent').clientHeight;

            if (containerHeight > 0) {
                clearTimeout(timeoutId);
                self.updatePositions();
            } else {
                timeoutId = setTimeout(checkContainerHeight, 50);
            }
        }
        timeoutId = setTimeout(checkContainerHeight, 50);
    }

    function playerPlay() {
        // (ws) 2016-01-19 Skyscaper nicht zeigen, wenn Gravity-Ad abgespielt wird
        self.skyscrapers.style.display = 'none';
        // (pj) 2015-11-17 Gravity Container auf Block erst bei Video Play setzen
        self.gravityContainer.style.display = 'block';
        // self.updatePositions();
        // (pj) 2015-11-17 end
    }

    function playerComplete() {
        if (self.options.maxPlayCounter < 1) {
            // 1) Ein Wert <= 0 bedeutet, dass das Video endlos neu gestartet wird
            self.player.play(true);
        } else if (self.options.maxPlayCounter >= 1 && self.currentPlayCounter < self.options.maxPlayCounter) {
            // 2) Ein Wert groesser 0 (1, 2, ... ) bedeutet, dass das Video so oft abgespielt wird, wie angegeben
            self.currentPlayCounter++;
            self.player.play(true);
        } else {
            // self.player.remove();
            // self.gravityContainer.style.display = 'none';
            self.player.stop();
            // (ws) 2016-01-19 Skyscaper zeigen, wenn Gravity-Ad nicht abgespielt wird
            self.skyscrapers.style.display = 'block';
        }
    }

    function playerClick() {
        window.open(self.options.url);
    }

    function playerSetupError() {
        self.player.remove();
        self.gravityContainer.style.display = 'none';
    }

    // -----------------------------------------------
    // -----------------------------------------------

    if (6 === globalPlayerMajorVersion) {

        self.player.onReady(playerReady);
        // (pj) 2015-11-17 bei onPlay soll erst der gravityContainer sichtbar werden.
        // Wunsch von Florian/Georg, da sonst lange Zeite eine schwarze Flaeche sichtbar ist.
        self.player.onPlay(playerPlay);
        // (pj) 2015-11-17 end
        self.player.onComplete(playerComplete);
        self.player.onDisplayClick(playerClick);
        self.player.onSetupError(playerSetupError);

    } else if (7 === globalPlayerMajorVersion) {

        self.player.on('ready', playerReady);
        // (pj) 2015-11-17 bei onPlay soll erst der gravityContainer sichtbar werden.
        // Wunsch von Florian/Georg, da sonst lange Zeite eine schwarze Flaeche sichtbar ist.
        self.player.on('play', playerPlay);
        // (pj) 2015-11-17 end
        self.player.on('complete', playerComplete);
        self.player.on('click', playerClick);
        self.player.on('setupError', playerSetupError);


    // (bs) 2018-02-16 Anpassungen für das Update auf Version 8
    } else if (8 === globalPlayerMajorVersion) {
        //console.log('gravity wants to use Version 8 of jwPlayer');
        self.player.on('ready', playerReady);
        self.player.on('play', playerPlay);
        self.player.on('complete', playerComplete);
        self.player.on('click', playerClick);
        self.player.on('setupError', playerSetupError);

    }

    // self.player.on('ready', function(event) {

    //     var offsetHeight = self.gravityContainer.offsetHeight;
    //     console.log(offsetHeight);

    //     self.bodyClass = self.bodyElement.className;
    //     self.bodyElement.className = [self.bodyClass, 'withGravityAd'].join(" ");

    //     self.addWindowEventListener();
    //     self.addMoveEventListener();
    //     self.addVolumeEventListener();

    //     self.updatePositions();

    //     self.wrapper.style.marginTop = offsetHeight + 'px';
    //     window.scrollTo(0, 0);
    // });

    // self.player.on('complete', function() {

    //     if (self.options.maxPlayCounter < 1) {
    //         // 1) Ein Wert <= 0 bedeutet, dass das Video endlos neu gestartet wird
    //         self.player.play(true);
    //     } else if (self.options.maxPlayCounter >= 1 && self.currentPlayCounter < self.options.maxPlayCounter) {
    //         // 2) Ein Wert groesser 0 (1, 2, ... ) bedeutet, dass das Video so oft abgespielt wird, wie angegeben
    //         self.currentPlayCounter++;
    //         self.player.play(true);
    //     } else {
    //         // self.player.remove();
    //         self.player.stop();
    //     }
    // });

    // self.player.on('click', function(event) {
    //     window.open(self.options.url);
    // });

    // self.player.on('setupError', function(e) {
    //     self.player.remove();
    // });

    // self.player.on('remove', function(event) {
    //     self.gravityContainer.style.display = 'none';
    // });
}

GravityAd.prototype.addWindowEventListener = function() {

    var self = this;

    function windowResizeHandler() {
        self.updatePositions();
    }

    function windowScrollHandler() {
        var opacity = self.getOpacity();
        self.gravityContainer.style.opacity = opacity;
    }

    if (window.addEventListener) {

        window.addEventListener('scroll', windowScrollHandler, false);
        window.addEventListener('resize', windowResizeHandler, false);

    } else if (window.attachEvent)  {

        window.attachEvent('scroll', windowScrollHandler);
        window.attachEvent('resize', windowResizeHandler);
    }
}

GravityAd.prototype.addMoveEventListener = function() {

    var self = this;

    function gravityMoveClickHandler(event) {

        var containerHeight = document.querySelector('#gravityPlayerContent').clientHeight;

        gravityScrollToY(containerHeight, 1500, 'easeInOutQuint');

        event.preventDefault();
        event.stopPropagation();
    }

    if (this.gravityMove && this.gravityMove.addEventListener) {
        this.gravityMove.addEventListener('click', gravityMoveClickHandler, false);
    } else if (this.gravityMove && this.gravityMove.attachEvent)  {
        this.gravityMove.attachEvent('click', gravityMoveClickHandler);
    }
    if (this.gravityMoveLogo && this.gravityMoveLogo.addEventListener) {
        this.gravityMoveLogo.addEventListener('click', gravityMoveClickHandler, false);
    } else if (this.gravityMoveLogo && this.gravityMoveLogo.attachEvent)  {
        this.gravityMoveLogo.attachEvent('click', gravityMoveClickHandler);
    }

}

GravityAd.prototype.addVolumeEventListener = function() {

    var self = this;

    function gravityVolumeClickHandler(event) {

        if (typeof self.player !== 'object' || self.player.getState() === 'idle') {
            return;
        }

        self.player.setMute(!self.player.getMute());
        self.gravityVolumeIcon.src = (true === self.player.getMute())
            ? '/images/gravity/gravityVolumeMute.png'
            : '/images/gravity/gravityVolumeSpeaker.png';

        event.preventDefault();
        event.stopPropagation();
    }

    if (this.gravityVolume && this.gravityVolume.addEventListener) {
        this.gravityVolume.addEventListener('click', gravityVolumeClickHandler, false);
    } else if (this.gravityVolume && this.gravityVolume.attachEvent)  {
        this.gravityVolume.attachEvent('click', gravityVolumeClickHandler);
    }
}

// -------------------------------------------------------
// -------------------------------------------------------

GravityAd.prototype.updatePositions = function() {

    var windowHeight    = this.getWindowHeight(),
        containerHeight = document.querySelector('#gravityPlayerContent').clientHeight;
        clientHeight    = this.gravityControls.clientHeight,
        minHeight       = Math.min(containerHeight, windowHeight);

    // (pj) 2015-11-17 Bug, wenn Gravity Container erst beim Play-Event erscheinen soll, muss hier die Opacity auch nochmal gesetzt werden.
    // Wenn es hier nicht gesetzt wird, wird der Container zwar geoeffnet, aber die Opacity bleibt bei 0.
    this.gravityContainer.style.opacity = this.getOpacity();
    // (pj) 2015-11-17 end
    this.gravityControls.style.top = (minHeight - clientHeight) + 'px';
    this.wrapper.style.marginTop = containerHeight + 'px';

    // (pj) 2015-11-13 Sticky Header zum testen, im Echtbetrieb kann der raus.
    // (bs) sollt ja echt betrieb sein, oder ? ich nehme die Zeile mal raus.
    // OE24InitSticky('gravity', 'Superbanner', 'bb_sticky');
    // (pj) 2015-11-13 end
}

GravityAd.prototype.getWindowHeight = function() {

    var windowHeight = window.parent.innerHeight ||
                       window.parent.document.documentElement.clientHeight ||
                       window.parent.document.body.clientHeight;

    return windowHeight;
}

GravityAd.prototype.getOpacity = function() {

    var self = this,
        windowHeight = self.getWindowHeight(),
        offsetHeight = self.gravityContainer.offsetHeight,
        scrollPosition = window.pageYOffset || document.documentElement.scrollTop,
        minHeight = Math.min(offsetHeight, windowHeight),
        term = minHeight - self.opacityZeroPosition;

    if (scrollPosition <= term) {
        opacity = 1 - (scrollPosition / windowHeight);
    } else {
        opacity = 0;
    }

    if (opacity > 0) {
        // (ws) 2016-01-19 Skyscaper zeigen, wenn Gravity-Ad nicht abgespielt wird
        self.skyscrapers.style.display = 'none';
        // (pj) 2015-11-17 Player abspielen, wenn sichtbar
        self.player.play(true);
    } else {
        // (ws) 2016-01-19 Skyscaper zeigen, wenn Gravity-Ad nicht abgespielt wird
        self.skyscrapers.style.display = 'block';
        // (pj) 2015-11-17 Player pausieren, wenn nicht sichtbar
        self.player.pause(true);
    }

    return opacity;
}

// -------------------------------------------------------
// -------------------------------------------------------

GravityAd.prototype.init = function() {

    // Zaehler zum Vergleich, wie oft das Video gespielt werden soll, falls
    // diese Option konfiguriert wurde (siehe -> globalGravityOptions.maxPlayCounter)
    this.currentPlayCounter = 1;

    // Abstand von oben, wo die Opacity des Ad-Containers auf 0 gesetzt wird
    this.opacityZeroPosition = 90;

    // Opacity des Ad-Containers, bei der das Video pausiert wird
    this.suspendPlayBack = 0.5;

    // ---------------------------------------------------

    this.bodyElement          = document.querySelector('body');
    this.wrapper              = document.querySelector('#wrap');
    this.gravityContainer     = document.querySelector('.gravityContainer');
    this.gravityPlayerContent = document.querySelector('#gravityPlayerContent');
    this.skyscrapers          = document.querySelector('#Skyscrapers');

    this.gravityControls      = this.gravityContainer.querySelector('.gravityControls');
    this.gravityVolume        = this.gravityControls.querySelector('.gravityVolume');
    this.gravityMove          = this.gravityControls.querySelector('.gravityMove');
    this.gravityMoveLogo      = this.gravityContainer.querySelector('.gravityMoveLogo');
    this.gravityVolumeIcon    = this.gravityVolume.querySelector('.gravityVolumeIcon');
    this.gravityMoveIcon      = this.gravityMove.querySelector('.gravityMoveIcon');

    this.player = this.initPlayer();
    if (!this.player) {
        return false;
    }

    // ---------------------------------------------------

    this.header = document.querySelector('header');

    // ---------------------------------------------------

    // (pj) 2015-11-17 Gravity Container hier noch nicht auf Block setzen.
    // Grund: Das oeffnen des Containers hinterlaesst einen schwarzen Bereich fuer etwa 2-3 Sekunden, danach wird erst das Video abgespielt.
    // Wunsch: Container soll sich erst oeffnen, wenn das Video zum abspielen beginnt.
    // this.gravityContainer.style.display = 'block';
    // (pj) 2015-11-17 end

    // ---------------------------------------------------

    return true;
}

GravityAd.prototype.initPlayer = function() {

    var self = this;

    var player,
        playerId = self.gravityPlayerContent.getAttribute('id'),
        playerConfig = {
            // 'primary': 'flash',
            'file': self.options.video,
            'image': (typeof self.options.image === 'undefined' || !self.options.image) ? '' : self.options.image,
            'type': 'mp4',
            'autostart': true,
            'width': '100%',
            'aspectratio': '16:9',
            'mute': true,
            'controls': false,
            // 'flashplayer': 'http://www.oe24.at/misc/jwplayer_7_0_3/jwplayer.flash.swf'
            'flashplayer': 'http://www.oe24.at/misc/jwplayer_8_0_11/jwplayer.flash.swf',
            // für version 8:
            // 'key': 'QcCdgx3inM94dJ9izldPrT3TuCMlZ+e+QhYdRg=='
        }

    if (null === playerId) {
        // console.log('playerId ist null') ;
        return null;
    }

    player = jwplayer(playerId);
    player = player.setup(playerConfig);

    return player;
}


// -------------------------------------------------------
// -------------------------------------------------------


if (typeof jwplayer === 'function') {

    var globalPlayerMajorVersion = jwplayer.version.substr(0, 1)*1;

    if (6 === globalPlayerMajorVersion) {
        jwplayer.key = "0c5MB4r7nSgjR9tFqI4PsNqh4MQcbFV0duseNQ==";
    } else if (7 === globalPlayerMajorVersion) {
        jwplayer.key = "4BDv8xMllXGBIp2Tj+l3LlDBKqajA2+ZMcou/w==";
        // jwplayer.key = "IJ159Vs5AiH7tZUMXfkm3ORPVL55CSUFv19XeQ==";
    } else {
        jwplayer.key = "unknown";
    }

    if (typeof globalGravityOptions !== 'undefined' && globalGravityOptions !== null &&
        typeof globalGravityOptions.video !== 'undefined' && globalGravityOptions.video !== null) {
        new GravityAd(globalGravityOptions);
    }
}


// -------------------------------------------------------
// -------------------------------------------------------


// http://stackoverflow.com/questions/12199363/scrollto-with-animation

// first add raf shim
// http://www.paulirish.com/2011/requestanimationframe-for-smart-animating/
window.requestAnimFrame = (function(){
  return  window.requestAnimationFrame       ||
          window.webkitRequestAnimationFrame ||
          window.mozRequestAnimationFrame    ||
          function( callback ){
            window.setTimeout(callback, 1000 / 60);
          };
})();

// main function
function gravityScrollToY(scrollTargetY, speed, easing) {

    // scrollTargetY: the target scrollY property of the window
    // speed: time in pixels per second
    // easing: easing equation to use

    var scrollY = window.scrollY,
        scrollTargetY = scrollTargetY || 0,
        speed = speed || 2000,
        easing = easing || 'easeOutSine',
        currentTime = 0;

    // min time .1, max time .8 seconds
    var time = Math.max(.1, Math.min(Math.abs(scrollY - scrollTargetY) / speed, .8));

    // easing equations from https://github.com/danro/easing-js/blob/master/easing.js
    var PI_D2 = Math.PI / 2,
        easingEquations = {
            easeOutSine: function (pos) {
                return Math.sin(pos * (Math.PI / 2));
            },
            easeInOutSine: function (pos) {
                return (-0.5 * (Math.cos(Math.PI * pos) - 1));
            },
            easeInOutQuint: function (pos) {
                if ((pos /= 0.5) < 1) {
                    return 0.5 * Math.pow(pos, 5);
                }
                return 0.5 * (Math.pow((pos - 2), 5) + 2);
            }
        };

    // add animation loop
    function tick() {
        currentTime += 1 / 60;

        var p = currentTime / time;
        var t = easingEquations[easing](p);

        if (p < 1) {
            requestAnimFrame(tick);
            window.scrollTo(0, scrollY + ((scrollTargetY - scrollY) * t));
        } else {
            window.scrollTo(0, scrollTargetY);
        }
    }

    // call it once to get started
    tick();
}

// scroll it!
// gravityScrollToY(0, 1500, 'easeInOutQuint');
