<script language=javascript runat="server"> 
function BitAnd(val1,val2) 
{ 
return val1&val2; //按位与 
} 
function BitOr(val1,val2) 
{ 
return val1|val2; //按位或 
} 
function BitNot(val) 
{ 
return ~val; //按位取反 
} 
function BitXor(val1,val2) 
{ 
return val1^val2; //按位异或 
} 
function UBitRight(val,n) 
{ 
return val>>>n; //无符号右移 
} 
function BitLeft(val,n) 
{ 
return val<<n; //左移 
} 
function BitRight(val,n) 
{ 
return val>>n; //右移 
} 
</script>

