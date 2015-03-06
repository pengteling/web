<!--#include file="UpLoad_Class.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="css.css" rel="stylesheet" type="text/css">
<%
dim upload
set upload = new AnUpLoad
upload.Exe = "jpg|bmp|jpeg|gif|png|swf|doc|pdf|flv|f4v|docx|mp3|zip|rar|mp4"
upload.MaxSize = 100 * 1024 * 1024 '2M
upload.GetData()

	filepath=trim(upload.forms("filepath"))
		filelx=trim(upload.forms("filelx"))
		
		i=0
if upload.ErrorID>0 then 
	response.Write upload.Description
else
	dim savpath
	savepath = "../uploadfiles/"&upload.forms("filepath")
	for each f in upload.files(-1)
		dim file
		set file = upload.files(f)
		if not(file is nothing) then	
			result = file.saveToFile(savepath,-1,false)
			if result then

FileName="/uploadfiles/"&filepath&""&file.filename
  response.write "<script>window.opener.document."&upload.forms("FormName")&"."&upload.forms("EditName")&".value='"&FileName&"'</script>"
%>
<script>
		//window.opener.SetDropDownPic("<%=FileName%>")
</script>
<%	else
				response.Write file.Exception
			end if
		end if
		set file = nothing
	next
end if
set upload = nothing


		
 


%>
<script language="javascript">
window.close();
</script>
