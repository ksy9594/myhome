<%@ page contentType="text/html; charset=utf-8" %>
<% 
	request.setCharacterEncoding("utf-8");
	
%>
<!doctype html>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
	<link href= "css/write.css" rel="stylesheet" type="text/css" media="all" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<script type = "text/javascript" src ="js/smartEdit/HuskyEZCreator.js" charset="UTF-8"></script>
	<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    <title>유저게시판</title>
</head>
<body>
<style type="text/css">
       
	.red
	{
		color:red;
    }

</style>
<script type="text/javascript">
	
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
	
	$(function() 
	{
        $("#imgfile").on('change', function(){
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
</script>
<form id = "smartForm" name = "boradlist" action = "writeProc.jsp" method = "post" enctype="multipart/form-data">	
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
			<!--  <td>Subject</td>
			<td><label><input type = "text"></label></td>-->
			<td>
			<!--  <img id="blah-m" src="#" alt="이미지 미리보기를 제공합니다."/>-->
			</td>
			<td>
			<img id="blah" src="#" alt="이미지 미리보기를 제공합니다."/>
			</td>
		</tr>
		
		<tr>
			<td>글 내용</td>
			<td style="width : 725px;">
			<textarea id = "ir1" class="form-control" type="textarea" placeholder="괜찬은 코디와 간단한 코멘트를 입력해주세요" name = "content" style="width : 725px;">
			</textarea>
			</td>
			<td></td>
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
				<label><input type = "button" value = "작성완료" class="btn btn-primary pull-right" onclick="check()" id="save"></label>
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
<script type="text/javascript">
var oEditors = [];

$(function(){
	nhn.husky.EZCreator.createInIFrame({
		oAppRef : oEditors,
		elPlaceHolder : "ir1",
		sSkinURI : "SmartEditor2Skin.html",
		htParams :
		{
			bUseToolbar : true, //툴바 사용 여부
			bUseVerticalResizer : true, //입력창 크기 조절바 사용 여부
			bUseModeChanger : true,
			fOnBeforeUnload : function()
			{			
			}
		},
		fOnAppLoad : function() //기존 저장된 내용의 text 내용을 에디터상에 뿌려주고자 할때
		{
			oEditors.getById["ir1"].exec("PASTE_HTML",["기존 DB에 저장될 내용을 에디터에 적용할 문구"]);
		},
		fCreator : "createSEditor2"
	});
	$("#save").click(function()
	{
		oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD",[]);
		$("#smartForm").submit();		
	});	
});
</script>




</body>
</html>