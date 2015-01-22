<!--#include file="../FiveInc/conn.asp"-->
<!--#include file="admin.asp"-->
<!--#include file="Inc/md5.asp"-->
<!-- #include file="Inc/Head.asp" -->
<%
Act=Trim(Request("Act"))
id=clng(request("id"))

if Act ="SavePermission" then

sonid=request.Form("sonid")
sonid=replace(sonid," ","")
'response.Write sonid
'response.End()

conn.execute "update zh_Admin set sonid='"&sonid&"' where id="&Id
end if


set rs=server.createobject("adodb.recordset")
sqltext="select * from zh_Admin where Id=" & id
rs.open sqltext,conn,1,1
if  rs.eof then
response.Write "找不到此管理员"
response.End()
else
sonid=rs("sonid")
end if
'response.write sonid
%>
<table width="100%" border="0" cellpadding="2" cellspacing="1" class="table_southidc">
        <tr> 
          <td height="25" align="center" class="back_southidc"><strong>普通管理员栏目权限设置</td>
        </tr>
        <tr class="tr_southidc"> 
          <form name="form1"  onsubmit="return form1_onsubmit()" action="Manage_Admin_permission.asp?Act=SavePermission&uid=<%=rs("Id")%>" method="post">
            <input type="hidden" value="<%=rs("id")%>" name="id">
            <input type="hidden" name="act" value="SavePermission">
            <td><table width="50%" border="0" align="center" cellpadding="0" cellspacing="2">
                <tr> 
                  <td height="25" colspan="2">&nbsp;</td>
                </tr>
                <tr> 
                  <td width="29%" height="22" align="right"> 管理帐号：</td>
                  <td width="71%"><%=rs("UserName")%></td>
                </tr>
                  <tr><td height="22" align="right"> 操作：</td><td>
             <a id="setall" href="javascript:;">全选</a>   <a id="setNotall" href="javascript:;">不选</a>   <a id="setallC" href="javascript:;">反选</a>  
               </td></tr>
                <tr> 
                  <td height="22" align="right"> 设置权限：</td>
                  <td><div id="inputlist">
                  <%set rs2=server.CreateObject("adodb.recordset")
			rs2.open "select cateid,catename,followid,depth,sonid,parentid,orderID from category where catetype<=1 order by depth,orderID",conn,1,1
			if not rs2.eof then
				data= rs2.getRows()
			end if
			rs2.close
			
	class_list=""
	
	
sub classlist(byval t0)
		dim i
		for i=0 to ubound(data,2)
			if t0=data(2,i) then
				if followid = data(0,i) then
					isslected="selected"
				else
					isslected=""
				end if
				'class_list=class_list&"<option value="""&data(0,i)&""" "&isslected&">"

For k=2 To data(3,i)
class_list=class_list&"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
next

If data(3,i)>1 then class_list=class_list& "&nbsp;&nbsp;"
				class_list=class_list&"<input type=checkbox name=sonid value='"&data(0,i)&"'"
				if instr(","+sonid+",",","+cstr(data(0,i))+",")>0 then class_list=class_list& " checked"
				class_list=class_list&">" &data(1,i)&"<Br>"
				
				classlist(data(0,i))
			end if
		next
	end sub
	if isarray(data) then	
		call classlist(0)	
	end if	
		response.write class_list
   %>      
         </div>
                  </td>
                </tr>
             
               
               <script type="text/javascript">
$(document).ready(function () {
$("#setall").click(function () {
$("#inputlist :input[name=sonid]").attr("checked", true);
});
$("#setNotall").click(function () {
$("#inputlist :input[name=sonid]").attr("checked", false);
});
$("#setallC").click(function () {
$("#inputlist :input[name=sonid]").each(function () {
$(this).attr("checked", !$(this).attr("checked"));

});
});

});
</script>
                <tr> 
                  <td height="22" colspan="2"><div align="center">
                      <INPUT  type="submit" value="确认修改" name="Submit2">
                    &nbsp;
                    <input type="button" name="Submit" value="返回上一页" onClick="window.location.href='manage_admin.asp';">
                  </div></td>
                </tr>
              </table></td>
          </form>
        </tr>
</table>
<%
rs.close

%>