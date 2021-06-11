<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>Insert</h1>
	
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
				<th colspan="2">내용</th>
			</tr>
			<tr>
				<td colspan="2"><textarea rows="10" cols="60" name="post_content" required></textarea></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="작성">
					<input type="button" value="취소" onclick="noticeList.do">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>