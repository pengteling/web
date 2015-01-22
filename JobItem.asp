<!--#include file="fiveinc/inc.asp"-->
<!--#include file="FiveInc/Check_Sql.asp"-->
<!--#include file="FiveInc/page.asp"-->
<%
nid=31
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
<!--#include file="lmenu.asp"-->
<!--#include file="top.asp"-->


<!--首页中部 -->
<div class="greybg">
<div class="main">
  <div class="cleft fl"> 
    <!--#include virtual="/cleft.asp"--> 
  </div>
  <div class="cright fr">
  
    <div class="curlocation">
      <div class="fr"><%=menustr%></div>
      <div class="fl"><%=catename%></div>
    </div>
    
    
    	<div class="maincontent" id="maincontent">
        <div class="mcontent" > 
        
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" >
<tr>
<td id="ShowContent" style="line-height:20px;"><%
msql="select * from job where id="& clng(request("id"))
rs.open msql,conn,1,1
	If not Rs.Eof Then 
%>
<TR>
                                          <TD 
                  height=1 valign="top"><br>
                                              <table width="680" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#D6D6D6">
                                                <tr bgcolor="#f5f5f5">
                                                  <td width="24%"><div align="center"><font color="#434343"><b>招聘对象</b></font></div></td>
                                                  <td width="57%" height="28" bgcolor="#f5f5f5" class=font3><b><font color="#990000"><%=rs("Duix")%></font></b></td>
                                                  <td width="19%" bgcolor="#f5f5f5" class=font3><div align="center"><a href="acceptjob.asp?job=<%=server.URLEncode(rs("Duix"))%>"><img src="images/yingpin.jpg" width="83" height="25" border="0"></a></div></td>
                                                </tr>
                                                <tr bgcolor="#FFFFFF">
                                                  <td><div align="center"><font color="#434343"><b>招聘人数</b></font></div></td>
                                                  <td height="28" colspan="2"  class=font3><%=rs("Rens")%></td>
                                                </tr>
                                                <tr bgcolor="#f5f5f5">
                                                  <td><div align="center"><font color="#434343"><b>工作地点</b></font></div></td>
                                                  <td height="28" colspan="2" class=font3><%=rs("did")%></td>
                                                </tr>
                                                <tr bgcolor="#FFFFFF">
                                                  <td><div align="center"><font color="#434343"><b>学历要求</b></font></div></td>
                                                  <td height="28" colspan="2" class=font3><%=rs("workyear")%></td>
                                                </tr>
                                                 <tr bgcolor="#f5f5f5">
                                                  <td><div align="center"><font color="#434343"><b>招聘部门</b></font></div></td>
                                                  <td height="28" colspan="2" class=font3><%=rs("bumen")%></td>
                                                </tr>
                                                <tr bgcolor="#FFFFFF">
                                                  <td><div align="center"><font color="#434343"><b>联系方式</b></font></div></td>
                                                  <td height="28" colspan="2" class=font3><%=rs("Daiy")%></td>
                                                </tr>
                                                <tr bgcolor="#f5f5f5">
                                                  <td><div align="center"><font color="#434343"><b>发布时间</b></font></div></td>
                                                  <td height="28" colspan="2" class=font3><%=rs("time")%></td>
                                                </tr>
                                                <tr bgcolor="#FFFFFF">
                                                  <td><div align="center"><font color="#434343"><b>有效期限</b></font></div></td>
                                                  <td height="28" colspan="2" class=font3><%=rs("Qix")%></td>
                                                </tr>
                                                <tr bgcolor="#f5f5f5">
                                                  <td height="22"><div align="center"><font color="#434343"><b>招聘要求</b></font></div></td>
                                                  <td height="28" colspan="2" class=font3><%=rs("yaoq")%></td>
                                                </tr>
                                                <tr align="center" bgcolor="#FFFFFF"></tr>
                                            </table></TD>
                                        </TR>


       
       
            
            <%
	end if
Set Rs = Nothing

%></td>
        </tr>
        
      </table>
        
        　 </div>
      </div>
    
  </div>
  <div class="clear"></div>
</div>
</div>
      
 
  <!--<div class="maincontent">
    
    </div>--> 
</div>
<!--首页中部end --> 

<!--#include file="foot.asp"-->