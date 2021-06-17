<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
				<th>분류</th>
				<th>제목</th>
				<th>작성자</th>
				<th>조회수</th>
				<th>작성일</th>
				<th>첨부파일</th>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${empty list }">
					<tr>
						<td colsapn="7" align="center">				
						------------	작성된 글이 없습니다		-------------
						</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="dto" items="${list }">
						<tr>
							<td>${dto.post_no}</td>
							<td>
							<c:if test="${dto.post_category eq 'P' }">결제</c:if>	
							<c:if test="${dto.post_category eq 'R' }">환불</c:if>	
							<c:if test="${dto.post_category eq 'M' }">회원</c:if>	
							<c:if test="${dto.post_category eq 'E' }">기타</c:if>					
							<c:if test="${empty dto.post_category }">분류 없음</c:if>
							</td>
							<td><a href="qnaDetail.do?post_id=${dto.post_id}">${dto.post_title}[${dto.post_comment_count }]</a></td>
							<td>${dto.post_writer}</td>
							<td>${dto.post_hit }</td>
							<td><fmt:formatDate pattern="yyyy-MM-dd" value="${dto.post_regdate }"/></td>
							<td>
	                        	<c:if test="${ !empty dto.originName }">
	                        		★
	                        	</c:if>
	                        </td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>	
			<c:if test="${ !empty Ldto.member_id }">
				<tr>
					<td colspan="7" align="right">
						<button onclick="location.href='qnaInsertForm.do'">글쓰기</button>
					</td>
				</tr>
			</c:if>		
		</tbody>
	</table>

</body>
</html>