<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<script type="text/javascript">

	$(function(){
		$("#loginChk").hide();
	});
	
	function login(){
		var member_id = $("#member_id").val().trim();
		var member_pw = $("#member_pw").val().trim();
		var loginVal = {
				"member_id": member_id,
				"member_pw": member_pw
		}
		
		if(member_id == null || member_id == "" || member_pw == null || member_pw == "" ){
			alert("ID 및 PW를 입력해 주세요");
		}else{
			$.ajax({
				type:"post",
				url:"ajaxlogin.do",
				data:JSON.stringify(loginVal),
				contentType:"application/json",
				dataType:"json",
				success: function(msg){
					if(msg.check == true){
						location.href='index.jsp';
					}else{
						$("#loginChk").show();
						$("#loginChk").html("ID 혹은 PW가 잘못되엇습니다.")
					}
				},
				error:function(){
					alert("통신 실패");
				}
			});
		}
	}
</script>
	
<script type="text/javascript">
	function JoinForm(){
		$(".join").click(function(){
			$(".join").attr("action", "/member/joinform");
			$(".join").submit();
		});
	});
</script>


<body>
	<table>
			<tr>
				<th>ID</th>
			<td><input type="text" id="member_id"/></td>
			</tr>
			<tr>
				<th>PW</th>
				<td><input type="text" id="member_pw"/></td>
			</tr>
			<tr>
				<td colspan="2"><input type="button" value="login" id="login" onclick="login();"/></td>
			</tr>
			<tr>
				<td colspan="2" align="center" id="loginChk"></td>
			</tr>
			<tr>
			<td>
			<input type="button" value="회원가입" id="join" onclick="location.href='joinform.do'"/></td>
			</tr>
		
		</table>

</body>
</html>