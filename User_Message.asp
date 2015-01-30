<!--#include file="fiveinc/inc.asp"-->
<!--#include file="FiveInc/Check_Sql.asp"-->
<!--#include file="FiveInc/page.asp"-->
<!--#include file="User_Config.asp"-->
<%
nid=28
rs.open "select * from category where cateid="&nid,conn,1,1
if not rs.eof then
	parentid=rs("parentid")
	sonid=rs("sonid")
	followid=rs("followid")	
	catetype=rs("catetype")
	modeltype=rs("modeltype")
	catename= rs("catename")		
	title=rs("title")
	Com_Content=rs("content")

else
	response.write "网址传递参数有误"
	response.End()

end if
rs.close



%>
<!--#include virtual="/lmenu.asp"-->
<!--#include virtual="/top.asp"-->

<div class="main">
  <div class="cleft"> 
    <!--#include virtual="/cleft.asp"--> 
  </div>
  <div class="cright">
    <div class="curlocation clearfix">
      <div class="fr"><img src="/images/home.jpg" /> 您当前位置：<%=menustr%></div>
    </div>
    <div class="maincontent" >
      <div class="tit"><%=catename%></div>
        <div class="newszy center">美宇编辑欢迎您！如有疑问请拨打：<span class="blue"><%=companyTel%></span> 我们会在第一时间帮您解决所有疑问，期待为您服务！</div>
      
      
      <table width="700" border="0" align="center" cellpadding="0" cellspacing="0" class="mgt10">
  <tr>
    
    <td width="684" valign="top">
    <table width="650" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td>
          <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td height="30" align="right"><a href="Messages.asp">我要留言</a></td>
            </tr>
          </table>
              
              
              <%
			  TrNum=0
	cateid = strToNum(Request("id"))	
	Keyword = ChkFormStr(Request("so"))
	
	 userid=conn.execute("select UserID from [user] where UserName='"&mx_username&"'")(0)
     msql= "Select * from liuyan where huifupeople="&userid&" order by id desc"
	
	
	
	Set mypage=new zh_Showpage
	PSize=4
	mypage.getconn=Conn	
	mypage.getsql=msql
	mypage.pagesize=PSize	
	set rs=mypage.getrs()
	
	If 	rs.Eof Then
		Response.Write "<br />&nbsp;&nbsp;&nbsp;没有找到信息!"
	Else
			Response.Write ("<ul>")&vbcrlf
		For TrNum=1 To mypage.pagesize
			If rs.Eof Then Exit For
			
	
%>
      
       <table width="100%" border="0" cellpadding="0" cellspacing="0" class="messtab">
            <tr>
              <td valign="top">   
              <table width="100%" border="0" cellspacing="2" cellpadding="2" bgcolor="#FFFFFF">
                <tr>
                  <td valign="top" bgcolor="#f8f8f8"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="67%"><strong>标题：</strong><%=rs("B_title")%></td>
                      <td width="33%"><span style="float:left;">时间：<%=rs("B_date")%></span><%if rs("tgsh")=false then%><span style="float:right; padding-right:15px; color:#F00; font-weight:bolder;">未审核</span><%end if%></td>
                    </tr>
                    <tr>
                      <td colspan="2" valign="top"><strong>内容：</strong><%=Rs("B_dom")%></td>
                    </tr>
                  </table>
                  <%if rs("B_hui")<>"" then%>
                    <table width="95%" border="0" cellspacing="0" cellpadding="0" style="border:1px solid #e8e6e4; background:#f8f6f4; margin:5px 10px; line-height:25px; padding:10px;" align="center">
                      <tr>
                        <td><font style="color:#a33024;">回复：</font>&nbsp;<%=rs("B_hui")%></td>
                        </tr>
                    </table>
                    <%end if%>
                  </td>
                </tr>
              </table>
              </td>
            </tr>
          </table>
         
      
            
       
<%
		
		
			rs.MoveNext
		Next
			Response.Write("</ul>")&vbcrlf
		'Set rs = Nothing
		
		
	End If

			  
			  %>
               </td>
      </tr>
    </table>
    </td>
  </tr>
  <tr>
    <td height="30" colspan="2"></td>
  </tr>
</table>
        <%
		If TrNum >=1 Then
			Response.Write(""&mypage.showpage()&"")
		End If
		
		rs.close
		%>
      </div>
    </div>
  </div>
  <div class="clear"></div>
</div>

<!--#include virtual="/foot.asp"-->


