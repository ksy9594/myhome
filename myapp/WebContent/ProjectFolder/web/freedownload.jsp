<%@ page contentType="text/html; charset=UTF-8" %>
<jsp:useBean id="Mgr" class="project.freeboardMgr" />
<%
	  Mgr.downLoad(request, response,out, pageContext);
%>