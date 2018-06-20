<%@ page contentType="text/html; charset=UTF-8" %><!-- 자유게시판 -->
<%@ page import="project.freeboardBean" %>
<%@ page import="java.util.Vector" %>
<jsp:useBean id="mgr" class="project.freeboardMgr" />
<% 
	request.setCharacterEncoding("UTF-8");
	int totalRecord = 0; //전체 레코드 수
	int numPerPage = 10; //페이지 당 레코드 수
	int pagePerBlock = 15;
	int totalPage = 0; //전체 페이지 수
	int totalBlock = 0; //전체 블락 수
	int nowPage = 1; //현재 페이지
	int nowBlock = 1; //현재 블럭
	int start = 1; //DB 시작번호
	int end = numPerPage; //시작번호로부터 가져올 select 수
	int listSize = 0; //현재 읽어온 게시물 숫자
	
	Vector<freeboardBean> vlist = null;
	String keyWord="", keyField="";
	
	totalRecord = mgr.getTotalCount(keyField, keyWord);
	totalPage = (int)Math.ceil((double)totalRecord/numPerPage);
	totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);
	nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);
	
	if(request.getParameter("keyWord")!=null) //검색일때
	{
		keyWord=request.getParameter("keyWord");
		keyField=request.getParameter("keyField");
	}
	if(request.getParameter("reload") != null &&
			request.getParameter("reload").equals("true"))
	{
		keyWord = "";
		keyField = "";	
	}
	
	if(request.getParameter("nowPage")!= null)
	{
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	
	start = (nowPage*numPerPage)-numPerPage;
	
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <!-- This file has been downloaded from Bootsnipp.com. Enjoy! -->
    <title>건의게시판</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link href= "css/board.css?ver=1" rel="stylesheet" type="text/css" media="all" />
    <link href="css/iconbar.css?ver=1" rel="stylesheet" type="text/css" media="all" />
    <link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
    <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
	
</head>
<body>
<script type="text/javascript">
	function list()
	{
		document.listFrm.action = "freeboard.jsp";
		document.listFrm.submit();
	}
	function pageing(page) 
	{
		document.readFrm.nowPage.value=page;
		document.readFrm.submit()
	}
	function block(block)
	{
		document.readFrm.nowPage.value
		=<%=pagePerBlock%>*(block-1)+1;
		document.readFrm.submit()
	}
	function read(num)
	{
		document.readFrm.num.value=num;
		document.readFrm.action="freeread.jsp";
		document.readFrm.submit();
	}
	function check() 
	{
		if(document.searchFrm.keyWord.value=="")
		{
			alert("검색어를 입력하세요.");
			document.searchFrm.keyWord.focus();
			return;
		}
		document.searchFrm.submit();
	}
</script>
<div class="container">
	<div class="row">
		<section class="content">
			<h1>건의 게시판</h1>
			<div class="col-md-8 col-md-offset-2">
				<div class="panel panel-default">
					<div class="panel-body">
						<div class="pull-right">
							<div class="btn-group">
								<a href="freewrite.jsp"><button type="button" class="btn btn-success btn-filter" data-target="pagado">글쓰기</button></a>
								<a href="main.html"><button type="button" class="btn btn-warning btn-filter" data-target="pendiente">홈으로</button></a>
								<!--<button type="button" class="btn btn-danger btn-filter" data-target="cancelado">Cancelado</button>
								<button type="button" class="btn btn-default btn-filter" data-target="all">Todos</button>-->
							</div>
						</div>
						<div class="table-container">
							<table class="table table-filter">
								<tbody>
								<%
									vlist = mgr.getBoardList(keyField, keyWord, start, end);
									listSize = vlist.size();
									
									for(int i = 0; i<numPerPage; i++)
									{
										if(i == listSize)
										{
											break;
										}
										freeboardBean bean = vlist.get(i);
										int num = bean.getNum(); //게시글번호
										String subject = bean.getSubject();//글제목
										String name = bean.getName();//작성자
										String content = bean.getContent(); //글내용
										String regdate = bean.getRegdate(); //작성 날짜
										String filename = bean.getFilename(); //사진이름
										int ref = bean.getRef(); //게시글 번호
										int count = bean.getCount(); //조회수
									%>
									<tr data-status="pagado"> <!--여기서부터가 게시판 셀 -->
										<td>
											<div>
												<span class="pull-right pagado" id ="boardnum">
												<%=totalRecord-((nowPage-1)*numPerPage)-i%></span>
											</div>
										</td>
										<td>
										</td>
										<td>
											<div class="media">
												<div class="media-body">
													<span class="media-meta pull-right"><%=regdate%></span>
													<h4 class="title">
														<a href = "javascript:read('<%=num%>')">
														<%=subject%>
														</a>
														<span class="pull-right pagado"><%=name%></span>
													</h4>
													<p class="summary"><%=content%></p>
												</div>
											</div>
										</td>
										<td>
											<div>
												<span class="pull-right pagado" id ="cnt"><%=count%></span>
											</div>
										</td>
									</tr><!--여기서까지가 게시판 셀 -->
									<%
									}
									%>									
								</tbody>
							</table>							
						</div>
						<div class="container">
							<ul class="pagination">
							<%
								int pageStart = (nowBlock-1)*pagePerBlock+1; //시작 페이지
								int pageEnd = ((pageStart+pagePerBlock)<totalPage)? //마지막 페이지
									(pageStart+pagePerBlock):totalPage+1;
								
									if(totalPage != 0)
									{
							%>
									<%if(nowBlock > 1){ %>
										<li class="disabled">
										<a href="javascript:block('<%=nowBlock-1%>')">«</a></li>
										<%}%>
									<%
										for(;pageStart<pageEnd;pageStart++)
										{
									%>
										<%if(nowPage == pageStart)
										{
										%>
											<li class="active">
											<a href="javascript:pageing('<%=pageStart %>')">
											<%=pageStart %>
											<span class="sr-only">(current)</span></a></li>
										<%
										} 
										else
										{
										%>
										<li><a href="javascript:pageing('<%=pageStart %>')">
										<%=pageStart%></a></li>
										<%
										} 
										%>
									<%
										}
									%>
									<%if(nowBlock<totalBlock){ %>
									<li><a href="javascript:block('<%=nowBlock+1%>')">
										»</a></li>
									<%}%>
									
									<%}%>
							</ul>
							<form  name="searchFrm"  method="post" action="freeboard.jsp">
								<table border="0" width="300px" align=left cellpadding="4" cellspacing="0">
							 		<tr>
							  			<td align="center" valign="bottom">
							   				<select name="keyField" size="1" >
							    				<option value="name"> 이 름</option>
							    				<option value="subject"> 제 목</option>
							    				<option value="content"> 내 용</option>
							   				</select>
							   				<input type="text" size="16" name="keyWord">
							   				<input type="button"  value="찾기" onClick="javascript:check()" class="btn btn-success btn-filter">
							   				<input type="hidden" name="nowPage" value="1">
							  			</td>
							 		</tr>
								</table>
							</form>
							
							<form name="listFrm" method="post">
							<input type="hidden" name="reload" value="true"> 
							<input type="hidden" name="nowPage" value="1">
							</form>
							<form name="readFrm" method="get">
								<input type="hidden" name="num"> 
								<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
								<input type="hidden" name="keyField" value="<%=keyField%>"> 
								<input type="hidden" name="keyWord" value="<%=keyWord%>">
							</form>
						</div>
					</div>
				</div>
				<div class="content-footer">
					<p>
						Page © - 2017 <br>
						Powered By <a href="#">ksy</a>
					</p>
				</div>
			</div>
		</section>
	</div>
</div>
</body>
</html>