<!--#include virtual="/fiveinc/conn.asp"-->
<%

dim act:act=lcase(Easp.var("act"))
dim formvalue:formvalue=Easp.var("formvalue")
dim checkvalue:checkvalue=Easp.var("checkvalue")  '判断值  用于两个密码检测



errcode="0<img src=""/images/err.gif"" /> "


succcode="1<img src=""/images/ok_min.gif"" />"

select case act

	case "username"
		if len(formvalue)>=5 and len(formvalue)<=20 then
			set rs = Easp.Db.Sel("select * from [user] where username={formvalue}")				
			if rs.eof and rs.bof then
				response.write succcode
			else
				response.write errcode&"用户名已经存在，请换一个试试"
			end if
			rs.close
			
		else
			response.write errcode&"由5-20位数字、字母、下划线组成"
		end if
		
		
	
		
	case "password"
		if len(formvalue)>=6 and len(formvalue)<=16 then
		
			response.write succcode
		else
			response.write errcode&"由6-16个数字、字母、下划线组成"
		end if
	case "repass"
		if formvalue=checkvalue then
		
			response.write succcode
		else
			response.write errcode&"两次输入的密码不一样"
		end if
	case "email"
		if IsValidEmail(formvalue) then
			response.write succcode
		else
			response.write errcode&"电子邮箱格式不正确"
		end if
	case "code"
		if formvalue=session("imgcode") then
			response.write succcode
		else
			response.write errcode&"验证码不正确"
		end if

end select


%>