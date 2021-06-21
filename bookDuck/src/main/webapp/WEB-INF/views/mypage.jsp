<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="com.spring.bookduck.pay.dto.PayDto"%>
<%@page import="com.spring.bookduck.introduce.dto.IntroduceDto"%>
<%@page import="com.spring.bookduck.model.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
MemberDto dto1 = (MemberDto) session.getAttribute("Ldto");
%>

</head>
<body>
	<h1>MYPAGE</h1>
	<c:if test="${Ldto != null }">
		<p>${Ldto.member_id }님,</p>
	</c:if>

	<c:if test="${Ldto.member_payrole eq 'N'}">
		<div>
			<a href="payorder.do?">회원결제하기</a>
		</div>
	</c:if>
	<c:if test="${Ldto.member_payrole eq 'Y'}">
		<p>유료회원 입니다.</p>
	</c:if>
	<div>
		<c:choose>
			<c:when test="${empty intdDto.intd_content}">
				<table>
					<tr>
						<td colspan="1" align="center" onclick="location.href='intdinsertres.do'">자기소개를 작성해 주세요</td>
					</tr>
				</table>
			</c:when>
			<c:otherwise>
				<table>
					<tr>
						<th>자기소개</th>
						<td><input type="text" name="intd_content"
							value="${intdDto.intd_content}"></td>
					</tr>
				</table>
			</c:otherwise>
		</c:choose>



	</div>





</body>
</html>