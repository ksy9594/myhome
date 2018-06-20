<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="project.boardBean"%>
<jsp:useBean id="bMgr" class="project.Imgloadmgr" />
<% 
	request.setCharacterEncoding("UTF-8");
	int num = Integer.parseInt(request.getParameter("num"));
	String nowPage = request.getParameter("nowPage");
	
	Cookie[] cookies2 = request.getCookies();
	Cookie Cookieview2 = null;
	
	if(cookies2 != null && cookies2.length >0) //쿠기가 존재여부 체크
	{
		  for(int i = 0; i <cookies2.length; i++)
		  {
			  if(cookies2[i].getName().equals("Cookieview2")) //쿠키가 같냐 안같냐 체크
			  {
				  Cookieview2 = cookies2[i]; //같으면 변수에 값을 입력
			  }				  
		  }
	}
	
	if(Cookieview2 == null)
	{
		 System.out.println("추천쿠키없음");
		 Cookie newCookie = new Cookie("Cookieview2","|"+num+"|");
		 response.addCookie(newCookie);		 
	}
	else
	{
		 System.out.println("추천쿠키있음");
		 String value = Cookieview2.getValue();
		 
		 if(value.indexOf("|"+num+"|") <0)
		 {
			 value = value+"|"+num+"|";
			 Cookieview2.setValue(value);
			 response.addCookie(Cookieview2);
			 System.out.println(Cookieview2.getValue());
			 bMgr.UpRecommand(num);	 
%>
			<script>
			alert("추천했습니다!!");
			location.href = "read.jsp?nowPage=<%=nowPage%>&num=<%=num%>";
			</script>			 
<% 			 
		 }
		 else
		 {
%>			 
			<script>
			alert("이미추천했습니다.");
			location.href = "read.jsp?nowPage=<%=nowPage%>&num=<%=num%>";
			</script>
<%
		 }		 
	}
%>






