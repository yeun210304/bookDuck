<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책추천 해줄게 북...덕... :: 북덕 BookDuck</title>
</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<body>
<jsp:include page="../header.jsp"/>
	<h1>ID 찾기</h1>
	
	<form action="findIdRes.do" method="post" name="findform">
		<div class="findId-form_email">
			<div class="email">email</div>
			<div class="email_input_box">
				<input type="text" id="member_email" name="member_email" class="member_email">
				<br/>가입 시 사용한 이메일을 입력해 주세요
			</div>
		</div>
		<div class="findId-button">
			<button type="submit">아이디 찾기</button>
			<button type="button">취소</button>
		</div>
		<!-- 정보가 일치하지 않을 때 -->
		<c:if test="${check==1 }">
			<label>일치하는 정보가 존재하지 않습니다.</label>
		</c:if>
		
		<!-- 정보가 일치할 때 -->
		<c:if test="${check==0 }">
			<label>찾으시는 아이디는 '${member_id}'입니다.</label>
		</c:if>
	</form>

</body>
</html>