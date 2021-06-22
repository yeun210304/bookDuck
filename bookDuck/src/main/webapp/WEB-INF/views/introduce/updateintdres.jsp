<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.spring.bookduck.introduce.dto.IntroduceDto"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- include libraries(jQuery, bootstrap) -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 
<!-- include summernote css/js-->
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.js"></script>
<!-- include summernote-ko-KR -->
<script src="/resources/js/summernote-ko-KR.js"></script>
</head>
<script>
function goWrite(frm) {
	var intd_content = frm.intd_content.value;
	if (intd_content.trim() == ''){
		alert("내용을 입력해주세요");
		return false;
	}
	frm.submit();
}
</script>	
<script>
	$(document).ready(function() {
		$('#summernote').summernote();
		
	});
</script>

<body>
<h2 style="text-align: center;">자기소개 수정</h2><br><br><br>

<div style="width: 60%; margin: auto;">
	<form action="updateintd.do" method="post">
		<input type="hidden" name="intd_no" value="${intdDto.intd_no }">
		<input type="text" name="member_id" readonly="readonly" style="width: 20%;" value="${Ldto.member_id}"/><br>
		<br><br> 
		<textarea id="summernote" name="intd_content">${intdDto.intd_content}</textarea>
		<input type="submit" value="수정" style="float: right;" onclick="goWrite(this.form)"/>
		<input type="button" value="취소" onclick="location.href='home.do'"/>
	</form>
	
	
</div>
</body>
</html>