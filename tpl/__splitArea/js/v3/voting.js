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
    	//var theUrl = '<?=$votingUrl?>votePanel.do?key=' + self.param.voteKey + '&template=' + self.param.template + '&imgUrl=' + self.param.imgUrls[this.currentImage] ;
        var theUrl = '<?=$votingUrl?>' + self.param.pollType + '.do?key=' + self.param.voteKey + '&template=' + self.param.template + '&imgUrl=' + self.param.imgUrls[this.currentImage] ;

        // console.log('url: '+theUrl);
    	$('#votingFrame').attr("src", theUrl);
        // console.log('set 2 votingFrame');
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
    // console.log('vot1');
    if (typeof votingBoxes != "undefined") {
        // console.log('vot2');
        for (s=0; s<votingBoxes.length; s++) {
            // console.log('s: '+s);

            var oImgUrls = (typeof votingBoxes[s]['imgUrls'] != 'undefined') ? votingBoxes[s]['imgUrls'] : '';
            var oVoteKey = (typeof votingBoxes[s]['voteKey'] != 'undefined') ? votingBoxes[s]['voteKey'] : '';
            var oTemplate = (typeof votingBoxes[s]['template'] != 'undefined') ? votingBoxes[s]['template'] : '';
            var oPollType = (typeof votingBoxes[s]['pollType'] != 'undefined') ? votingBoxes[s]['pollType'] : 'votePanel';

            window['theVoting'] = new slideshowVoting({
                imgUrls : oImgUrls,
                voteKey: oVoteKey,
                template: oTemplate,
                pollType : oPollType
            });

        }

    }

    if (window['initVoting'] == true && typeof window['theVoting'] != "undefined") {
        // console.log('initVoting exists');
        window['theVoting'].gotoImage(0);
    }
    else{
        // console.log('NO voting');
    }
});
