<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<!-- #include file="../Inc/Head.asp" -->
<%
Act=lcase(ChkFormStr(Request("act")))
ID=strToNum(Request("ID"))
followid=StrtoNum(Request("followid"))
ComName=ChkFormStr(Request("ComName"))
catename_en=ChkFormStr(Request("catename_en"))
catedir=ChkFormStr(Request("catedir"))
IsHome=strToNum(Request("IsHome"))
OrderID=StrtoNum(Request("OrderID"))
modeltype=StrtoNum(Request("modeltype"))
catetype=StrtoNum(Request("catetype"))
OutLinkUrl=ChkFormStr(Request("OutLinkUrl"))
DefaultPicUrl=ChkFormStr(Request("DefaultPicUrl"))
if followid<>0 then

rs.open "select sonid,parentid,Depth from category where cateid="&followid,conn,1,1
if not rs.eof then
 sonid_f= rs("sonid")
 parentid_f=rs("parentid")
 Depth_f =rs("Depth") 
end if
rs.close


else
Depth_f=0

end if

Select Case Act
    Case "add"
'		ComName=ChkFormStr(Request("ComName"))
'		IsHome=strToNum(Request("IsHome"))
'		OrderID=strToNum(Request("OrderID"))
'		IsOutLink=StrtoNum(Request("IsOutLink"))
'		OutLinkUrl=ChkFormStr(Trim(Request("OutLinkUrl")))

set rs5 =conn.execute("select * from category where catedir='"&catedir&"'")
if not rs5.eof then
Response.Write "<script language=javascript>alert('已经存在相同的英文目录！');history.go(-1)</script>"
			Response.End()
end if
rs5.close
		
		If ComName="" Or IsNull(ComName) Or IsEmpty(ComName) Then
			Response.Write "<script language=javascript>alert('项目名称不能为空！');history.go(-1)</script>"
			Response.End()
		End If
		If catetype=3 Then
			If OutLinkUrl="" Or IsNull(OutLinkUrl) Or IsEmpty(OutLinkUrl) Then
				Response.Write "<script language=javascript>alert('链接地址不能为空！');history.back(1)</script>"
				Response.End()
			End If
		Else
			If OutLinkUrl<>"" Then OutLinkUrl="http://"
		End If
		
		conn.BeginTrans '事务开始
		
		set Rs=server.createobject("adodb.recordset")
		Sql="Select * From category where followid="&followid
		Rs.Open Sql,Conn,1,3
		
		Rs.AddNew
			Rs("catename")=ComName	
			Rs("catedir")=catedir			
			Rs("OrderID")=OrderID
			Rs("catetype")=catetype
			Rs("modeltype")=modeltype
			Rs("OutLinkUrl")=OutLinkUrl						
			Rs("followid")=followid
			rs("Depth")=Depth_f +1	
			rs("isHome")=isHome				
			rs("DefaultPicUrl")=DefaultPicUrl
			Rs("catename_en")=catename_en	
			
		Rs.Update
		if IsSqlserver=1 then  'Sqlserver取自增ID
			set rs2=conn.execute("select IDENT_CURRENT('category')") 
				cid=rs2(0)
			rs2.close
		else
			cid= rs("cateid") 'access取当前ID
		end if
		
		rs.close
		
		rs.open "Select * from category where cateid="& cid,conn,1,3
		

		rs("dynamicUrl")= companyURL(cid,catetype,outlinkurl,modeltype,catedir,"0")
		rs("staticUrl")= companyURL(cid,catetype,outlinkurl,modeltype,catedir,"1")
		if parentid_f="" then
		rs("parentid")= cid
		else
		rs("parentid")= cid&","& parentid_f 'parentid继承上级
		end if
		rs("sonid") = cid
		
		
		
		rs.update			
		Rs.Close	
		if parentid_f<>"" then	
		'response.write ("update category set sonid=sonid&',"&cid&"' where cateid in ("&parentid_f&") ")
		conn.execute ("update category set sonid=sonid&',"&cid&"' where cateid in ("&parentid_f&") ")
		end if
		
		dirpath(cid) '更新静态页面路径
		
		conn.CommitTrans  '如果没有conn错误，则执行事务提交
		'response.write cid
		
		'conn.execute("Insert Into Company(ComName,IsHome,OrderID,IsOutLink,OutLinkUrl,ChildID) values('"&ComName&"',"&IsHome&","&OrderID&","&IsOutLink&",'"&OutLinkUrl&"','"&ChildID&"'")
		Response.Write "<script language=javascript>alert('添加栏目成功！');document.location='Companyall.asp'</script>"
		Response.End()
	Case "edit"
		Set InfoRs=Conn.execute("select * From category Where cateID="&ID)
		if InfoRs.eof then response.Write "找不到": response.End()
		 
		ComName=InfoRs("CateName")
		if (InfoRs("IsHome")) then
		 	IsHome=1
		else
			IsHome=0
		end if
		modeltype=InfoRs("modeltype")
		
		OrderID=InfoRs("OrderID")
		
		OutLinkUrl=InfoRs("OutLinkUrl")
		catedir	=InfoRs("catedir")
		followid=InfoRs("followid")
		catetype=InfoRs("catetype")
		DefaultPicUrl=InfoRs("DefaultPicUrl")
	catename_en	=	InfoRs("catename_en")
		
		Act="editrecord"
		TT="修改"
	Case "editrecord"
		If ComName="" Or IsNull(ComName) Or IsEmpty(ComName) Then
			Response.Write "<script language=javascript>alert('项目名称不能为空！');history.go(-1)</script>"
			Response.End()
		End If
		If catetype=3 Then
			If OutLinkUrl="" Or IsNull(OutLinkUrl) Or IsEmpty(OutLinkUrl) Then
				Response.Write "<script language=javascript>alert('链接地址不能为空！');history.back(1)</script>"
				Response.End()
			End If
		Else
			If OutLinkUrl<>"" Then OutLinkUrl="http://"
		End If
		'sql="update Set ComName='"&ComName&"',IsHome="&IsHome&",OrderID="&OrderID&" where Id="&ID
	    'Conn.execute("update Company Set ComName='"&ComName&"',IsHome="&IsHome&",OrderID="&OrderID&",IsOutLink="&IsOutLink&",OutLinkUrl='"&OutLinkUrl&"' where Id="&ID)
		set Rs=server.createobject("adodb.recordset")
		set rs2=server.CreateObject("adodb.recordset")
		Sql="Select * From category Where cateID="&ID&""
		Rs.Open Sql,Conn,1,3
		If Not Rs.Eof Then
			conn.BeginTrans '事务开始
			sonid_e = rs("sonid")
			parentid_e =rs("parentid")
			followid_e=rs("followid")
			Depth_e=rs("Depth")
			
			if instr(","&sonid_e&",", ","&followid&",")>0 then
				response.Write "不能移动到自己的子栏目下面 <a href='javascript:history.back()'>返回</a>"
				response.End()
			end if
			
			
			rs("followid")=followid '当前的followid变化
			'rs("parentid")=id &"," & parentid_f  '更新这个的父路径
			Rs("cateName")=ComName
			Rs("cateName_en")=cateName_en
			'Rs("catedir")=catedir			'由于修改后会影响子栏目的生成路径，帮修改时不让修改
			Rs("IsHome")=IsHome
			Rs("OrderID")=OrderID
			Rs("cateType")=cateType
			Rs("OutLinkUrl")=OutLinkUrl
			rs("modelType")=modelType
		rs("DefaultPicUrl")=DefaultPicUrl
		
		rs("dynamicUrl")= companyURL(id,catetype,outlinkurl,modeltype,catedir,"0")
		rs("staticUrl")= companyURL(id,catetype,outlinkurl,modeltype,catedir,"1")
		
			Rs.Update
			
			if followid_e<>followid then
				'表示移动了栏目 要进行如下处理
				'当前栏目的父路径 
				start1= instr(parentid_e,",") 
				if start1>0 then
				cutnum = len(parentid_e)-start1+1 
				else
				cutnum=0
				end if		
				
				rs2.open "select cateid,parentid,depth from category where cateid in ("& sonid_e &")",conn,1,3
				while not rs2.eof
					'response.write rs2("cateid")
					if parentid_f<>"" then
					rs2("parentid")=left( rs2("parentid"),len(rs2("parentid"))-cutnum) &","&parentid_f '截掉原来的parentid 换上新的parentid
					else
					rs2("parentid")=left( rs2("parentid"),len(rs2("parentid"))-cutnum)
					end if
					rs2("depth") =rs2("Depth") + Depth_f +1 - Depth_e '深度变化
					rs2.update
				rs2.movenext
				wend
				rs2.close
				
				'其下sonid 不变  但原来的父路径的sonid要删除这些子id
				sonid_arr =split(sonid_e,",")
				rs2.open "select cateid,sonid from category where  cateid<>"&cint(id)&" and cateid in ("&parentid_e&")  ",conn,1,3'奇怪  cateid<>"&cint(id)&" and asp查出来还是有 含自身id的记录 access中直接查询无
				'response.write "select cateid,sonid from category where cateid in ("&parentid_e&") and cateid<>"&clng(id)&""
				response.write rs2.recordcount
				while not rs2.eof
					'if clng(rs2("cateid"))<>id then
					sonid_p = rs2("sonid")
					sonid_p =","+sonid_p+","
				response.write rs2("cateid")
					for i=0 to ubound(sonid_arr)
						sonid_p =replace(sonid_p,","+sonid_arr(i)+",",",") '删除后 其父栏目的 子栏目数据变化
					next
		
		
					sonid_p =right(sonid_p,len(sonid_p)-1)
					sonid_p =left(sonid_p,len(sonid_p)-1)
		response.write sonid_p
					rs2("sonid") = sonid_p
					rs2.update
					'end if
				
				rs2.movenext
				wend
				rs2.close
				
				'新移过去的parentid的sonid 要加上 sonid_e
				if followid<>0 then
				rs2.open "select cateid,sonid from category where  cateid in ("&parentid_f&")",conn,1,3
				while not rs2.eof
				
					
					sonid = rs2("sonid")
					for i=0 to ubound(sonid_arr)
						
						if instr(","+sonid+",",","+sonid_arr(i)+"," )<=0 then'检查是否已经有sonid
							
							sonid=sonid &","&sonid_e
						
						end if
						
					next
					
				rs2("sonid")=sonid				
					
				rs2.update
				rs2.movenext
				wend
				rs2.close
				end if
								
				
				
			end if
			
			
			'response.end
			
			dirpath(ID) '更新静态页面路径
			conn.CommitTrans  '如果没有conn错误，则执行事务提交
			
			
			
		End If
		
		Rs.Close
		Response.Write "<script language=javascript>document.location='Companyall.asp';</script>"
		Response.End()
	Case Else
	    IsHome=1
		Act="add"
		TT="添加"
		catetype=1
End Select
IsHome=strToNum(IsHome)
%>
<script language="javascript" src="../../fiveinc/pinyin.js"></script>

<script language="JavaScript" type="text/javascript">
<!--
function CheckForm()
{

	if (document.myform.ComName.value=="")
	{
		alert("项目名称不能为空！");
		document.myform.ComName.focus();
		return false;
	}

	if (document.myform.IsOutLink[0].checked==true)
	{
		if (document.myform.OutLinkUrl.value=="")
		{
			alert("请输入链接地址！");
			document.myform.OutLinkUrl.focus();
			return false;
		}
	}
}

function Pinyin(en,id){id.value=getSpell(en,"");}

-->
</script>
<form id="myform" name="myform" method="post" action="CompanyAdd.asp" onSubmit="return CheckForm();">
  <table width="100%" border="0" align="center" cellpadding="3" cellspacing="1" class="table_southidc">
    <tr>
      <td colspan="2" align="center"><a href="companyall.asp"><span class="blod"><%=TT%>项目</span></a></td>
    </tr>
    <tr>
      <td align="right" class="tr_southidc">所属栏目：</td>
      <td class="tr_southidc"><select name="followid">
          <option value="0">作为根目录</option>
          <%

set rs=server.CreateObject("adodb.recordset")
			rs.open "select cateid,catename,followid,depth,sonid,parentid,orderID from category where catetype<=3 order by depth,orderID",conn,1,1
			if not rs.eof then
				data= rs.getRows()
			end if
			rs.close
			
	class_list=""
	
	
sub classlist(byval t0)
		dim i
		for i=0 to ubound(data,2)
			if t0=data(2,i) then
				if followid = data(0,i) then
					 isslected="selected"
				else
					isslected=""
				end if
				class_list=class_list&"<option value="""&data(0,i)&""" "&isslected&">"

For k=2 To data(3,i)
class_list=class_list&"&nbsp;&nbsp;&nbsp;&nbsp;"
next

If data(3,i)>1 then class_list=class_list& "├"
				class_list=class_list& data(1,i)&"</option>"
				
				classlist(data(0,i))
			end if
		next
	end sub
	if isarray(data) then	
		call classlist(0)	
	end if	
		response.write class_list
		  %>
        </select></td>
    </tr>
    <tr>
      <td width="20%" align="right" class="tr_southidc">项目名称：</td>
      <td width="62%" class="tr_southidc"><input name="ComName" type="text" id="ComName" value="<%=ComName%>" onBlur="Pinyin(this.value,this.form.catedir)"/></td>
    </tr>
    <tr>
      <td width="20%" align="right" class="tr_southidc">英文名称：</td>
      <td width="62%" class="tr_southidc"><input name="catename_en" type="text" id="catename_en" value="<%=catename_en%>" /></td>
    </tr>
    
    <tr>
      <td width="20%" align="right" class="tr_southidc">文件目录：</td>
      <td width="62%" class="tr_southidc"><input name="catedir" type="text" id="catedir" value="<%=catedir%>" /> * 默认汉语拼音，所有栏目不能有重复，设置后不可修改</td>
    </tr>
    
    <tr>
      <td align="right" class="tr_southidc">栏目类型： </td>
      <td class="tr_southidc"><input type="radio" name="catetype" onClick="LinkUrl.style.display='none'" value="1" <%IF catetype=1 Then Response.Write "checked=""checked"""%> />
        栏目(列表)
        &nbsp;&nbsp;<input type="radio" name="catetype" onClick="LinkUrl.style.display='none'" value="0" <%IF catetype=0 Then Response.Write "checked=""checked"""%> />
        栏目(内容)
        &nbsp;&nbsp;
        <input type="radio" name="catetype" onClick="LinkUrl.style.display='none'" value="2" <%IF catetype=2 Then Response.Write "checked=""checked"""%> />
        单页&nbsp;&nbsp;
        <input type="radio" name="catetype" onClick="LinkUrl.style.display=''" value="3" <%IF catetype=3 Then Response.Write "checked=""checked"""%> />
        链接 </td>
    </tr>
    <tr>
      <td align="right" class="tr_southidc">栏目模型： </td>
      <td class="tr_southidc"><select name="modeltype" id="modeltype">
       
          <option value="0" <%if modeltype=0 then response.write "selected"%>>文字信息列表</option>
         <option value="1" <%if modeltype=1 then response.write "selected"%>>图片信息列表</option>                 
          <option value="2" <%if modeltype=2 then response.write "selected"%>>成长足迹列表</option>        

        </select></td>
    </tr>
    <tr id="LinkUrl" <%if catetype<>3 then%>style="display:none;"<%end if%>>
      <td align="right" class="tr_southidc">链接地址： </td>
      <td class="tr_southidc"><div style="float:left;">
        <input name="OutLinkUrl" type="text" id="OutLinkUrl" value="<%=OutLinkUrl%>" /></td>
    </tr>
    <tr>
      <td align="right" class="tr_southidc">菜单显示： </td>
      <td class="tr_southidc"><input name="IsHome" type="radio" value="1" <%IF IsHome=1 Then Response.Write "checked=""checked"""%> />
        是
        &nbsp;&nbsp;
        <input type="radio" name="IsHome" value="0" <%IF IsHome=0 Then Response.Write "checked=""checked"""%> />
        否 </td>
    </tr>
    <tr>
     <td align="right" class="tr_southidc">项目图片： </td>
      <td class="tr_southidc">
     <input name="DefaultPicUrl" type="text" id="DefaultPicUrl" value="<%=DefaultPicUrl%>" size="30" maxlength="120" />
    <input name="Submit222" type="button" value="上传图片"  onClick="window.open('../../FiveInc/mx_upload_flash.asp?formname=myform&editname=DefaultPicUrl&uppath=company&filelx=jpg','','status=no,scrollbars=no,top=300,left=200,width=420,height=136')">
    </td>
    </tr>
    <tr>
      <td align="right" class="tr_southidc">排序： </td>
      <td class="tr_southidc"><input name="OrderID" type="text" id="OrderID" value="<%=OrderID%>" size="5" maxlength="100" />
        <input name="Act" type="hidden" id="Act" value="<%=Act%>" />
        <input name="ID" type="hidden" id="ID" value="<%=ID%>"></td>
    </tr>
    <tr>
      <td align="center" class="tr_southidc">&nbsp;</td>
      <td align="left" class="tr_southidc">&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="submit" name="Submit" value="确认<%=TT%>" />
        &nbsp;
        <input type="button" name="Submit2" value="返回上一页" onClick="history.go(-1);" /></td>
    </tr>
  </table>
</form>

<%set rsClass1=nothing
set rs=nothing
set rsClass2=nothing
%>
<!-- #include file="../Inc/Foot.asp" -->