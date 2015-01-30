<script runat="server" type="text/javascript" language="jscript" src="json2.js">
</script>
<script runat="server" type="text/javascript" language="jscript">
function toObject(json) {
    eval("var o=" + json);
    return o;
}

function getItem(obj,Num){
return obj[Num];
}

function setItem(obj,pid,Num){
	obj[pid]=Num;
}
function toJSONstr(obj){
	return JSON.stringify(obj);
}


function viewObject(obj){  
var msg='';
for(var a in obj){  
msg += ', ' + a;
for(var x in obj[a]){
msg += ', ' + x;
msg += ', ' + obj[a][x];
}
}
return msg;
}



function Obj2str(o) {
                if (o == undefined) {
                    return "";
                }
                var r = [];
                if (typeof o == "string") return "\"" + o.replace(/([\"\\])/g, "\\$1").replace(/(\n)/g, "\\n").replace(/(\r)/g, "\\r").replace(/(\t)/g, "\\t") + "\"";
                if (typeof o == "object") {
                    if (!o.sort) {
                        for (var i in o)
                            r.push("\"" + i + "\":" + fn.Obj2str(o[i]));
                        if (!!document.all && !/^\n?function\s*toString\(\)\s*\{\n?\s*\[native code\]\n?\s*\}\n?\s*$/.test(o.toString)) {
                            r.push("toString:" + o.toString.toString());
                        }
                        r = "{" + r.join() + "}"
                    } else {
                        for (var i = 0; i < o.length; i++)
                            r.push(fn.Obj2str(o[i]))
                        r = "[" + r.join() + "]";
                    }
                    return r;
                }
                return o.toString().replace(/\"\:/g, '":""');
            }

</script>

<%
'{"productid1":3,"productid3":13}

function getCartStr()
	dim tempstr
	tempstr =trim(request.Cookies("AntCart"))
	tempstr=mid(tempstr,2,len(tempstr)-2)
	getCartStr=tempstr
end function

'CartStr=getCartStr()
'
'response.write CartStr


Sub CartAdd(ProductID,Num)
	CartStr=getCartStr()
	
	if CartStr="" then
		response.cookies("AntCart")="{"""&ProductID&""":"&Num&"}"
	else
		
	end if

end sub


Dim CartStr
'购物车相关函数
'黄杰 2007年1月23号
'购物车数据定义:  商品ID|数量#颜色*尺寸,商品ID|数量#颜色*尺寸,商品ID|数量#颜色*尺寸,商品ID|数量#颜色*尺寸



Sub CartEdit(ProductID,Num)
'编辑某种商品的数量
 CartStr = ","&Trim(Request.Cookies("SpiderCart"))
 if(InStr(CartStr,","&ProductID&"|") = 0) Then
  Alert("该商品刚刚卖完")
  CartDel(ProductID)
  Exit Sub
 end if
 
 Arr = Split(CartStr,","&ProductID&"|")
 CartStr = Arr(0) &"," &ProductID& "|" & Num & "#" & Right(Arr(1),Len(Arr(1)) - InStr(Arr(1),"#"))
 CartStr = Right(CartStr,Len(CartStr)-1)
 
 Response.Cookies("SpiderCart") = CartStr
End Sub

Sub CartClear
 Response.Cookies("SpiderCart") = ""
End Sub

Sub CartDel(ProductID)
'删除某种商品
 CartStr = Trim(Request.Cookies("SpiderCart"))
 if(CartStr = "") Then Exit Sub
 'Alert(CartStr)
 
 if( UBound(Split(CartStr,"|")) = 1 ) Then
  Response.Cookies("SpiderCart") = ""
  Exit Sub
 end if
 
 CartStr = "," & CartStr
 ArrCart = Split(CartStr,","&ProductID&"|")
 CartStr = ArrCart(0) & Right(ArrCart(1),Len(ArrCart(1))-InStr(ArrCart(1),"*"))
 CartStr = Right(CartStr,Len(CartStr) - 1)
 Response.Cookies("SpiderCart") = CartStr
End Sub

Function GetColorBYProductID(ProductID)
'返回商品的颜色
 CartStr = ","&Trim(Request.Cookies("SpiderCart"))
 
 ArrCart = Split(CartStr,","&ProductID&"|")
 ArrCart(1) = Right(ArrCart(1),Len(ArrCart(1)) - InStr(ArrCart(1),"#"))
 GetColorBYProductID = Left(ArrCart(1),InStr(ArrCart(1),"*")-1)
End Function

Function GetNumBYProductID(ProductID)
'返回商品的数量
 CartStr = ","&Trim(Request.Cookies("SpiderCart"))
 
 ArrCart = Split(CartStr,","&ProductID&"|")
 GetNumBYProductID = Left(ArrCart(1),InStr(ArrCart(1),"#")-1)
End Function

Function GetSizeBYProductID(ProductID)
'返回商品的尺寸
 CartStr = ","&Trim(Request.Cookies("SpiderCart"))
 
 'Response.Write(CartStr)
 'Response.End()
 
 ArrCart = Split(CartStr,","&ProductID&"|")
 ArrCart(1) = Right(ArrCart(1),Len(ArrCart(1)) - InStr(ArrCart(1),"*"))
 if(InStr(ArrCart(1),",") = 0) Then
  GetSizeBYProductID = ArrCart(1)
 else
  GetSizeBYProductID = Left(ArrCart(1),InStr(ArrCart(1),",")-1)
 end if
End Function

Function GetIDStr
'返回购物车中商品由ID组成的字符串
 CartStr = Trim(Request.Cookies("SpiderCart"))

 if(CartStr = "") Then GetIDStr = "":Exit Function

 if(InStr(CartStr,",") = 0 ) Then
  GetIDStr = Split(CartStr,"|")(0)
  Exit Function
 end if
 
 ArrCart = Split(CartStr,",")
 
 For i = 0 to Ubound(ArrCart)
  if ( i = 0 ) then
   GetIDStr = Split(ArrCart(i),"|")(0)
  else
   GetIDStr = GetIDStr & "," & Split(ArrCart(i),"|")(0)
  end if
 Next
End Function

Function isExistsInCart(ProductID)
'判断某个商品是否已经存在购物车中
 CartStr = Trim(Request.Cookies("SpiderCart"))
 
 if CartStr="" Then
  isExistsInCart = False
  Exit Function
 end if
 
 CartStr = "," & CartStr
 
 if Instr(CartStr,","& ProductID & "|") > 0 Then
  isExistsInCart = True
 Else
  isExistsInCart = False
 End if
End Function

Function GetCartCount
'计算购物车中商品数量
 CartStr = Trim(Request.Cookies("SpiderCart"))
 if CartStr = "" Then
  GetCartCount = 0 
  Exit Function
 end if
 
 GetCartCount = Ubound(Split(CartStr,"|"))
End Function

Function GetMoney
'计算购物车中商品总价格
 CartStr = Trim(Request.Cookies("SpiderCart"))
 if(CartStr = "") Then GetMoney = 0:Exit Function
 
 Dim m,TotalPrice
 Set m = Server.CreateObject("Adodb.RecordSet")

 if(InStr(CartStr,",") = 0 ) Then
  arr = Split(CartStr,"|")
  Sql = "Select NewPrice*"&Left(arr(1),InStr(arr(1),"#")-1)&" as TotalPrice from SP_Detail where id="&arr(0)
  m.Open Sql,Conn,1,3
  if(m.RecordCount > 0) Then 
   GetMoney =  m("TotalPrice")
   Exit Function
  else '该商品在购买后已经被删除
   CartDel(arr(0)) '清空商品
   GetMoney = 0
   m.Close
   Set m = Nothing
   Exit Function
  end if
  m.Close
 end if
 
 ArrCart = Split(CartStr,",")
 TotalPrice = 0
 
 'Response.Write(CartStr)
 'Response.End()
 
 For i = 0 to Ubound(ArrCart)
 arr = Split(ArrCart(i),"|")
  Sql = "Select NewPrice*"&Left(arr(1),InStr(arr(1),"#")-1)&" as TotalPrice from SP_Detail where id="&arr(0)
  m.Open Sql,Conn,1,3
  if(m.RecordCount > 0) Then 
   TotalPrice = TotalPrice +  m("TotalPrice") 'm.fields(0).value
  else '该商品在购买后已经被删除
   CartDel(arr(0)) '清空商品
  end if
  m.Close
 Next
 
 Set m = Nothing
 GetMoney = TotalPrice
End Function
%>