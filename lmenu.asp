<%rs.open "select cateid,catename,outlinkurl,catetype,modeltype,catedir,sonid,defaultpicurl from category where cateid in("&parentid&") order by depth ",conn,1,1
k=1
menustr = "<a href=""/"">首页</a>"
while not rs.eof 

if k=1 then
	cateId_d1=rs("Cateid")
	catename_d1=rs("catename")
	catedir_d1=rs("catedir")
	sonid_d1 =rs("sonid")
	defaultpic_d1=rs("defaultpicurl")
end if
if k=2 then
cateId_d2 = rs("Cateid")
sonid_d2 =rs("sonid")
'if rs("defaultpicurl")<>"" then defaultpic_d1=rs("defaultpicurl")
end if

if k=3 then
cateId_d3 = rs("Cateid")
sonid_d3 =rs("sonid")
end if

if k=4 then
cateId_d4 = rs("Cateid")
sonid_d4 =rs("sonid")
end if

if k=5 then
cateId_d5 = rs("Cateid")
sonid_d5 =rs("sonid")
end if


if cateid=rs("cateid") then
menustr = menustr &" > <a href="""& companyURL(rs("cateid"),rs("catetype"),rs("outlinkurl"),rs("modeltype"),rs("catedir"),supportHtml)&""">"&rs("catename")&"</a>"
else
menustr = menustr &" > <a href="""& companyURL(rs("cateid"),rs("catetype"),rs("outlinkurl"),rs("modeltype"),rs("catedir"),supportHtml)&""">"&rs("catename")&"</a>"
end if
'menustr = menustr&" >> "&rs("catename")
k=k+1

rs.movenext
wend
rs.close


currentTitle=catename
curpageTitle= catename&"-"&SiteTitle
%>