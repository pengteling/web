<!--#include virtual="/fiveinc/conn.asp"-->
<!--#include virtual="/User_Config.asp"-->
<%

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
                <div class="page_content">
                    
               <form onSubmit="return checkdb(this)">
               <ul id="reg">
               
                <li><span>用户名：</span>pengteling</li>
                   <li><span>真实姓名：</span><input type="text" name="truename" class="ip w03 c_truename" maxlength="4" /><span class="tip" id="reg_truename">由2-4位汉字组成</span></li>
                   <li><span>性别：</span>
                   <input type="radio" name="sex" id="sex_1" value="1" /><label for="sex_1">男</label>
                   <input type="radio" name="sex" id="sex_2" value="2" /><label for="sex_2">女</label>
                   </li>
                   <li><span>生日：</span><select name="birthday_year" id="year" style="width:60px"><option value="0">----</option></select>&nbsp;年 
<select name="birthday_month" id="month"><option value="0">----</option></select>&nbsp;月 
<select name="birthday_day" id="day"><option value="0">----</option></select>&nbsp;日</li>
                   <li><span>QQ：</span><input type="text" name="qq" class="ip w03 c_qq" maxlength="15" /><span class="tip" id="reg_qq">由5-15位数字组成</span></li>
                   <li><span>MSN：</span><input type="text" name="msn" class="ip w01 c_msn" maxlength="50" /><span class="tip" id="reg_msn">格式：user@domain.com</span></li>
                   <li><span>手机：</span><input type="text" name="mobile" class="ip w04 c_mobile" maxlength="11" /><span class="tip" id="reg_mobile">由11位数字组成</span></li>
                   <li><span>电话：</span><input type="text" name="tel" class="ip w04 c_tel" maxlength="13" /><span class="tip" id="reg_tel">格式：010-66668888</span></li>
                   <li><span>职业：</span><input type="text" name="job" class="ip w03 c_job" maxlength="10" /><span class="tip" id="reg_job"></span></li>
                   <li><span>邮编：</span><input type="text" name="zipcode" class="ip w03 c_zipcode" maxlength="6" /><span class="tip" id="reg_zipcode">由6位数字组成</span></li>
                   <li><span>地址：</span><input type="text" name="address" class="ip w01 c_address" maxlength="50" /><span class="tip" id="reg_address"></span></li> <dd><input type="submit" value="修改资料" class="bnt" name="bnt" /> <input type="button" value="取消" onClick="location.href='javascript:history.go(-1)'" class="bnt" /></dd>
               </dl>
               </form>
              
               <script>
			   var u_birthday = "0000-00-00";	   
				var days = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
				var selectStr = '<option value="0">----</option>';
				var check_m_d = false;
				function isLeap(year) {
				return ((0 == year % 4) && (0 != (year % 100))) || (0 == year % 400) ? true : false; 
				}
				function isDate(date) {
				var d = date.split('-');
				return (d[0] =='0000' || d[1] == '00' || d[2] == '00')?false:true;
				}
				function setYear(b) {
				var html = '';
				var now = new Date(); 
				var year = now.getFullYear(); 
				var select = '';
				var b_array =new Array();
				if(isDate(b)) {
				b_array = b.split('-');
				check_m_d = true;
				} else {
				b_array = [0,0,0];
				}
				 
				for(var i=year;i>1909;i--) {
				select = (i ==b_array[0] )?' selected="selected"':'';
				html += '<option value="'+i+'" '+select+'>'+i+'</option>';
				}
				$("#year").append(html);
				if(check_m_d) {
				setMonth(b_array[1]);
				setDay(b_array[0],b_array[1],b_array[2]);
				}
				};
				function setMonth(m) {
				var html = selectStr;
				for(var i=1;i<13;i++) {
				i = (i>=10) ? i : '0' + i;
				select = (i ==m )?' selected="selected"':'';
				html += '<option value="'+i+'" '+select+'>'+i+'</option>';
				}
				$("#month").empty().append(html);
				}
				function setDay(y,m,d) {
				ds = days[m-1];
				if(isLeap(y) && (m == '02')) {
				ds++;
				}
				var html = selectStr;
				for(var i=1;i<=ds;i++) {
				i = (i>=10) ? i : '0' + i;
				select = (i == d )?' selected="selected"':'';
				html += '<option value="'+i+'" '+select+'>'+i+'</option>';
				}
				$("#day").empty().append(html);
				}
				$(function(){
				var y = $("#year");
				var m = $("#month");
				var d = $("#day");
				var daySelect = function(){
				if(y.val() ==0 || m.val() == 0) {
				d.empty().append(selectStr);
				return;
				}
				setDay(y.val(),m.val(),1);
				};
				var daySelect2 = function() {
				if(y.val() == 0) {
				m.empty().append(selectStr);
				d.empty().append(selectStr);
				return;
				} else {
				var m_set = m.val()>1?m.val():1;
				setMonth(m_set);
				setDay(y.val(),m_set,1);
				}
				};
				y.change(daySelect2);
				m.change(daySelect);
				setYear(u_birthday);
				});

			   </script>
               
                </div>
            </div>
            <!--右侧结束-->

            
          

            <div class="clear"></div>
        </div>
    </div>
