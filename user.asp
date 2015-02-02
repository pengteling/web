<!--#include virtual="/fiveinc/conn.asp"-->
<!--#include virtual="/fiveinc/md5.asp"-->
<!--#include virtual="/User_Config.asp"-->
<%

if request("act")="checkdb" then

result = Easp.Db.Upd("user","somane={truename},sex={sex},phone={tel},email={email},zip={zipcode},[add]={address}","userid={userid}")
if result>0 then

	response.write "1修改成功"
else
	response.write "0修改失败！"
end if
response.End()
end if


if request("act")="checkdb2" then

Easp.Var("oldpwd") = md5(Easp.var("oldpass"))
Easp.Var("password") = md5(Easp.var("password"))
set rs =Easp.Db.Sel("select * from [user] where userid={userid} and password={oldpwd}")
if  rs.eof then
	response.write "0旧密码输入不正确！"
	response.End()	
end if


result = Easp.Db.Upd("user","password={password}","userid={userid}")
if result>0 then

	response.write "1修改成功"
else
	response.write "0修改失败！"
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
<script src="/js/dialog/jquery.artDialog.js?skin=default" language="javascript"></script>

<title>我的账户</title>
</head>
<script>
$(function(){
	$(".ico06").addClass("hover ico06_");
	$(".user_title_more li").eq(<%=clng(request("v"))%>).addClass("hover");
})
</script>
<script>

function checkdb(the)
{
	var sex="0";
	for(i=0;i<the.sex.length;i++)
	{
		if(the.sex[i].checked)
		{
			sex=the.sex[i].value;
		}
	}
	
	if($.trim(the.truename.value)=="")
	{
		$.message({content:"联系人不能为空"});
		the.truename.focus();
		return false;
	}
	
	if($.trim(the.truename.value)=="")
	{
		$.message({content:"联系人不能为空"});
		the.truename.focus();
		return false;
	}
	
	if(!valid_tel(the.tel.value)){
			
			$.message({content:"电话格式不对，请输入座机或手机号码！"});
			the.tel.focus();
			return false
		}
	if(!valid_email(the.email.value)){
			
			$.message({content:"电子邮箱格式不对！"});
			the.email.focus();
			return false
		}	
	if(!valid_zipcode(the.zipcode.value)){
			
			$.message({content:"请输入正确的邮政编码！"});
			the.zipcode.focus();
			return false
		}		
	if(the.address.value==""){
			
			$.message({content:"请输入详细地址！"});
			the.address.focus();
			return false
		}		

	var url,data;
	url="?act=checkdb";
	data="truename="+encodeURIComponent($.trim(the.truename.value));
	data+="&sex="+encodeURIComponent(sex);	
	data+="&tel="+encodeURIComponent($.trim(the.tel.value));
	data+="&email="+encodeURIComponent($.trim(the.email.value));
	data+="&zipcode="+encodeURIComponent($.trim(the.zipcode.value));
	data+="&address="+encodeURIComponent($.trim(the.address.value));
	$.ajax({
	type:"post",
	cache:false,
	url:url,
	data:data,
	error:function(_a){alert(_a);},
	success:function(_)
	{
		var act=_.substring(0,1);
		var info=_.substring(1);
		switch(act)
		{
			case "0":
				$.message({type:"error",content:info});
				break;
			case "1":
				$.message({type:"ok",content:info,time:2500});
				//setTimeout(function(){location.href="user.asp?t="+Math.random()+""},3500);
				break;
			
			default:
				alert(_)
				break;
		}
	}});
	return false;
}

$(function(){
	$(".c_truename").focus(function(){$('#reg_truename').addClass('tipred');$(this).addClass('ipon');});
	$(".c_truename").blur(function(){$('#reg_truename').removeClass();$('#reg_truename').addClass('tip');$(this).removeClass('ipon');});
	
	
	$(".c_tel").focus(function(){$('#reg_tel').addClass('tipred');$(this).addClass('ipon');});
	$(".c_tel").blur(function(){$('#reg_tel').removeClass();$('#reg_tel').addClass('tip');$(this).removeClass('ipon');});
	
	$(".c_email").focus(function(){$('#reg_email').addClass('tipred');$(this).addClass('ipon');});
	$(".c_email").blur(function(){$('#reg_email').removeClass();$('#reg_email').addClass('tip');$(this).removeClass('ipon');});
	
	
	$(".c_zipcode").focus(function(){$('#reg_zipcode').addClass('tipred');$(this).addClass('ipon');});
	$(".c_zipcode").blur(function(){$('#reg_zipcode').removeClass();$('#reg_zipcode').addClass('tip');$(this).removeClass('ipon');});
	$(".c_address").focus(function(){$('#reg_address').addClass('tipred');$(this).addClass('ipon');});
	$(".c_address").blur(function(){$('#reg_address').removeClass();$('#reg_address').addClass('tip');$(this).removeClass('ipon');});
	$("#user_menu_10").addClass("hover");
})









function checkdb2(the)
{
	the.bnt.disabled=true;
	if(strlen(the.oldpass.value)<6||strlen(the.oldpass.value)>16)
	{
		the.oldpass.focus();
		the.bnt.disabled=false;
		return false
	}
	if(strlen(the.password.value)<6||strlen(the.password.value)>16)
	{
		the.password.focus();
		the.bnt.disabled=false;
		return false
	}
	if(strlen(the.repass.value)<6||strlen(the.repass.value)>16)
	{
		the.repass.focus();
		the.bnt.disabled=false;
		return false
	}
	if($.trim(the.password.value)!=$.trim(the.repass.value))
	{
		the.repass.focus();
		the.bnt.disabled=false;
		return false
	}
	var url,data;
	url="?act=checkdb2";
	data="oldpass="+encodeURIComponent($.trim(the.oldpass.value));
	data+="&password="+encodeURIComponent($.trim(the.password.value));
	data+="&repass="+encodeURIComponent($.trim(the.repass.value));
	$.ajax({
	type:"post",
	cache:false,
	url:url,
	data:data,
	error:function(_a){alert(_a);},
	success:function(_)
	{
		var act=_.substring(0,1);
		var info=_.substring(1);
		switch(act)
		{
			case "0":
				$(".c_oldpass").focus();
				$.message({type:"error",content:info,time:3000});
				the.bnt.disabled=false;
				break;
			case "1":
				the.oldpass.value="";
				the.password.value="";
				the.repass.value="";
				$("#reg_oldpass").html("请输入原密码");
				$("#reg_password").html("由6-16个数字、字母、下划线组成");
				$("#reg_repass").html("请再次输入密码");
				$("#strength").removeClass().addClass('nothing').text('');
				$.message({type:"ok",content:info,time:3000});
				setTimeout("location.href='?act=pwd'",2500);
				break;
			default:
				alert(_)
				break;
		}

	}});
	return false
};
$(function(){
	$(".c_oldpass").focus(function(){$('#reg_oldpass').addClass('tipred');$(this).addClass('ipon');});
	$(".c_oldpass").blur(function(){$('#reg_oldpass').removeClass();$('#reg_oldpass').addClass('tip');$(this).removeClass('ipon');});
	$(".c_password").focus(function(){$('#reg_password').addClass('tipred');$(this).addClass('ipon');});
	$(".c_password").blur(function(){$('#reg_password').removeClass();$('#reg_password').addClass('tip');$(this).removeClass('ipon');
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
	});
	$("#user_menu_12").addClass("hover");
});

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
                        <li><a href="user.asp">基本资料</a></li>                      
                        <li><a href="user.asp?act=pwd&V=1">修改密码</a></li>
                  
                    </ul>
                </div>
                
               <%
			   if request("act")="pwd" then
			   %>
               
               <div class="page_content">
                   <form onSubmit="return checkdb2(this)">
                   <ul id="reg">
                       <li><span>用户名：</span>pengteling</li>
                       <li><span>原密码：</span><input type="password" name="oldpass" class="ip w01 c_oldpass" maxlength="16" /><span class="tip" id="reg_oldpass">请输入原密码</span></li>
                       <li><span>新密码：</span><input type="password" name="password" class="ip w01 c_password" maxlength="16" /><span class="tip" id="reg_password">由6-16个数字、字母、下划线组成</span></li>
                       <dd><div id="strength"></div></dd>
                       <li><span>再次输入密码：</span><input type="password" name="repass" class="ip w01 c_repass" maxlength="16" /><span class="tip" id="reg_repass">请再次输入密码</span></li>
                       <dd><input type="submit" value="修改密码" class="bnt" name="bnt" /> <input type="button" value="取消" onClick="location.href='javascript:history.go(-1)'" class="bnt" /></dd>
                   </ul>
                   </form>
                </div>


               
               <%else%>
                <div class="page_content">
    <%set rs =Easp.Db.sel("select * from [user] where userid={userid}")
	if rs.eof then response.Redirect "user_login.asp":response.End()
	%>                
               <form onSubmit="return checkdb(this)">
               <ul id="reg">
               
                <li><span>用户名：</span>pengteling</li>
                   <li><span>联系人：</span><input type="text" name="truename" class="ip w03 c_truename" maxlength="20" value="<%=rs("Somane")%>"/><span class="tip" id="reg_truename"></span></li>
                   <li><span>性别：</span>
                   <input type="radio" name="sex" id="sex_1" value="1" <%if rs("sex")=1 then response.write "checked='checked'"%> /><label for="sex_1">男</label>
                   <input type="radio" name="sex" id="sex_2" value="0" <%if rs("sex")=0 then response.write "checked='checked'"%>/><label for="sex_2">女</label>
                   </li>
                  <li><span>邮箱：</span><input type="text" name="email" class="ip w04 c_email" maxlength="50"  value="<%=rs("Email")%>"/><span class="tip" id="reg_email">格式：username@qq.com</span></li>
                   
                   <li><span>电话：</span><input type="text" name="tel" class="ip w04 c_tel" maxlength="13"  value="<%=rs("phone")%>"/><span class="tip" id="reg_tel">格式：010-66668888 或 11位手机号</span></li>
                   
                   <li><span>邮编：</span><input type="text" name="zipcode" class="ip w03 c_zipcode" maxlength="6"  value="<%=rs("zip")%>"/><span class="tip" id="reg_zipcode">由6位数字组成</span></li>
                   <li><span>地址：</span><input type="text" name="address" class="ip w01 c_address" maxlength="50"  value="<%=rs("add")%>"/><span class="tip" id="reg_address"></span></li> <dd><input type="submit" value="修改资料" class="bnt" name="bnt" /> <input type="button" value="取消" onClick="location.href='javascript:history.go(-1)'" class="bnt" /></dd>
               </dl>
               </form>
              
               
               
                </div>
                <%end if%>
            </div>
            <!--右侧结束-->

            
          

            <div class="clear"></div>
        </div>
    </div>
