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
		var member_gender = document.getElementById("member_gender").value;
		if(member_gender==null||member_gender==0|member_gender==""){
			$('form').bind('submit', submitAction);
			alert("성별을 선택해 주세요");
			return false;
	}else if{
		var member_email = document.getElementById("member_email").value;
		if(member_email==null||member_email==0|member_email==""){
			$('form').bind('submit', submitAction);
			alert("이메일을 입력해 주세요");
			return false;
	}
}
</script>
<!--  <link href="css/join.css" rel="stylesheet">-->
</head>
<body>
<jsp:include page="../header.jsp"/>
	<h1>회원가입</h1>
	<form action="reg.do" method="post">
	<div class=checkpls id=checkpls>
	<ul>
			<li><div class="id">아이디</div></li>
			<li><div class="id_input_box">
				<input type="text" id="member_id" name="member_id" class="member_id" placeholder="아이디를 입력하세요">
				<button class="idCheck" type="button" id="idCheck" onclick="Check_id();" value="N">중복확인</button>
			</div></li>
			<li><div class="pw">비밀번호</div></li>
			<li><input type="password" id="member_pw" name="member_pw" placeholder="비밀번호를 입력하세요"></li>
			<li><div class="age">생년월일</div></li>
			<li><input type="tel" id="member_age" name="member_age" placeholder="입력 예시: 19990101"></li>
			<li><div class="gender">성별</div></li>
			<li><input type="radio" id="member_gender" name="member_gender" value="F">여
			<input type="radio" id="member_gender" name="member_gender" value="M">남</li>
			<li><div class="email">이메일</div></li>
			<li><input type="text" id="member_email" name="member_email" class="member_email" maxlength="20" placeholder="이메일을 입력하세요">
			<button class="emailCheck" type="button" id="idCheck" onclick="Check_email();" value="N">이메일 중복 확인</button></li>
			<!--  
			<span id="imt3" style="font-weight:bold; color:black;">@</span>
			<input type="text" id="usermail2" name="usermail2" class="usermail2" maxlength="10">
			<!-- [1]이메일 인증번호 발송 -> [2]이메일 인증번호 확인 
			<input type="button" name="btemail" class="btemail" id="btemail" value="인증번호 발송!">
			
			<!-- 인증번호 입력란 
			<input type="text" name="writechk" class="writechk" id="writechk" value="">
			<span id="explainsp">*메일로 보내드린 인증번호 6자리를 입력해 주세요</span>
			
			<!-- 이메일 인증시 Y/N 
			<input type="hidden" name="emailchk" class="emailchk" id="emailchk" value="" style="background: yellow;">
			-->
			<li><input type="submit" onclick="null_check();" value=회원가입 /></li>
		</ul>
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

function Check_email(){
	$.ajax({
		url:"emailCheck.do",
		type: "POST",
		dataType: "json",
		data: {"member_email" : $("#member_email").val()},
		success: function(data){
			if(data==1){
				console.log("메일 중복");
				alert("이미 사용 중인 이메일입니다.");
			}else if(data==0){
				console.log("메일 가능");
				$("#emailCheck").attr("value", "Y");
				alert("사용 가능한 이메일입니다.");
			}
		}
	})
}
$("#btemail").click(function(){
	//alert("이메일 인증 시작!");
	var user_email1 = $(".usermail1").val();
	var user_email2 = $(".usermail2").val();
	
	var key; //인증키
	var bool = true;
	
	if(bool){
		$.ajax({
			url:"<c:url value='member/certifiedMail.do'/>",
			type: "post",
			dataType:"json",
			data:{"user_email1":user_email1,
				  "user_email2":user_email2},
			success: function(result){
				alert("인증번호 발송!");
				key=result;
				bool=false;
			},
		error: function(xhr, status, error){
			alert("Error : "+status+"==>"+error);
		}
	}); //ajax
	$(".writechk").show(); //이메일 인증 입력란
	$(".btemail").val("인증번호 확인!"); //이메일 인증 버튼 -> 내용 변경
	
	$(".writechk").keyup(function(){
		if($(".writechk").val()>=6){
			var userContent = $(".writechk").val();
			//alert(userContent);
			
			if(userContent == key){
				alert("인증 성공!");
				$("#emailchk").val("Y"); //숨겨져 있음 -> DB에 저장할거임 (Y/N)
				$("#btemail").val("인증 완료!"); 
				$("#btemail").attr("disabled", true); //읽기 전용으로 변환
				$(".writechk").attr("disabled", true);
			}else{
				$("#emailchk").val("N");
				$("#btemail").val("인증번호 재발송!");
				event.preventDefault();
			}
		}
	}); //keyup
	}else{
		alert("test1 => false");
		event.preventDefault();
	}
})
</script>
</html>