<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp" -->
<!-- #include file="../Inc/Head.asp" -->
<%
set rs=server.CreateObject("adodb.recordset")
IF Request("work")="sh" Then
sql="update reply set ischeck=1 where id="&Request("id")&""
Conn.execute(sql)
End IF

IF Request("work1")="ischeck" Then
	conn.execute("update reply Set ischeck=1 Where Id="&Request("ID"))
	rs.open "select pid from reply where ltype=1 and Id="&Request("ID"),conn,1,1
	if not rs.eof then 
		pid = rs(0)
		rs.close
		conn.execute "update news set comments=comments+1 where id="&pid
	end if
	
End If

IF Request("work1")="ischeck1" Then
	conn.execute("update reply Set ischeck=0 Where Id="&Request("ID"))
	rs.open "select pid from reply where ltype=1 and Id="&Request("ID"),conn,1,1
	if not rs.eof then 
		pid = rs(0)
		rs.close
		conn.execute "update news set comments=comments-1 where id="&pid
	end if
End If

IF Request("work1")="del" Then
	conn.execute("delete from reply Where Id="&Request("ID"))
End If

if Request("work")="add" then
session("verifycode")=""
 set rs=server.createobject("adodb.recordset") 
 sql="select * from reply where id="&Request("id")&"" 
 rs.open sql,conn,1,2
  rs("B_dom")     =Request("B_dom")
  rs("B_hui")     =Request("B_hui")
 rs.update 		'更新数据表记录
 rs.close
 set rs=nothing
 Response.Redirect "book_index_reply.asp?ok=ck"
 End IF
%>
<script LANGUAGE="JavaScript">
function check()
{
   if (document.Form1.B_dom.value=="")
     {
      alert("请填写您的评论内容！")
      document.Form1.B_dom.focus()
      document.Form1.B_dom.select()		
      return
	       }
     document.Form1.submit()
}
</SCRIPT>
<%if Request("work")="edit" then
 set rs=server.createobject("adodb.recordset") 
 sql="select * from reply where id="&Request("id")&""
 rs.open sql,conn,1,1
%>

<TABLE width=100% border=0 align=center cellPadding=3 cellSpacing=1 class="table_southidc">
  <FORM name=Form1 action=book_index_reply.asp method=post>
    <TBODY>
      <TR>
        <TD colspan="2" align="center" valign="top" class="blod">回复评论</TD>
      </TR>
      <TR>
        <TD width="32%" align="right" valign="top" class="tr_southidc">评论内容:</TD>
        <TD width="68%" class="tr_southidc"><TEXTAREA class=ss1 id=B_dom name=B_dom rows=5 wrap=VIRTUAL cols=60><%=rs("B_dom")%></TEXTAREA></TD>
      </TR>
      <TR>
        <TD align="right" valign="top" nowrap class="tr_southidc">管理回复:</TD>
        <TD class="tr_southidc"><TEXTAREA class=ss1 id=B_hui name=B_hui rows=5 wrap=VIRTUAL cols=60><%=rs("B_hui")%></TEXTAREA></TD>
      </TR>
      <TR>
        <TD colSpan=2 align="center" class="tr_southidc"><input type="button" name="Submit" value="提交评论" onClick="check()">
          &nbsp;
          <INPUT class=STYLE1 type=reset value="返回上一页" name=Submit2 onClick="history.go(-1);">
          <INPUT id=work type=hidden value=add name=work>
          <INPUT id=id type=hidden value=<%=Request("id")%> name=id>        </TD>
      </TR>
  </FORM>
</TABLE>
</td>
  </tr>
  <%
 rs.close
 set rs=nothing
 end if%>
  <tr>
    <td bgcolor="#FFFFFF">
	<Script>
function ConfirmDel()
{
   if(confirm("确定要删除选中的信息吗？一旦删除将不能恢复！"))
     return true;
   else
     return false;
	 
}
</script>
      <TABLE class=tdtop cellSpacing=0 cellPadding=0 width=100% align=center border=0>
        <TBODY>
          <TR>          </TR>
        </TBODY>
      </TABLE>    </td>
  </tr>
  
  <tr>
    <td bgcolor="#FFFFFF"><TABLE width=100% border=0 align=center cellPadding=5 cellSpacing=1 class="table_southidc">
      <TBODY>
	  
        <TR>
          <TD colspan="2">栏目导航：<a href="book_index_reply.asp">所有评论</a> | <a href="book_index_reply.asp?ischeck=true">已审核评论</a> | <a href="book_index_reply.asp?ischeck=false">未审核评论</a>
          <br>
          <span class="blod">评论列表</span></TD>
        </TR>
  <%
 shou  =Request("shou")
 ischeck=Request("ischeck")
 sql="select * from reply where 1=1 "
 if shou<>"" then
  sql= sql & " and ( B_name like '%"&shou&"%' or  B_dom like '%"&shou&"%')"
 end if
 if ischeck="true" then
 sql= sql & " and ischeck=true "
 end if
 if ischeck="false" then
 sql= sql & " and ischeck=false "
 end if
 sql=sql & " order By id Desc,pid desc"
 set rs=server.createobject("adodb.recordset") 
 rs.open sql,conn,1,1
 IF Not rs.eof Then
 proCount=rs.recordcount
	rs.PageSize=20					  '定义显示数目
		if not IsEmpty(Request("ToPage")) then
	       ToPage=CInt(Request("ToPage"))
		   if ToPage>rs.PageCount then
					rs.AbsolutePage=rs.PageCount
					intCurPage=rs.PageCount
		   elseif ToPage<=0 then
					rs.AbsolutePage=1
					intCurPage=1
				else
					rs.AbsolutePage=ToPage
					intCurPage=ToPage
				end if
			else
			        rs.AbsolutePage=1
					intCurPage=1
		  end if
	intCurPage=CInt(intCurPage)
	For i = 1 to rs.PageSize
	if rs.EOF then     
	Exit For 
	end if
%>

        <TR>
          <TD width="23%" class="td_southidc"><font color="blue"><b><%=rs("username")%></b></font>  (<%=year(rs("posttime"))%>-<%=month(rs("posttime"))%>-<%=day(rs("posttime"))%>) </TD>
          <TD width="77%" class="td_southidc">
<%If rs("ischeck") Then%>
<a href="book_index_reply.asp?work1=ischeck1&id=<%=rs("id")%>&work=yz"><font color="#000000">已经审核</font></a>
<%Else%>
<a href="book_index_reply.asp?work1=del&id=<%=rs("id")%>" onClick="return ConfirmDel();"><font color="#FF0000">删除评论</font></a> &nbsp;
<a href="book_index_reply.asp?work1=ischeck&id=<%=rs("id")%>&work=yz"><font color="#FF0000">通过审核</font></a>
<%End If%>
</TD>
        </TR>

        <TR>
          <TD colspan="2" class="td_southidc">
		  <%=rs("content")%> <br><br>
		  
	   </TD>
        </TR>

<%
rs.MoveNext 
next
%>
        <TR>
          <TD colspan="2"><TABLE width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
            <TR>
              <TD>
                  <span style="font-size: 9pt;"> 总共：<font color="#ff0000"><%=rs.PageCount%></font>页, <font color="#ff0000"><%=proCount%></font>条评论, 当前页：<font color="#ff0000"> <%=intCurPage%> </font>
                  <% if intCurPage<>1 then
		  %>
                  <a href="?ToPage=1&shou=<%=shou%>&ok=ck">首页</a>|<a href="?ToPage=<%=intCurPage-1%>&shou=<%=shou%>&ok=ck">上一页</a>|
                    <% end if
if intCurPage<>rs.PageCount then %>
                  <a href="?ToPage=<%=intCurPage+1%>&shou=<%=shou%>&ok=ck">下一页</a>|<a href="?ToPage=<%=rs.PageCount%>&shou=<%=shou%>&ok=ck"> 尾页</a>|
                    <% end if%>
                </span></TD>
            </TR>
          </TABLE>
            <%
else
%>
            <TABLE width="80%" align="center">
              <TR>
                <TD>对不起！目前库中没有您要查询记录！[===<span class="style2"><%= Request("shou") %></span>===]</TD>
              </TR>
            </TABLE>
            <%
end if
rs.close
set rs=nothing
%></TD>
        </TR>
      </TBODY>
    </TABLE></td>
  </tr>
<!-- #include file="../Inc/Foot.asp" -->