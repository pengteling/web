 <div class="subnav">
        <%

rs.open "select * from category where followid="&cateid_d1&" order by depth, orderid",conn,1,1
while not rs.eof


if cateid=rs("cateid") then
response.write "<a href="""&companyURL(rs("cateid"),rs("catetype"),rs("outlinkurl"),rs("modeltype"),rs("dirpath"),supportHtml)&""" class=""menu_select"">"&rs("catename")&"</a>"
else
response.write "<a href="""&companyURL(rs("cateid"),rs("catetype"),rs("outlinkurl"),rs("modeltype"),rs("dirpath"),supportHtml)&""">"&rs("catename")&"</a>"
end if
rs.movenext
if not rs.eof then response.write "<span class=""splitline"">|</span>"
wend
rs.close
%>
      </div>