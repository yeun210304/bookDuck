<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-latest.js"></script>
</head>
<body>

	<table>
		<tr>
			<th>제목</th>
			<td colspan="5">${dto.post_title }</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>${dto.post_writer }</td>
			<th>작성일</th>
			<td><fmt:formatDate pattern="yyyy-MM-dd hh:mm" value="${dto.post_regdate }"/></td>
			<th>조회수</th>
			<td>${dto.post_hit}</td>
		</tr>
		<tr>
			<th>첨부파일</th>
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
			<th colspan="6">내용</th>
		</tr>
		<tr>
			<td colspan="6">${dto.post_content }</td>
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

</body>
</html>