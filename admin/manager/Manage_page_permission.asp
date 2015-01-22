<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<!--#include file="../Inc/md5.asp"-->
<!-- #include file="../Inc/Head.asp" -->
<!-- #include file="../Inc/bit.asp" -->
<%
set rs=server.createobject("adodb.recordset")
Act=Trim(Request("Act"))
id=clng(request("id"))

if Act ="SavePermission" then


'response.Write sonid
'response.End()
'for each key in request.Form()
'response.Write key &"--" & request.Form(key) &"<Br>"
'next

sonid =request.Form("sonid")
sonid=replace(sonid," ","")
'response.Write sonid
'response.End()

conn.execute "update zh_AdminGroup set sonid_page='"&sonid&"' where id="&Id


'cateids=split(cateids,",")
rs.open "select cateid from catepage order by depth,orderid",conn,1,1
cateids=rs.getRows()
rs.close


for i =0 to ubound(cateids,2)

response.write cateids(0,i) &"<br>"
response.write request.Form("cate"&cateids(0,i))&"<br>"

cateid =  trim(cateids(0,i)) '一定要去除空格

pmn = request.Form("cate"&cateid)
pmn = split(pmn,",")

level =0
j=0
	for j = 0 to ubound(pmn)
		level = pmn(j) + level
	next

rs.open "Select * from zh_AdminGroupPrivileges where groupid="&id&" and Ptype=2 and cateid="&cateid&" ",conn,1,3
if not rs.eof then
rs("level")=level
rs.update
else
rs.addnew
rs("groupid")=id
rs("ptype")=2
rs("cateid")=cateid
rs("level")=level
rs.update

end if
rs.close

next

response.Redirect "Manage_page_permission.asp?id="&id

end if



sqltext="select * from zh_AdminGroup where Id=" & id
rs.open sqltext,conn,1,1
if  rs.eof then
response.Write "找不到此管理员组"
response.End()
else
sonid=rs("sonid_page")
end if
'response.write sonid
%>
<table width="700" border="0" cellpadding="2" cellspacing="1" class="table_southidc">
        <tr> 
          <td height="25" align="center" class="back_southidc"><strong><%=rs("title")%> 页面权限设置</td>
        </tr>
        <tr class="tr_southidc"> 
          <form name="form1"  action="Manage_page_permission.asp" method="post">
            <input type="hidden" value="<%=rs("id")%>" name="id">
            <input type="hidden" name="act" value="SavePermission">
            <td>
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="2" id="inputlist">
                <tr class="tr_southidc">
                <td>选择</td>
                <td>页面名称</td>
                <td>操作权限</td>
          <!--      <td>添加</td>
                <td>修改</td>
                <td>删除</td>
                <td>审核</td>
                <td>移动</td>-->
                
                </tr>                
                  
             
                 
                
                  <%
				  
				  rs.close
				  set rs2=server.CreateObject("adodb.recordset")
			rs2.open "select cateid,catename,followid,depth,sonid,parentid,orderID from catepage where catetype<=10 order by depth,orderID",conn,1,1
			if not rs2.eof then
				data= rs2.getRows()
			end if
			rs2.close
			
	class_list=""
	
	
sub classlist(byval t0)
		dim i
		for i=0 to ubound(data,2)
			if t0=data(2,i) then
				
				'class_list=class_list&"<option value="""&data(0,i)&""" "&isslected&">"
class_list=class_list&"<tr class=""tr_southidc"&data(3,i)&""">"
	class_list=class_list&"<td><input type=checkbox name=sonid value='"&data(0,i)&"'"
				if instr(","+sonid+",",","+cstr(data(0,i))+",")>0 then class_list=class_list& " checked"
				class_list=class_list&"  class=""td_southidc"&data(3,i)&"""></td>"

class_list=class_list&"<td>"				
For k=2 To data(3,i)
class_list=class_list&"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
next

If data(3,i)>1 then class_list=class_list& "&nbsp;&nbsp;"
				
				class_list=class_list &"<img src=""../Images/tree_folder3.gif"">" &data(1,i)&"<Br>"
				class_list=class_list&"</td>"
				
		rs.open "select * from 	zh_AdminGroupPrivileges where groupid ="&id&" and ptype=2 and cateid="&data(0,i)
		if not rs.eof then
			plevel=rs("level")
		else
			plevel=0
		end if
		rs.close
				
		if BitAnd(plevel,1)=1 then
			p1="checked"
		else
			p1=""
		end if	
		
		if BitAnd(plevel,2)=2 then
			p2="checked"
		else
			p2=""
		end if	
		
		if BitAnd(plevel,4)=4 then
			p3="checked"
		else
			p3=""
		end if	
		if BitAnd(plevel,8)=8 then
			p4="checked"
		else
			p4=""
		end if	
		if BitAnd(plevel,16)=16 then
			p5="checked"
		else
			p5=""
		end if	
		if BitAnd(plevel,32)=32 then
			p6="checked"
		else
			p6=""
		end if		
				class_list=class_list&"<td><input type=checkbox name='cate"&data(0,i)&"' value=1 "&p1&"></td>"
			'	class_list=class_list&"<td><input type=checkbox name='cate"&data(0,i)&"' value=2 "&p2&"></td>"
			'	class_list=class_list&"<td><input type=checkbox name='cate"&data(0,i)&"' value=4 "&p3&"></td>"
			'	class_list=class_list&"<td><input type=checkbox name='cate"&data(0,i)&"' value=8 "&p4&"></td>"
			'	class_list=class_list&"<td><input type=checkbox name='cate"&data(0,i)&"' value=16 "&p5&"></td>"
			'	class_list=class_list&"<td><input type=checkbox name='cate"&data(0,i)&"' value=32 "&p6&"></td>"
				class_list=class_list&"</tr>"
				
				classlist(data(0,i))
			end if
		next
	end sub
	if isarray(data) then	
		call classlist(0)	
	end if	
		response.write class_list
   %>      
        
                
           
             
               
               <script type="text/javascript">
$(document).ready(function () {
$("#setall").click(function () {
$("#inputlist input[name=sonid]").prop("checked", true).each(function(index, element) {
   
		var cateid=$(this).prop("value");
		$("#inputlist input[name=cate"+cateid+"]").each(function(index, element) {
            $(this).prop("checked", true);
        });
		
			//alert($(this).prop("value"));
});
});
$("#setNotall").click(function () {
$("#inputlist input[name=sonid]").prop("checked", false).each(function(index, element) {
    var cateid=$(this).prop("value");
		$("#inputlist input[name=cate"+cateid+"]").each(function(index, element) {
            $(this).prop("checked", false);
        });
});;
});
$("#setallC").click(function () {
$("#inputlist input[name=sonid]").each(function () {
$(this).prop("checked", !$(this).prop("checked")).each(function(index, element) {
    if($(this).prop("checked")){
		var cateid=$(this).prop("value");
		$("#inputlist input[name=cate"+cateid+"]").each(function(index, element) {
            $(this).prop("checked", true);
        });
	}else{
		 var cateid=$(this).prop("value");
		$("#inputlist input[name=cate"+cateid+"]").each(function(index, element) {
            $(this).prop("checked", false);
        });
	}
});;

});
});

$("#inputlist input[name=sonid]").bind("change",function(){
	if($(this).prop("checked")){
		var cateid=$(this).prop("value");
		$("#inputlist input[name=cate"+cateid+"]").each(function(index, element) {
            $(this).prop("checked", true);
        });
		}
		else{
		//	alert($(this).prop("value"));
		var cateid=$(this).prop("value");
		$("#inputlist input[name=cate"+cateid+"]").each(function(index, element) {
            $(this).prop("checked", false);
        });
			}
	})
});

$("#inputlist input[name=sonid]").click(function(){
	if($(this).prop("checked")){
	var curClass=($(this).attr("class"));
	var curClassNum=parseInt(curClass.substr(11,1));
	//alert(curClassNum);
	for (i=curClassNum-1; i>=1; i--){
		$(this).parent().parent().prevAll("tr.tr_southidc"+i+"").first().children("td").find(".td_southidc"+i+"").prop("checked", true);
	}
	}
	});
</script>
                <tr> 
                  <td height="22" colspan="1"><a id="setall" href="javascript:;">全选</a>   <a id="setNotall" href="javascript:;">不选</a>    
                      </td><td colspan="4"><div align="center"><INPUT  type="submit" value="确认修改" name="Submit2">
                    &nbsp;
                    <input type="button" name="Submit" value="返回上一页" onClick="window.location.href='ad_sort.asp';">
                  </div></td>
                </tr>
              </table></td>
          </form>
        </tr>
       
</table>
