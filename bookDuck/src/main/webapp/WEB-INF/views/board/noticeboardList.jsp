<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#boardList{text-align: center; width: 100%;}
	#boardList>tbody>tr{height: 50px;}
	thead{height: 40px; }
	ul{text-align : center;}
	ul li{list-style: none; display: inline-block;}
	#pagingArea{width:fit-content; margin:auto;}
	#searchForm {text-align: center;}
	#searchForm>*{display:inline-block; margin:5px;}
	.paging a {
		padding: 3px 8px;
		margin: 5px;
	}
	a.on{
		width: 30px;
		height: 30px;
		border: none;
		border-radius: 100%;
		background-color: #F5DC7A;
		color: white;
	}
	button{
		width : 60px;
		height: 35px;
		border: none;
		border-radius: 20%;
		background-color: #F5DC7A;
		cursor: pointer;
	}
</style>
<!-- bootstrap 4 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script type="text/javascript">
		$(function(){
			var currentPage = ${pi.currentPage};
			$("#page"+currentPage).addClass("on");
		});
</script>

</head>
<body>

	<jsp:include page="../header.jsp"/>

	<div class="content">
		<div class="innerOuter">
			<h1 align="center">공지사항</h1>
			<br>
			<br>
			<table class="table" id="boardList" align="center">
				<thead class="table-warning">
					<tr>
						<th>번호</th>
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
								<td colspan="6" align="center">------------ 작성된 글이 없습니다 -------------</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="dto" items="${list }">
								<tr>
									<td>${dto.post_no}</td>
									<td><a href="noticeDetail.do?post_id=${dto.post_id}">${dto.post_title}</a></td>
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
					<c:if test="${ Ldto.member_role eq 'ADMIN' }">
						<tr>
							<td colspan="6" align="right">
								<button onclick="location.href='noticeInsertForm.do'">글쓰기</button>
							</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		
			<div id="paging-area" align="center">
				<ul class="paging">
					<c:if test="${ pi.currentPage ne 1 }">
						<c:choose>
							<c:when test="${ !empty map.condition }">
								<li><a href="noticeSearch.do?currentPage=${ pi.currentPage-1 }&condition=${map.condition}&keyword=${map.keyword}">이전</a></li>
							</c:when>
							<c:otherwise>
								<li><a href="noticeList.do?currentPage=${ pi.currentPage-1 }">이전</a></li>
							</c:otherwise>
						</c:choose>
					</c:if>
		
					<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
						<c:choose>
							<c:when test="${ !empty map.condition }">
								<li><a id="page${p }" href="noticeSearch.do?currentPage=${ p }&condition=${map.condition}&keyword=${map.keyword}">${ p }</a></li>
							</c:when>
							<c:otherwise>
								<li><a id="page${p }" href="noticeList.do?currentPage=${ p }">${ p }</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
		
					<c:if test="${ pi.currentPage ne pi.maxPage }">
						<c:choose>
							<c:when test="${ !empty map.condition }">
								<li><a href="noticeSearch.do?currentPage=${ pi.currentPage+1 }&condition=${map.condition}&keyword=${map.keyword}">다음</a></li>
							</c:when>
							<c:otherwise>
								<li><a href="noticeList.do?currentPage=${ pi.currentPage+1 }">다음</a></li>
							</c:otherwise>
						</c:choose>
					</c:if>
				</ul>
			</div>
		
			<br clear="both">
			<br>
		
			<!-- 검색 영역 -->
			<form id="searchForm" action="noticeSearch.do" method="Get"
				align="center">
				<input type="hidden" name="board_id" value="0">
				<div class="select">
					<select class="custom-select" name="condition">
						<option value="title">제목</option>
						<option value="content">내용</option>
						<option value="writer">작성자</option>
					</select>
				</div>
				<div class="text">
					<input type="text" class="form-control" name="keyword"
						value="${map.keyword }">
				</div>
				<button type="submit" class="searchBtn">검색</button>
			</form>
		
			<c:if test="${!empty map.condition }">
				<script type="text/javascript">
					$(function() {
						$("#searchForm option[value=${map.condition}]").attr(
								"selected", true);
					});
				</script>
			</c:if>
		</div>
	</div>
</body>
</html>