<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책추천 해줄게 북...덕... :: 북덕 BookDuck</title>
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
	
	table *{margin: 5px;}
	table{width: 90%; margin: auto; font-family: 'NanumSquare'; transform:skew(-0.03deg);}
	th{height: 40px;}
	button{
		width : 60px;
		height: 35px;
		border: none;
		background-color: #F5DC7A;
		cursor: pointer;
	}
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
			<h1 align="center">공지사항</h1>
			<br><br><br>
			
			<table class="table" id="contentArea" align="center">
				<tr>
					<th class="table-warning">제목</th>
					<td colspan="5">${dto.post_title }</td>
				</tr>
				<tr>
					<th class="table-warning">작성자</th>
					<td>${dto.post_writer }</td>
					<th class="table-warning">작성일</th>
					<td><fmt:formatDate pattern="yyyy-MM-dd hh:mm" value="${dto.post_regdate }"/></td>
					<th class="table-warning">조회수</th>
					<td>${dto.post_hit}</td>
				</tr>
				<tr>
					<th class="table-warning">첨부파일</th>
					<td colspan="5">
						<c:choose>
							<c:when test="${empty dto.originName }">
								첨부파일이 없습니다
							</c:when>
							<c:otherwise>
								<a href="${dto.changeName }" download="${dto.originName }">${dto.originName }</a>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th class="table-warning text-center" colspan="6">내용</th>
				</tr>
				<tr>
					<td colspan="6" height="400px">${dto.post_content }</td>
				</tr>
				<tr>
					<td colspan="6" align="right">
						<c:choose>
							<c:when test="${Ldto.member_id eq dto.post_writer }">
								<button onclick="postFormSubmit(1);">수정</button>
								<button onclick="postFormSubmit(2);">삭제</button>
								<button onclick="location.href='noticeList.do'">목록</button>
							<form id="postForm" action="" method="post">
					            <input type="hidden" name="post_id" value="${ dto.post_id }">
					           	<input type="hidden" name="filePath" value="${ dto.changeName }"> 
					           	<!-- 첨부파일존재o : "파일경로" / 첨부파일존재x : "" -->
					        </form>
					        <script>
				            	function postFormSubmit(num){
				            		if(num == 1){ // 수정하기 클릭시
				            			$("#postForm").attr("action", "noticeUpdateForm.do").submit();
				            		}else{ // 삭제하기 클릭시
				            			$("#postForm").attr("action", "noticeDelete.do").submit();
				            		}
				            	}
				            </script>
							</c:when>
							<c:otherwise>
								<button onclick="location.href='noticeList.do'">목록</button>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>