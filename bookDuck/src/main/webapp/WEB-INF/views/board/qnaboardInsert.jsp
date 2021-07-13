<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책추천 해줄게 북...덕... :: 북덕 BookDuck</title>
<style type="text/css">
	/* nanumsquare bold */
	@font-face{
		font-family : 'Nanum Square Bold';
		src: url("font/NanumSquare_acB.ttf");
	}
	h1{
		font-family:'Nanum Square Bold', sans-serif !important;
		letter-spacing: 10px;
	}
	
	table *{margin: 5px;}
	table{width: 100%; margin: auto; font-family : 'NanumSquare' !important; transform:skew(-0.03deg); font-size: medium;}
	th{background-color: #6277BA; height: 40px;}
	input{border: none;}
	input[type=button]{
		width : 60px;
		height: 35px;
		border: none;
		background-color: #6277BA;
		color: white;
		}
	input[type=submit]{
		width : 60px;
		height: 35px;
		border: none;
		background-color: #6277BA;
		color: white;
	}
	.content {
		width: 90%;
		margin: auto;
	}
	
	.innerOuter {
		width: 80%;
		margin: auto;
		padding: 5% 10%;
		background: white;
	}
	
</style>
<!-- bootstrap 4 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- summernote editor -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
</head>
<body>

	<jsp:include page="../header.jsp"/>

	<div class="content">
		<div class="innerOuter">

			<h1 align="center">문의게시판</h1>
			<br><br><br>
			<form action="qnaInsertRes.do" enctype="multipart/form-data" method="post">
				<table class="table">
					<tr>
						<th class="table-primary">분류</th>
						<td><select class="form-control" name="post_category">
							<option value="P">결제</option>
							<option value="R">환불</option>
							<option value="M">회원</option>
							<option value="E">기타</option>
						</select></td>
						<th class="table-primary">제목</th>
						<td><input class="form-control" type="text" name="post_title" required></td>
					</tr>
					<tr>
						<th class="table-primary">작성자</th>
						<td colspan="3"><input type="text" value="${Ldto.member_id }" readonly name="post_writer"></td>
					</tr>
					<tr>
						<th class="table-primary">첨부파일</th>
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
	
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>