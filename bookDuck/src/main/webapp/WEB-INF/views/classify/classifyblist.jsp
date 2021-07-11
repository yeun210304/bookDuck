<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>    
<% response.setContentType("text/html; charset=UTF-8"); %>  

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책추천 해줄게 북...덕... :: 북덕 BookDuck</title>
</head>
<body>

	<h1>BLACK LIST</h1>
	
	<table border="1">
		<tr>
			<th>번호</th>
			<th>신고자</th>
			<th>대상</th>
			<th>내용</th>
			<th>날짜</th>				
		</tr>
		<c:choose>
			<c:when test="${empty blist}">
				<tr>
					<td colspan="5">
						------- 검색 내용이 없습니다. -------
					</td>
				</tr>
			</c:when>
			<c:otherwise>					
				<c:forEach var="b" items="${blist}">
					<tr>
						<td>${b.blacklist_no}</td>
						<td>${b.blacklist_from}</td>
						<td>${b.blacklist_to}</td>
						<td>${b.blacklist_contents}</td>
						<td>${b.blacklist_date}</td>
					</tr>				
				</c:forEach>
			</c:otherwise>			
		</c:choose>		
		
	</table>

</body>
</html>