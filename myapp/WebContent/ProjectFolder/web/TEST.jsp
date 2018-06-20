<%@ page contentType="text/html; charset=EUC-KR" %>
<% 
	request.setCharacterEncoding("EUC-KR");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
   		Cookie[] cookies = request.getCookies();
	  
	  if(cookies != null)
	  {
		  for(int i = 0; i<cookies.length; ++i)
		  {
			  
		
   %>
   	Cookie Value : <%=cookies[i].getName()%>
   <%
		  }
	  }
   %>  

</body>
</html>