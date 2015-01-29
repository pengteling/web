<!--#include file = "../FiveInc/conn.asp" -->
<!--#include file="Admin.asp"-->
<!--#include file="Inc/Head.asp"-->

<%  
if request("action")="Backup" then

conn.execute ("backup database jdb to DISK =N'f:\恒昌农具\web\FDatabase\"& formatdate(date(),2)&".bak'")
result="备分成功！"
end if
%>

     <table cellspacing=1 cellpadding=1 align=center width="90%">                

      <tr>

       <th height=25 >

       &nbsp;&nbsp;<B>数据库备份</B>

       </th>

      </tr>

      <form method="post" action="?action=Backup">

      <tr>

       <td height=100  style="line-height:150%">

             

              

      &nbsp;&nbsp;<input type=submit value="备份数据"><hr align="center" width="90%" color="#999999">&nbsp;&nbsp;<font color="#666666">·<%=result%></font></td>

      </tr>

      </form>

     </table>

  


<!-- #include file="Inc/Foot.asp" -->