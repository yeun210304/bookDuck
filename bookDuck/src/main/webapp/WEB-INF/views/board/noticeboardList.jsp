<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책추천 해줄게 북...덕... :: 북덕 BookDuck</title>
<!-- 나눔고딕 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@700&display=swap" rel="stylesheet">
<!-- 나눔바른고딕 -->
<link href='https://cdn.rawgit.com/openhiun/hangul/14c0f6faa2941116bb53001d6a7dcd5e82300c3f/nanumbarungothic.css' rel='stylesheet' type='text/css'>
<!-- 나눔 스퀘어 -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/moonspam/NanumSquare@1.0/nanumsquare.css"> 
<style type="text/css">
	/* nanumsquare bold */
	@font-face{
		font-family : 'Nanum Square Bold';
		src: url("font/NanumSquare_acB.ttf");
	}
	
	#boardList{text-align: center; width: 100%; font-family : 'NanumSquare'; transform:skew(-0.03deg);}
	#boardList>tbody>tr{height: 50px;}
	thead{height: 40px;}
	ul{text-align : center;}
	ul li{list-style: none; display: inline-block;}
	#pagingArea{width:fit-content; margin:auto; font-family: 'NanumSquare'; transform:skew(-0.03deg);}
	#searchForm {text-align: center; font-family: 'NanumSquare'; transform:skew(-0.03deg);}
	#searchForm>*{display:inline-block; margin:5px;}
	
	a {text-decoration: none !important; color: black !important;}
	
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
		color: white !important;
	}
	button{
		width : 60px;
		height: 35px;
		border: none;
		border-radius: 20%;
		background-color: #F5DC7A;
		cursor: pointer;
	}
	h1{
		/*font-family: 'Nanum Gothic', sans-serif;*/
		font-family:'Nanum Square Bold', sans-serif;
		letter-spacing: 10px;
	}
	#postContent{display:inline-block !important; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;}
	
	.content {
		width: 90%;
		margin: auto;
	}
	
	.innerOuter {
		width: 80%;
		margin: auto;
		padding: 5% 10%;
		background: white;
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
			<br>
			<table class="table" id="boardList" align="center">
				<col width="7%">
				<col width="33%">
				<col width="20%">
				<col width="10%">
				<col width="15%">
				<col width="10%">
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
								<td colspan="6" align="center">------------  작성된 글이 없습니다  -------------</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="dto" items="${list }">
								<tr>
									<td>${dto.post_no}</td>
									<td width="369px" id="postContent"><a href="noticeDetail.do?post_id=${dto.post_id}">${dto.post_title}</a></td>
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
		
			<br><br>
			<div id="pagingArea" align="center">
				<ul class="paging">
					<c:choose>
						<c:when test="${ pi.currentPage ne 1 }">
							<c:choose>
								<c:when test="${ !empty map.condition }">
									<li><a href="noticeSearch.do?currentPage=${ pi.currentPage-1 }&condition=${map.condition}&keyword=${map.keyword}">이전</a></li>
								</c:when>
								<c:otherwise>
									<li><a href="noticeList.do?currentPage=${ pi.currentPage-1 }">이전</a></li>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<li><a href="">이전</a></li>
						</c:otherwise>
					</c:choose>
					
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
					
					<c:choose>
						<c:when test="${ pi.currentPage ne pi.maxPage }">
							<c:choose>
								<c:when test="${ !empty map.condition }">
									<li><a href="noticeSearch.do?currentPage=${ pi.currentPage+1 }&condition=${map.condition}&keyword=${map.keyword}">다음</a></li>
								</c:when>
								<c:otherwise>
									<li><a href="noticeList.do?currentPage=${ pi.currentPage+1 }">다음</a></li>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<li><a href="">다음</a></li>
						</c:otherwise>
					</c:choose>
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
	
	<jsp:include page="../footer.jsp"/>
</body>
</html>