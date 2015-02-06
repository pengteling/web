<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<html xmlns:x="urn:schemas-microsoft-com:office:excel">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <head>
        <!--[if gte mso 9]><xml>
            <x:ExcelWorkbook>
                <x:ExcelWorksheets>
                    <x:ExcelWorksheet>
                        <x:Name>Sheet1</x:Name>
                        <x:WorksheetOptions>
                            <x:Print>
                                <x:ValidPrinterInfo />
                            </x:Print>
                        </x:WorksheetOptions>
                    </x:ExcelWorksheet>
                </x:ExcelWorksheets>
            </x:ExcelWorkbook>
        </xml>
        <![endif]-->
    </head>
<%'response.ContentType ="application/vnd.ms-excel"

date1=cdate(request.Form("date1"))
date2=cdate(request.Form("date2"))

Response.AddHeader "Content-Disposition","attachment;filename=hc"&date1&"-"&date2&".xls"


Set rs = Server.CreateObject("ADODB.Recordset")

'response.write "select * from orderlist where addtime>=#"&date1&"# and addtime<=#"&date2&"# order by id desc"
rs.open "select * from orderlist_c where addtime>='"&date1&"' and addtime<='"&date2&"' and isdel=0 order by id desc",conn,1,1

%>

            <table >
              <tr >
                <td >订单编号</td>               
                  <td>用户名</td>
                 <td >商品金额</td>
                 <td >浮动金额</td>
                 <td >实际付款</td>
                 <td >订单状态</td>
                 <td >下单时间</td>
                <td > 
                  收货人</td>
                <td > 
                  联系电话</td>
                
               
                
               
              </tr>
              <%
if not rs.eof then
i=0
do while not rs.eof
%>
              <tr>
                <td><%=rs("OrderNum")%></td> 
                <td> 
                <%=rs("username")%></td>
                <td> 
                <%=rs("totalmoney")%></td>
                <td> 
                <%=rs("floatmoney")%></td>
                <td><span style="color:red" >
                <%=rs("totalmoney")+rs("floatmoney")%></span></td>
                <td> 
                  <%=Easp.var(trim(rs("refund_status")))%>
                </td>
                <td> 
                  <%=rs("addtime")%>
                </td>
               
                <td> 
                  <%=rs("xm")%>
                </td>
                
                 <td> 
                  <%=rs("tel")%>
                </td>
                
             
             
              </tr>
              <%
i=i+1

rs.movenext
loop
end if


rs.close
conn.close
%>
</table>