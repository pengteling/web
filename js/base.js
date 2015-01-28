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

