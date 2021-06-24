<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-latest.js"></script>
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
						<td colspan="7" align="center">------------ 작성된 글이 없습니다 -------------</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="dto" items="${list }">
						<tr>
							<td>${dto.post_no}</td>
							<td><c:if test="${dto.post_category eq 'P' }">결제</c:if> <c:if
									test="${dto.post_category eq 'R' }">환불</c:if> <c:if
									test="${dto.post_category eq 'M' }">회원</c:if> <c:if
									test="${dto.post_category eq 'E' }">기타</c:if> <c:if
									test="${empty dto.post_category }">분류 없음</c:if></td>
							<td><a href="qnaDetail.do?post_id=${dto.post_id}">${dto.post_title}[${dto.post_comment_count }]</a></td>
							<td>${dto.post_writer}</td>
							<td>${dto.post_hit }</td>
							<td><fmt:formatDate pattern="yyyy-MM-dd"
									value="${dto.post_regdate }" /></td>
							<td><c:if test="${ !empty dto.originName }">
	                        		★
	                        	</c:if></td>
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

	<div id="paging-area" align="center">
			
			<c:if test="${ pi.currentPage ne 1 }">
				<c:choose>
					<c:when test="${ !empty map.condition }">
						<a href="qnaSearch.do?currentPage=${ pi.currentPage-1 }&condition=${map.condition}&keyword=${map.keyword}&category=${map.category}">[이전]</a>
            		</c:when>
            		<c:otherwise>
            			<a href="qnaList.do?currentPage=${ pi.currentPage-1 }">[이전]</a>
            		</c:otherwise>
            	</c:choose>
			</c:if>
			
			<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
				<c:choose>
					<c:when test="${ !empty map.condition }">
						<a href="qnaSearch.do?currentPage=${ p }&condition=${map.condition}&keyword=${map.keyword}&category=${map.category}">[${ p }]</a>
	            	</c:when>
	            	<c:otherwise>
	            		<a href="qnaList.do?currentPage=${ p }">[${ p }]</a>
            		</c:otherwise>
            	</c:choose>
            </c:forEach>
            
            <c:if test="${ pi.currentPage ne pi.maxPage }">
            	<c:choose>
            		<c:when test="${ !empty map.condition }">
		            	<a href="qnaSearch.do?currentPage=${ pi.currentPage+1 }&condition=${map.condition}&keyword=${map.keyword}&category=${map.category}">[다음]</a>
		            </c:when>
		            <c:otherwise>
		            	<a href="qnaList.do?currentPage=${ pi.currentPage+1 }">[다음]</a>
            		</c:otherwise>
            	</c:choose>
            </c:if>
            
        </div>

	<br clear="both">
	<br>
	
	<!-- 검색 영역 -->
	<form id="searchForm" action="qnaSearch.do" method="Get" align="center">
		<div class="select">
			<select class="category-select" name="category">
				<option value="A">전체</option>
				<option value="P">결제</option>
				<option value="R">환불</option>
				<option value="M">회원</option>
				<option value="E">기타</option>
			</select>
			<select class="custom-select" name="condition">
				<option value="title">제목</option>
				<option value="content">내용</option>
				<option value="writer">작성자</option>
			</select>
		</div>
		<div class="text">
			<input type="text" class="form-control" name="keyword" value="${map.keyword }">
		</div>
		<button type="submit" class="searchBtn btn btn-secondary">검색</button>
	</form>
	
	<c:if test="${!empty map.condition }">
		<script type="text/javascript">
			$(function(){
				$("#searchForm option[value=${map.condition}]").attr("selected", true);
				$("#searchForm option[value=${map.category}]").attr("selected", true);
			});
		</script>
	</c:if>

</body>
</html>