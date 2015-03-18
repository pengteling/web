<!--#include file="fiveinc/inc.asp"-->
<!--#include file="FiveInc/Check_Sql.asp"-->
<!--#include file="FiveInc/page.asp"-->
<%
newsid=strToNum(Request.QueryString("id"))

rs.open "select * from news_c where id="&newsid&" ",conn,1,3
if not rs.eof then
rs("hits")=rs("hits")+1
rs.update
nid =rs("cateid")
cateid=nid
newstitle=rs("title")
News_Content=rs("content")
content_zy =rs("content_zy")
posttime=formatdate(rs("posttime"),5)
author=rs("ComeFrom")
defaultpicurl=rs("defaultpicurl")
hits=rs("hits")


a=instr(1,News_Content,"<a href=",1)+9
	if a>9 then
	b=instr(a+1,news_content,"""")
	
	downfileurl =mid(news_content,a,b-a)
	
	'response.write "http://"&Request.ServerVariables("Http_Host")&downfileurl
	if instr(lcase(downfileurl),"uploadfile")>0 then
	response.Redirect(downfileurl)
	end if
	end if
else
response.write "该文章不存在或未通过审核！"
response.end
end if
rs.close

set ReadRs=server.CreateObject("adodb.recordset")
'ReadRs.open "select top 1 * from news_c where cateid="&nid&" and isdel=0 and id>"&newsid &" order by id ",conn,1,1
ReadRs.open " SELECT * FROM   (select *,row_number() over(order by Elite desc,px desc ,posttime desc) as rowid from news_c  where cateid="&nid&" and isdel=0) g WHERE rowid= (select rowid-1 from  (select *,row_number() over(order by Elite desc,px desc ,posttime desc) as rowid from news_c  where cateid="&nid&" and isdel=0) g where id="&newsid &")",conn,1,1

if not ReadRs.eof then
prelink="<a href=""readnews.asp?id="&ReadRs("id")&""">"&ReadRs("Title")&"</a>"
else
prelink="这是第一篇"
end if
ReadRs.Close
'ReadRs.open "select top 1 * from news_c where  cateid="&nid&" and isdel=0 and  id<"&newsid&" order by id desc",conn,1,1
ReadRs.open "WITH tbtemp as (select *,row_number() over(order by Elite desc,px desc ,posttime desc) as rowid from news_c  where cateid="&nid&" and isdel=0) SELECT * FROM  tbtemp WHERE rowid= (select rowid+1 from tbtemp where id="&newsid &")",conn,1,1
'ReadRs.open " SELECT * FROM   (select *,row_number() over(order by Elite desc,px desc ,posttime desc) as rowid from news_c  where cateid="&nid&" and isdel=0) g WHERE rowid= (select rowid+1 from  (select *,row_number() over(order by Elite desc,px desc ,posttime desc) as rowid from news_c  where cateid="&nid&" and isdel=0) g where id="&newsid &")",conn,1,1

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
        <div class="laiyuan">日期：<%=posttime%> 来源：<%=author%> 点击量：<%=hits%></div>
		<div class="newscontent">
		<%=News_Content%>
        </div>
        <div class="newspage" style="height:100px;">
        
        <div class="newspage2 fr">下一篇：<%=nextlink%></a></div>
        <div class="newspage1 fl">上一篇：<%=prelink%></div>
        <div class="clear"></div>
        
      </div>

    </div>
      </div>
    </div>
    <div class="clear"></div>
  </div>
</div>




<!--#include virtual="/foot.asp"-->


