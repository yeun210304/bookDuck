<%@page import="com.spring.bookduck.pay.dto.PayDto"%>
<%@page import="com.spring.bookduck.model.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <%
  	MemberDto dto1 = (MemberDto)session.getAttribute("Ldto");
  %>
 <header>
</header>
	<c:if test="${Ldto != null }"><a href="logout.do">로그아웃</a></c:if>
	
	<c:if test="${Ldto != null }">
		<p>${Ldto.member_id }님 안녕하세요.</p>
		<a href="mypage.do?member_id=${Ldto.member_id}&member_payrole=${Ldto.member_payrole}&intd_id=${intd_id}">MYPAGE</a>
		<a href="updatePwForm.do">비밀번호변경</a>
	</c:if>
	

</body>
</html>