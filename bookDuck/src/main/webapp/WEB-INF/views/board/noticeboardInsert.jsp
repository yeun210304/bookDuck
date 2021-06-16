<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<body>

	<h1>공지사항 작성</h1>
	
	<form action="noticeInsertRes.do" enctype="multipart/form-data" method="post">
		<input type="hidden" name="board_id" value="0">
		<table>
			<tr>
				<th>제목</th>
				<td><input type="text" name="post_title" required></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><input type="text" value="${Ldto.member_id }" readonly name="post_writer"></td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td><input type="file" name="mpfile"></td>
			</tr>
			<tr>
				<td colspan="2"><textarea id="summernote" name="post_content" required></textarea></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="submit" value="작성">
					<input type="button" value="취소" onclick="location.href='noticeList.do'">
				</td>
			</tr>
		</table>
	</form>
	<script type="text/javascript">
		$(document).ready(function() {
		  $('#summernote').summernote({
			  height: 300,
			  minHeight: 300,
			  maxHeight: null
		  });
		});
	</script>
</body>
</html>