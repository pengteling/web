<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<!-- #include file="../Inc/Head.asp" -->
<%
id=request("id")
page=request("page")
set rs=server.createobject("adodb.recordset")
sqltext="select * from OrderList where OrderNum='"&id&"'"
rs.open sqltext,conn,1,1
%>

<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td align="center" valign="top">
<form method="post" action="OrderList_Save.asp?OrderNum=<%=rs("OrderNum")%>"><table  width="100%" border="0" cellpadding="2" cellspacing="1" class="table_southidc">
        <tr> 
          <td height="25" align="center" class="back_southidc">            <strong><%=rs("OrderNum")%>号订单管理 <br>
            </strong></td>
        </tr>
        <tr> 
          
            <td class="tr_southidc"><TABLE cellSpacing=1 cellPadding=4 width=100% height="514">
              <TBODY>
                <TR>
                  <TD height="10"  colSpan=2 valign="top" bgcolor="#DBDBDB" class="tr_southidc"></TD>
                </TR>
                <TR bgColor=#eeeeee>
                  <TD height="32"  colSpan=2 class="tr_southidc"><font color="#000000">客户订货单详细资料</font></TD>
                </TR>
                <TR>
                  <TD  width=21% height=25 align="right" bgColor=#DBDBDB class="tr_southidc"><font color="#000000">订单编号：</font></TD>
                  <TD  width=79% height=25 bgcolor="#eeeeee" class="tr_southidc"><%=rs("OrderNum")%></TD>
                </TR>
               <tr>
                  <TD height=25 align="right" bgColor=#DBDBDB class="tr_southidc"><font color="#000000">电器名称：</font></TD>
                  <TD height=25 bgcolor="#eeeeee" class="tr_southidc"><%=rs("productname")%></TD>
                </tr>
                <tr>
                  <TD height=25 align="right" bgColor=#DBDBDB class="tr_southidc"><font color="#000000">购买商场：</font></TD>
                  <TD height=25 bgcolor="#eeeeee" class="tr_southidc"><%=rs("buyplace")%></TD>
                </tr>
                  <tr>
                  <TD height=25 align="right" bgColor=#DBDBDB class="tr_southidc"><font color="#000000">是否购买自保：</font></TD>
                  <TD height=25 bgcolor="#eeeeee" class="tr_southidc"><%If rs("isyb")=0 Then%>
                    否
                    <%else%>
                    是
                    <%End If%>                  </TD>
                </tr>
                   <tr>
                  <TD height=25 align="right" bgColor=#DBDBDB class="tr_southidc"><font color="#000000">服务要求：</font></TD>
                  <TD height=25 bgcolor="#eeeeee" class="tr_southidc"><%=rs("list_tr")%></TD>
                </tr>             
                <tr>
                  <TD height=25 align="right" bgColor=#DBDBDB class="tr_southidc"><font color="#000000">姓名：</font></TD>
                  <TD height=25 bgcolor="#eeeeee" class="tr_southidc"><%=rs("username")%></TD>
                </TR>
              
                <tr>
                  <TD height=25 align="right" bgColor=#DBDBDB class="tr_southidc"><font color="#000000">通讯地址：</font></TD>
                  <TD height=25 bgcolor="#eeeeee" class="tr_southidc"><%=rs("addr")%></TD>
                </tr>
             
                <tr>
                  <TD height=25 align="right" bgColor=#DBDBDB class="tr_southidc"><font color="#000000">手&nbsp;&nbsp;&nbsp; 机：</font></TD>
                  <TD height=0 bgcolor="#eeeeee" class="tr_southidc"><%=rs("mobile")%></TD>
                </tr>
                  <tr>
                  <TD height=25 align="right" bgColor=#DBDBDB class="tr_southidc"><font color="#000000">电&nbsp;&nbsp;&nbsp; 话：</font></TD>
                  <TD height=0 bgcolor="#eeeeee" class="tr_southidc"><%=rs("tel")%></TD>
                </tr>
                <tr>
                  <TD height=25 align="right" bgColor=#DBDBDB class="tr_southidc">邮&nbsp;&nbsp;&nbsp; 箱<font color="#000000">：</font></TD>
                  <TD height=25 bgcolor="#eeeeee" class="tr_southidc"><%=rs("email")%></TD>
                </tr>
                
                
                       
               
                <tr>
                  <TD height=24 align="right" bgColor=#DBDBDB class="tr_southidc"><font color="#000000">下单日期：</font></TD>
                  <TD height=24 bgcolor="#eeeeee" class="tr_southidc"><%=rs("addtime")%></TD>
                </tr>
                <tr>
                  <TD height=25 align="right" bgColor=#DBDBDB class="tr_southidc"><font color="#000000">订单是否已经处理：</font></TD>
                  <TD height=25 bgcolor="#eeeeee" class="tr_southidc"><%If rs("Flag")="尚未处理" Then%>
                    尚未处理
                    <%else%>
                    已经处理
                    <%End If%>                  </TD>
                </tr>
                <tr>
                  <TD height=24 align="right" bgColor=#DBDBDB class="tr_southidc"><font color="#000000">订单最后处理时间：</font></TD>
                  <TD height=24 bgcolor="#eeeeee" class="tr_southidc"><%=rs("addtime")%></TD>
                </tr>
                
              <center>
                <TR>
                  <TD height="25"  colSpan=2 bgcolor="#eeeeee" class="tr_southidc"><p align="center">
                      <%If rs("Flag")="尚未处理" Then%>
                      <input type="submit" value="处理订单" name="B1">
<%
rs.close
conn.close
End If
%>
                      <input type="button" value="返回上一页" name="B4" onClick="javascript:window.history.go(-1)">
                    </TD>
                </TR>
                <TR bgColor=#DBDBDB>
                  <TD height="3"  colSpan=2></TD>
                </TR>
              </center>
            </TABLE></td>
          
        </tr>
      </table></form></td>
  </tr>
</table>
<!-- #include file="../Inc/Foot.asp" -->