<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
</head>
<body>

	<form action="qnaUpdateRes.do" method="post" enctype="multipart/form-data">
		<input type="hidden" name="post_id" value="${dto.post_id }">		
		
		<table>
			<tr>
				<th>제목</th>
				<td><input type="text" name="post_title" value="${dto.post_title }" required></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>${dto.post_writer }</td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td>
					<input type="file" name="reupfile">
					<c:if test="${!empty dto.originName }">
						현재 업로드 된 파일 : <a href="${dto.changeName }" download="${dto.originName }">${dto.originName }</a>
						<input type="hidden" name="originName" value="${dto.originName }">
						<input type="hidden" name="changeName" value="${dto.changeName }">
					</c:if>
				</td>
			</tr>
			<tr>
				<td colspan="2"><textarea id="summernote" name="post_content" required>${dto.post_content }</textarea></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="수정">
					<input type="button" value="취소" onclick="location.href='qnaDetail.do?post_id=${dto.post_id}'">
				</td>
			</tr>
		</table>
	</form>
	<script type="text/javascript">
		$(document).ready(function() {
		  $('#summernote').summernote({
			  height: 300,
			  minHeight: 300,
			  maxHeight: null,
			  lang: "ko-KR",	// 한글 설정
			  callbacks: {		// 콜백사용
				  onImageUpload: function(files){
					  console.log(files);
					  sendFile(files[0]);
				  }
			  }
		  });
		});
		
		function sendFile(file){
			var data = new FormData();
			data.append("mpfile", file);
			$.ajax({
				data : data,
				type : "post",
				url : "imageUpload.do",
				cache : false,
				contentType: false,
				enctype: 'multipart/form-data',
				processData: false,
				success: function(url){
					//console.log(url);
					var path = "http://localhost:8787/bookduck";
					//console.log(path+url);
					var image = $('<img>').attr('src', path+url).attr('width','500');
					$("#summernote").summernote('insertNode', image[0]);
				}
			});
		}
	</script>
</body>
</html>