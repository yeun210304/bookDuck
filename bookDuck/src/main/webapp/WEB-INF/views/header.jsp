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
		<a href="mypage.do">MYPAGE</a>
	</c:if>

</body>
</html>