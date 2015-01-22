<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<!-- #include file="../Inc/Head.asp" -->

<%
if request("t2")<>"" and request("Cateid")<>"" then 

t2 = clng(request("t2"))
cateid=cint(request("cateid"))
n=clng(request("n"))
allnum =clng(request("allnum"))
'response.write allnum
c_num=1

if cateid=0 then
	sql="select top 2 * from news_c where id>="&n&" order by id"
else

	set rs2=server.CreateObject("Adodb.recordset")
	rs2.open "select sonid from category where cateid="&cateid&"",conn,1,1
	if not rs2.eof then
	sonid=rs2("sonid")
	end if
	rs2.close
	sql="select top 2 * from news_c where id>="&n&" and cateid in ("&sonid&") order by id"
end if
'response.write sql
	rs.open sql,conn,1,1
	if  rs.eof then
		response.write "该栏目及子栏目下无信息！"
	else
		
		set rs3=server.CreateObject("Adodb.recordset")
		rs3.open "select dirpath from category where cateid="&rs("cateid"),conn,1,1
		if not rs3.eof then
			catepath=rs3("dirpath")
		end if
		rs3.close
		set rs3=nothing 
		response.Write htmlRoot&catepath&rs("staticUrl")
		'response.write SiteUrl&rs("dynamicUrl")
		issuccess=	C_htm(SiteUrl&rs("dynamicUrl"),htmlRoot&catepath&rs("staticUrl"))
			response.write " "&rs("title") &" "
			if issuccess then
				response.write "生成成功！"
			else
				response.write "生成失败！"
			end if
	
	
	
	rs.movenext
		if not rs.eof and c_num<allnum then
				%>
<script language="javascript">
	setTimeout("location.href='c_readnews.asp?cateid=<%=cateid%>&n=<%=rs("id")%>&t2=<%=t2%>&allnum=<%=allnum%>'",<%=t2*1000%>);
	//1000为1秒
	</script>
<%
	c_num=c_num+1
		else
	response.write "<br>全部生成结束！"
		end if
	
	end if
	
	rs.close



else
%>
<form id="form1" name="form1" method="get" action="?" target="Loadinfo">
  <table width="100%" border="0" align="center" cellpadding="3" cellspacing="1" class="table_southidc">
    <tr>
      <td>生成信息页</td>
    </tr>
    <tr>
      <td  align="left" class="tr_southidc"><div align="left">请选择栏目：
          <select name="cateid">
            <option value="0">所有栏目</option>
            <%

set rs=server.CreateObject("adodb.recordset")
			rs.open "select cateid,catename,followid,depth,sonid,parentid,orderID from category where catetype<=3 "&sql_sonid&" order by depth,orderID",conn,1,1
			if not rs.eof then
				data= rs.getRows()
			end if
			rs.close
			
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
				class_list=class_list&"<option value="""&data(0,i)&""" "&isslected&">"

For k=2 To data(3,i)
class_list=class_list&"&nbsp;&nbsp;&nbsp;&nbsp;"
next

If data(3,i)>1 then class_list=class_list& "├"
				class_list=class_list& data(1,i)&"</option>"
				
				classlist(data(0,i))
			end if
		next
	end sub
	if isarray(data) then	
		call classlist(0)	
	end if	
		response.write class_list
		  %>
          </select>
        </div></td>
    </tr>
    <tr>
      <td height="25" align="left" class="tr_southidc">生成数量：
        <input name="allnum" type="text" value="100" class="input" />
        <span>单位：条</span> 要生成最新的多少条信息 </td>
    </tr>
    <tr>
      <td height="25" align="left" class="tr_southidc">每次间隔：
        <input name="t2" type="text" value="1" class="input" />
        <span>单位：秒</span></td>
    </tr>
    <tr>
      <td height="25" class="tr_southidc"><input type="submit" value="开始生成"></td>
    </tr>
    <tr>
      <td class="tr_southidc"><iframe frameborder="0" name="Loadinfo" id="Loadinfo" width="100%" height="150"></iframe></td>
    </tr>
  </table>
</form>
<%end if%>
