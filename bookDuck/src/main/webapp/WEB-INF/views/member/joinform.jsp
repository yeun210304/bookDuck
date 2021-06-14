<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
	/* 중복아이디 존재하지 않는경우 */
	.id_re1{
		color : green;
		display : none;
	}
	/* 중복아이디 존재하는 경우 */
	.id_re2{
		color : red;
		display : none;
	}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<h1>회원가입</h1>
	
	<form action="reg.do" method="post">
		<div class="join-form_id">
			<label for="id">ID</label>
			<input type="text" id="member_id" name="member_id">
			<span class="id_re1">사용 가능한 아이디입니다.</span>
			<span class="id_re2">중복된 아이디가 이미 존재합니다.</span>
		</div>
		<div class="join-form_pw">
			<label for="pw">비밀번호</label>
			<input type="password" id="member_pw" name="member_pw">
		</div>
		<div class="join-form_age">
			<label for="age">생년월일</label>
			<input type="tel" id="member_age" name="member_age">
		</div>
		<div class="join-form_gender">
			<label for="gender">성별</label>
			<input type="radio" id="member_gender" name="member_gender" value="F">여
			<input type="radio" id="member_gender" name="member_gender" value="M">남
		</div>
		<div class="join-form_email">
			<label for="email">이메일</label>
			<input type="email" id="member_email" name="member_email">
		</div>
		<div class="join-button">
			<button type="submit">회원가입</button>
		</div>
	</form>
</body>
<script>
$(document).ready(function(){
	$('#member_id').on("propertychange change keyup paste input"), function(){
		var member_id = $('#member_id').val();		//#member_id에 입력되는 값
		var data = {member_id : member_id}			//'컨트롤러에 넘길 데이터 이름' : '데이터(#member_id)에 입력되는 값'
		
		$.ajax({
			type : "post",
			url: "/member/memberIdChk",
			data: data
			
	});
});
</script>
</html>