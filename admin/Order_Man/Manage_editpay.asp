<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<%

if Request.QueryString("no")="eshop" then
	
	ID=strToNum(request("id"))
	paytitle=ChkFormStr(Request("paytitle"))
	bankdemo=ChkFormStr(Request("bankdemo"))
	bankname=ChkFormStr(Request("bankname"))
	bankcode=ChkFormStr(Request("bankcode"))
	payee=ChkFormStr(Request("payee"))
	site=ChkFormStr(Request("site"))


Set rs = Server.CreateObject("ADODB.Recordset")
sql="select * from Paydefault where id="&id
rs.open sql,conn,1,3
	rs("paytitle")=paytitle
	rs("bankdemo")=bankdemo
	rs("bankname")=bankname
	rs("bankcode")=bankcode
	rs("payee")=payee
	rs("site")=site
rs.update
rs.close
response.redirect "Manage_pay.asp"
end if
%>
<%
id=request.querystring("id")
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open "Select * From Paydefault where id="&id, conn,3,3
%>
<!-- #include file="../Inc/Head.asp" -->
<form id="form1" name="form1" method="post" action="Manage_editpay.asp?no=eshop">
  <table width="100%" border="0" align="center" cellpadding="3" cellspacing="1" class="table_southidc">
    <tr>
      <td width="16%" height="24" align="right" class="tr_southidc">付款标题：</td>
      <td width="39%" class="tr_southidc"><input name="paytitle" type="text" id="paytitle" value="<%=Rs("paytitle")%>" /></td>
      <td width="45%" rowspan="5" class="tr_southidc">其它说明：<br />
          <textarea name="bankdemo" cols="40" rows="10" id="bankdemo"><%=Rs("bankdemo")%></textarea></td>
    </tr>
    <tr>
      <td height="22" align="right" class="tr_southidc">开户银行：</td>
      <td class="tr_southidc"><input name="bankname" type="text" id="bankname" value="<%=Rs("bankname")%>" /></td>
    </tr>
    <tr bgcolor="#A4B6D7">
      <td height="22" align="right" class="tr_southidc">银行帐号：</td>
      <td height="22" class="tr_southidc"><input name="bankcode" type="text" id="bankcode" value="<%=Rs("bankcode")%>" /></td>
    </tr>
    <tr bgcolor="#A4B6D7">
      <td height="22" align="right" class="tr_southidc">收 款 人：</td>
      <td height="22" class="tr_southidc"><input name="payee" type="text" id="payee" value="<%=Rs("payee")%>" /></td>
    </tr>
    <tr bgcolor="#A4B6D7">
      <td height="22" align="right" class="tr_southidc">银行 URL：</td>
      <td height="22" class="tr_southidc"><input name="site" type="text" id="site" value="<%=Rs("site")%>" /></td>
    </tr>
    <tr bgcolor="#A4B6D7">
      <td height="22" colspan="3" align="center" class="tr_southidc"><input type="submit" name="Submit" value="确认修改" />
        &nbsp;
        <input type="button" name="Submit2" value="返回上一页" onClick="history.go(-1);"/>
        <input name="id" type="hidden" id="id" value="<%=ID%>" /></td>
    </tr>
  </table>
</form>
<!-- #include file="../Inc/Foot.asp" -->