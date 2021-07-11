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

	<h1>일단 AIRELIST</h1>
	
	<table border="1">
		<tr>
			<th>번호</th>
			<th>ID</th>
			<th>나이</th>
			<th>장르</th>
			<th>취향</th>
			<th>날짜</th>		
		</tr>
		<c:choose>
			<c:when test="${empty airelist}">
				<tr>
					<td colspan="6">
						------- 검색 내용이 없습니다. -------
					</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach var="aire" items="${airelist}">
					<tr>
						<td>${aire.recommend_no }</td>
						<td>${aire.recommend_id }</td>
						<td>${aire.recommend_age }</td>
						<td>${aire.recommend_genre }</td>
						<td>${aire.recommend_favor }</td>
						<td>${aire.recommend_date }</td>						
					</tr>				
				</c:forEach>
			</c:otherwise>			
		</c:choose>
			
	</table>

</body>
</html>