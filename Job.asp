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

<style>
.jobstxt{font-weight:bold; font-size:14px; line-height:36px;}
.jobsbiao{ text-align:center;border-collapse: collapse;
  border: none;}
.jobsbiao td{border:#d2d2d2 1px solid};
</style>
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
        
        
        
        <div class="jobs">
	     <table width="100%" border="0" cellspacing="0" cellpadding="0" class="jobsbiao">
           <tr>
             <td width="5%"  class="jobstxt">
             序号 </td>
             <td width="27%"  class="jobstxt">岗位名称 </td>
             <td width="16%"  class="jobstxt">工作地点</td>
             <td width="14%"  class="jobstxt">人数</td>
             <td width="19%"  class="jobstxt">学历要求</td>
             <td width="19%" >&nbsp;</td>
           </tr>
           
           
           <%
		   
curpage=		   cint(request("page"))
if curpage<1 then curpage=1
msql="select * from job order by id desc"
Set mypage=new zh_Showpage
PSize=10
mypage.getconn=Conn	
mypage.getsql=msql
mypage.pagesize=PSize	
set Rs=mypage.getrs()
If 	Rs.Eof Then
Response.Write "没有找到信息!"
'Response.Write "<tr><td align=center>"&msql&"</td></tr>"
Else
For TrNum=1 To mypage.pagesize
	If Rs.Eof Then Exit For
%>

				<tr>
		          <td><%=TrNum +  (curpage-1)* Psize %></td>
		          <td><%=rs("Duix")%></td>
		          <td><%=rs("did")%></td>
		          <td><%=rs("Rens")%>人</td>
		          <td><%=rs("workyear")%></td>
		          <td class="jobstxt1"><a href="JobItem.asp?id=<%=rs("id")%>">&gt;&gt; 详情</a></td>
		        </tr>
        <%
	Rs.MoveNext
	Next
Set Rs = Nothing
End If
%>
			

         </table>
	   </div>
        
<div class="center"><%mypage.showpage()%></div>
        
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