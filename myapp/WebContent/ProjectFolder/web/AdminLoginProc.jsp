<%@ page contentType="text/html;charset=UTF-8" %>
<%request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="memMgr" class="project.Imgloadmgr" />
<jsp:useBean id="bean" class="project.boardBean" scope="session"/>
<jsp:useBean id="upBean" class ="project.boardBean"/>
<jsp:setProperty property="*" name="upBean"/>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String nowPage = request.getParameter("nowPage");

	//bean에 있는 pass와 upBean pass를 비교(read.jsp)
	String upPass = upBean.getPass(); //기존비번
	String inPass = bean.getPass(); //새로 입력한 비번
	String rtn = "updatepwd.jsp?nowPage="+nowPage+"&num="+upBean.getNum();

	if(upPass.equals(inPass))
	{
		String url = "update.jsp?nowPage="+nowPage+"&num="+upBean.getNum();
		response.sendRedirect(url);
%>

<%}
	else
{%>

   <script>
   alert("입력한 정보가 정확하지 않습니다.");
   location.href="<%=rtn%>";
   </script>

<%}%>