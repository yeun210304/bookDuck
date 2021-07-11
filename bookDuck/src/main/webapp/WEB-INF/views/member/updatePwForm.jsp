<%@page import="com.spring.bookduck.model.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책추천 해줄게 북...덕... :: 북덕 BookDuck</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
var submitAction = function() { /* do something with Error */ return false; };

function null_check(){
	var member_pw = document.getElementById("member_pw").value;
	if(member_pw==null||member_pw==0|member_pw==""){
		$('form').bind('submit', submitAction);
		alert("아이디를 입력해 주세요");
		return false;
</script>
</head>
<link href="css/upDelMem.css" rel="stylesheet">
<body>
<jsp:include page="../header.jsp"/>
<br/>
<div id="update-title" style="text-align: center;">
	<h2>비밀번호 변경</h2>
</div>
	<form action="updatePwRes.do" method="post">
		<table id="updatePwtable">
			<colgroup>
				<col width="15%">
			</colgroup>
			<tr id="idForm">
				<th>ID</th>
				<td>&nbsp;<input type="text" id="member_id" name="member_id" class="text_box" value="${Ldto.member_id}" readonly="readonly"></td>
			</tr>
			<tr id="pwForm">
				<th>PW</th>
				<td>&nbsp;<input type="password" class="text_box" placeholder="변경할 비밀번호를 입력해 주세요." id="member_pw"/></td>
			</tr>
			<tr id="updatePw-button">
				<td colspan="2"><input type="submit" id="update-button" value="비밀번호 수정" onclick="login();"/></td>
			</tr>
			<!-- 
			<tr id="updatePw-cancel">
				<td colspan="2"><input type="button" id="updatePw-cancel" value="취소"/></td>
			<tr> -->
		</table>

	</form>

</body>
</html>