<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
var submitAction = function() { /* do something with Error */ return false; };

function null_check(){
	var member_id = document.getElementById("member_id").value;
	if(member_id==null||member_id==0|member_id==""){
		$('form').bind('submit', submitAction);
		alert("아이디를 입력해 주세요");
		return false;
	}else if{
		var member_pw = document.getElementById("member_pw").value;
		if(member_pw==null||member_pw==0|member_pw==""){
			$('form').bind('submit', submitAction);
			alert("비밀번호를 입력해 주세요");
			return false;
	}else if{
		var member_age = document.getElementById("member_age").value;
		if(member_age==null||member_age==0|member_age==""){
			$('form').bind('submit', submitAction);
			alert("생년월일을 입력해 주세요");
			return false;
	}else if{
		var member_gender = document.getElementById("member_gender").value;
		if(member_gender==null||member_gender==0|member_gender==""){
			$('form').bind('submit', submitAction);
			alert("성별을 선택해 주세요");
			return false;
	}else if{
		var member_email = document.getElementById("member_email").value;
		if(member_email==null||member_email==0|member_email==""){
			$('form').bind('submit', submitAction);
			alert("이메알을 입력해 주세요");
			return false;
	}else if{
		var checkpls = document.getElementById("checkpls").value;
		if(checkpls==null||checkpls==0|checkpls==""){
			$('form').bind('submit', submitAction);
			alert("모든 칸을 입력해 주세요");
			return false;
	}
</script>
</head>
<body>
<jsp:include page="../header.jsp"/>

	<h4>sns 간편 회원가입</h4>
<div id=checkpls>
	<form action="reg.do">
		<div class="join-form_id">
			<div class="id">ID</div>
			<div class="id_input_box">
				<input type="text" id="member_id" name="member_id" class="member_id">
				<button class="idCheck" type="button" id="idCheck" onclick="Check_id();" value="N">중복확인</button>
			</div>
		</div>
		<div class="join-form_pw">
			<div class="pw">비밀번호</div>
			<input type="password" id="member_pw" name="member_pw">
		</div>
		<div class="join-form_age">
			<div class="age">생년월일</div>
			<input type="tel" id="member_age" name="member_age" placeholder="입력 예시: 19990101">
		</div>
		<div class="join-form_gender">
			<div class="gender">성별</div>
			<input type="radio" id="member_gender" name="member_gender" value="F">여
			<input type="radio" id="member_gender" name="member_gender" value="M">남
		</div>
		<div class="join-form_email">
			<div class="email">이메일</div>
			<input type="text" id="member_email" name="member_email" class="member_email" maxlength="200" value="${member_email }">
		</div>
            <input type="submit" value="가입" onclick="null_check();">
           	<input type="button" value="취소">
	</form>
</div>
</body>
<script type="text/javascript">
function Check_id(){
	$.ajax({
		url:"idCheck.do",
		type: "POST",
		dataType: "json",
		data: {"member_id" : $("#member_id").val()},
		success: function(data){
			if(data==1){
				console.log("아이디 중복");
				alert("중복된 아이디입니다.");
			}else if(data==0){
				console.log("아이디 있음");
				$("#idCheck").attr("value", "Y");
				alert("사용 가능한 아이디입니다.");
			}
		}
	})
}
</script>
</html>