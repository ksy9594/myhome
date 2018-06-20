<%@page import="project.boardBean"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<jsp:useBean id="mgr" class="project.Imgloadmgr" />
<% 
	request.setCharacterEncoding("UTF-8");
	
%>
<% 
	  int num = Integer.parseInt(request.getParameter("num"));
	  String nowPage = request.getParameter("nowPage");
	  boardBean bean = (boardBean)session.getAttribute("bean");
	  
	  //boardBean //bean = mgr.getProduct(num);
	  
	  String subject = bean.getSubject();
	  String name = bean.getName(); 
	  String content = bean.getContent(); 
	  String filename = bean.getFilename();
%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset ="utf-8">	
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
	<link href= "css/update.css" rel="stylesheet" type="text/css" media="all" />
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<title>유저게시판</title>
<style type="text/css">       
	.red
	{
		color:red;
    }
	.form-area
	{
		
		<!--background-color: #FAFAFA;-->
		<!--padding: 10px 40px 60px;-->
		padding-left : 20px;
		border: 0px solid GREY;
	}
	#blah
	{
		width : 250px;
		height : 120px;
	}
</style>
</head>
<body>
<script>
	$(function() 
	{
		$("#imgfile").on('change', function()
		{
		   readURL(this);
		});
	}); 

		function readURL(input)
		{
		    if (input.files && input.files[0]) 
		    {
		    	var reader = new FileReader();

		        reader.onload = function (e) 
		        {
		                $('#blah').attr('src', e.target.result);
		        }

		          reader.readAsDataURL(input.files[0]);
		    }
		}
		function imgload()
		{
			var fileup = $("#imgfile").val();
			
			if(fileup != "")
			{
				var ext = fileup.slice(fileup.lastIndexOf(".")+1).toLowerCase();
				
				if(!(ext == "gif" || ext == "jpg" || ext == "png"))
				{
					alert("이미지파일(.jpg, .png, .gif)만 업로드 가능합니다.");
					history.go(this);
					return false;
				}		
			}	
		}
</script>
<form name = "updateFrm" action = "updateProc.jsp" method = "post" enctype="multipart/form-data">	
	<table class = "form-area">
		<caption><Center>글 쓰기</Center><caption>
		<tr>
			<td>닉네임</td>
			<td><label><input type = "text" name = "name" class="form-control" placeholder="닉네임을 입력하세요"
			value="<%=name%>"></label></td>
		</tr>
				
		<tr>
			<td>글 제목</td>
			<td><label><input type = "text"  id="message" name="subject" placeholder="제목을 입력하세요" class="form-control"
			value="<%=subject%>"></label></td>
		</tr>
		
		<tr>
			<td></td>		
			<td>
			<img id="blah" src="fileuploadimg/<%=filename%>" alt="이미지 미리보기를 제공합니다."/>
			</td>
		</tr>
		
		<tr>
			<td>글 내용</td>
			<td>
			<textarea class="form-control" type="textarea" placeholder="괜찬은 코디와 간단한 코멘트를 입력해주세요" 
			name = "content" cols = "60" rows = "15">
			<%=content%>
			</textarea>
			</td>
		</tr>
				
		<tr>
			<td>FileUpLoad</td>
			<td><label>
			<input type = "file" id="imgfile" placeholder = "선택된 파일 없음" name = "filename" class="form-control">
			</label>
		</tr>
	    
	 <tr>
     <td colspan="2">
	  <input type="submit" value="수정완료" class="btn btn-primary pull-right">
      <input type="reset" value="다시수정" class="btn btn-primary pull-right"> 
      <input type="button" value="뒤로" onClick="history.go(-1)" class="btn btn-primary pull-right">
	 </td>
    </tr>
    
	</table>
	<input type="hidden" name="nowPage" value="<%=nowPage%>">
 	<input type="hidden" name="num" value="<%=num%>">
 	<input type="hidden" name="flag" value="update">
</form>
</body>
</html>