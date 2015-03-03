<%
'Easp.Db.SetConnection "default", "MSSQL", "yugao", "jdb_f:jadeboxadm@JADEBOXSERVER\SQLEXPRESS"
connstr="Provider=SQLOLEDB.1;Server=JADEBOXSERVER\SQLEXPRESS;User ID=jdb_f;Password=jadeboxadm;Database=jdb;"
'connstr="Provider=SQLOLEDB.1;Server=122.114.121.55;User ID=hcjdb_f;Password=jadeboxadm;Database=hcjdb;"
Set conn = Server.CreateObject("ADODB.Connection")
	conn.open ConnStr
%>