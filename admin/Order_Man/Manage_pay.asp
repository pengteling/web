<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<%
Set Rs = Server.CreateObject("ADODB.Recordset")
Rs.ActiveConnection = Conn
Rs.Open "SELECT * FROM Paydefault Order BY id"

if Request.QueryString("mark")="yes" then
id= Trim(Request("id"))
Set Rs = Server.CreateObject("ADODB.Recordset")
Rs.ActiveConnection = Conn
Rs.Open "DELETE FROM Paydefault Where id="&id,Conn,2,3,1
Set Rs= Nothing
Set Conn = Nothing
Response.Redirect "Manage_pay.asp"
end if

if Request.QueryString("mark")="southidc" then
	paytitle=ChkFormStr(Request("paytitle"))
	bankdemo=ChkFormStr(Request("bankdemo"))
	bankname=ChkFormStr(Request("bankname"))
	bankcode=ChkFormStr(Request("bankcode"))
	payee=ChkFormStr(Request("payee"))
	site=ChkFormStr(Request("site"))

Set rs = Server.CreateObject("ADODB.Recordset")
sql="select * from Paydefault "
rs.open sql,conn,1,3
rs.addnew
	rs("paytitle")=paytitle
	rs("bankdemo")=bankdemo
	rs("bankname")=bankname
	rs("bankcode")=bankcode
	rs("payee")=payee
	rs("site")=site
rs.update
Response.Redirect "Manage_pay.asp"
end if
%>
<!-- #include file="../Inc/Head.asp" -->
<script language="javascript">
function chkform(){
if(payfrom.paytitle.value.length==0){
    alert('������֧������');
	payfrom.paytitle.focus();
	return false;
}

if(payfrom.bankname.value.length==0){
    alert('�����뿪������');
	payfrom.bankname.focus();
	return false;
}

if(payfrom.bankcode.value.length==0){
    alert('�����������ʺ�');
	payfrom.bankcode.focus();
	return false;
}

if(payfrom.payee.value.length==0){
    alert('�������տ���');
	payfrom.payee.focus();
	return false;
}

if(payfrom.bankdemo.value.length==0){
    alert('������֧��˵��');
	payfrom.bankdemo.focus();
	return false;
}
}
</script>
 <form name="payfrom" id="payfrom" method="post" action="Manage_pay.asp?mark=southidc" onSubmit="return chkform();">
    <table width="100%" border="0" align="center" class="table_southidc">
    <tr>
        <td align="center" class="blod">֧������</td>
     </tr>
</table>
	
  
    <table width="100%" border="0" align="center" cellpadding="3" cellspacing="1" class="table_southidc">
        
    <tr>
          <td width="16%" height="24" align="right" class="tr_southidc">������⣺</td>
          <td width="39%" class="tr_southidc"><input name="paytitle" type="text" id="paytitle"></td>
          <td width="45%" rowspan="5" class="tr_southidc">����˵����<br>
                <textarea name="bankdemo" cols="40" rows="10" id="bankdemo"></textarea></td>
        </tr>
        <tr>
          <td height="22" align="right" class="tr_southidc">�������У�</td>
          <td class="tr_southidc"><input name="bankname" type="text" id="bankname"></td>
        </tr>
        <tr bgcolor="#A4B6D7">
          <td height="22" align="right" class="tr_southidc">�����ʺţ�</td>
          <td height="22" class="tr_southidc"><input name="bankcode" type="text" id="bankcode"></td>
        </tr>
        <tr bgcolor="#A4B6D7">
          <td height="22" align="right" class="tr_southidc">�� �� �ˣ�</td>
          <td height="22" class="tr_southidc"><input name="payee" type="text" id="payee"></td>
        </tr>
        <tr bgcolor="#A4B6D7">
          <td height="22" align="right" class="tr_southidc">���� URL��</td>
          <td height="22" class="tr_southidc"><input name="site" type="text" id="site" value="http://"></td>
        </tr>
        <tr bgcolor="#A4B6D7">
          <td height="22" colspan="3" align="center" class="tr_southidc"><input type="submit" name="Submit" value="�ᡡ��">
          &nbsp;
          <input type="reset" name="Submit2" value="�ء���"></td>
        </tr>
</table>
          
<%
Do While Not Rs.Eof
%>		  
          <br><table width="100%" border="0" align="center" cellpadding="3" cellspacing="1" class="table_southidc">
            <tr>
              <td height="22" colspan="3" class="tr_southidc"><b><a href="<%=rs("site")%>" target="_blank"><%=rs("paytitle")%></a></b></td>
            </tr>
            <tr>
              <td width="11%" height="22" align="right" class="tr_southidc"><span class="tr_southidc">�������У�</span></td>
              <td width="44%" height="22" class="tr_southidc"><span class="tr_southidc"><%=rs("bankname")%></span></td>
              <td width="45%" rowspan="4" valign="top" class="tr_southidc"><p class="tr_southidc">˵����<br>
                &nbsp;&nbsp;&nbsp;&nbsp;<%=rs("bankdemo")%></p>
                </td>
            </tr>
            <tr>
              <td height="22" align="right" class="tr_southidc"><span class="tr_southidc">�����ʺţ�</span></td>
              <td height="22" class="tr_southidc"><span class="tr_southidc"><%=rs("bankcode")%></span></td>
            </tr>
            <tr>
              <td height="22" align="right" class="tr_southidc"><span class="tr_southidc">�� �� �ˣ�</span></td>
              <td height="22" class="tr_southidc"><span class="tr_southidc"><%=rs("payee")%></span></td>
            </tr>
            <tr>
              <td height="22" align="right" class="tr_southidc">����ѡ�</td>
              <td height="22" align="center" class="tr_southidc"><a href="Manage_editpay.asp?id=<%=Rs("id")%>">�޸�</a> | <a href="Manage_pay.asp?id=<%=Rs("id")%>&amp;mark=yes">ɾ��</a></td>
            </tr>
			
</table>
<%
Rs.Movenext
Loop
%>
</form>

<% 
    Set Rs = Nothing 
	Set Conn = Nothing 
%>
<!-- #include file="../Inc/Foot.asp" -->