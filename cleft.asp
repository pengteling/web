<div class="lmenu">
  <div class="subnav">
    <div class="subnav-d1"> <a href="<%=companyurl_db(cateid_d1)%>"><%=catename_d1%></a> </div>
    <ul>
      <%		
		set rs3=server.CreateObject("adodb.recordset")
		set rs4=server.CreateObject("adodb.recordset")
		set rs5=server.CreateObject("adodb.recordset")
		rs.open "Select cateid,catename,catename_en,catetype,outlinkurl,modeltype,catedir,dirpath,sonid from category_c  where followid="&cateid_d1&" order by orderid ",conn,1,1
		k=0
		while not rs.eof 
		sonid_2=""
		k=k+1
		if k= rs.recordcount then
		 response.write "<li class="" q-cnclast"
		else
		response.write "<li  class="""
		end if
		if cateId_d2=cint(rs("cateid")) then
				response.write " select"""
				sonid_2 = rs("sonid")
		else
			response.write """"
			end if
		response.write "><a href="""&companyURL(rs("cateid"),rs("catetype"),rs("outlinkurl"),rs("modeltype"),rs("dirpath"),supportHtml)&""""
		
			
		response.write ">"&rs("catename")&"</a></li>"
		
		if instr(sonid_2,",")>0 then
			rs3.open "select * from category_c where followid="&rs("cateid")&" order by orderid ",conn,1,1
			while not rs3.eof 
			sonid_3 =""
			response.write "<li  class=""subnav-d3"
			if cateId_d3=cint(rs3("cateid")) then
				response.write " select"""
				sonid_3 = rs3("sonid")
			else
			response.write """"
			end if
		response.write "><a href="""&companyURL(rs3("cateid"),rs3("catetype"),rs3("outlinkurl"),rs3("modeltype"),rs3("dirpath"),supportHtml)&""""
		
			
		response.write ">"&rs3("catename")&"</a></li>"
		
						if instr(sonid_3,",")>0 then
							rs4.open "select * from category_c where followid="&rs3("cateid")&" order by orderid ",conn,1,1
							while not rs4.eof 
							sonid_4 =""
							response.write "<li  class=""subnav-d4"
							if cateId_d4=cint(rs4("cateid")) then
								response.write " select"""
								sonid_4 = rs3("sonid")
							else
							response.write """"
							end if
						response.write "><a href="""&companyURL(rs4("cateid"),rs4("catetype"),rs4("outlinkurl"),rs4("modeltype"),rs4("dirpath"),supportHtml)&""""
						
							
						response.write ">"&rs4("catename")&"</a></li>"
							if instr(sonid_4,",")>0 then
								rs5.open "select * from category_c where followid="&rs4("cateid")&" order by orderid ",conn,1,1
								while not rs5.eof 
								sonid_5 =""
								response.write "<li  class=""subnav-d5"
								if cateId_d5=cint(rs5("cateid")) then
									response.write " select"""
									sonid_5 = rs5("sonid")
								else
								response.write """"
								end if
							response.write "><a href="""&companyURL(rs5("cateid"),rs5("catetype"),rs5("outlinkurl"),rs5("modeltype"),rs5("dirpath"),supportHtml)&""""
							
								
							response.write ">"&rs5("catename")&"</a></li>"
							
								rs5.movenext
								wend
								rs5.close
							
							end if
						
							rs4.movenext
							wend
							rs4.close
						
						end if
		
			rs3.movenext
			wend
			rs3.close
			
			response.write "<div class=""sub-line""></div>"
		
		end if
		
		rs.movenext
		wend
		rs.close
		
	 
	%>
    </ul>
  </div>
</div>
