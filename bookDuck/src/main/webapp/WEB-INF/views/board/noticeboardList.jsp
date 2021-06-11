<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<table id="boardList">
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>조회수</th>
				<th>작성일</th>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${empty list }">
					<tr>
						<td colsapn="6" align="center">				
						------------	작성된 글이 없습니다		-------------
						</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="b" items="list">
						<tr>
							<td>${b.post_no}</td>
							<td><a href="noticeDetail.do?post_no=${b.post_no}">${b.post_title}</a></td>
							<td>${b.post_writer}</td>
							<td>${b.post_hit }</td>
							<td>${b.post_regdate }</td>
							<td>
	                        	<c:if test="${ !empty b.originName }">
	                        		★
	                        	</c:if>
	                        </td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>	
			<c:if test="${ !empty Ldto.member_id }">
				<tr>
					<td colspan="6" align="right">
						<button onclick="location.href='noticeInsertForm.do'">글쓰기</button>
					</td>
				</tr>
			</c:if>		
		</tbody>
	</table>

</body>
</html>