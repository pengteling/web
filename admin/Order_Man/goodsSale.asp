<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<!-- #include file="../Inc/Head.asp" -->

<%
if Easp.var("date1")="" then
Easp.var("date1")=date()-30
Easp.var("date2")=date()

end if
%>

<form name="form1" method="post" action="?">
  <table width="100%" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#ECF5FF" class="table_southidc">
    <tr>
      <td height="25" colspan="2" align="center"><span style="font-weight: bold">设置统计周期</span></td>
    </tr>
    <tr>
      <td width="8%" height="25" align="center" class="tr_southidc">查询开始日期</td>
      <td width="62%" class="tr_southidc"><input name="date1" type="text" id="date1" value="<%=formatDate(date()-30,2)%>" size="20" maxlength="40" onfocus="WdatePicker({maxDate:'%y-%M-%d'})">  格式：<%=formatDate(Date()-30,2)%>    </td>
    </tr>
    <tr>
      <td height="22" align="center" class="tr_southidc">查询结束日期</td>
      <td class="tr_southidc"><input name="date2" type="text" id="date2" value="<%=formatDate(date(),2)%>" size="20" maxlength="120" onfocus="WdatePicker({maxDate:'%y-%M-%d'})"> 格式：<%=formatDate(Date()-30,2)%>    </td>
    </tr>
   
    <tr>
      <td height="25" colspan="2" align="center" bgcolor="#E3E3E3" class="tr_southidc">
        <input name="submit" type="submit" value="查询">
&nbsp;        <input name="reset" type="button" value="返回上一页" onClick="history.go(-1);">      </td>
    </tr>
    
     <tr>
      <td height="25" colspan="3" align="center"><span style="font-weight: bold">查看产品订单量</span></td>
    </tr>
  </table>
</form>
<br><br>
<br><br>
 <table width="500" border="0" align="left" cellpadding="3" cellspacing="1" bgcolor="#ECF5FF" class="table_southidc">

    
    <tr class="tr_southidc">
    <td>产品名称</td>
    <td>产品订单量</td>
    </tr>
    <%
	set proc=Easp.Db.Query("exec goodsSalesCount {date1},{date2}")
	If Not IsNull(proc("rs")) Then
  		Set rs = proc("rs")
		while not rs.eof 
		
		response.write "<tr class=""tr_southidc""><td>"&rs("goodsname")&"</td><td>"&rs("goodsnum")&"</td></tr>"
		
		rs.movenext
		wend
		rs.close
	end if

	%>
    
 </table>

<!-- #include file="../Inc/Foot.asp" -->