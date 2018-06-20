<%@ page contentType="text/html; charset=UTF-8" %>
<% 
	request.setCharacterEncoding("UTF-8");	
%>
<jsp:useBean id="mgr" class="project.freeboardMgr" />
<jsp:useBean id="upBean" class="project.freeboardBean"/>
<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%
	String SAVEFOLDER = "C:/Jsp/WebContent/ProjectFolder/web/fileuploadimg/";
	int MAXSIZE = 5*1024*1024;
	
	MultipartRequest mr = new MultipartRequest(request,
			SAVEFOLDER,
			MAXSIZE,
        "utf-8",
        new DefaultFileRenamePolicy());
	int num = Integer.parseInt(mr.getParameter("num"));
	
	 String uname=mr.getParameter("name");
	 String title=mr.getParameter("subject");
	 String content=mr.getParameter("content");
	 String filename = mr.getOriginalFileName("filename");
	 String flag = mr.getParameter("flag");
	 
	 out.print(uname+"<br/>");
	 out.print(title+"<br/>");
	 out.print(content+"<br/>"); 
	 
	
	  boolean result = false;
	  String msg = "Error!";
	  
	  
	if(flag.equals("freeupdate"))
	{
		mgr.updateboard(uname, title, content, filename, num);
		msg = "업데이트 되었습니다!!!!!!!!!!!";
		//String url = "read.jsp?nowPage="+nowPage+"&num="+upBean.getNum();
		//response.sendRedirect(url); 
	}
%>
<script>
	alert("<%=msg%>");
	location.href="freeboard.jsp?";
</script>