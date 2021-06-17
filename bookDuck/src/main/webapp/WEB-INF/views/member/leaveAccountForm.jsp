<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<script type="text/javascript">
$(document).ready(function(){
	// 취소
	$(".cancel").on("click", function(){
		
		location.href = "/";
				    
	})

	$("#submit").on("click", function(){
		if($("#member_pw").val()==""){
			alert("비밀번호를 입력해주세요.");
			$("#member_pw").focus();
			return false;
		}	
	});
})
</script>
<body>
	<h1>회원 탈퇴</h1>
	<form action="leaveAccount.do">
		<div class="leave_id">
			<div class="id">ID</div>
			<div class="id_input_box">
				<input type="text" id="member_id" name="member_id" class="member_id" value="${Ldto.member_id}" readonly="readonly">
			</div>
		</div>
		<div class="leave_pw">
			<div class="pw">비밀번호</div>
			<input type="password" id="member_pw" name="member_pw">
		</div>
		<div class="leave-button">
			<button type="submit">회원탈퇴</button>
			<button type="button" class="cancel">취소</button>
		</div>
	</form>
	<div>
		<c:if test="${msg==false }">
			비밀번호가 맞지 않습니다.
		</c:if>
	</div>

</body>
</html>