<!--#include file = "../FiveInc/conn.asp" -->
<!--#include file="Admin.asp"-->
<!--#include file="Inc/Head.asp"-->
<%
conn.close
set conn=nothing
%>
<%
'====================压缩数据库 =========================
sub CompressData()
%><!-- 以下颜色不同部分为客户端界面代码 -->
<table border="0"  cellspacing="1" cellpadding="5" height="1" align=center width="100%" class="table_southidc">
<td align="center"><form action="Admin_db_ys.asp?action=CompressData" method="post">
  <span class="blod">数据库压缩</span>

<tr>
<td class="tr_southidc" height=25><b>注意：</b>
输入数据库所在相对路径,并且输入数据库名称（正在使用中数据库不能压缩，请选择备份数据库进行压缩操作） </td>
</tr>
<tr>
<td class="tr_southidc">压缩数据库：<input type="text" name="dbpath" value='<%=MyDbPath&Db%>'>
<input type="submit" value="开始压缩"></td>
</tr>
<tr>
<td class="tr_southidc"><input type="checkbox" name="boolIs97" value="True">如果使用 Access 97 数据库请选择
(默认为 Access 2000 数据库)</td>
</tr>
<form>
</table>
<%
dim dbpath,boolIs97
dbpath = request("dbpath")
boolIs97 = request("boolIs97")

If dbpath <> "" Then
dbpath = server.mappath(dbpath)
    '调用服务器端的自定义函数 CompactDB 来压缩数据库
    response.write(CompactDB(dbpath,boolIs97))
End If

end sub

'以下为实际压缩数据库的自定义函数，在服务器端运行
'=====================压缩参数=========================
Function CompactDB(dbPath, boolIs97)
Dim fso, Engine, strDBPath,JET_3X
strDBPath = left(dbPath,instrrev(DBPath,"\"))
Set fso = CreateObject(xiaodaofso)

If fso.FileExists(dbPath) Then
Set Engine = CreateObject("JRO.JetEngine")

'其实，和在Access中压缩数据库一样，我们仍然调用 JRO 来压缩修复数据库
'所不同的是在这里我们没有向Access那样采用“先引用”的方式（工具菜单选择引用）
'而是采用脚本所能使用的“后引用”方式建立 JRO 的实例 CreateObject("JRO.JetEngine")

    If boolIs97 = "True" Then
        Engine.CompactDatabase "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & dbpath, _
        "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & strDBPath & "temp.mdb;" _
        & "Jet OLEDB:Engine Type=" & JET_3X
    Else
        Engine.CompactDatabase "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & dbpath, _
        "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & strDBPath & "temp.mdb"
    End If
'操作完成后将已经缩小体积的数据库 COPY 回原位，覆盖原始文件
fso.CopyFile strDBPath & "temp.mdb",dbpath
'删除无用的临时文件
fso.DeleteFile(strDBPath & "temp.mdb")
Set fso = nothing
Set Engine = nothing

    CompactDB = "你的数据库, " & dbpath & ", 已经压缩成功!" & vbCrLf

Else
    CompactDB = "数据库名称或路径不正确. 请重试!" & vbCrLf
End If

End Function

CompressData()
%> 
<!-- #include file="Inc/Foot.asp" -->