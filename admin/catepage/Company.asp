<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<!-- #include file="../Inc/Head.asp" -->
<!-- #include file="../Inc/ReplaceSaveRemoteFile.asp" -->
<%
ID=strToNum(request("ID"))
Act=lcase(Request("act"))
content=Trim(Request("content"))
if clng(request("saveimg"))=1 then
Content=ReplaceSaveRemoteFile(Content,FilesStartStr,FilesOverStr,False,True,True,FilesPath,NewsUrl) 
end if
If Act="edit" Then
    content = replace(content,"'","")
    conn.execute("Update category Set content='"&content&"' where cateID="&ID)
	Response.Write "<script language=javascript>alert('修改成功！');document.location='Companyall.asp';</script>"
End If

Set ComRs=conn.execute("Select * From category Where cateID="&ID)
If ComRs.Eof Then
    Response.Write "项目错误"
	Response.End
End If
%>
<form id="form1" name="form1" method="post" action="">
  <table width="100%" border="0" align="center" cellpadding="3" cellspacing="1" class="table_southidc">
    <tr>
      <td height="25" align="center"><span style="font-weight: bold"><%=sqlbad(comRs("catename"))%></span></td>
    </tr>
    <tr>
      <td height="380" align="center" valign="top" class="tr_southidc">

<br>
    
  	<link rel="stylesheet" href="/kindeditor/themes/default/default.css" />
	 <link rel="stylesheet" href="/kindeditor/plugins/code/prettify.css" />
	<script charset="utf-8" src="/kindeditor/kindeditor.js"></script>
	<script charset="utf-8" src="/kindeditor/lang/zh_CN.js"></script>
	<script charset="utf-8" src="/kindeditor/plugins/code/prettify.js"></script>
	<script>
		var editor1;
		KindEditor.ready(function(K) {
			editor1 = K.create('textarea', {
				cssPath : '/kindeditor/plugins/code/prettify.css',
				uploadJson : '/kindeditor/asp/upload_json.asp',
				fileManagerJson : '/kindeditor/asp/file_manager_json.asp',
				allowFileManager : true,
				filterMode : false, // true:开启过滤模式, false:关闭过滤模式
				afterCreate : function() {
					var self = this;
					K.ctrl(document, 13, function() {
						self.sync();
						K('form[name=example]')[0].submit();
					});
					K.ctrl(self.edit.doc, 13, function() {
						self.sync();
						K('form[name=example]')[0].submit();
					});
				}
				
			});
			
			prettyPrint();
		});
		function show()
{

	// 同步数据后可以直接取得textarea的value
editor1.sync();
//html = document.getElementById('editor_id').value; // 原生API
html=document.form1.content.value;
alert(html);
//html = K('#editor_id').val(); // KindEditor Node API
	}
			</script>
<textarea name="content" style="width:100%;height:400px;visibility:hidden;"><%
if not isnull(comRs("content")) then
response.write htmlspecialchars(comRs("content"))
end if%></textarea>
<!--		
<a href="javascript:show()">show</a>
			分页标记请手动插入 <font color=red>[nextpage]</font>-->
            <input name="saveimg" type="checkbox" value="1">保存远程图片
			</td></tr>
    <tr>
      <td height="32" align="center" class="tr_southidc"><input type="submit" name="Submit" value="确认修改" />
        &nbsp;
        <input type="button" name="Submit2" value=" 返回 " onClick="history.go(-1);" />
        <input name="Act" type="hidden" id="Act" value="edit" />
        <input name="ID" type="hidden" id="ID" value="<%=ID%>" /></td>
    </tr>
  </table>
</form>
<!-- #include file="../Inc/Foot.asp" -->
