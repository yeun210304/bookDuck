<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책추천 해줄게 북...덕... :: 북덕 BookDuck</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<link href="css/upDelMem.css" rel="stylesheet">
<script type="text/javascript">

$(document).ready(function(){
	// 취소
	$(".cancel").on("click", function(){
		
		location.href = "/";
				    
	})

	$("#submit").on("click", function(){
		if($("#member_pw").val()==""){
			alert("비밀번호를 입력해주세요.");
			$("#member_pw").focus();
			return false;
		}	
	});
})

</script>
<body>
<jsp:include page="../header.jsp"/>
<br/>
<div id="update-title" style="text-align: center;">
	<h2>회원 탈퇴</h2>
</div>
<br/>
	<form action="leaveAccount.do">
		<table id="updatePwtable">
			<colgroup>
				<col width="15%">
			</colgroup>
			<tr class="leave_id">
				<th class="id">ID</th>
				<td>&nbsp;<input type="text" class="text_box" id="member_id" name="member_id" class="member_id" value="${Ldto.member_id}" readonly="readonly"></td>
			</tr>
			<tr class="pw">
			<th>PW</th>
				<td>&nbsp;<input type="password" class="text_box" placeholder="비밀번호를 입력해 주세요." id="member_pw"/></td>
			</tr>
			<tr id="updatePw-button">
				<td colspan="2"><input type="submit" id="update-button" value="회원 탈퇴" onclick=""/></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" id="update-button" value="취소" onclick=""/></td>
			</tr>
		</table>
	</form>
		<div>
			<c:if test="${msg==false }">
				비밀번호가 맞지 않습니다.
			</c:if>
		</div>
		

</body>
</html>