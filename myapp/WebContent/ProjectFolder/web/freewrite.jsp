<%@ page contentType="text/html; charset=UTF-8" %><!-- 글쓰기 -->
<% 
	request.setCharacterEncoding("UTF-8");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>건의게시판</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
	<link href= "css/write.css" rel="stylesheet" type="text/css" media="all" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
</head>
<body>

<form name = "boradlist" action = "freewriteProc.jsp" method = "post" enctype="multipart/form-data">	
	<table class = "form-area">
		<caption><Center>글 쓰기</Center><caption>
		<tr>
			<td>닉네임</td>
			<td><label><input type = "text" name = "name" class="form-control" placeholder="닉네임을 입력하세요"></label></td>
		</tr>
		<!--  <tr>
			<td>
			<label><input type = "text" name = "name" class="form-control" placeholder="닉네임을 입력하세요" id="m-form-ctrl">
			</label></td>
		</tr>-->
		
		<tr>
			<td>비밀번호</td>
			<td><label><input type = "password" name = "pass" class="form-control" placeholder="비밀번호를 입력하세요"></label></td>
		</tr>
		<!--  <tr>
			<td><label><input type = "password" name = "pass" class="form-control" placeholder="비밀번호를 입력하세요" 
			id="m-form-ctrl"></label></td>
		</tr>-->	
		
		<tr>
			<td >글 제목</td>
			<td><label><input type = "text"  id="message" name="subject" placeholder="제목을 입력하세요" class="form-control"></label></td>
		</tr>
		<!--  <tr>
			<td><label><input type = "text"  id="message-m" name="subject" placeholder="제목을 입력하세요" 
			class="form-control"></label></td>
		</tr>-->
		
		<!--<tr>
			<td>Homepage</td>
			<td><label><input type = "text"></label></td>
		</tr>
		<tr>
			<td>Option</td>
			<td><label><input type ="checkbox" name = "mail">답변 메일 받기</label>
				<label><input type ="checkbox" name = "mail">답변 메일 받기</label>
			</td>
		</tr>-->
		<tr>			
		</tr>
		
		<tr>
			<td>글 내용</td>
			<td>
			<textarea class="form-control" type="textarea" placeholder="괜찬은 코디와 간단한 코멘트를 입력해주세요" name = "content" cols = "60" rows = "15">
			</textarea>
			</td>
		</tr>
		
		<!--  <tr>
			<td>
			<textarea class="form-control" type="textarea" placeholder="괜찬은 코디와 간단한 코멘트를 입력해주세요" name = "content" cols = "60" rows = "15" id="m-form-ctrl">
			</textarea>
			</td>
		</tr>-->
		
		<tr>
			<td>FileUpLoad</td>
			<td><label>
			<input type = "file" id="imgfile" placeholder = "선택된 파일 없음" onclick="imgload()" name = "filename" class="form-control">		
			</label></td>
		</tr>
		
		 <!--  <tr>
			<td>
			<label><input type = "file" id="imgfile-m" placeholder = "선택된 파일 없음" onclick="imgload()" name = "filename" 
			class="form-control">		
			</label>
			</td>			
		</tr>-->
			
		 <tr>
			<td id="m-blank"><!--<a href = "">미리보기</a>--></td>
			<td>
				<label><input type = "button" value = "작성완료" class="btn btn-primary pull-right" onclick="check()"></label>
				<label><input type = "reset" value = "취소하기" class="btn btn-primary pull-right" onclick="history.go(-1);"></label>
			</td>		
		</tr>
	</table>
	<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
</form>
<script type="text/javascript">
function check()
{
	if(document.boradlist.content.value=="")
	{
		alert("글 내용이 없습니다.");
		return
	}
	if(document.boradlist.pass.value=="")
	{
		alert("비밀번호를 입력하세요");
		return
	}
	if(document.boradlist.name.value=="")
	{
		alert("닉네임을 입력하세요");
		return
	}
	if(document.boradlist.subject.value=="")
	{
		alert("글 제목을 정해주세요.");
		return
	}
	document.boradlist.submit();
}
</script>
</body>
</html>