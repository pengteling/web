<div class="lmenu product">

<div class="subtitle"><%=catename_d1%></div>

 <ul>
 
 <%		
		rs.open "Select cateid,catename,catename_en,catetype,outlinkurl,modeltype,catedir,dirpath,sonid from category  where followid="&cateId_d1&" and ishome=true order by orderid ",conn,1,1
		k=0
		while not rs.eof 
		k=k+1
		if k= rs.recordcount then
		 response.write "<li class="" q-cnclast"
		else
		response.write "<li  class="""
		end if
		if cateId_d2=cint(rs("cateid")) then
				response.write " select"""
		else
			response.write """"
			end if
		response.write "><a href="""&companyURL(rs("cateid"),rs("catetype"),rs("outlinkurl"),rs("modeltype"),rs("dirpath"),supportHtml)&""""
		
			if len(rs("catename"))<11 then
			 response.write "class=""oneline"""
			 end if
		response.write "><span class=""lmenu-ico""></span><span class=""zh"">"&rs("catename")&"</span></a></li>"
		
		if instr(rs("sonid"),",")>0 then
		response.write "<ul class=""sub-ul"">"
		'response.write "┠"
		set rs2=server.CreateObject("adodb.recordset")
		rs2.open "select * from category where followid="&rs("cateid")&" and depth=3 and ishome=true order by orderid",conn,1,1
		while not rs2.eof
		if rs2("cateid")=cateid_d3 then
		response.write "<li class=""select"">"
		else
		response.write "<li>"
		end if
		response.write "<a href="""&companyURL(rs2("cateid"),rs2("catetype"),rs2("outlinkurl"),rs2("modeltype"),rs2("dirpath"),supportHtml)&""">┠"&rs2("catename")&"</a></li>"
		rs2.movenext
		wend
		rs2.close
		
		response.write  "</ul>"
		end if
		
		rs.movenext
		wend
		rs.close
		
	 
	%>
    
 
 
 </ul>

 </div>
 