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
	var checkpls = document.getElementById("checkpls").value;
	if(checkpls==null||checkpls==0|checkpls==""){
		$('form').bind('submit', submitAction);
		alert("모든 항목을 입력해 주세요");
		return false;
	}
}
</script>
</head>
<body>
	<h1>회원가입</h1>
	<form action="reg.do" method="post">
	<div class=checkpls id=checkpls>
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
			<input type="tel" id="member_age" name="member_age">
		</div>
		<div class="join-form_gender">
			<div class="gender">성별</div>
			<input type="radio" id="member_gender" name="member_gender" value="F">여
			<input type="radio" id="member_gender" name="member_gender" value="M">남
		</div>
		<div class="join-form_email">
			<div class="email">이메일</div>
			<input type="text" id="member_email" name="member_email" class="member_email" maxlength="20">
			<span id="imt3" style="font-weight:bold; color:black;">@</span>
			<input type="text" id="usermail2" name="usermail2" class="usermail2" maxlength="10">
			<!-- [1]이메일 인증번호 발송 -> [2]이메일 인증번호 확인 -->
			<input type="button" name="btemail" class="btemail" id="btemail" value="인증번호 발송!">
			
			<!-- 인증번호 입력란 -->
			<input type="text" name="writechk" class="writechk" id="writechk" value="">
			<span id="explainsp">*메일로 보내드린 인증번호 6자리를 입력해 주세요</span>
			
			<!-- 이메일 인증시 Y/N -->
			<input type="hidden" name="emailchk" class="emailchk" id="emailchk" value="" style="background: yellow;">
		</div>
		<div class="join-button">
			<input type="submit" onclick="null_check();" value=회원가입 />
		</div>
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