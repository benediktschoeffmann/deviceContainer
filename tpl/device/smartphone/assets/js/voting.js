<?php
/**
 * @collector noauto
 * @collector footerSplitArea
 */
?>

function slideshowVoting(param){
    var self = this;
    /**
    * goto a image
    */
    this.gotoImage = function(image){
    	this.currentImage = image;
    	<?
            if (!isset($absPath)) {
                $votingUrl = spunQ::getConfiguration()->getStringValue("oe24.oe24.votingUrl", '');
            }
    	?>
    	var theUrl = '<?=$votingUrl?>votePanel.do?key=' + self.param.voteKey + '&template=' + self.param.template + '&imgUrl=' + self.param.imgUrls[this.currentImage] ;
        $('#votingFrame').attr("src", theUrl);
    }
	this.showResult = function() {
		document.location.href= href + '&result=true';
	}
    this.currentImage = 1;
    this.param = param;
};

function checkVotingFrameSize() {
	var theframe = document.getElementById('vresultframe');
	var theBody = theframe.contentWindow.document.body;
	var contentHeight = theBody.offsetHeight + 30;
	var iframeHeight = theframe.offsetHeight;
	if (iframeHeight < contentHeight) {
		theframe.style.height= contentHeight + 'px';
	}
 };

$(document).ready(function() {
    if (typeof votingBoxes != "undefined") {
        
        for (s=0; s<votingBoxes.length; s++) {
            window['theVoting'] = new slideshowVoting({
                imgUrls : votingBoxes[s]['imgUrls'],
                voteKey: votingBoxes[s]['voteKey'],
                template: votingBoxes[s]['template']
            });
        }

    }

    if (window['initVoting'] == true && typeof window['theVoting'] != "undefined") {
        window['theVoting'].gotoImage(0);
    }
});
