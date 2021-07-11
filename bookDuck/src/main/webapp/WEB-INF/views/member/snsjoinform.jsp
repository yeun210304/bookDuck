<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책추천 해줄게 북...덕... :: 북덕 BookDuck</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-latest.js"></script>
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
 <link href="css/join.css" rel="stylesheet">
</head>
<body>
<jsp:include page="../header.jsp"/>
	<div class=join-title>
		<h2 align="center">sns 간편 회원가입</h2>
	</div>

	<form action="reg.do">
		<div class="join-form" id=checkpls>
			<table id="jointable">
				<colgroup>
					<col width="15%"/>
				</colgroup>
				<tr class="id">
					<th>아이디</th>
						<td>&nbsp;<input class="text_box" type="text" id="member_id" name="member_id" class="member_id" maxlength="20" placeholder="아이디를 입력하세요">
						<button class="idCheck" type="button" id="idCheck" onclick="Check_id();" value="N">아이디 중복 확인</button></td>
				</tr>
				<tr class="pw">
					<th>비밀번호</th>
						<td>&nbsp;<input class="text_box" type="password" id="member_pw" name="member_pw" placeholder="비밀번호를 입력하세요"></td>
				</tr>	
				<tr class="age">
					<th>생년월일</th>
						<td>&nbsp;<input class="text_box" type="tel" id="member_age" name="member_age" placeholder="입력 예시: 19990101"></td>
				</tr>
				<tr class="gender">
					<th>성별</th>
						<td>&nbsp;<input type="radio" id="member_gender" name="member_gender" value="F">여성
						<input type="radio" id="member_gender" name="member_gender" value="M">남성</td>
				</tr>
				<tr class="email">
					<th>이메일</th>
						<td>&nbsp;<input class="text_box" type="text" id="member_email" name="member_email" class="member_email" maxlength="200" value=${member_email }>
						<button class="emailCheck" type="button" id="emailCheck" onclick="Check_email();" value="N">이메일 중복 확인</button></td>
				</tr>
				<tr class="joinbutton">
					<td colspan="3"><input type="submit" value="가입" id="joinbutton" onclick="null_check();"/></td>
				</tr>
			</table>
		</div>
	</form>

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