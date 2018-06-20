<%@ page contentType="text/html; charset=UTF-8" %>
<% 
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="mgr" class = "project.Imgloadmgr"/>

<%
	mgr.insertBoard(request);
%>
<script>
location.href("board.jsp").reload();
</script>
<%
	response.sendRedirect("board.jsp");
%>