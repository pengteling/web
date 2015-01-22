<!--#include file="bit.asp"-->
<%
dim my_sonid '该管理员拥有权限的所有子栏目
dim groupid '该管理员所属管理组
dim sql_sonid ' 针对 my_sonid的权限 如果是超级管理员 则该语句为空

sub p_page '检查页面权限
purl = lcase(GetLocationURL())

start1 = instr(purl,"/admin/")+7
purl = mid(purl,start1,len(purl)-start1+1)
'response.write purl

'页面权限。。。。。
rs.open "select * from zh_admin where id="&session("AdminID"),conn,1,1
if not rs.eof then
	groupid=rs("groupid")
end if
rs.close

if groupid=2 then
	'超级管理员不用了
	sql_sonid=" "
else
	rs.open "select sonid from zh_adminGroup where id="&groupid
	if not rs.eof then
		my_sonid =rs(0)
		sql_sonid=" and cateid in ("&my_sonid&")"
	end if
	rs.close
	
	rs.open "select * from catepage where outlinkurl='"&purl&"'",conn,1,1
	if not rs.eof then
		pageid=rs("cateid")
	end if
	rs.close
	
	'response.write "select [level] from zh_admingroupPrivileges where groupid="&groupid&" and cateid="&pageid&" and ptype=2"
	'如果页面在 页面表里面 查权限
	if pageid<>"" and isnumeric(groupid) then
		rs.open "select [level] from zh_admingroupPrivileges where groupid="&groupid&" and cateid="&pageid&" and ptype=2",conn,1,1
		if not rs.eof then
		  if clng(rs(0))=0 then
			  wrongMsg("对不起，您没有该页面的操作权限！")	
		  end if
		
		else
		wrongMsg("对不起，您没有该页面的操作权限！")
		
		end if
		rs.close
	end if
end if

if my_sonid ="" then my_sonid =0



end sub



sub p_cate(cateid_p,c_level) 'cateid_p 要检查权限的栏目  c_level 检查的权限 1,2,4,8....

if groupid<>2 then
'查栏目的操作权限
	if cateid_p <>"" and isnumeric(groupid) then
		rs.open "select [level] from zh_admingroupPrivileges where groupid="&groupid&" and cateid="&cateid_p&" and ptype=1",conn,1,1
		if not rs.eof then
			cate_p_level =clng(rs(0))
			'response.write cate_p_level
			if BitAnd(cate_p_level , c_level) <> c_level then
				wrongMsg("对不起，您没有操作该栏目的权限！")
			end if			
			
	
		else
		wrongMsg("对不起，您没有操作该栏目的权限！")
		
		end if
		rs.close
	end if
end if	
end sub

call p_page()
%>