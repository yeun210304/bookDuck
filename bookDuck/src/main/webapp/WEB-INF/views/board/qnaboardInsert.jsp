<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	table *{margin: 5px;}
	table{width: 100%; margin: auto;}
	th{background-color: #6277BA; height: 40px;}
	td{background-color: #B5BFE5;}
	input{border: none; background-color: #B5BFE5;}
	input[type=button]{
		width : 60px;
		height: 25px;
		border: none;
		border-radius: 25%;
		background-color: #6277BA;
		color: white;
		}
	input[type=submit]{
		width : 60px;
		height: 25px;
		border: none;
		border-radius: 25%;
		background-color: #6277BA;
		color: white;
		}
</style>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
</head>
<body>

	<jsp:include page="../header.jsp"/>

	<div class="content">
		<div class="innerOuter">

			<h2 align="center">문의사항 작성</h2>
			<br><br>
			<form action="qnaInsertRes.do" enctype="multipart/form-data" method="post">
				<table>
					<tr>
						<th>분류</th>
						<td><select name="post_category">
							<option value="P">결제</option>
							<option value="R">환불</option>
							<option value="M">회원</option>
							<option value="E">기타</option>
						</select></td>
						<th>제목</th>
						<td><input type="text" name="post_title" required></td>
					</tr>
					<tr>
						<th>작성자</th>
						<td colspan="3"><input type="text" value="${Ldto.member_id }" readonly name="post_writer"></td>
					</tr>
					<tr>
						<th>첨부파일</th>
						<td colspan="4"><input type="file" name="mpfile"></td>
					</tr>
					<tr>
						<td colspan="4"><textarea id="summernote" name="post_content" required></textarea></td>
					</tr>
					<tr>
						<td colspan="4" align="right">
							<input type="submit" value="작성">
							<input type="button" value="취소" onclick="location.href='qnaList.do'">
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function() {
		  $('#summernote').summernote({
			  height: 300,		//에디터 높이
			  minHeight: 300,	//최대 높이 => 설정시, 스크롤바 생성
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