<%@ page contentType="text/html; charset=UTF-8" %>
<% 
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="mgr" class = "project.freeboardMgr"/>

<%
	mgr.insertBoard(request);
%>
<script>
location.href("freeboard.jsp").reload();
</script>
<%
	response.sendRedirect("freeboard.jsp");
%>