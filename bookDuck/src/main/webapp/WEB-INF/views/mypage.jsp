<%@page import="com.spring.bookduck.introduce.dto.IntroduceDto"%>
<%@page import="com.spring.bookduck.model.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<% 
MemberDto Ldto = (MemberDto)session.getAttribute("Ldto");
IntroduceDto intdDto =(IntroduceDto)session.getAttribute("intdDto");
Boolean memberchk = Ldto!= null;
Boolean intdchk = intdDto!= null;
String member_payrole = "N";

%>


</head>
<body>
<h1>mypage</h1>
<div>
<%
	if(!memberchk){
%>
	<nav>
		<ul>
			<li><a href="payorder.do">회원권 결제하기</a></li>
		</ul>
	</nav>
<%
	} else{
%>	
	<nav>
		<ul>
			<li><a href="payorder.do">유료회원 입니다.</a></li>
		</ul>
	</nav>
<%
	if(!intdchk){	
%>
<div>
	<table>
		
		<tr>
			<th>자기소개</th>
			<td>${dto.intd_content}</td>
		</tr>
		<tr>
			<td>
				<input type="button" value="작성하기" onclick="location.href='intdupdateform.do?intd_no=${dto.intd_no}'"/> 
			</td>
		</tr>
	</table>
</div>

<%
		}

	}
%>
</div>














</body>
</html>