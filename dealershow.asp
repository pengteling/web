<!--#include file="fiveinc/inc.asp"-->
<!--#include file="FiveInc/Check_Sql.asp"-->
<!--#include file="FiveInc/page.asp"-->
<%
newsid=strToNum(Request.QueryString("id"))

rs.open "select * from dealers where id="&newsid&" ",conn,1,3
if not rs.eof then

nid =rs("cateid")
cateid=nid
newstitle=rs("title")
News_Content=rs("content")

posttime=formatdate(rs("posttime"),5)

defaultpicurl=rs("defaultpicurl")




else
response.write "该文章不存在或未通过审核！"
response.end
end if
rs.close

set ReadRs=server.CreateObject("adodb.recordset")
ReadRs.open "select top 1 * from news_c where cateid="&nid&" and isdel=0 and id>"&newsid &" order by id ",conn,1,1
if not ReadRs.eof then
prelink="<a href=""readnews.asp?id="&ReadRs("id")&""">"&ReadRs("Title")&"</a>"
else
prelink="这是第一篇"
end if
ReadRs.Close
ReadRs.open "select top 1 * from news_c where  cateid="&nid&" and isdel=0 and  id<"&newsid&" order by id desc",conn,1,1
if not ReadRs.eof then
nextlink="<a href=""readnews.asp?id="&ReadRs("id")&""">"&ReadRs("Title")&"</a>"
else
nextlink="已经是最后一篇"
end if
set ReadRs=nothing


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


<div class="greybg">
  <div class="main">
    <div class="cleft fl">
     
      <!--#include virtual="/cleft.asp"--> 
    </div>
    <div class="cright fr">
      
    <div class="curlocation">
      <div class="fr"><%=menustr%></div>
     <!-- <div class="fl"><%=catename%></div>-->
     
    </div>
     
      <div class="maincontent" > 
       <div class="newscenter">
     <div class="newscentertitle"><%=newstitle%></div>
        
		<div class="newscontent">
		<%=News_Content%>
        </div>
    </div>
      </div>
    </div>
    <div class="clear"></div>
  </div>
</div>




<!--#include virtual="/foot.asp"-->


