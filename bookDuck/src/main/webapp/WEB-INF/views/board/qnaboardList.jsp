<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책추천 해줄게 북...덕... :: 북덕 BookDuck</title>
<!-- 나눔 스퀘어 -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/moonspam/NanumSquare@1.0/nanumsquare.css"> 
<style type="text/css">
	/* nanumsquare bold */
	@font-face{
		font-family : 'Nanum Square Bold';
		src: url("font/NanumSquare_acB.ttf");
	}
	h1{
		font-family:'Nanum Square Bold', sans-serif;
		letter-spacing: 10px;
	}
	
	#boardList{text-align: center; width: 100%; font-family: 'NanumSquare'; transform:skew(-0.03deg);}
	#boardList>tbody>tr{height: 50px;}
	thead th{height: 40px;}
	ul {text-align: center;}
	ul li {list-style: none; display: inline-block;}
	#pagingArea{width:fit-content; margin:auto; font-family : 'NanumSquare'; transform:skew(-0.03deg);}
	#searchForm {text-align: center; font-family : 'NanumSquare'; transform:skew(-0.03deg);}
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
		background-color: #6277BA;
		color: white !important;
	}
	button{
		width : 60px;
		height: 35px;
		border: none;
		border-radius: 20%;
		background-color: #6277BA;
		color: white;
		cursor: pointer;
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
</head>
<body>
	<jsp:include page="../header.jsp"/>

	<div class="content">
	
		<div class="innerOuter">
	
			<h1 align="center">문의게시판</h1>
			<br>
			<br>
			<br>
			<table class="table" id="boardList" align="center">
				<col width="7%">
				<col width="7%">
				<col width="30%">
				<col width="20%">
				<col width="10%">
				<col width="16%">
				<col width="10%">
				<thead class="table-primary text-center">
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
								<td colspan="7" align="center">------------  작성된 글이 없습니다  -------------</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="dto" items="${list }">
								<tr>
									<td>${dto.post_no}</td>
									<td><c:if test="${dto.post_category eq 'P' }">결제</c:if> 
										<c:if test="${dto.post_category eq 'R' }">환불</c:if>
										<c:if test="${dto.post_category eq 'M' }">회원</c:if>
										<c:if test="${dto.post_category eq 'E' }">기타</c:if>
										<c:if test="${empty dto.post_category }">분류 없음</c:if></td>
									<td width="310px" id="postContent"><a href="qnaDetail.do?post_id=${dto.post_id}">${dto.post_title}&nbsp;[${dto.post_comment_count }]</a></td>
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
			
			<br><br>
			<div id="pagingArea" align="center">
				<ul class="paging">
					<c:choose>
						<c:when test="${ pi.currentPage ne 1 }">
							<c:choose>
								<c:when test="${ !empty map.condition }">
									<li class="page-item"><a href="qnaSearch.do?currentPage=${ pi.currentPage-1 }&condition=${map.condition}&keyword=${map.keyword}&category=${map.category}">이전</a></li>
			            		</c:when>
			            		<c:otherwise>
			            			<li class="page-item"><a href="qnaList.do?currentPage=${ pi.currentPage-1 }">이전</a></li>
			            		</c:otherwise>
			            	</c:choose>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a href="">이전</a></li>
						</c:otherwise>
					</c:choose>
					<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
						<c:choose>
							<c:when test="${ !empty map.condition }">
								<li class="page-item"><a id="page${p }" href="qnaSearch.do?currentPage=${ p }&condition=${map.condition}&keyword=${map.keyword}&category=${map.category}">${p}</a></li>
			            	</c:when>
			            	<c:otherwise>
			            		<li class="page-item"><a id="page${p }" href="qnaList.do?currentPage=${p}">${p}</a></li>
		            		</c:otherwise>
		            	</c:choose>
		            </c:forEach>
		            <c:choose>
			            <c:when test="${ pi.currentPage ne pi.maxPage }">
			            	<c:choose>
			            		<c:when test="${ !empty map.condition }">
					            	<li class="page-item"><a href="qnaSearch.do?currentPage=${ pi.currentPage+1 }&condition=${map.condition}&keyword=${map.keyword}&category=${map.category}">다음</a></li>
					            </c:when>
					            <c:otherwise>
					            	<li class="page-item"><a href="qnaList.do?currentPage=${ pi.currentPage+1 }">다음</a></li>
			            		</c:otherwise>
			            	</c:choose>
			            </c:when>
			            <c:otherwise>
			            	<li class="page-item"><a href="">다음</a></li>
			            </c:otherwise>
		            </c:choose>
		          </ul>	  
		        </div>
		
			<br clear="both">
			<br>
			
			<!-- 검색 영역 -->
			<form id="searchForm" action="qnaSearch.do" method="Get" align="center">
				<div class="select">
					<select class="custom-select" name="category">
						<option value="A">전체</option>
						<option value="P">결제</option>
						<option value="R">환불</option>
						<option value="M">회원</option>
						<option value="E">기타</option>
					</select>
				</div>
				<div class="select">
					<select class="custom-select" name="condition">
						<option value="title">제목</option>
						<option value="content">내용</option>
						<option value="writer">작성자</option>
					</select>
				</div>
				<div class="text">
					<input type="text" class="form-control" name="keyword" value="${map.keyword }">
				</div>
				<button type="submit">검색</button>
			</form>
			
			<c:if test="${!empty map.condition }">
				<script type="text/javascript">
					$(function(){
						$("#searchForm option[value=${map.condition}]").attr("selected", true);
						$("#searchForm option[value=${map.category}]").attr("selected", true);
					});
				</script>
			</c:if>
		</div>
	</div>
	<script type="text/javascript">
		$(function(){
			var currentPage = ${pi.currentPage};
			$("#page"+currentPage).addClass("on");
		});
	</script>
	
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>