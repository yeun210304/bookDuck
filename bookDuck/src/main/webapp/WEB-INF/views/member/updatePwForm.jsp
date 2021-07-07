<%@page import="com.spring.bookduck.model.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="../header.jsp"/>
<h1>비밀번호 변경</h1>
	<form action="updatePwRes.do" method="post">
		<div class="updatePw-form_id">
			<div class="id">ID</div>
			<div class="id_input_box">
				<input type="text" id="member_id" name="member_id" class="member_id" value="${Ldto.member_id}" readonly="readonly">
			</div>
		</div>
		<div class="updatePw_pw">
			<div class="pw">비밀번호</div>
			<input type="password" id="member_pw" name="member_pw">
		</div>
		<div class="updatePw-button">
			<button type="submit">회원정보 수정</button>
			<button type="button">취소</button>
		</div>
	</form>

</body>
</html>