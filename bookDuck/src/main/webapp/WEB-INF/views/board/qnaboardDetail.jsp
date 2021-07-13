<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책추천 해줄게 북...덕... :: 북덕 BookDuck</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-latest.js"></script>
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
	
	table *{margin: 5px;}
	table{width: 90%; margin: auto; font-family : 'NanumSquare'; transform:skew(-0.03deg);}
	#contentArea th{height: 40px;}
	#contentArea{border-bottom: 1px solid lightgray; margin-bottom: 50px;}
	#comment{resize : none;}
	#replyArea{border-collapse: collapse; }
	#commentBody tr{border-bottom: solid 1px white;}
	.commentList{border-style: none; resize: none;}
	button{
		width : 50px;
		height: 35px;
		border: none;
		background-color: #6277BA;
		color: white;
		cursor: pointer;
	}
	
	/* 올라가기 고정 버튼 */
	#upup {
	    position: fixed;
	    height : 30px;
	    width : 50px;
	    right: 50px;
	    bottom: 50px;
	    z-index: 50;
	    /*
	    height : 50px;
	    width : 50px;
	    
	    right: 2%;
	    bottom: 50px;
	    z-index: 999;
	    */
	 
	}
	
	#upup:hover{cursor: pointer;}
	
	/* 페이지 스크롤업 이미지 */
	#upup img{
		height : 50px;
	    width : 50px;
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
			<h1 align="center">문의게시판</h1>
			<br><br><br>
		
			<table class="table" id="contentArea" align="center">
				<tr>
					<th class="table-primary">분류</th>
					<td>
						<c:if test="${dto.post_category eq 'P' }">결제</c:if>	
						<c:if test="${dto.post_category eq 'R' }">환불</c:if>	
						<c:if test="${dto.post_category eq 'M' }">회원</c:if>	
						<c:if test="${dto.post_category eq 'E' }">기타</c:if>					
						<c:if test="${empty dto.post_category }">분류 없음</c:if>	
					</td>
					<th class="table-primary">제목</th>
					<td colspan="3">${dto.post_title }</td>
				</tr>
				<tr>
					<th class="table-primary">작성자</th>
					<td>${dto.post_writer }</td>
					<th class="table-primary">작성일</th>
					<td><fmt:formatDate pattern="yyyy-MM-dd hh:mm" value="${dto.post_regdate }"/></td>
					<th class="table-primary">조회수</th>
					<td>${dto.post_hit}</td>
				</tr>
				<tr>
					<th class="table-primary">첨부파일</th>
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
					<th class="table-primary text-center" colspan="6">내용</th>
				</tr>
				<tr>
					<td colspan="6" height="300px">${dto.post_content }</td>
				</tr>
				<tr>
					<td colspan="6" align="right">
						<c:choose>
							<c:when test="${Ldto.member_id eq dto.post_writer }">
								<button onclick="postFormSubmit(1);">수정</button>
								<button onclick="postFormSubmit(2);">삭제</button>
								<button onclick="location.href='qnaList.do'">목록</button>
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
							</c:when>
							<c:otherwise>
								<button onclick="location.href='qnaList.do'">목록</button>
							</c:otherwise>
						</c:choose>
						
					</td>
				</tr>
			</table>
			<!-- 댓글 기능 -->
			<table class="table" id="replyArea" align="center">
				<thead>
					<tr>
						<c:choose>
							<c:when test="${empty Ldto }">
								<th colspan="2" class="text-center">
									<textarea rows="4" cols="70" id="comment" readonly>로그인한 사용자만 사용가능한 서비스입니다. 로그인 후 이용해 주세요.</textarea>
								</th>
								<th><button disabled>등록</button></th>
							</c:when>
							<c:otherwise>
								<th colspan="2" class="text-center">
									<textarea class="form-control" rows="3" cols="55" id="comment"></textarea>
								</th>
								<th><button id="addCommentBtn" onclick="addComment();">등록</button>
									<button id="cancelCommentBtn" onclick="cancelComment();">취소</button>
								</th>
							</c:otherwise>
						</c:choose>
					</tr>
					<tr>
						<td colspan="3">댓글(<span id="ccount"></span>)</td>
					</tr>
				</thead>
				<tbody id="commentBody">
				</tbody>
			</table>
			
			<!-- 페이지 스크롤업 -->
			<div id="upup">
				<img src="resources/img/arrow_up.png" >
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
		$(function(){
			selectCommentList();
			
			$('#upup').on('click',function(e){
				e.preventDefault();
				$('html,body').animate({scrollTop:0},1000);
			});
			//setInterval(selectCommentList, 1000);
		});
		
		function cancelComment(){
			$("#comment").val("");
			$("#addCommentBtn").attr('onclick', 'addComment();').html('등록');
			selectCommentList();
		}
		
		function addComment(){
			if($("#comment").val().trim().length != 0){ //댓글 작성되어 있을 경우 => ajax로 댓글작성 요청
				
				$.ajax({
					url: "commentInsert.do",
					data: {
						comment_content : $("#comment").val(),
						post_id : ${dto.post_id},
						comment_writer : '${Ldto.member_id}'
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
				type : "post",
				url : "commentList.do",
				data: {post_id : ${dto.post_id}},
				success: function(data){
					var value = "";
					$.each(data.list, function(i, obj){
						value += "<tr>";
						if(obj.comment_titletab > 0){
							value += "<td>"
							for(var i = 0; i < obj.comment_titletab; i++){
								value += "<img src='https://image.flaticon.com/icons/png/128/1621/1621573.png' width='8px' height='8px'>";
							}
							value += obj.comment_writer + "</td>";
						} else{
							value += "<td>" + obj.comment_writer + "</td>";
						}
						value +=	"<td><textarea class='commentList' rows='4' cols='70' name='"+ obj.comment_id +"' readonly>" + obj.comment_content + "</textarea></td>"
							  +		"<td>" + obj.comment_regdate + "</td>"
							  +  "</tr>";
						if('${Ldto.member_id}' == obj.comment_writer){
							value += "<tr>"
								  + "<td colspan='3' align='right'><button onclick='answerCommentForm("+obj.comment_id+");' >답글</button>&nbsp;<button name='"+obj.comment_id+"' onclick='updateCommentForm("+ obj.comment_id +");'>수정</button>"
								  + "&nbsp;<button onclick='deleteComment("+ obj.comment_id +");'>삭제</button></td>"
								  + "</tr>"
						} else if(${!empty Ldto}){
							value += "<tr>"
								  + "<td colspan='3' align='right'><button onclick='answerCommentForm("+obj.comment_id+");' >답글</button></td></tr>"
						}
					});
					
					$("#commentBody").html(value);
					$("#ccount").html(data.list.length);
					
				}, error: function(){
					console.log("댓글 리스트 조회용 ajax 실패")
				}
			});
		}
		
		function answerCommentForm(comment_id){
			$("#comment").focus();
			$("#addCommentBtn").attr('onclick', 'answerComment('+comment_id+');').html('답글');
		}
		function answerComment(comment_id){
			if($("#comment").val().trim().length != 0){ //댓글 작성되어 있을 경우 => ajax로 댓글작성 요청
				
				$.ajax({
					url: "commentAnswerInsert.do",
					data: {
						'comment_id' : comment_id, 
						comment_content : $("#comment").val(),
						post_id : ${dto.post_id},
						comment_writer : '${Ldto.member_id}'
					},
					success : function(status){
						if(status == "success"){
							$("#comment").val("");
							$("#addCommentBtn").attr('onclick', 'addComment();').html('등록');
							selectCommentList();
						}
					},
					error: function(){
						console.log("대댓글 작성용 ajax 통신 실패");
					}
				});
			} else { // 댓글 미작성
				alertify.alert("댓글을 작성해 주세요.");
			}
		}
		
		function updateCommentForm(comment_id){
			$("textarea[name='"+comment_id+"']").attr('readonly', false).focus();
			$("button[name='"+comment_id+"']").attr('onclick', 'updateComment('+comment_id+');')
		}
		
		function updateComment(comment_id){
			var newComment = $("textarea[name='"+comment_id+"']").val();
			console.log(newComment);
			$.ajax({
				url : "commentUpdate.do",
				data : {"comment_id" : comment_id,
					"comment_content" : newComment},
				success : function(status){
					if(status == "success"){
						$("textarea[name='"+comment_id+"']").attr('readonly', true);
						$("button[name='"+comment_id+"']").attr('onclick', 'updateCommentForm('+comment_id+');')
						selectCommentList();
					}
				},
				error: function(){
					console.log("댓글 수정용 ajax 통신 실패");
				}
			});
		}
		
		function deleteComment(comment_id){
			$.ajax({
				url: "commentDelete.do",
				data: {"comment_id" : comment_id,
						"post_id" : ${dto.post_id}},
				success : function(status){
					if(status == "success"){
						selectCommentList();
					}
				}, error: function(){
					console.log("댓글 삭제 ajax 통신실패");
				}
			});
		}
	</script>
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>