$(function(){
	var $body;
	var $select;
	var messageIdNumber=0;
	var messageId;
	$.message=function(settings){
		if(settings.content==null){
			settings.content="";
		}
		if($body==null){
			$body=$("body");
		}
		if(!window.XMLHttpRequest&&$select==null){
			$select=$("select");
		}
		if($select!=null) {
			$select.css("visibility","hidden");
		}
		if(settings.type==null){
			settings.type="warn";
		}
		if(settings.time==null){
			settings.time=1500;
		}
		if(settings.id==null)
		{
			messageId="message"+messageIdNumber;
		}
		else
		{
			messageId=settings.id
		}
		messageIdNumber++;
		var messageHtml;
		
		messageHtml='<div class="baseMessage" id="'+messageId+'"><span class="icon_'+settings.type+'"></span><span class="icon_txt">'+settings.content+'</span><span class="icon_r"></span></div>';
		$body.append(messageHtml);
		var $message=$("#"+messageId);
		$message.css({"margin-left":"-"+parseInt($message.width()/2)+"px"}).slideToggle();
		setTimeout(function(){
			$message.animate({width:0,height:0},"toggle",function(){
				$message.remove();
				if ($select!=null){
					$select.css("visibility","visible");
				}
			});
		},settings.time);
		return messageId;
	}

});


//字符限制

function strlen_verify(obj, checklen, maxlen) { //obj表示文本框  checklen 要显示的剩余字数的span id   maxlen
	var v = obj.value;
	var len =v.length;
	
	if(maxlen >= len) {
		$('#'+checklen).html(maxlen - len);//checklen 是显示剩余字数的span id
	} else {
		obj.value = v.substring(0,maxlen);
	}
}

function valid_tel(mobile) {    var patten = new RegExp(/^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$|(^(13[0-9]|15[0-9]|17[0-9]|18[0-9])\d{8}$)/);    return patten.test(mobile);   } 

function valid_email(email) {    var patten = new RegExp(/^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]+$/);    return patten.test(email);   } 
//电子邮件验证
var emailOnly=function(str){
	var regEmail=/[_a-zA-Z\d\-\.]+@[_a-zA-Z\d\-]+(\.[_a-zA-Z\d\-]+)+$/;
	if (regEmail.test(str)){
		return true;
	} else {
		return false;
	}
}
function valid_zipcode(zip) {    var patten = new RegExp(/^\d{6}$/);    return patten.test(zip);   } 


function strlen(str) {
	return  str.length;
}


//密码强度检测
function passwordGrade(pwd) {
	var score = 0;
	var regexArr = ['[0-9]', '[a-z]', '[A-Z]', '[\\W_]'];
	var repeatCount = 0;
	var prevChar = '';
	//check length
	var len = pwd.length;
	score += len > 18 ? 18 : len;
	//check type
	for (var i = 0, num = regexArr.length; i < num; i++) { if (eval('/' + regexArr[i] + '/').test(pwd)) score += 4; }
	//bonus point
	for (var i = 0, num = regexArr.length; i < num; i++) {
		if (pwd.match(eval('/' + regexArr[i] + '/g')) && pwd.match(eval('/' + regexArr[i] + '/g')).length >= 2) score += 2;
		if (pwd.match(eval('/' + regexArr[i] + '/g')) && pwd.match(eval('/' + regexArr[i] + '/g')).length >= 5) score += 2;
	}
	//deduction
	for (var i = 0, num = pwd.length; i < num; i++) {
		if (pwd.charAt(i) == prevChar) repeatCount++;
		else prevChar = pwd.charAt(i);
	}
	score -= repeatCount * 1;
	return score;
 }
