<!--#include file="../easyasp/easp.asp"-->
<%
Session.CodePage=65001
'Response.CharSet="utf-8"
Response.CharSet="utf-8"
Response.LCID = 2052

%>
<!--#include file="webconfig.asp"-->
<!--#include file="config.asp"-->
<!--#include file="hdp.asp"-->
<!--#include file="Function.asp"-->
<%
dim conn
dim connstr,MyDbPath 
dim db
'on error resume next

if IsSqlserver=1 then
'SQL Server
connstr="Provider=SQLOLEDB.1;Server=122.114.121.55;User ID=hcjdb_f;Password=jadeboxadm;Database=hcjdb;"
'connstr="Provider=sqloledb.1;Data Source=122.114.121.66;Initial Catalog=jdb;User Id=jdb_f;Password=jadeboxadm;"
Easp.Db.SetConnection "default", "MSSQL", "hcjdb", "hcjdb_f:jadeboxadm@122.114.121.55"

'connstr="Provider=SQLOLEDB.1;Server=JADEBOXSERVER\SQLEXPRESS;User ID=jdb_f;Password=jadeboxadm;Database=jdb;"
'Easp.Db.SetConnection "default", "MSSQL", "jdb", "jdb_f:jadeboxadm@JADEBOXSERVER\SQLEXPRESS"


'connstr="Provider=SQLOLEDB.1;Server=PTL-PC\SQLEXPRESS;User ID=jdb_f;Password=jadeboxadm;Database=jdb;"
'Easp.Db.SetConnection "default", "MSSQL", "jdb", "jdb_f:jadeboxadm@PTL-PC\SQLEXPRESS"


else

MyDbPath =systemroot
Db = "FDatabase/#%&_db.mdb"
'Access
connstr="Provider = Microsoft.Jet.OLEDB.4.0;Data Source = " & Server.MapPath(MyDbPath & db)
Easp.Db.SetConnection "default", "ACCESS", MyDbPath & db,""

end if

	Set conn = Server.CreateObject("ADODB.Connection")
	conn.open ConnStr
	Set conn_easp = Easp.Db.GetConn()
	If Err Then
		err.Clear
		Set Conn = Nothing
		Response.Write "数据库连接出错，请检查连接字串。"
		Response.End
	End If
Set rs= Server.CreateObject("ADODB.Recordset")
sub CloseConn()
	conn.close
	set conn=nothing
end sub	

'============邮件发送配置=====================
dim login_user,login_pwd,mailhost,mail_user,mail_usert,senduser

login_user="" '邮件登陆用户名
login_pwd="" '邮件登陆所需密码
mailhost="smtp.ym.163.com" '邮件服务器地址
mail_user="" '接受邮件邮箱
mail_usert="" '接受邮件邮箱
senduser=SiteName '发件人名称

'支付宝担保交易接口 状态
Easp.var("WAIT_BUYER_PAY")="等待买家付款"
Easp.var("WAIT_SELLER_SEND_GOODS")="已付款未发货"
Easp.var("WAIT_BUYER_CONFIRM_GOODS")="已发货"
Easp.var("TRADE_FINISHED")="订单完成"
Easp.var("WAIT_SELLER_AGREE")="等待卖家同意退款"
Easp.var("REFUND_SUCCESS")="退款成功"
Easp.var("TRADE_CLOSED")="订单关闭"
%>