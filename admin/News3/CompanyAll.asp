<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<!-- #include file="../Inc/Head.asp" -->
<style>
.td_southidc1{BACKGROUND-COLOR: #ECF5FF;}
.td_southidc4{BACKGROUND-COLOR: #ffffff;}
.td_southidc5{BACKGROUND-COLOR: #ffffff;}
.td_southidc3{BACKGROUND-COLOR: #ffffff;}
.td_southidc2{BACKGROUND-COLOR: #ffffff;}
.td_southidc6{BACKGROUND-COLOR: #ffffff;}
.td_southidc7{BACKGROUND-COLOR: #ffffff;}
td b{color:#000000;}
</style>
<%set rs=server.createobject("adodb.recordset")
ID=strToNum(request("ID"))
Act=ChkFormStr(Request("Act"))
If Act="del" Then
	'response.write "由于网站架构删除对网站数据影响很大，如需删除请联系作者"
	'response.end()
	conn.BeginTrans '事务开始
	rs.Open"Select * From category Where cateID="&ID,Conn,1,3
	If Not rs.Eof Then
		followid=rs("followid")	
		parentid=rs("parentid")	
		sonid=rs("sonid")
		sonid_arr=split(sonid,",")
	End If
	'rs.Delete
	'rs.Update
	rs.Close
	
	'response.write "delete from category where cateid in ("&sonid&")"
	conn.execute ("delete from category where cateid in ("&sonid&")")
	conn.execute ("Delete from news where cateid in ("&sonid&")")
	
	rs.open "select cateid,sonid from category where cateid in ("&parentid&") and cateid<>"&ID&" order by depth,orderID",conn,1,3
	
	while not rs.eof 
		sonid_p = rs("sonid")
		sonid_p =","+sonid_p+","
		
		for i=0 to ubound(sonid_arr)
			sonid_p =replace(sonid_p,","+sonid_arr(i)+",",",") '删除后 其父栏目的 子栏目数据变化
		next
		
		sonid_p =right(sonid_p,len(sonid_p)-1)
		sonid_p =left(sonid_p,len(sonid_p)-1)
		
		rs("sonid") = sonid_p
		rs.update
	
	rs.movenext
	wend
	rs.close
	
	
	conn.CommitTrans  '如果没有conn错误，则执行事务提交

	Response.Redirect("companyAll.asp")
	Response.End()
End IF
If Act="IsHide" Then
	s=strToNum(request("s"))
	Conn.Execute("Update category Set IsHome="&s&" Where cateID="&ID&"")
	Response.Redirect("companyAll.asp")
	Response.End()
End If
If Act="IsOut" Then
	Conn.Execute("Update category Set IsOutLink=0 Where cateID="&ID&"")
	Response.Redirect("companyAll.asp")
	Response.End()
End If
If Act="IsPage" Then
	p=strToNum(request("p"))
	If p=0 Then p=ID
	Conn.Execute("Update category Set IsIndex=0 Where cateID="&p&" Or followid="&p&"")
	Conn.Execute("Update category Set IsIndex=1 Where cateID="&ID&"")
	set Rs=server.createobject("adodb.recordset")
	Response.Redirect("companyAll.asp")
	Response.End()
End If

%>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="table_southidc">
  <tr>
    <td width="44%" align="center" class="blod">项目名</td>
    <td width="14%" align="center" class="blod">属性</td>
    <td width="27%" align="center" class="blod">相关操作</td>
  </tr>
<%

sql = "select cateid,catename,followid,depth,sonid,parentid,orderID,cateType,isHome from category where 1=1 "&sql_sonid&" and modeltype<=3  order by depth,orderID"


set rs=server.CreateObject("adodb.recordset")
			rs.open sql,conn,1,1
			if not rs.eof then
				data= rs.getRows()
			end if
			rs.close
			
	class_list=""
	
	
sub classlist(byval t0)
		dim i
		for i=0 to ubound(data,2)
			if t0=data(2,i) then
				
				
				

'If data(3,i)>1 then class_list=class_list& "├"

if  data(3,i)=1  then '一级分类 和 有下级栏目的 分类显示 +号图标  or instr(data(4,i),",")>0
					imgno=3
					trclass="td_southidc"
		else
					imgno=3		
					trclass="td_southidc"		
end if
				trclass="td_southidc" &	data(3,i)	
				class_list=class_list&"<tr class="""&trclass&"""><td align=""left"">"
				For k=2 To data(3,i)
				class_list=class_list&"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
				next
				
				
				
				class_list=class_list&"<img src=""../Images/tree_folder"&imgno&".gif"" width=""19"" height=""18"" align=""absbottom""><b>"&data(1,i)&"</b> ("&data(6,i)&")</td>"
					select case data(7,i)
					case 1
					catetype= "栏目（列表）"
					 catetype_str="<a href=""/admin/News/News_add.asp?cateid="&data(0,i)&""">添加内容</a> | <a href=""/admin/News/News_Manage.asp?cateid="&data(0,i)&""">内容管理</a>"
					 case 0
					catetype= "栏目（内容）"
					 catetype_str="<a href=""/admin/News/News_add.asp?cateid="&data(0,i)&""">添加内容</a> | <a href=""company.asp?ID="&data(0,i)&""">修改栏目首页内容</a> | <a href=""/admin/News/News_Manage.asp?cateid="&data(0,i)&""">内容管理</a>"
					case 2
					catetype= "单网页"
					catetype_str="<a href=""company.asp?ID="&data(0,i)&""">修改单页内容</a>"
					case 3
					catetype= "单链接"
				catetype_str="无操作"
					end select
				class_list=class_list & "<td align=""center"" class="""&trclass&""">"&catetype&" "
				
				
					
					
				
				class_list=class_list &"</td>"
				
				class_list=class_list & "<td align=""center"" class="""&trclass&""">"
				
				class_list=class_list &catetype_str
				
				
				class_list=class_list&"</td></tr>"
				
				classlist(data(0,i))
			end if
		next
	end sub
	if isarray(data) then	
		call classlist(0)	
	end if	
response.write class_list		

%>	

</table>
<span class="red" style="font-weight: bold">注:</span> 为了不影响系统正常运行,默认项目请不要删除,如需删除请联系制作者.

<script type="text/javascript">
$(function(){
		
	$("tr[class^=td_southidc] img").click(function(){
		
	var tr_this = $(this).parent().parent();
	//$("tr[class^=td_southidc]").click(function(){
		//alert($(this).attr("class"));
		//$(this).nextUntil("td[class^=td_southidc").parent().toggle();
		var curClass=$(tr_this).attr("class");
		var curClassNum=parseInt(curClass.substr(11,1));
		//alert(curClassNum);
		var img1="../Images/tree_folder3.gif";		
		var img2="../Images/tree_folder4.gif";
		var isOpen=true;
		if ($(tr_this).find("img").attr("src")==img1)
		{
			$(tr_this).find("img").attr("src",img2);
			isOpen=false;
		}
		else
		{
			$(tr_this).find("img").attr("src",img1);
			isOpen=true;
		}
		
		
		//alert(subClass);
		//$(this).nextUntil("tr[class="+curClass+"]").nextUntil("tr[class!="+subClass+"]").toggle();
		var k=1;
		$(tr_this).nextUntil("tr[class="+curClass+"]").each(function(index,element){
			 if( parseInt($(element).attr("class").substr(11,1))>curClassNum && k==1 )
			 {
				 //alert($(element).attr("class").substr(11,1));
				 if($(element).is(":hidden") )
				 {
					if(isOpen){
						$(element).show();
						$(this).find("img").attr("src",img1);
					}
					else{
						$(element).hide();
						$(this).find("img").attr("src",img2);
					}
					
				 }
				 else
				 {
				 	$(element).hide();
				 }				 
			 }
			 else
			 {
				 k=2;
			 }
		});
		
		

	});
});
</script>
<!-- #include file="../Inc/Foot.asp" -->