<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<form action="noticeUpdateRes.do" method="post" enctype="multipart/form-data">
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
				<td colspan="2">내용</td>
			</tr>
			<tr>
				<td colspan="2"><textarea rows="10" cols="60" name="post_content" required>${post_content }</textarea></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="수정">
					<input type="button" value="취소" onclick="noticeDetail.do?post_id=${dto.post_id}">
				</td>
			</tr>
		</table>
	</form>

</body>
</html>