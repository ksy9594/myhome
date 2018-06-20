<%@ page contentType="text/html; charset=UTF-8" %><!-- 자유게시판 읽기 -->
<%@page import="project.freeboardBean"%>
<%@page import="project.CommentBean"%>
<%@ page import="java.util.Vector" %>
<% 
	request.setCharacterEncoding("UTF-8");
	
%>
<!DOCTYPE html>
<html>
<head>
<%@page import="project.freeboardBean"%>
<jsp:useBean id="bMgr" class="project.freeboardMgr" />
<jsp:useBean id="cmgr" class="project.CommentMgr"/>

<%
	  request.setCharacterEncoding("UTF-8");
	  int num = Integer.parseInt(request.getParameter("num"));
	  String nowPage = request.getParameter("nowPage");
	  String keyField = request.getParameter("keyField");
	  String keyWord = request.getParameter("keyWord");
	  
	  
	  //댓글 입력 및 삭제, 게시물 읽기
	  if(request.getParameter("flag") != null)
	  {
		  if(request.getParameter("flag").equals("insert"))
		  {
			  CommentBean cbean = new CommentBean();
			  cbean.setNum(num);
			  cbean.setName(request.getParameter("cName"));
			  cbean.setComment(request.getParameter("comment"));
			  cmgr.insertComment(cbean);
		  }
		  else if(request.getParameter("flag").equals("del"))
		  {
			  int cnum = Integer.parseInt(request.getParameter("cnum"));
			  cmgr.deleteComment(cnum);
		  }
		  else
		  {
			  bMgr.upCount(num);//조회수 증가
		  }
	  }
	  Vector<CommentBean> cvlist = cmgr.getComment(num);
	  
	  //bMgr.upCount(num); //조회수 증가
	  freeboardBean bean = bMgr.getBoard(num);//게시물 가져오기
	  String name = bean.getName();
	  
	  String subject = bean.getSubject();
      String regdate = bean.getRegdate();
	  String content = bean.getContent();
	  String filename = bean.getFilename();
	  int filesize = bean.getFilesize();
	  String ip = bean.getIp();
	  int count = bean.getCount();
	  session.setAttribute("bean", bean);//게시물을 세션에 저장
	  
	  Cookie[] cookies3 = request.getCookies();
	  Cookie Cookieview3 = null;
	  
	  if(cookies3 != null && cookies3.length >0) //쿠기가 존재여부 체크
	  {
		  for(int i = 0; i <cookies3.length; i++)
		  {
			  if(cookies3[i].getName().equals("Cookieview3")) //쿠키가 같냐 안같냐 체크
			  {
				  Cookieview3 = cookies3[i]; //같으면 변수에 값을 입력
			  }				  
		  }
	  }
	 
	 if(Cookieview3 == null)
	 {
		 System.out.println("쿠키없음");
		 Cookie newCookie = new Cookie("Cookieview3","|"+num+"|");
		 response.addCookie(newCookie);		 
	 }
	 else
	 {
		 System.out.println("쿠키있음");
		 String value = Cookieview3.getValue();
		 
		 if(value.indexOf("|"+num+"|") <0)
		 {
			 value = value+"|"+num+"|";
			 Cookieview3.setValue(value);
			 response.addCookie(Cookieview3);
			 System.out.println(Cookieview3.getValue());
			 
			 bMgr.upCount(num);
		 }		 
	 }
	 
%>

<title>건의게시판</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<script type="text/javascript">
	
	function list() //리스트로 돌아가기
	{
	 	document.listFrm.action="freeboard.jsp";
	    document.listFrm.submit();
	} 
	function down(filename) //파일 다운
	{
		 document.downFrm.filename.value=filename;
		 document.downFrm.submit();
	}
	function cDel(cnum) //코멘트 삭제
	{
		document.cFrm.cnum.value=cnum;
		document.cFrm.submit();
	}
	function cInsert() //코멘트 입력
	{
		if(document.insFrm.comment.value=="")
		{
			alert("댓글을 입력하세요.");
			document.insFrm.comment.focus();
			return;
		}
		document.insFrm.submit();
	}
</script>
</head>
<body>
<style>
a#address:hover
{
	text-decoration : underline;
}
#m-info
{
	display : none;
}
@media only screen and (max-width:480px) and (min-width:320px)
{
	body
	{
		margin : 0px;
		padding : 0px;
	}
	tbody
	{
		width : 360px;
	}
	table
	{
		width : 360px;
		margin : 0px;
		padding : 0px;
	}
	#m-comment
	{
		width : 200px;
		height : 100px;
		padding : 20px;
		margin : 10px;
	}
	div
	{
		float : left;
		width : 360px;
		margin : 0px;
		padding : 0px;
	}
	a#address
	{
		width : 360px;
		font-size : 10px;
	}
	#m-ip-cnt
	{
		float :left;
		width : 20px;
		white-space : nowrap;		
	}
	img
	{
		width : 300px;
		height : 70%;
	}
	#info
	{
		display : none;
	}
	#m-info
	{
		display : block;
		width : 360px;
		margin : 0px;
		padding : 0px;
	}
	#m-tdname, #m-tdsubject
	{
		width : 360px;
	}
	td #m-tdcell
	{
		width : 360px;
	}
	#m-cregdate
	{
		float : left;
		width : 100px;
	}
	td #comment
	{
		width : 140px;		
	}
}
</style>
<br/><br/>
<table align="center" width="70%" border=0 cellspacing="3" cellpadding="0">
 <tr>
  <td bgcolor="#9CA2EE" height="25" align="center" id="m-tdcell">글읽기</td>
 </tr>
 <tr>
  <td colspan="2">
   <table border="0" cellpadding="3" cellspacing="0" width=100%> 
 <tr> 
	  <td align="center" bgcolor="#DDDDDD" width="10%" id="m-tdname"> 이 름 </td>
	  <td bgcolor="#FFFFE8" id="info"><%=name%></td>
	  <td align="center" bgcolor="#DDDDDD" width=10% id="info"> 등록날짜 </td>
	  <td bgcolor="#FFFFE8" id="info"><%=regdate%></td>
 </tr>
 <tr>
 	<td bgcolor="#FFFFE8" id="m-info"><%=name%></td>
 		
 </tr>
 <tr>
 	<td align="center" bgcolor="#DDDDDD" width=10% id="m-info">등록날짜 </td>
	<td bgcolor="#FFFFE8" id="m-info"><%=regdate%></td>
 </tr>
 
 <tr>
    <td align="center" bgcolor="#DDDDDD" id="m-tdsubject"> 제 목</td>
    <td bgcolor="#FFFFE8" colspan="3" id="info"><%=subject%></td>
 </tr>
 <tr>
 	<td bgcolor="#FFFFE8" colspan="3" id="m-info"><%=subject%></td>
 </tr>
 
   <tr> 
     <td align="center" bgcolor="#DDDDDD">첨부파일</td>
     <td bgcolor="#FFFFE8" colspan="3" id="info">
     <% if( filename !=null && !filename.equals("")) {%>
  		<a href="javascript:down('<%=filename%>')" style = "text-decoration:none; color:black;"><%=filename%></a>
  		<font color="blue">(<%=filesize%>KBytes)</font>  
  		 <%} else{%> 등록된 파일이 없습니다.<%}%>
     </td>
   </tr>
   <tr>
   	<td bgcolor="#FFFFE8" colspan="3" id="m-info">
     <% if( filename !=null && !filename.equals("")) {%>
  		<a href="javascript:down('<%=filename%>')" style = "text-decoration:none; color:black;"><%=filename%></a>
  		<font color="blue">(<%=filesize%>KBytes)</font>  
  		 <%} else{%> 등록된 파일이 없습니다.<%}%>
     </td>
   
   </tr>
   <tr> 
    <td colspan="4"><br/>
    <pre>    
    <%=content%>
    </pre><br/></td>
   </tr>
   <tr>
    <td colspan="4" align="right" id="m-ip-cnt">
     <%=ip%>로 부터 글을 남기셨습니다.<br>
              조회수 <%=count%>
    </td>
   </tr>
   </table>
  </td>
 </tr>
 <tr>
  <td align="center" colspan="2"> 
 <hr/>
 
 <!-- 댓글리스트 -->
  <div align="right">주소 복사 :<a id = "address" href = "javascript:current();" style = "text-decoration:none;">
  <script>
  document.write(location.href);
  </script>
  </a></div>
  <hr/>
  <%
  		if(!cvlist.isEmpty())
  		{
  %>
  <table align=center width=70% border=0 cellspacing=5 cellpadding=2>
  	<%
  			for(int i=0;i<cvlist.size();i++)
  			{
  				CommentBean cbean = cvlist.get(i);
  				String cname = cbean.getName();
  				String comment = cbean.getComment();
  				String cregdate = cbean.getRegdate();
  				int cnum = cbean.getCnum();
  	%>
  			<tr>
  				<td colspan="3"><b><%=cname%></b></td>
  			</tr>
  			<tr>
  				<td align = "center" colspan ="2" id="comment"><%=comment%></td>
  				<td align="right" id="m-cregdate"><%=cregdate%></td>
  				<td align="center" valign="middle">
  					<input type="button" value="삭제" 
  					onclick="cDel('<%=cnum%>')">
  				</td>
  			</tr>
  			<tr>
  				<td colspan="3"><hr/></td>
  			</tr>
  	<%}//for%>
  </table>
  <%}//if%>
  <!-- 댓글폼 -->
  <form method="post" name="insFrm">
		<table width=70% border=0 cellspacing=3 cellpadding=0>
			<tr>
				<td width=10%>이름</td>
				<td width=90%>
					<input name="cName" size="10" maxlength=30>
				</td>
			</tr>
			<tr>
				<td>내 용</td>
				<td width=90%>
				<input name="comment" size="50" id="m-comment"> 
				<input type="button" value="등록" onclick="cInsert()"></td>
			</tr>
		</table>
	<input type="hidden" name="flag" value="insert">	
	<input type="hidden" name="num" value="<%=num%>">
    <input type="hidden" name="nowPage" value="<%=nowPage%>">
   <%if(!(keyWord==null||keyWord.equals(""))){ %>
    <input type="hidden" name="keyField" value="<%=keyField%>">
    <input type="hidden" name="keyWord" value="<%=keyWord%>">
	<%} %>
</form>
 
 [ <a href="javascript:list()" style = "text-decoration:none; color:black;" hover:text-decoration:underline>리스트</a> | 
 <a href="freeupdatepwd.jsp?nowPage=<%=nowPage%>&num=<%=num%>" style = "text-decoration:none; color:black;">수 정</a> |
 <a href="freedelete.jsp?nowPage=<%=nowPage%>&num=<%=num%>" style = "text-decoration:none; color:black;">삭 제</a> ]<br>
  </td>
 </tr>
</table>

<form name="downFrm" action="download.jsp" method="post">
	<input type="hidden" name="filename">
</form>

<form name="listFrm" method="post">
	<input type="hidden" name="num" value="<%=num%>">
	<input type="hidden" name="nowPage" value="<%=nowPage%>">
	<%if(!(keyWord==null || keyWord.equals("null"))){ %>
	<input type="hidden" name="keyField" value="<%=keyField%>">
	<input type="hidden" name="keyWord" value="<%=keyWord%>">
	<%}%>
</form>

<form name="cFrm" method="post">
	<input type="hidden" name="flag" value="del">
	<input type="hidden" name="cnum">
	<input type="hidden" name="num" value="<%=num%>">
	<input type="hidden" name="nowPage" value="<%=nowPage%>">
	<%if(!(keyWord==null||keyWord.equals(""))){ %>
	<input type="hidden" name="keyWord" value="<%=keyWord%>">
	<input type="hidden" name="keyField" value="<%=keyField%>">
	<%} %>
</form>
<script>
function current()
{
	location.href();
}
</script>
</body>
</html>