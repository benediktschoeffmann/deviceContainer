<?php
/**
 * @collector noauto
 */
?>
 /** @collector footerSplitArea*/

if (typeof shoutBoxes != "undefined") {

	var initLoadComments;
	var userTriggerContent = Array();
	var userTriggerLevels = Array();
	var commentsTrigger = Array();
	var userTriggerStatus = Array();
	var userTriggerTags = Array();
	var permanentTriggerUserStatus = Array();
	var xhrArray = Array();
	(function(){
	  "use strict";
	    var skipDuplicateContentAtLevel = true;
	    var contentLevel = Object();
	    var maxContentCntperLevel = 5;
		var cookieSessionName = "PHPSESSID"; //FIXME
		var cookieAutoLoginName = "loginName";
		var cookieAutoLoginPass = "loginPass";
		var cookieRememberUserEmail = "userEmail";
		var cookieRememberUserName = "userName";
		var cookieRememberExpiresDays = 1;
		var cookieAutoLoginExpiresDays = 14;
		var guestData = Object();
		var userLevelReq = 0;
		guestData.status = 0;
		guestData.username = readCookie(cookieRememberUserName);
		guestData.email = readCookie(cookieRememberUserEmail);
		function getLayoutLevelsByPrio(){
			var levelArray = Array();
			$(".asideBox").each(function() {
				if($(this).attr('data-id')){
					levelArray.push($(this).attr('data-id'));
				}
			});
			return levelArray;
		}
		function getJsTriggerName(inName){
			if(!inName){
				return inName;
			}
			var funcName = inName;
			var funcParam = Array();
			var regexFunc=new RegExp('^([a-z]+)\((.*)\)','i');
			var funcArray = regexFunc.exec(inName);
			if(funcArray != null){
				var funcName = funcArray[1];
				try {var funcParam = eval('Array' + funcArray[2]);} catch (e) {}
			}
			return Array(funcName,funcParam);
		}
	    function initUserLevels(inData){
	        if(!inData){
	            return false;
	        }
			foundInLayout = false;
			var allLoadedLevelIds = Array();
			var dataByLevel = Object();
	        $.each(inData, function(key, val) {
				if(val['levels']){
					$.each(val['levels'], function(key2, val2) {
						dataByLevel[val2] = Object();
						dataByLevel[val2].items = val['items'];
						dataByLevel[val2].tagNames = val['tagNames'];
					});
					if(!val['jsTrigger']){
						jsTrigger=false;
					} else {
						jsTrigger=getJsTriggerName(val['jsTrigger']);
					}
					if(!jsTrigger || !window[jsTrigger[0]] || window[jsTrigger[0]](val, jsTrigger[1])){
						if(val['items']){
							if(isLevelExists(val['levels'])){
								foundInLayout=true;
								userLevelReq++;
								loadUserContentItems(val['items'], val['tagNames'], val['levels']);
								allLoadedLevelIds.push(val['levels'][0]);
							}
						}
					}
				}
	        });
			for (var i = 0; i < userTriggerLevels.length; ++i){
				userTriggerLevels[i](inData,dataByLevel);
			}
			userTriggerLevels = Array();
			/*
			$.each($('.asideBox[data-id]'), function() {
				if(allLoadedLevelIds.indexOf(parseInt($(this).attr('data-id'))) == -1){
					$('.inner', $(this)).append(Templates.renderNoContent());
					$(this).show();
				}
			});
			*/
			if(!foundInLayout){
				return false;
			}
			userTriggerStatus.push(function(inData){
	            if(!inData.status){
	                $('.asideBox[data-id]').hide();
					$('.asideBox[data-id] .inner article').remove();
					contentLevel = Object();
	            }
	        });
	    }
		function xhrAbort(){
			for (var i = 0; i < xhrArray.length; ++i){
				xhrArray[i].abort();
			}
			xhrArray = Array();
		}
	    function initUserData(inData, inItems, inTagNames, inLevels){
			$dataCnt = 0;
	        $.each(inLevels, function(keyLevel, valLevel) {
	            $.each(inData, function(keyData, valData) {
					$dataCnt++;
	                if(!contentLevel[valLevel]){
	                    contentLevel[valLevel]=Array();
	                }
	                if(skipDuplicateContentAtLevel && $.inArray(valData.id, contentLevel[valLevel]) != -1){
						//console.log("skip level: " + valData.id + ', content:' + valLevel);
	                    return true;
	                }
					if($('.contentBox.contentId'+valData.id).length > 0){
						//console.log("skip level #1: " + valData.id + ', content:' + valLevel);
						return true;
					}
	                if(maxContentCntperLevel <= contentLevel[valLevel].length){
						//console.log("skip level #2: " + valLevel + ', max-cnt:' + maxContentCntperLevel);
						if(valLevel != '0'){ //FIXME
							return false;
						}
	                }
	                contentLevel[valLevel].push(valData.id);
					if(inTagNames && inTagNames[$dataCnt-1]){
						if($dataCnt==1){
							var prefixTitle = $('.asideBox[data-id='+valLevel+'] .overwriteTitle').attr('data-prefixTitle');
							if(!prefixTitle || prefixTitle==null){
								prefixTitle='';
							} else {
								prefixTitle=prefixTitle.toUpperCase() + ' ';
							}
							$('.asideBox[data-id='+valLevel+'] .overwriteTitle').html(prefixTitle + inTagNames[$dataCnt-1].toUpperCase());
						}
						valData.tagName = inTagNames[$dataCnt-1];
					}
					$('.asideBox[data-id='+valLevel+']').attr('data-cnt', contentLevel[valLevel].length);
	                $('.asideBox[data-id='+valLevel+'] .inner').append(Templates.renderArticle(valData));
	                $('.asideBox[data-id='+valLevel+']').show();
	            });
	            //$('.asideBox[data-id='+valLevel+']').show();
	            //Sidebar.updateBox(valLevel);
	        });
			userLevelReq--;
			if(userLevelReq==0){
				for (var i = 0; i < userTriggerContent.length; ++i){
					userTriggerContent[i](contentLevel);
				}
				userTriggerContent = Array();
			}
	        if(!inData){
	            return false;
	        }
	    }
	    function loadUserContentItems(inItems, inTagNames, inLevels){
	        if(inItems.length <= 0){
	            return initUserData(false, inItems, inTagNames, inLevels);
	        }
	        xhrArray.push($.ajax({
	        dataType: "json",
	        url: '/json/article?ids=' + inItems.join('-'),
	        success: function(inData){initUserData(inData, inItems, inTagNames, inLevels)}
	        }).fail(function(){userLevelReq--;}));
	        return true;
	    }
	    function isLevelExists(inData){
	        for (var i = 0; i < inData.length; ++i){
	            if($('.asideBox[data-id='+inData[i]+']').length){
	                return true;
	            }
	        }
	        return false;
	    }
		initLoadComments = function (inCommentRef){
			$(document).ready(function() {loadComments(inCommentRef)});
		}
		function loadComments(inCommentRef){
	        xhrArray.push($.ajax({
	        dataType: "json",
	        url: '/user/json/getcomments/' + inCommentRef,
	        success: (function(response){
				for (var i = 0; i < commentsTrigger.length; ++i){
					commentsTrigger[i](response);
				}
				//commentsTrigger = Array();
			})}));
	    }
	    function loadUserContent(inUserId){
	        xhrArray.push($.ajax({
	        dataType: "json",
	        url: '/user/json/usercontent/' + inUserId,
	        success: initUserLevels
	        }));
	    }
	    function loadUserTags(inUserId){
	        xhrArray.push($.ajax({
	        dataType: "json",
	        url: '/user/json/tags/' + inUserId,
	        success: initUserTags
	        }));
	    }
	    function initUserTags(inData){
	        if(!inData){
	            return false;
	        }
	        $.each(inData, function(key, val) {
	            $('input[name="mappedTags[]"][type="checkbox"][value="'+val+'"]').attr('checked','checked');
				$('input[name="mappedTags[]"][type="hidden"][value="'+val+'"]').removeAttr('disabled');
				$('div[data-name="mappedTags"][data-id="'+val+'"]').removeClass('disabled');
	        });
			$('.mainList,.list').each(function(){
				Checkboxes.update($(this));
			});
	        for (var i = 0; i < userTriggerTags.length; ++i){
	            userTriggerTags[i](inData);
	        }
	    }
		function readCookie(name) {
			if(!document.cookie){
				return null;
			}
			var nameEQ = name + "=";
			var ca = document.cookie.split(';');
			for(var i=0;i < ca.length;i++) {
				var c = ca[i];
				while (c.charAt(0)==' ') c = c.substring(1,c.length);
				if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
			}
			return null;
		}
		function createCookie(name,value,days){
			if (days) {
				var date = new Date();
				date.setTime(date.getTime()+(days*24*60*60*1000));
				var expires = "; expires="+date.toGMTString();
			}
			else var expires = "";
			document.cookie = name+"="+value+expires+"; path=/";
		}
		function eraseCookie(name){
			createCookie(name,"",-1);
		}
		function setLoginStatus(response){
			for (var i = 0; i < userTriggerStatus.length; ++i){
				userTriggerStatus[i](response);
			}
			userTriggerStatus = Array();
			for (var i = 0; i < permanentTriggerUserStatus.length; ++i){
				permanentTriggerUserStatus[i](response);
			}
			if(response.status &&  response.status == 1){
				if(response.username){
					if(response.email){
						createCookie(cookieRememberUserEmail, response.email,cookieRememberExpiresDays);
					}
					createCookie(cookieRememberUserName, response.username,cookieRememberExpiresDays);
					if(response.cryptPasswd){
						createCookie(cookieAutoLoginName, response.username,cookieAutoLoginExpiresDays);
						createCookie(cookieAutoLoginPass, response.cryptPasswd,cookieAutoLoginExpiresDays);
					}
				}
				User.set(response);
				if($('.asideBox').length > 0){
					loadUserContent(response.id);
				}
			} else {
				eraseCookie(cookieAutoLoginName);
				eraseCookie(cookieAutoLoginPass);
				User.unset();
			}
		}
		function checkAutoLogin(){
			var tmpUser =readCookie(cookieAutoLoginName);
			var tmpPass =readCookie(cookieAutoLoginPass);
			if(tmpUser == null || tmpUser == null){
				setLoginStatus(guestData);
				return false;
			}
			if(tmpPass == '' || tmpPass == ''){
				setLoginStatus(guestData);
				return false;
			}
			$.post('/user/json', {login: 1, username: tmpUser, password: '1bc29b36f623ba82aaf6724fd3b16718', cryptPasswd:tmpPass}, function(response){
				setLoginStatus(response);
			},'json');

			return true;
		}
	    function checkLoginStatus(){
			if(readCookie(cookieSessionName) == null || readCookie(cookieSessionName) == ''){
				return checkAutoLogin();
			}
	        $.post('/user/json', 'status', function(response){
				setLoginStatus(response);
	        }, 'json').fail(function(){User.unset();});
			return true;
	    }
	    function initUserForm(inName){
			var formClassPre = '#'+inName+'Form';
			$(formClassPre + ' input,select,textarea,checkbox').change(function(e){
				if(e.target.name != 'reg_agb' && e.target.name != 'reg_netiquette'){
						$(formClassPre + ' input[name="'+inName+'"]').attr('value', 1);
				}
			});
			if(inName == 'login'){
				$(formClassPre + ' input[name="'+inName+'"]').attr('value', 1);
			}
	        $(formClassPre).bind('submit', function(){
				if(inName == 'logout'){
					// 4 connection probs
					xhrAbort();
					eraseCookie(cookieAutoLoginName);
					eraseCookie(cookieAutoLoginPass);
					eraseCookie(cookieRememberUserEmail);
					eraseCookie(cookieRememberUserName);
				}
	            var data = $(formClassPre).serialize();
	            //data += '&'+inName+'=1';
	            setErrorMsg(inName,'');
	            setSuccessMsg(inName, '');
				$(formClassPre+' button[type="submit"]').attr('disabled', 'disabled');
				$(formClassPre+' input[type="submit"]').attr('disabled', 'disabled');
	            $.post('/user/json', data, function(response){
					$(formClassPre+' button[type="submit"]').removeAttr('disabled');
					$(formClassPre+' input[type="submit"]').removeAttr('disabled');
	                setErrorMsg(inName, response.error);
	                setSuccessMsg(inName, response.success);
	                if(!response.error || response.error == null){
						if(response.success || true){
							if($(formClassPre+' input[name="successUrl"]').length > 0){
								document.location.href = $(formClassPre+' input[name="successUrl"]').attr('value');
								return true;
							}
							if(typeof(window[inName + 'Success']) != 'undefined' && window[inName + 'Success'] && window[inName + 'Success'] != null){
								window[inName + 'Success'](response);
								return true;
							}
						}
	                    $('#'+inName+'Form')[0].reset();
	                }
	                setLoginStatus(response);
	            },'json').fail(function(){
					setErrorMsg(inName,'Es ist ein Verbindungsfehler aufgetreten.');
					$(formClassPre+' button[type="submit"]').removeAttr('disabled');
					$(formClassPre+' input[type="submit"]').removeAttr('disabled');
				});;
	            return false;
	        });
	    }
	    function setErrorMsg(inClassName, inMsg){
	        /*setOutputMsg(inClassName + 'Error', inMsg);*/
			MessageBox.show(inMsg);
	    }
	    function setSuccessMsg(inClassName, inMsg){
	        //setOutputMsg(inClassName + 'Success', inMsg);
			MessageBox.show(inMsg);
	    }
	    function setOutputMsg(inClassName, inMsg){
	        if(!inMsg && inMsg==null){
	            inMsg='';
	        }
	        $('.' + inClassName + 'Msg').html(inMsg);
	    }
	    function isOldUser(inData){
	        //FIXME
	        if(!inData){
	            return true;
	        }
	        if(!inData.firstName || inData.firstName == null || inData.firstName == 'null'){
	            return true;
	        }
	        if(!inData.country || inData.country == null || inData.country == 'null'){
	            return true;
	        }
	        if(!inData.adress || inData.adress == null || inData.adress == 'null'){
	            return true;
	        }
	        return false;
	    }
	    function initUserMappedTag(inName){
	        if($('#' + inName + 'Form').length <= 0){
	            return false;
	        }
	        userTriggerStatus.push(function(inData){
	            if(!inData.status || isOldUser(inData)){
	                document.location.href='/user';
	            } else if(inData.status==1){
	                loadUserTags(inData.id);
	            }
	        });
	        return true;
	    }
	    function initUserRegister(inName, userStatus){
	        if($('#' + inName + 'Form').length <= 0){
	            return false;
	        }
	        userTriggerStatus.push(function(inData){
	            if(inData.status == userStatus){
	                $.each(inData, function(keyData, valData) {
	                    if(valData==null){
	                        //valData='';
	                        return true;
	                    }
	                    if(keyData == 'country' || keyData == 'state' || keyData == 'birthdayDay' || keyData == 'birthdayMonth'|| keyData == 'birthdayYear'){
	                        $('select[data-source="'+keyData+'"] option[value="'+valData+'"]').attr('selected','selected');
	                    } else if(keyData == 'gender'){
	                        $('input[data-source="'+keyData+'"][value="'+valData+'"]').attr('checked','checked');
	                    } else {
	                        $('input[data-source="'+keyData+'"]').attr('value',valData);
	                    }
	                });
	            }
	        });
	    }
	    $(document).ready(function() {
	        initUserRegister('userRegister', true); //set user values
			initUserRegister('login', false);
	        initUserMappedTag('userSettings'); //set user values
			initUserForm('userRegister');
			initUserForm('userSettings');
	        initUserForm('login');
	        initUserForm('logout');
	        initUserForm('getPass');
	        initUserForm('getUsername');
	        initUserForm('setComment');
	        checkLoginStatus();
	    });
	})();
}

$(document).ready(function() {

	if (typeof shoutBoxes != "undefined") {

		Comments.init();

	    for (s=0; s<shoutBoxes.length; s++)
	    {
	    	initLoadComments(shoutBoxes[s]['id']);
	    	if (!shoutBoxes['checkPostings']) {
		        function setCommentSuccess(){
		            initLoadComments(shoutBoxes[s]['id']);
					$('#setCommentForm')[0].reset();
		        }
				function funcInitLoadComments(shoutId){
					window.setTimeout(function(){
						initLoadComments(shoutId);
						funcInitLoadComments(shoutId);
					}, 8000);
				}
				funcInitLoadComments(shoutBoxes[s]['id']);
	    	}
	    }
	}

});
