<%@ page contentType="text/html;charset=UTF-8" %>
<%request.setCharacterEncoding("UTF-8");%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String nowPage = request.getParameter("nowPage");
%>
<html>
<head>
<title>유저게시판</title>
<link href="../style.css" rel="stylesheet" type="text/css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<script type="text/javascript">
function check() 
{
   if (document.pwdFrm.pass.value == "") 
   {
	 alert("수정을 위해 패스워드를 입력하세요.");
	 document.pwdFrm.pass.focus();
	 return false;
	}
   document.pwdFrm.submit();
}
</script>
</head>

<body topmargin="100">

	<table width="75%" align="center">
	<tr>  
	<td height="190">
	
		<form name="pwdFrm" method="post" action="freeAdminLoginProc.jsp">
		<table width="50%" border="1" align="center">
		
		<tr> 
		<td colspan="2" align="center">비밀번호를 입력하세요.</td>
		</tr>
		
		<tr align="center"> 
		<td>Password</td>
		<td><input type="password" name="pass"></td>
		</tr>
		
		<tr> 
		<td colspan="2" align="center"><input type="submit" value="입력" onClick="check()">
		<input type="reset" value="초기화">
		</td>
		</tr>
		
		</table>
		<input type="hidden" name="num" value="<%=num%>">
		<input type="hidden" name="nowPage" value="<%=nowPage%>">
		
		</form>	
	</td>
	</tr>
	</table>
</body>
</html>