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
						<td colspan="6" align="center">				
						------------	작성된 글이 없습니다		-------------
						</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="dto" items="${list }">
						<tr>
							<td>${dto.post_no}</td>
							<td><a href="noticeDetail.do?post_id=${dto.post_id}">${dto.post_title}</a></td>
							<td>${dto.post_writer}</td>
							<td>${dto.post_hit }</td>
							<td>${dto.post_regdate }</td>
							<td>
	                        	<c:if test="${ !empty dto.originName }">
	                        		★
	                        	</c:if>
	                        </td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>	
			<c:if test="${ Ldto.member_role eq 'ADMIN' }">
				<tr>
					<td colspan="6" align="right">
						<button onclick="location.href='noticeInsertForm.do'">글쓰기</button>
					</td>
				</tr>
			</c:if>		
		</tbody>
	</table>
	
	<div id="pagingArea">
			<ul class="pagination">
				<c:choose>
					<c:when test="${pi.currentPage eq 1 }">
						<li><a href="#">Previous</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="noticeList.do?currentPage=${pi.currentPage-1 }">Previous</a></li>
					</c:otherwise>
				</c:choose>
				
				<c:forEach var="p" begin="${pi.startPage }" end="${pi.endPage }">
					<li><a href="noticeList.do?currentPage=${p }">${p }</a></li>
				</c:forEach>
				
				<c:choose>
					<c:when test="${pi.currentPage eq pi.maxPage }">
						<li><a href="#">Next</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="noticeList.do?currentPage=${pi.currentPage+1 }">Next</a></li>
					</c:otherwise>
				</c:choose>
				
			</ul>
		</div>

</body>
</html>