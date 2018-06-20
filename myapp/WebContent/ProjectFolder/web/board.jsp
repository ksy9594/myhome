<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="project.boardBean" %>
<%@ page import="java.util.Vector" %>
<jsp:useBean id="mgr" class="project.Imgloadmgr" />
<% 
	request.setCharacterEncoding("utf-8");
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
	
	Vector<boardBean> vlist = null;
	
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
    <title>유저 착샷</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link href= "css/board.css?ver=1" rel="stylesheet" type="text/css" media="all" />
    <link href="css/iconbar.css?ver=1" rel="stylesheet" type="text/css" media="all" />
    <link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
    <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
    
	<style>	
	    #preview
	    {
	       z-index: 9999;
	       position:absolute;
	       border:0px solid #ccc;
	       background:#333;
	       padding:1px;
	       display:none;
	       color:#fff;	       
	    }
	    /*** media***/
	@media only screen and (max-width:480px) and (min-width:320px)
	{
		.grid_3 
		{
			display: inline;
			float: left;
			margin-left: 10px;
			margin-right: 10px;
			width: 220px;
		}
		.fmcircle_in 
		{
			width: 35px;
			height: 35px;
			margin: 4px;
			display: inline-block;
			overflow: hidden;
			border-radius: 85px;
			-moz-border-radius: 85px;
			-webkit-border-radius: 85px;
			-o-border-radius: 85px;
		}
		.fmcircle_out 
		{
			width: 45px;
			height: 45px;
			background: rgba(221,221,221,0.3) url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAkAAAAJCAYAAADgkQYQAAAAO0lEQVQYV2NkIAIwElKze/fu/3gVgRS4uroyEjQJZBNWRTATYE7BUISuAKdJ6J6Bm4TNBBTr8CkAKQQA02QXOj4w/E8AAAAASUVORK5CYII=);
			text-align: center;
			display: block;
			margin-left: 0px;
			opacity: 0.5;	
					
			border-radius: 100px;
			-moz-border-radius: 100px;
			-webkit-border-radius: 100px;
			-o-border-radius: 100px;
					
			-webkit-transition: all 0.2s linear;
			-moz-transition: all 0.2s linear;
			-o-transition: all 0.2s linear;
			-ms-transition: all 0.2s linear;
			transition: all 0.2s linear;
		}
		#cntlist
		{
			display : none;
		}
	}
	</style>
        
</head>
<style type="text/css">
        .pagination>li>a, .pagination>li>span { border-radius: 50% !important;margin: 0 5px;}
               
</style>

<body>
<script type="text/javascript">
	function list()
	{
		document.listFrm.action = "board.jsp";
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
		document.readFrm.action="read.jsp";
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
	$("document").ready(function() 
	{  
		  
	    var currentPosition = parseInt($("#right_section").css("top"));  
	  
	    $(window).scroll(function() {  
	            var position = $(window).scrollTop(); // 현재 스크롤바의 위치값을 반환합니다.  
	            $("#right_section").stop().animate({"top":position+currentPosition+"px"},500);  
	    });
	    
	  //scroll the message box to the top offset of browser's scrool bar  
	    $(window).scroll(function()  
	    {  
	        $('#scroll').animate({top:$(window).scrollTop()+"px" },{queue: false, duration: 350});    
	    });  
	    //when the close button at right corner of the message box is clicked   
	    $('#scroll').click(function()  
	    {  
	        //the messagebox gets scrool down with top property and gets hidden with zero opacity   
	        $('#scroll').animate({ top:"+=15px",opacity:0 }, "slow");  
	    });  	      
	});
</script>

<div style="position:relative; float:left; width:80px;">
    <div id="" style="position:absolute; top:300px; left:100px;">
    <div class="grid_3">
			<div class="fmcircle_out">
				<a href="#web">
					<div class="fmcircle_border">
						<div class="fmcircle_in fmcircle_blue">
						</div>
					</div>
				</a>
			</div>
		</div>
        <table border = "0" cellpadding="5" cellspacing="2" width="150" id="cntlist">
        <tr>
        <td align = "center" style="color:red; font-size : 1.5em;">조회수  Top10</td>
        </tr>        
        <%
       		vlist = mgr.cntchart();
        
        	for(int i = 0; i < vlist.size(); i++)
        	{
        		boardBean bean = (boardBean)vlist.elementAt(i);
        		int num = bean.getNum();
        		
        		if(i == 10)
        		{
        			break;
        		}
        %>
               
        <tr>
        <td align = "left"><%=i+1%>.
        <a href = "javascript:read('<%=num%>')">
        <%=bean.getSubject()%></a>
        </td>
        </tr>
        
        <%
        	}
        %>
        <tr>
        <td align = "center" style="color:red; font-size : 1.5em;">추천수  Top10</td>
        </tr>
        <%
       		vlist = mgr.RecommandChart10();
        
        	for(int i = 0; i < vlist.size(); i++)
        	{
        		boardBean bean = (boardBean)vlist.elementAt(i);
        		int num = bean.getNum();
        		
        		if(i == 10)
        		{
        			break;
        		}
        %>
               
        <tr>
        <td align = "left"><%=i+1%>.
        <a href = "javascript:read('<%=num%>')">
        <%=bean.getSubject()%></a>
        </td>
        </tr>       
        <%
        	}
        %>
        </table>                    
	</div>
</div>
  
<div class="container">
	<div class="row">
		<section class="content">
			<h1>유저 착샷</h1>
			<div class="col-md-8 col-md-offset-2">
				<div class="panel panel-default">
					<div class="panel-body">
						<div class="pull-right">
							<div class="btn-group">										
								<a href="write.jsp"><button type="button" class="btn btn-success btn-filter">글쓰기</button></a>
								<a href="main.html"><button type="button" class="btn btn-warning btn-filter" data-target="pendiente">홈으로</button></a>			
								<!--<button type="button" class="btn btn-danger btn-filter" data-target="cancelado">Cancelado</button>
								<button type="button" class="btn btn-default btn-filter" data-target="all">Todos</button>-->
							</div>
						</div>
						<div>
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
										boardBean bean = vlist.get(i);
										int num = bean.getNum(); //게시글번호
										String subject = bean.getSubject();//글제목
										String name = bean.getName();//작성자
										String content = bean.getContent(); //글내용
										String regdate = bean.getRegdate(); //작성 날짜
										String filename = bean.getFilename(); //사진이름
										int ref = bean.getRef(); //게시글 번호
										int count = bean.getCount(); //조회수
										int recommand = bean.getRecommand(); //추천수
								%>
					
									<tr data-status="pagado"> <!--여기서부터가 게시판 셀 -->
										<td>
											<div>
												<span class="pull-right pagado"><%=totalRecord-((nowPage-1)*numPerPage)-i%></span>
											</div>
										</td>
										<td>
											<div style="color : red;">
												<span class="pull-right pagado"><%=recommand%></span>
											</div>
										</td>
										<td>
											<div class="media">
												<a class="pull-left">
													<img src="fileuploadimg/<%=filename%>" width="60px" height="80px" class = "thumbnail"> <!--첨부한 이미지 출력 -->
													<!--"https://s3.amazonaws.com/uifaces/faces/twitter/fffabs/128.jpg"--><!-- class="media-photo"-->																								
												</a>
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
									<!--<tr data-status="cancelado">
										<td>
											<div class="ckbox">
												<input type="checkbox" id="checkbox2">
												<label for="checkbox2"></label>
											</div>
										</td>
										<td>
											<a href="javascript:;" class="star">
												<i class="glyphicon glyphicon-star"></i>
											</a>
										</td>
										<td>
											<div class="media">
												<a href="#" class="pull-left">
													<img src="https://s3.amazonaws.com/uifaces/faces/twitter/fffabs/128.jpg" class="media-photo">
												</a>
												<div class="media-body">
													<span class="media-meta pull-right">Febrero 13, 2016</span>
													<h4 class="title">
														Lorem Impsum
														<span class="pull-right cancelado">(Cancelado)</span>
													</h4>
													<p class="summary">Ut enim ad minim veniam, quis nostrud exercitation...</p>
												</div>
											</div>
										</td>
									</tr>-->
									<!--<tr data-status="pagado" class="selected">
										<td>
											<div class="ckbox">
												<input type="checkbox" id="checkbox4" checked>
												<label for="checkbox4"></label>
											</div>
										</td>
										<td>
											<a href="javascript:;" class="star star-checked">
												<i class="glyphicon glyphicon-star"></i>
											</a>
										</td>
										<td>
											<div class="media">
												<a href="#" class="pull-left">
													<img src="https://s3.amazonaws.com/uifaces/faces/twitter/fffabs/128.jpg" class="media-photo">
												</a>
												<div class="media-body">
													<span class="media-meta pull-right">Febrero 13, 2016</span>
													<h4 class="title">
														Lorem Impsum
														<span class="pull-right pagado">(Pagado)</span>
													</h4>
													<p class="summary">Ut enim ad minim veniam, quis nostrud exercitation...</p>
												</div>
											</div>
										</td>
									</tr>-->
									<!--<tr data-status="pendiente">
										<td>
											<div class="ckbox">
												<input type="checkbox" id="checkbox5">
												<label for="checkbox5"></label>
											</div>
										</td>
										<td>
											<a href="javascript:;" class="star">
												<i class="glyphicon glyphicon-star"></i>
											</a>
										</td>
										<td>
											<div class="media">
												<a href="#" class="pull-left">
													<img src="https://s3.amazonaws.com/uifaces/faces/twitter/fffabs/128.jpg" class="media-photo">
												</a>
												<div class="media-body">
													<span class="media-meta pull-right">Febrero 13, 2016</span>
													<h4 class="title">
														Lorem Impsum
														<span class="pull-right pendiente">(Pendiente)</span>
													</h4>
													<p class="summary">Ut enim ad minim veniam, quis nostrud exercitation...</p>
												</div>
											</div>
										</td>
									</tr>-->
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
							<form  name="searchFrm"  method="post" action="board.jsp">
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
				<div class="content-footer">
					<p>
						Page © - 2017-07 <br>
						Powered By <a href="#">ksy</a>
						<!-- <a href="https://www.facebook.com/tavo.qiqe.lucero" target="_blank">ksy</a> -->
					</p>
				</div>
			 </div>
		  </div>
		</section>
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() 
{
      
    var xOffset = 10;
    var yOffset = 30;

    $(document).on("mouseover",".thumbnail",function(e){ //마우스 오버시
         
        $("body").append("<p id='preview'><img src='"+ $(this).attr("src") +"' width='400px' /></p>"); //보여줄 이미지를 선언                       
        $("#preview")
            .css("top",(e.pageY - xOffset) + "px")
            .css("left",(e.pageX + yOffset) + "px")
            .fadeIn("fast"); //미리보기 화면 설정 셋팅
    });
     
    $(document).on("mousemove",".thumbnail",function(e)
    { //마우스 이동시
        $("#preview")
            .css("top",(e.pageY - xOffset) + "px")
            .css("left",(e.pageX + yOffset) + "px");
    });
     
    $(document).on("mouseout",".thumbnail",function()
    { //마우스 아웃시
        $("#preview").remove();
    });
    $(".fmcircle_in").click(function()
    {
    	$("#cntlist:not(:animated)").toggle("slow");
    	$("#cntlist").css("display","block");
    });
});
</script>
</body>
</html>