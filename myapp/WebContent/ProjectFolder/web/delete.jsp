<%@page import="project.boardBean"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
<%@page import="project.boardBean"%>
<jsp:useBean id="bMgr" class="project.Imgloadmgr" />
<%
	request.setCharacterEncoding("UTF-8");
	String nowPage = request.getParameter("nowPage");
	int num = Integer.parseInt(request.getParameter("num"));
	if (request.getParameter("pass") != null) 
	{
		//비번을 입력을 해서 세션에 있는 pass 비교요청
		String inPass = request.getParameter("pass");
		boardBean bean = (boardBean) session.getAttribute("bean");
		String dbPass = bean.getPass();
		
		if (inPass.equals(dbPass)) 
		{
			bMgr.deleteBoard(num);
			String url = "board.jsp?nowPage=" + nowPage;
			response.sendRedirect(url);
		} 
		else 
		{
%>
<script type="text/javascript">
	alert("입력하신 비밀번호가 아닙니다.");
	history.back();
</script>
<%}
	} 
	else 
	{
%>
<title>JSP Board</title>
<link href="style.css" rel="stylesheet" type="text/css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<script type="text/javascript">
	function check() 
	{
		if (document.delFrm.pass.value == "") 
		{
			alert("패스워드를 입력하세요.");
			document.delFrm.pass.focus();
			return false;
		}
		document.delFrm.submit();
	}
</script>
</head>
<body>
	<div align="center">
		<br/><br/>
		<table width="50%" cellspacing="0" cellpadding="3">
			<tr>
				<td bgcolor=#dddddd height="21" align="center">
					사용자의 비밀번호를 입력해주세요.
				</td>
			</tr>
		</table>
		<form name="delFrm" method="post" action="delete.jsp">
			<table width="70%" cellspacing="0" cellpadding="2">
				<tr>
					<td align="center">
						<table align="center" border="0" width=91%>
							<tr>
								<td align="center">
									<input type="password" name="pass" size="17" maxlength="15">
								</td>
							</tr>
							<tr>
								<td><hr size="1" color="#eeeeee"></td>
							</tr>
							<tr>
								<td align="center">
									<input type="button" value="삭제완료" onClick="check()"> 
									<input type="reset" value="다시쓰기">
									<input type="button" value="뒤로" onClick="history.go(-1)">
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
			<input type="hidden" name="num" value="<%=num%>">
		</form>
	</div>
	<%
	}
	%>
</body>
</html>