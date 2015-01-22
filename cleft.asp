<div class="lmenu">



 <ul>
 <li>
 <a href="/">回到首页</a>
 </li>
 <%		
		rs.open "Select cateid,catename,catename_en,catetype,outlinkurl,modeltype,catedir,dirpath,sonid from category_c  where followid=0 order by orderid ",conn,1,1
		k=0
		while not rs.eof 
		k=k+1
		if k= rs.recordcount then
		 response.write "<li class="" q-cnclast"
		else
		response.write "<li  class="""
		end if
		if cateId_d1=cint(rs("cateid")) then
				response.write " select"""
		else
			response.write """"
			end if
		response.write "><a href="""&companyURL(rs("cateid"),rs("catetype"),rs("outlinkurl"),rs("modeltype"),rs("dirpath"),supportHtml)&""""
		
			
		response.write ">"&rs("catename")&"</a></li>"
		
		
		
		rs.movenext
		wend
		rs.close
		
	 
	%>
    
 
 
 </ul>

 </div>
 