<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	$(function(){
		$("#findBtn").click(function(){
			$.ajax({
				url: "/member/findPwForm",
				type: "POST"
				data: {
					id: $("#member_id").val(),
					email: $("#member_email").val()
				},
				success: fuction(result){
					alert(result);
				},
			})
		});
	})

</script>
<body>
	<h1>PW 찾기</h1>
	
	<form action="findPwRes.do" method="post" name="findform">
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
			<button type="submit">찾기</button>
			<button type="button">메인으로</button>
		</div>
	</form>


</body>
</html>