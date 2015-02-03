<!--#include virtual="/FiveInc/inc.asp"-->
<!--#include virtual="/fiveinc/md5.asp"-->

<%
if Easp.var("act")="db" and Easp.var("username")<>"" and Easp.var("password")<>"" then

Easp.var("md5pwd") =md5(Easp.var("password"))
Easp.var("IP") = getIP()

result = Easp.Db.Ins("user","username:{username},password:{md5pwd},email:{email},groupid:1,loginIP:{IP},lockuser:1") '注册时先锁定账户，审核后才可以登陆
if result>0 then

		

response.write "4注册成功！待审核成功后即可正常登陆"
else 

response.write "0注册出错，请联系管理员"
end if

response.End()
end if
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="/css/base.css" rel="stylesheet" type="text/css">
<link href="/css/cart.css" rel="stylesheet" type="text/css">
<script src="/js/jquery.min.js" type="text/javascript"></script>
<script src="/js/base.js" type="text/javascript"></script>
<script src="/js/cart.js" type="text/javascript"></script>
<title>会员注册</title>
</head>
<script>
$(function(){
	$(".ico01").addClass("hover ico01_");
	$(".user_title_more li").eq(<%=clng(request("v"))%>).addClass("hover");
})


</script>
<script>
function checkreg(the)
{
	if(strlen(the.username.value)<5||strlen(the.username.value)>20)
	{
		the.username.focus();
		return false
	}
	if(strlen(the.password.value)<6||strlen(the.password.value)>16)
	{
		the.password.focus();
		return false
	}
	if(the.username.value==the.password.value)
	{
		the.password.focus();
		return false
	}
	if(strlen(the.repass.value)<6||strlen(the.repass.value)>16)
	{
		the.repass.focus();
		return false
	}
	if($.trim(the.password.value)!=$.trim(the.repass.value))
	{
		the.repass.focus();
		return false
	}
	if($.trim(the.email.value)==""||!emailOnly($.trim(the.email.value)))
	{
		the.email.focus();
		return false
	}
	if($.trim(the.imgcode.value)=="")
	{
		the.imgcode.focus();
		return false
	}
	var url,data;
	url="?act=db";
	data="username="+encodeURIComponent($.trim(the.username.value));
	data+="&password="+encodeURIComponent($.trim(the.password.value));
	data+="&repass="+encodeURIComponent($.trim(the.repass.value));
	data+="&email="+encodeURIComponent($.trim(the.email.value));
	data+="&imgcode="+encodeURIComponent($.trim(the.imgcode.value));
	$.ajax({
	type:"post",
	cache:false,
	url:url,
	data:data,
	error:function(){alert("\u670d\u52a1\u5668\u9519\u8bef\uff0c\u64cd\u4f5c\u5931\u8d25");},
	success:function(_)
	{
		var act=_.substring(0,1);
		var info=_.substring(1);
		if(act>1)
		{
			the.username.value="";
			the.password.value="";
			the.repass.value="";
			the.email.value="";
			the.imgcode.value="";
			$("#reg_username").html("由5-20位数字、字母、下划线组成");
			$("#reg_password").html("由6-16个数字、字母、下划线组成");
			$("#reg_repass").html("请再次输入密码");
			$("#reg_email").html("请输入常用邮箱");
			$("#reg_code").html("请输入左侧图片上的文字");
			$("#imgcode")[0].src='/lib/imgcode.asp?t0=80&t1=20&'+Math.random();
			$("#strength").removeClass().addClass('nothing').text('');
		}
		switch(act)
		{
			case "0":
				$.message({content:info});
				break;
			case "1":
				$(".c_"+info).focus();
				break;
			case "2":
				$.message({type:"ok",content:info,time:10000});
				break;
			case "3":
				$.message({type:"ok",content:info,time:5000});
				break;
			case "4":
				$.message({type:"ok",content:info,time:2000});
				var gourl=$.trim(the.gourl.value);
				if(gourl==""){gourl="./user_index.asp"}
				if(gourl.indexOf("login.asp")!=-1||gourl.indexOf("reg.asp")!=-1){gourl="./user_index.asp"}
				$.message({type:"ok",content:info});
				setTimeout(function(){location.href=gourl},2500);
				break;
			default:
				alert(_)
				break;
		}
	}});
	return false
}
$(function(){
	$(".c_username").focus(function(){$('#reg_username').addClass('tipred');$(this).addClass('ipon');});
	$(".c_username").blur(function(){$('#reg_username').removeClass();$('#reg_username').addClass('tip');$(this).removeClass('ipon');
	if($(this)[0].value!=""){ajaxcheck("username","");}});
	$(".c_password").focus(function(){$('#reg_password').addClass('tipred');$(this).addClass('ipon');});
	$(".c_password").blur(function(){$('#reg_password').removeClass();$('#reg_password').addClass('tip');$(this).removeClass('ipon');if($(this)[0].value!=""){ajaxcheck("password",$(".c_username")[0].value);};
	var value=$(this).val();
	var box=$('#strength');
	if (value==''||value==null){
				box.removeClass().addClass('nothing').text('');
				return false;
			} else if (value.length<6){
				box.removeClass().addClass('nothing').text('密码过短');
			} else {
				var score=passwordGrade(value);
				if (score<11){
					box.removeClass().addClass('nothing').text('不安全');
				} else if (score<21){
					box.removeClass().addClass('strength normal').text('安全程度：低');
				} else if (score<31){
					box.removeClass().addClass('strength general').text('安全程度：中');
				} else if (score>30){
					box.removeClass().addClass('strength special').text('安全程度：高');
				}
			}
	});
	$(".c_repass").focus(function(){$('#reg_repass').addClass('tipred');$(this).addClass('ipon');});
	$(".c_repass").blur(function(){$('#reg_repass').removeClass();$('#reg_repass').addClass('tip');$(this).removeClass('ipon');
	if($(this)[0].value!=""){ajaxcheck("repass",$(".c_password")[0].value);}});
	$(".c_email").focus(function(){$('#reg_email').addClass('tipred');$(this).addClass('ipon');});
	$(".c_email").blur(function(){$('#reg_email').removeClass();$('#reg_email').addClass('tip');$(this).removeClass('ipon');if($(this)[0].value!=""){ajaxcheck("email","");};});
	$(".c_code").focus(function(){$('#reg_code').addClass('tipred');$(this).addClass('ipon');});
	$(".c_code").blur(function(){$('#reg_code').removeClass();$('#reg_code').addClass('tip');$(this).removeClass('ipon');if($(this)[0].value!=""){ajaxcheck("code","");};});
});
function ajaxcheck(t0,t1)
{
	var t2=$(".c_"+t0)[0].value;
	var t3="reg_"+t0;
	var url,data;
	url="ajax_user.asp";
	data="act="+encodeURIComponent($.trim(t0));
	data+="&formvalue="+encodeURIComponent($.trim(t2));
	data+="&checkvalue="+encodeURIComponent($.trim(t1));
	$.ajax({
	type:"post",
	cache:false,
	url:url,
	data:data,
	error:function(){$("#"+t3).html("fail");},
	success:function(_)
	{
		
		
		
		
		var act=_.substring(0,1);
		var info=_.substring(1);
		switch(act)
		{
			case "0":
				$("#"+t3).html(info);
				//$(".c_"+t0).focus();
				$("#sendreg")[0].disabled=true;
				break;
			case "1":
				$("#"+t3).html(info);
				$("#sendreg")[0].disabled=false;
				break;
			default:
				$("#"+t3).html("异步验证出错");
				break;
		}
	}});
}
</script>


<body>

<div class="width">
        <div class="user_bg">
            <div id="uleft">
    <!--#include virtual="/uleft.asp"-->
</div>
            <!--左侧结束-->
            <div id="uright">
                
                 
                 <div class="user_title_more">
                    <ul>
                    <li><a href="user_reg.asp">用户注册</a></li>              
                        <li><a href="user_login.asp">用户登录</a></li>                      
                          
                  
                    </ul>
                </div>
                  <div class="page_content">
                   
                   <form onSubmit="return checkreg(this)">
                   <ul id="reg">
                       <li><span>用户名：</span><input type="text" name="username" class="ip w01 c_username" maxlength="20" /><span class="tip" id="reg_username">由5-20位数字、字母、下划线组成</span></li>
                       <li><span>密码：</span><input type="password" name="password" class="ip w01 c_password" maxlength="16" /><span class="tip" id="reg_password">由6-16个数字、字母、下划线组成</span></li>
                       <dd><div id="strength"></div></dd>
                       <li><span>再次输入密码：</span><input type="password" name="repass" class="ip w01 c_repass" maxlength="16" /><span class="tip" id="reg_repass">请再次输入密码</span></li>
                       <li><span>电子邮箱：</span><input type="text" name="email" class="ip w01 c_email" maxlength="20" /><span class="tip" id="reg_email">请输入常用邮箱</span></li>
                       <li><span>验证码：</span><input type="text" name="imgcode" class="ip w02 c_code" maxlength="4" /> <img src="/fiveinc/imgcode.asp?t0=80&t1=20" title="看不清楚？点击刷新！" align="absmiddle" id="imgcode" onClick="this.src+='&'+Math.random();" /><span class="tip" id="reg_code">请输入左侧图片上的文字</span></li>
                      
                       <dd><input type="hidden" name="gourl" value="<%=request("gourl")%>" /><input type="submit" value="注 册" class="bnt" id="sendreg"/></dd>
                   </ul>
                   </form>
                   
                   
                </div>
            </div>
            <!--右侧结束-->

            <div class="clear"></div>
        </div>
    </div>
    
