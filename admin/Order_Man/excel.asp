<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<!-- #include file="../Inc/Head.asp" -->



<form name="form1" method="post" action="import.asp">
  <table width="100%" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#ECF5FF" class="table_southidc">
    <tr>
      <td height="25" colspan="2" align="center"><span style="font-weight: bold">导出订单到Excel</span></td>
    </tr>
    <tr>
      <td width="8%" height="25" align="center" class="tr_southidc">开始日期</td>
      <td width="62%" class="tr_southidc"><input name="date1" type="text" id="date1" value="<%=date()-30%>" size="20" maxlength="40">  格式：<%=Date()-365%>    </td>
    </tr>
    <tr>
      <td height="22" align="center" class="tr_southidc">结束日期</td>
      <td class="tr_southidc"><input name="date2" type="text" id="date2" value="<%=date()%>" size="20" maxlength="120"> 格式：<%=Date()-365%>       </td>
    </tr>
   
    <tr>
      <td height="25" colspan="2" align="center" bgcolor="#E3E3E3" class="tr_southidc">
        <input name="submit" type="submit" value="导出">
&nbsp;        <input name="reset" type="button" value="返回上一页" onClick="history.go(-1);">      </td>
    </tr>
  </table>
</form>
<!-- #include file="../Inc/Foot.asp" -->