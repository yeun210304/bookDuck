<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
			<th>분류</th>
			<td>
				<c:if test="${dto.post_category eq 'P' }">결제</c:if>	
				<c:if test="${dto.post_category eq 'R' }">환불</c:if>	
				<c:if test="${dto.post_category eq 'M' }">회원</c:if>	
				<c:if test="${dto.post_category eq 'E' }">기타</c:if>					
				<c:if test="${empty dto.post_category }">분류 없음</c:if>	
			</td>
			<th>제목</th>
			<td colspan="3">${dto.post_title }</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>${dto.post_writer }</td>
			<th>작성일</th>
			<td>${dto.post_regdate }</td>
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
				<c:if test="${Ldto.member_Id eq dto.post_writer }">
					<button onclick="postFormSubmit(1);">수정</button>
					<button onclick="postFormSubmit(2);">삭제</button>
				<form id="postForm" action="" method="post">
		            <input type="hidden" name="post_id" value="${ dto.post_id }">
		           	<input type="hidden" name="filePath" value="${ dto.changeName }"> 
		           	<!-- 첨부파일존재o : "파일경로" / 첨부파일존재x : "" -->
		        </form>
		        <script>
	            	function postFormSubmit(num){
	            		if(num == 1){ // 수정하기 클릭시
	            			$("#postForm").attr("action", "qnaUpdateForm.do").submit();
	            		}else{ // 삭제하기 클릭시
	            			$("#postForm").attr("action", "qnaDelete.do").submit();
	            		}
	            	}
	            </script>
				</c:if>
				<button onclick="location.href='qnaList.do'">목록</button>
			</td>
		</tr>
	</table>
	<!-- 댓글 기능 -->
	<table>
		<thead>
			<tr>
				<c:choose>
					<c:when test="${empty Ldto }">
						<th colspan="2">
							<textarea rows="2" cols="55" id="comment" readonly>로그인한 사용자만 사용가능한 서비스입니다. 로그인 후 이용해 주세요.</textarea>
						</th>
						<th><button disabled>동록</button></th>
					</c:when>
					<c:otherwise>
						<th>
							<textarea rows="2" cols="55" id="comment"></textarea>
						</th>
						<th><button onclick="addComment();">등록</button></th>
					</c:otherwise>
				</c:choose>
			</tr>
			<tr>
				<td colspan="3">댓글(<span id="ccount">${dto.post_comment_count}</span>)</td>
			</tr>
		</thead>
		<tbody id="commentBody">
		</tbody>
	</table>
	
	<script type="text/javascript">
		$(function(){
			selectCommentList();
			
			setInterval(selectCommentList, 1000);
		});
		
		function addComment(){
			if($("#comment").val().trim().length != 0){ //댓글 작성되어 있을 경우 => ajax로 댓글작성 요청
				
				$.ajax({
					url: "commentInsert.do",
					data: {
						comment_content : $("#comment").val(),
						post_id : ${dto.post_id},
						comment_writer : ${Ldto.member_id}
					},
					success : function(status){
						if(status == "success"){
							$("#comment").val("");
							selectCommentList();
						}
					},
					error: function(){
						console.log("댓글 작성용 ajax 통신 실패");
					}
				});
			} else { // 댓글 미작성
				alertify.alert("댓글을 작성해 주세요.");
			}
		}
		
		function selectCommentList(){
			$.ajax({
				url : "commentList.do",
				data: {post_id : ${dto.post_id}},
				success: function(list){
					var value = "";
					$.each(list, function(i, obj){
						value += "<tr>"
							  +		"<td>" + obj.comment_writer + "</td>"
							  +		"<td>" + obj.comment_content + "</td>"
							  +		"<td>" + obj.comment_regdate + "</td>"
							  +  "</tr>";
					});
					
					$("#commentBody").html(value);
					
				}, error: function(){
					console.log("댓글 리스트 조회용 ajax 실패")
				}
			});
		}
	</script>

</body>
</html>