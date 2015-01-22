<!--#include file="fiveinc/inc.asp"-->
<!--#include file="FiveInc/Check_Sql.asp"-->
<!--#include file="FiveInc/page.asp"-->
<%

if CheckRequest(Request.Form(("work")))="add" then
ChkPost
If Session("RandomNumber")="" Or IsEmpty(Session("RandomNumber")) Or IsNull(Session("RandomNumber")) Or Trim(Request.Form("RanNumber"))="" Or IsEmpty(Request.Form("RanNumber")) Or IsNull(Request.Form("RanNumber")) or Session("RandomNumber")<>Request.Form("RanNumber") Then
	response.write"<SCRIPT language=JavaScript>alert('禁止重复提交！');"
	response.write"location.href=""Guestbook.asp"";</SCRIPT>"
	response.End()
End If

B_name=ChkFormStr(Request.Form("B_name"))
B_msn=ChkFormStr(Request.Form("B_msn"))
B_mail=ChkFormStr(Request.Form("B_mail"))
B_tel=ChkFormStr(Request.Form("B_tel"))
B_title=ChkFormStr(Request.Form("B_title"))
B_chengs=ChkFormStr(Request.Form("B_chengs"))
B_sex=strToNum(Request.Form("B_sex"))
Userface=trim(Request("Userface"))
B_dom=Request.Form("B_dom")
Userface=right(Userface,6)
Userface=left(Userface,2)
If strToNum(Userface)=0 Then
	Userface=strToNum(right(Userface,1))
Else
	Userface=strToNum(Userface)
End If
If B_name="" Or IsNull(B_name) Or IsEmpty(B_name) Then
	response.write"<SCRIPT language=JavaScript>alert('请输入姓名！');"
	response.write"location.href=""Guestbook.asp"";</SCRIPT>"
	response.End()
End If



If B_mail="" Or IsNull(B_mail) Or IsEmpty(B_mail) Then
	response.write"<SCRIPT language=JavaScript>alert('请输入邮箱！');"
	response.write"location.href=""Guestbook.asp"";</SCRIPT>"
	response.End()
End If
If B_dom="" Or IsNull(B_dom) Or IsEmpty(B_dom) Then
	response.write"<SCRIPT language=JavaScript>alert('请输入内容！');"
	response.write"location.href=""Guestbook.asp"";</SCRIPT>"
	response.End()
End If

Set Rs=Server.CreateObject("ADODB.RecordSet")
sql="select * from liuyan"
Rs.open sql,conn,1,3
Rs.addnew
    Rs("styles")=gtitlest
    Rs("B_chengs")=B_chengs
	Rs("B_name")=B_name
	Rs("B_msn")=B_msn
	Rs("B_sex")=B_sex
	Rs("B_mail")=B_mail
	Rs("B_title")=B_title
	Rs("B_face")=Userface
	Rs("B_tel")=B_tel
	Rs("B_dom")=B_dom
	rs("B_type")=1
	If Checkbook="Yes" Then
		Rs("tgsh")=False
	Else
		Rs("tgsh")=True
	End If
	Rs("B_date")=now()
Rs.update
Rs.Close
set Rs=nothing 




Session("RandomNumber")=""
 Response.Write "<script lanaguage='javascript'>alert('信息提交成功,我们会尽快为您审核,请耐心等待!');document.location='index.asp';</script>"
 End if
 
Session("RandomNumber")=GetRndPassword(16)


nid=strToNum(Request.QueryString("id"))
nid=13
rs.open "select * from category where cateid="&nid,conn,1,1
if not rs.eof then
	cateid=rs("cateid")
	parentid=rs("parentid")
	sonid=rs("sonid")
	followid=rs("followid")	
	catetype=rs("catetype")
	modeltype=rs("modeltype")
	catename= rs("catename")		
	com_title=rs("title")
	Com_Content=rs("content")
	depth =rs("depth")
	catedir=rs("catedir")
	
	xmname= replace(catename,"培训","")
	if com_title="" or isnull(com_title) then com_title=catename
else
	response.write "网址传递参数有误"
	response.End()

end if
rs.close
%>

<!--#include virtual="/lmenu.asp"-->
<!--#include virtual="/top.asp"-->
<div class="greybg">
  <div class="main">
    <div class="cleft fl">
      <div class="nlogo"><a href="/"><img src="/images/logo-nei.png" alt="" /></a></div>
      <!--#include virtual="/cleft.asp"--> 
    </div>
    <div class="cright fr">
      <div class="subtit"><img src="images/subtitle-<%=cateid_d1%>.png" height="36" /></div>
      <%	
	 if instr(sonid_d1,",")>0 then%>
      <!--#include virtual="/subnav.asp"-->
      <%end if%>
      <div class="maincontent" >
        <div class="map">
          <iframe style="border:0px currentColor;" height="250" marginheight="0" src="/map.html" frameborder="0" width="680" marginwidth="0" scrolling="no"></iframe>
        </div>
        <div class="dizhi">
          <div class="fl"> <%=CompanyAddress%>  <br />
            <%=CompanyTel%> <br />
            <%=CompanyFax%>  <br />
            <%=CompanyTel400%><br />
            <%=CompanyEmail%><br />
          </div>
          <div class="fr">
            <div class="wbwx">
              <div class="wb"><a href="<%=wburl%>" target="_blank"></a></div>
              <div class="wx"><a href="javascript:;"></a></div>
              <div class="erwcode">
                <div class="img"><img src="<%=wxurl%>"></div>
                <div class="con"> 扫一扫<br>
                  关注旅发集团 </div>
              </div>
            </div>
          </div>
        </div>
        
        <!--<div class="tit"><%=com_title%></div> -->
        <div class="mcontent xh">
          <div class="midtitle">在线留言</div>
          <div class="guestbook">
            <form action="guestbook.asp" id="frmGuestbook" method="post">
              <div class="gtable">
                <div class="row">
                  <div class="fl">留 言 人：</div>
                  <div class="fr">
                    <input type="text" value="姓名..." class="fm_name" id="fm_name" name="B_name"/>
                  </div>
                </div>
                <div class="row">
                  <div class="fl">留言内容：</div>
                  <div class="fr">
                  <textarea class="fm_content" id="fm_content" name="B_dom">留言内容...</textarea>
                  </div>
                </div>
                            <div class="row">
                <div class="fl">电　　话：</div>
                <div class="fr">
                  <input type="text" value="电话..." class="fm_tel" id="fm_tel" name="B_tel"/>
                </div>
              </div>
              <div class="row">
                <div class="fl">电子邮箱：</div>
                <div class="fr">
                  <input type="text" value="电子邮箱..." class="fm_email" id="fm_email" name="B_mail"/>
                </div>
              </div>
             <div class="row">
             <div class="fl">&nbsp;</div>
             <div class="fr">
                <input type="submit" value="" class="fm_sub" id="i-okbtn"/>
                <input name="RanNumber" type="hidden" id="Act" value="<%=Session("RandomNumber")%>" />
                <input id="work" type="hidden" value="add" name="work" />
                </div>
              </div>
              </div>

            </form>
          </div>
        </div>
      </div>
    </div>
    <div class="clear"></div>
  </div>
</div>
<Script type="text/javascript" src="/js/msgbox.js"></script> 
<Script>

function valid_email(email) {    var patten = new RegExp(/^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]+$/);    return patten.test(email);   } 
function valid_mobile(mobile) {    var patten = new RegExp(/^1((3[4-9])||(5[0-2])||(5[8-9])||(8[8-9])||(82))\d{8}$/g);    return patten.test(mobile);   } 
function valid_tel(mobile) {    var patten = new RegExp(/^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$|(^(13[0-9]|15[0-9]|18[0-9])\d{8}$)/);    return patten.test(mobile);   } 
function valid_qq(email) {    var patten = new RegExp(/^[1-9]*[1-9][0-9]*$/);    return patten.test(email);   } 

$(function(){
	
	$("#fm_name").click(function(){
		if($("#fm_name").val()=="姓名...")
		{
			$("#fm_name").val("")
		}	
	})
	$("#fm_name").blur(function(){
		if($("#fm_name").val()=="")
		{
			$("#fm_name").val("姓名...")
		}	
	})
	$("#fm_tel").click(function(){
		if($("#fm_tel").val()=="电话...")
		{
			$("#fm_tel").val("")
		}	
	})
	$("#fm_tel").blur(function(){
		if($("#fm_tel").val()=="")
		{
			$("#fm_tel").val("电话...")
		}	
	})
	
	$("#fm_email").click(function(){
		if($("#fm_email").val()=="电子邮箱...")
		{
			$("#fm_email").val("")
		}	
	})
	$("#fm_email").blur(function(){
		if($("#fm_email").val()=="")
		{
			$("#fm_email").val("电子邮箱...")
		}	
	})
	
	
	$("#fm_content").click(function(){
		if($("#fm_content").val()=="留言内容...")
		{
			$("#fm_content").val("")
		}	
	})
	$("#fm_content").blur(function(){
		if($("#fm_content").val()=="")
		{
			$("#fm_content").val("留言内容...")
		}	
	})
	
	$("#frmGuestbook").submit(function(e){
			if( !valid_tel( $("#fm_tel").val())){
				ZENG.msgbox.show("您的电话格式有误，请重新输入！", 5, 3000);
				return false;
				};
				
				if( !valid_email( $("#fm_email").val())){
				ZENG.msgbox.show("您的邮箱格式有误，请重新输入！", 5, 3000);
				return false;
				};
				if( $("#fm_name").val()=="姓名..."){
				ZENG.msgbox.show("请填写您的姓名！", 5, 3000);
				return false;
				};
				if( $("#fm_content").val()=="留言内容..."){
				ZENG.msgbox.show("请填写留言内容！", 5, 3000);
				return false;
				};
	})
			
});
</script> 
<!--#include virtual="/foot.asp"-->