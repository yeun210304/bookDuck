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
				<td><input type="text" value="${Ldto.member_id }" readonly name="post_writer"></td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td><input type="file" name="mpfile"></td>
			</tr>
			<tr>
				<th colspan="4" align="center">내용</th>
			</tr>
			<tr>
				<td colspan="4"><textarea rows="10" cols="60" name="post_content" required></textarea></td>
			</tr>
			<tr>
				<td colspan="4" align="right">
					<input type="submit" value="작성">
					<input type="button" value="취소" onclick="qnaList.do">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>