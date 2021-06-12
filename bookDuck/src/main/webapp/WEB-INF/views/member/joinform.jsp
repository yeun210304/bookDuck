<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>회원가입</h1>
	
	<form action="reg.do" method="post">
		<div class="join-form">
			<label for="id">ID</label>
			<input type="text" id="member_id" name="member_id">
		</div>
		<div class="join-form">
			<label for="pw">비밀번호</label>
			<input type="password" id="member_pw" name="member_pw">
		</div>
		<div class="join-form">
			<label for="age">생년월일</label>
			<input type="tel" id="member_age" name="member_age">
		</div>
		<div class="join-form">
			<label for="gender">성별</label>
			<input type="radio" id="member_gender" name="member_gender" value="F">여
			<input type="radio" id="member_gender" name="member_gender" value="M">남
		</div>
		<div class="join-form">
			<label for="email">이메일</label>
			<input type="email" id="member_email" name="member_email">
		</div>
		<div class="join-button">
			<button type="submit">회원가입</button>
		</div>
	</form>
	
	
</body>
</html>