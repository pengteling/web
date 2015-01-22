<!--#include file="fiveinc/inc.asp"-->
<!--#include file="FiveInc/Check_Sql.asp"-->
<!--#include file="FiveInc/page.asp"-->
<%
nid=strToNum(Request.QueryString("id"))
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
  
  
  
    <div class="curlocation-dy">
      <div class="fr"><%=menustr%></div>
      <div class="fl"><%=catename%></div>
    </div>
    
    <div class="maincontent" > 
    	<!--<div class="tit"><%=com_title%></div> -->    
      <div class="mcontent"><%=Com_Content%>
      
      
      

      
      </div>
    </div>
  </div>
  
</div>

<!--#include virtual="/foot.asp"-->