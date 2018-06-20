<%@ page contentType="application;charset=euc-kr"%>
<jsp:useBean id="Mgr" class="project.Imgloadmgr" />
<%
	  Mgr.downLoad(request, response,out, pageContext);
%>