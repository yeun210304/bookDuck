<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책추천 해줄게 북...덕... :: 북덕 BookDuck</title>
</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>

</script>
<body>
<jsp:include page="../header.jsp"/>
	<h1>PW 찾기</h1>
	
	<form action="sendpw.do" name="findform" method="post">
		<div class="findPw-form_id">
			<div class="id">ID</div>
			<div class="id_input_box">
				<input type="text" id="member_id" name="member_id" class="member_id">
				<br/>아이디를 입력해 주세요
			</div>
		</div>
		<div class="findPw-form_email">
			<div class="email">email</div>
			<div class="email_input_box">
				<input type="text" id="member_email" name="member_email" class="member_email">
				<br/>이메일을 입력해 주세요
			</div>
		</div>
		<div class="findId-button">
			<button type="submit" id="findBtn">찾기</button>
			<button type="button">메인으로</button>
		</div>
	</form>


</body>
</html>